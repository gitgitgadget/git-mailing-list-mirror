From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] builtin/tag: Changes argument format for verify
Date: Fri, 26 Feb 2016 23:36:25 -0500
Message-ID: <20160227043625.GC11604@sigill.intra.peff.net>
References: <1456532864-30327-1-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Sat Feb 27 05:36:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZWcK-0002iK-MX
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 05:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050AbcB0Eg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 23:36:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:50557 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756020AbcB0Eg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 23:36:28 -0500
Received: (qmail 23587 invoked by uid 102); 27 Feb 2016 04:36:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 23:36:28 -0500
Received: (qmail 10424 invoked by uid 107); 27 Feb 2016 04:36:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 23:36:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 23:36:25 -0500
Content-Disposition: inline
In-Reply-To: <1456532864-30327-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287658>

On Fri, Feb 26, 2016 at 07:27:44PM -0500, santiago@nyu.edu wrote:

> From: Santiago Torres <santiago@nyu.edu>
> 
> The verify tag function converts the commit sha1 to hex and passes it as
> a command-line argument to builtin/verify-tag. Given that builtin/verify-tag
> already resolves the ref name sha1 equivalent, the sha1 to
> hex_sha1 conversion is unnecessary and the ref-name can be used instead.

Hrm. This is potentially racy, if git-tag is going to say something
about the ref, but git-verify-tag may have actually verified another tag
entirely.

AFAICT, though, git-tag doesn't say anything, and is just purely
forwarding work to verify-tag. So I can't see a real downside to passing
in the ref name, except that it is slightly less efficient (because
verify_tag has to re-resolve it). But...

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 1705c94..5de1161 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -105,8 +105,7 @@ static int verify_tag(const char *name, const char *ref,
>  				const unsigned char *sha1)
>  {
>  	const char *argv_verify_tag[] = {"verify-tag",
> -					"-v", "SHA1_HEX", NULL};
> -	argv_verify_tag[2] = sha1_to_hex(sha1);
> +					"-v", name, NULL};

You are passing in "name" here, not "ref". git-tag knows it is operating
specifically on tags, and completes a name like "foo" to
"refs/tags/foo". Whereas verify-tag is plumbing that can operate on any
ref, and will do the usual lookup for "foo", "refs/heads/foo",
"refs/tags/foo", etc.

So by passing the unqualified name, we may end up finding something
entirely different, generating "ambiguous name" errors, etc. So if we
_were_ to go this route, I think we'd need to use "ref" here, not
"name".

But I'm not really sure I see the upside.

A much more interesting change in this area, I think, would be to skip
verify-tag entirely. Once upon a time it had a lot of logic itself, but
these days it is a thin wrapper over run_gpg_verify(), and we could
improve the efficiency quite a bit by eliminates the sub-process
entirely.

-Peff
