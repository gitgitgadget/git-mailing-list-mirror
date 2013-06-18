From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http.c: don't rewrite the user:passwd string multiple
 times
Date: Tue, 18 Jun 2013 01:19:03 -0400
Message-ID: <20130618051902.GA5916@sigill.intra.peff.net>
References: <1371520840-24906-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 07:19:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UooK0-0000oz-VF
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 07:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563Ab3FRFTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 01:19:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:34145 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338Ab3FRFTH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 01:19:07 -0400
Received: (qmail 20743 invoked by uid 102); 18 Jun 2013 05:20:03 -0000
Received: from mobile-032-141-227-127.mycingular.net (HELO sigill.intra.peff.net) (32.141.227.127)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Jun 2013 00:20:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2013 01:19:03 -0400
Content-Disposition: inline
In-Reply-To: <1371520840-24906-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228153>

On Mon, Jun 17, 2013 at 07:00:40PM -0700, Brandon Casey wrote:

> Curl requires that we manage any strings that we pass to it as pointers.
> So, we should not be overwriting this strbuf after we've passed it to
> curl.

My understanding of curl's pointer requirements are:

  1. Older versions of curl (and I do not recall which version off-hand,
     but it is not important) stored just the pointer. Calling code was
     required to manage the string lifetime itself.

  2. Newer versions of curl will strdup the string in curl_easy_setopt.

So we do not have to worry about newer versions, as they do not care
about our pointer after curl_easy_setopt returns.

For older versions, if we were to grow the strbuf, we might free() the
pointer provided to an earlier call to curl_easy_setopt. But since we
are about to call curl_easy_setopt with the new value, I would assume
that curl will never actually look at the old one (i.e., when replacing
an old pointer, it would not dereference it, but simply overwrite it
with the new value).

So for a single curl handle, I don't think it is a problem.

It could be a problem when we have multiple handles in play
simultaneously (we invalidate the pointer that another simultaneous
handle is using, but do not immediately reset its pointer).

> Additionally, it is unnecessary since we only prompt for the user name
> and password once, so we end up overwriting the strbuf with the same
> sequence of characters each time.  This is why in practice it has not
> caused any problems for git's use of curl; the internal strbuf char
> pointer does not change, and get's overwritten with the same string
> each time.

In the current code, yes, we only do this once (and if we have a
username/password from the URL, we do not re-prompt if that fails).

> diff --git a/http.c b/http.c
> index 92aba59..6828269 100644
> --- a/http.c
> +++ b/http.c
> @@ -228,8 +228,8 @@ static void init_curl_http_auth(CURL *result)
>  #else
>  	{
>  		static struct strbuf up = STRBUF_INIT;
> -		strbuf_reset(&up);
> -		strbuf_addf(&up, "%s:%s",
> +		if (!up.len)
> +			strbuf_addf(&up, "%s:%s",
>  			    http_auth.username, http_auth.password);
>  		curl_easy_setopt(result, CURLOPT_USERPWD, up.buf);

This is correct for the current code because of the reasoning above.
I'm slightly negative on this only because it feels like we are setting
a trap for somebody who later wants to do:

  for (sanity = 0; sanity < 5; sanity++) {
      int ret = http_request(...);
      if (ret != HTTP_REAUTH)
              return ret;
  }

to give the user a few chances to input.  We would continue to update
the credential struct but never actually give the new value to curl.

Another option would be to just use a static fixed-size buffer. That
removes all memory management issues.

I dunno. Maybe I am being too picky, as I do not have plans to do
anything like the above (since we don't do significant work before the
http contact, there is no reason not to just die() and let the user
re-run the shell command).  I'd also be OK with just putting a comment
above the code in question to say something like "Note that we assume we
only ever have a single set of credentials in a given program run, so we
do not have to worry about updating this buffer, only setting its
initial value". Then the trap at least has a warning sign. :)

What do you think?

-Peff
