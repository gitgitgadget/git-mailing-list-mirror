From: Jeff King <peff@peff.net>
Subject: Re: git cat-file -e behavior
Date: Mon, 29 Feb 2016 07:40:32 -0500
Message-ID: <20160229124032.GA21158@sigill.intra.peff.net>
References: <56D41645.4050800@cihar.com>
 <20160229114455.GD29769@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michal =?utf-8?B?xIxpaGHFmQ==?= <michal@cihar.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 13:40:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaN7v-0006cT-2m
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 13:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbcB2Mkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 07:40:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:51368 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752129AbcB2Mkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 07:40:35 -0500
Received: (qmail 17716 invoked by uid 102); 29 Feb 2016 12:40:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 07:40:34 -0500
Received: (qmail 25908 invoked by uid 107); 29 Feb 2016 12:40:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 07:40:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 07:40:32 -0500
Content-Disposition: inline
In-Reply-To: <20160229114455.GD29769@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287833>

On Mon, Feb 29, 2016 at 06:44:55AM -0500, Jeff King wrote:

> [...]but it would be easy to change:
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 54db118..afde169 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -35,6 +35,9 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  	if (unknown_type)
>  		flags |= LOOKUP_UNKNOWN_OBJECT;
>  
> +	if (opt == 'e')
> +		return !has_sha1_file(sha1);
> +
>  	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
>  		die("Not a valid object name %s", obj_name);
>  
> @@ -58,9 +61,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  		printf("%lu\n", size);
>  		return 0;
>  
> -	case 'e':
> -		return !has_sha1_file(sha1);
> -
>  	case 'c':
>  		if (!obj_context.path[0])
>  			die("git cat-file --textconv %s: <object> must be <sha1:path>",

This is wrong, of course. We still need to call get_sha1, but just need
to not die. So it's more like this (totally untested, naturally):

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 54db118..44add8c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -35,8 +35,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	if (unknown_type)
 		flags |= LOOKUP_UNKNOWN_OBJECT;
 
-	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
+	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context)) {
+		if (opt == 'e')
+			return 1;
 		die("Not a valid object name %s", obj_name);
+	}
 
 	buf = NULL;
 	switch (opt) {

-Peff
