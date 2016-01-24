From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] convert: legitimately disable clean/smudge filter with
 an empty override
Date: Sun, 24 Jan 2016 16:45:00 -0500
Message-ID: <20160124214459.GA31091@sigill.intra.peff.net>
References: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jehan@orb.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sun Jan 24 22:45:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNST5-0005i5-OW
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 22:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbcAXVpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 16:45:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:59586 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751928AbcAXVpC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 16:45:02 -0500
Received: (qmail 11740 invoked by uid 102); 24 Jan 2016 21:45:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 16:45:02 -0500
Received: (qmail 12248 invoked by uid 107); 24 Jan 2016 21:45:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 16:45:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jan 2016 16:45:00 -0500
Content-Disposition: inline
In-Reply-To: <1453638170-52041-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284695>

On Sun, Jan 24, 2016 at 01:22:50PM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> A clean/smudge filter can be disabled if set to an empty string. However,
> Git will try to run the empty string as command which results in a error
> message per processed file.
> 
> Teach Git to consider an empty clean/smudge filter as legitimately disabled
> and do not print an error message.

That makes sense to me, as I do not think the empty filter name can
possibly do anything useful. You omitted the real motivation here, but I
know what it is from past discussions: you want to be able to
temporarily disable a filter with "git -c filter.foo.clean= ...". Which
I think makes it more immediately obvious that this is a useful thing to
have, and not just user error.

> diff --git a/convert.c b/convert.c
> index 814e814..58af965 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -786,7 +786,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
>  	struct conv_attrs ca;
> 
>  	convert_attrs(&ca, path);
> -	if (ca.drv) {
> +	if (ca.drv && ca.drv->clean && strlen(ca.drv->clean)) {
>  		filter = ca.drv->clean;
>  		required = ca.drv->required;
>  	}
> @@ -835,7 +835,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
>  	struct conv_attrs ca;
> 
>  	convert_attrs(&ca, path);
> -	if (ca.drv) {
> +	if (ca.drv && ca.drv->smudge && strlen(ca.drv->smudge)) {
>  		filter = ca.drv->smudge;
>  		required = ca.drv->required;
>  	}

This catches two calls, but I think there are others. What about
would_convert_to_git_filter_fd and convert_to_git_filter_fd?

Would it make more sense for apply_filter() to treat the empty string as
a noop, just as it does for NULL?

I.e.:


diff --git a/convert.c b/convert.c
index 814e814..02d5f1e 100644
--- a/convert.c
+++ b/convert.c
@@ -395,7 +395,7 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
 	struct async async;
 	struct filter_params params;
 
-	if (!cmd)
+	if (!cmd || !*cmd)
 		return 0;
 
 	if (!dst)

which I think would cover all callers?

-Peff
