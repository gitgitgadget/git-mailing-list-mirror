From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] replace: fix replacing object with itself
Date: Sun, 9 Nov 2014 00:58:43 -0500
Message-ID: <20141109055842.GB13445@peff.net>
References: <1415491531-29913-1-git-send-email-manzurmm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Manzur Mukhitdinov <manzurmm@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 07:06:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnLe1-00068K-JT
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 07:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbaKIF6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 00:58:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:38143 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750952AbaKIF6p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 00:58:45 -0500
Received: (qmail 17729 invoked by uid 102); 9 Nov 2014 05:58:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 23:58:45 -0600
Received: (qmail 15787 invoked by uid 107); 9 Nov 2014 05:58:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Nov 2014 00:58:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Nov 2014 00:58:43 -0500
Content-Disposition: inline
In-Reply-To: <1415491531-29913-1-git-send-email-manzurmm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 09, 2014 at 01:05:31AM +0100, Manzur Mukhitdinov wrote:

> When object is replaced with itself git shows unhelpful messages like(git log):
>     "fatal: replace depth too high for object <SHA1>"
> 
> Prevents user from replacing object with itself(with test for checking
> this case).

I thought we already did this in the last round of git-replace patches,
but it looks like we only did it for the newly added --edit and --graft
cases, not "git replace X X". I think this is probably a good step. I've
also considered that this should be another way of deleting the
replacement, but I think we decided that was too magical.

> diff --git a/builtin/replace.c b/builtin/replace.c
> index 294b61b..b7e05ad 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -186,6 +186,9 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
>  	if (get_sha1(replace_ref, repl))
>  		die("Failed to resolve '%s' as a valid ref.", replace_ref);
>  
> +	if (!hashcmp(object, repl))
> +		return error("new object is the same as the old one: '%s'", sha1_to_hex(object));
> +
>  	return replace_object_sha1(object_ref, object, replace_ref, repl, force);

I think all of the callers of replace_object_sha1 do this same check
now. Can we just move the check into that function instead of adding
another instance of it?

-Peff
