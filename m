From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-push: don't always prompt for password
Date: Fri, 4 Nov 2011 13:43:03 -0400
Message-ID: <20111104174303.GA22568@sigill.intra.peff.net>
References: <7vfwi6jucg.fsf@alter.siamese.dyndns.org>
 <1320390188-24334-1-git-send-email-stefan.naewe@gmail.com>
 <7vlirvdeb2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Naewe <stefan.naewe@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 18:43:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMNnO-0004ye-Gp
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 18:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322Ab1KDRnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 13:43:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33539
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118Ab1KDRnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 13:43:08 -0400
Received: (qmail 3415 invoked by uid 107); 4 Nov 2011 17:43:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Nov 2011 13:43:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2011 13:43:03 -0400
Content-Disposition: inline
In-Reply-To: <7vlirvdeb2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184788>

On Fri, Nov 04, 2011 at 09:48:17AM -0700, Junio C Hamano wrote:

> Stefan Naewe <stefan.naewe@gmail.com> writes:
> 
> > http-push prompts for a password when the URL is set as
> > 'https://user@host/repo' even though there is one set
> > in ~/.netrc. Pressing ENTER at the password prompt succeeds
> > then, but is a annoying and makes it almost useless
> > in a shell script, e.g.
> >
> > Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> > ---
> 
> Thanks.
> 
> With this the only callsite of init_curl_http_auth() becomes the one after
> we get the 401 response, and this caller makes sure that user_name is not
> NULL.
> 
> Do we still want "if (user_name)" inside init_curl_http_auth()?

Since we now only call init_curl_http_auth when we know we need auth, I
think it would make more sense to just move the user_name asking there,
too, like:

  static void init_curl_http_auth(CURL *result)
  {
          struct strbuf up = STRBUF_INIT;

          if (!user_name)
                  user_name = xstrdup(git_getpass_with_description("Username", description);
          if (!user_pass)
                  user_pass = xstrdup(git_getpass_with_description("Password", description);

          strbuf_addf(&up, "%s:%s", user_name, user_pass);
          curl_easy_setopt(result, CURLOPT_USERPWD, strbuf_detach(&up, NULL));
  }

And then it's easy to swap out the asking for credential_fill() when it
becomes available. But I admit I don't care that much now, as I'll just
end up doing that refactoring later with my credential patches anyway.

> I tried to rewrite the proposed commit log message to describe the real
> issue, and here is what I came up with:

Your description looks accurate to me.

> What is somewhat troubling is that after analyzing the root cause of the
> issue, I am wondering if a more correct fix is to remove the user@ part
> from the URL (in other words, document that a URL with an embedded
> username will ask for password upfront, and tell the users that if they
> have netrc entries or if they are accessing a resource that does not
> require authentication, they should omit the username from the URL).

It's tempting, because the non-netrc case is the common one, and we are
dropping the round-trip avoidance for those people. I'm just not sure
that it's going to be obvious to users that they need to drop the user@
portion from their URL when using netrc. That seems like a bizarre
requirement from the user's POV, even if we do document it.

-Peff
