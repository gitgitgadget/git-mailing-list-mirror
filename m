From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push.c: DAV must support olny http and https scheme
Date: Sun, 12 Apr 2009 01:48:05 -0700
Message-ID: <7vd4bi9s1m.fsf@gitster.siamese.dyndns.org>
References: <1239371060-3978-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Sun Apr 12 10:49:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsvNk-0008E5-6d
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 10:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278AbZDLIsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 04:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757246AbZDLIsL
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 04:48:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208AbZDLIsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 04:48:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 67D07E0C8;
	Sun, 12 Apr 2009 04:48:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BCDECE0C7; Sun,
 12 Apr 2009 04:48:06 -0400 (EDT)
In-Reply-To: <1239371060-3978-1-git-send-email-catap@catap.ru> (Kirill A.
 Korinskiy's message of "Fri, 10 Apr 2009 17:44:20 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A5FFCF18-273E-11DE-B23F-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116375>

"Kirill A. Korinskiy" <catap@catap.ru> writes:

> If the response from remote web-server have scp or other not http-like
> scheme http-push can't go to change url, because DAV must work only
> over HTTP (http and https scheme).
>
> Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
> ---
>  http-push.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index feeb340..48c9a04 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1457,16 +1457,17 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
>  			}
>  		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
>  			char *path = ctx->cdata;
> -			if (*ctx->cdata == 'h') {
> -				path = strstr(path, "//");
> -				if (path) {
> -					path = strchr(path+2, '/');
> -				}
> -			}
> -			if (path) {
> -				path += repo->path_len;
> -				ls->dentry_name = xstrdup(path);
> +			if (!strcmp(ctx->cdata, "http://")) {
> +				path = strchr(path + sizeof("http://") - 1, '/');
> +			} else if (!strcmp(ctx->cdata, "https://")) {
> +				path = strchr(path + sizeof("https://") - 1, '/');
>  			}
> +
> +			path += remote->path_len;

http-push.c: In function 'handle_remote_ls_ctx':
http-push.c:1466: error: 'remote' undeclared (first use in this function)
http-push.c:1466: error: (Each undeclared identifier is reported only once
http-push.c:1466: error: for each function it appears in.)

Ah, crap.

> +			ls->dentry_name = xmalloc(strlen(path) -
> +						  remote->path_len + 1);
> +			strcpy(ls->dentry_name, path + remote->path_len);
>  		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
>  			ls->dentry_flags |= IS_DIR;
>  		}
> -- 
> 1.6.2
