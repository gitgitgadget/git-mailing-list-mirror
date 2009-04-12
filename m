From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push.c: DAV must support olny http and https scheme
Date: Sun, 12 Apr 2009 12:33:20 -0700
Message-ID: <7vskkd651b.fsf@gitster.siamese.dyndns.org>
References: <7vd4bi9s1m.fsf@gitster.siamese.dyndns.org>
 <1239562146-32133-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Sun Apr 12 21:35:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt5SL-00077C-NG
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 21:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbZDLTd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 15:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbZDLTd3
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 15:33:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbZDLTd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 15:33:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DCF1AAA7C7;
	Sun, 12 Apr 2009 15:33:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6669FAA7C6; Sun,
 12 Apr 2009 15:33:23 -0400 (EDT)
In-Reply-To: <1239562146-32133-1-git-send-email-catap@catap.ru> (Kirill A.
 Korinskiy's message of "Sun, 12 Apr 2009 22:49:06 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CC00F7FA-2798-11DE-B265-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116391>

"Kirill A. Korinskiy" <catap@catap.ru> writes:

> If the response from remote web-server have scp or other not http-like
> scheme http-push can't go to change url, because DAV must work only
> over HTTP (http and https scheme).
>
> Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
> ---

Thanks.  I was wondering about a few more things about the patch and the
original code.

>  http-push.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index feeb340..cce9ead 100644
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

The original protects against an unexpected ctx->cdata such as

	http://frotz

that does not have any slash after the method:// part (in which case it
does not even set ls_dentry_name.


> +			if (!strcmp(ctx->cdata, "http://")) {
> +				path = strchr(path + sizeof("http://") - 1, '/');
> +			} else if (!strcmp(ctx->cdata, "https://")) {
> +				path = strchr(path + sizeof("https://") - 1, '/');

I wonder what happens if the strchr() returns NULL for such a broken
ctx->cdata.  Will it make strlen(path) later to segfault?

Besides, obviously this patch was never tested; you meant prefixcmp, not
strcmp here, so path never becomes NULL here.  Oh, and instead of
comparing with ctx->cdata it would be easier to compare against path.

>  			}
> +
> +			path += repo->path_len;
> +
> +			ls->dentry_name = xmalloc(strlen(path) -
> +						  repo->path_len + 1);
> +			strcpy(ls->dentry_name, path + repo->path_len);
>  		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
>  			ls->dentry_flags |= IS_DIR;
>  		}
> -- 
> 1.6.2
