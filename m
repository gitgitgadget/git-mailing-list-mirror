From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push: support full URI in handle_remote_ls_ctx()
Date: Mon, 29 Dec 2008 08:17:10 +0100
Organization: glandium.org
Message-ID: <20081229071710.GA19175@glandium.org>
References: <7vmyekag6p.fsf@gitster.siamese.dyndns.org> <1230517935-11299-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Mon Dec 29 08:19:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHCPg-00079a-FT
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 08:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbYL2HNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 02:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbYL2HNU
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 02:13:20 -0500
Received: from vuizook.err.no ([194.24.252.247]:48156 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320AbYL2HNU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 02:13:20 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LHCJJ-0004DI-Qh; Mon, 29 Dec 2008 08:13:12 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LHCNC-0005Kc-Kv; Mon, 29 Dec 2008 08:17:10 +0100
Content-Disposition: inline
In-Reply-To: <1230517935-11299-1-git-send-email-catap@catap.ru>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104076>

On Mon, Dec 29, 2008 at 05:32:15AM +0300, Kirill A. Korinskiy wrote:
> The program calls remote_ls() to get list of files from the server
> over HTTP; handle_remote_ls_ctx() is used to parse its response to
> populate "struct remote_ls_ctx" that is returned from remote_ls().
> 
> The handle_remote_ls_ctx() function assumed that the server returns a
> local path in href field, but RFC 4918 (14.7) demand of support full
> URI (e.g. "http://localhost:8080/repo.git").
> 
> This resulted in push failure (e.g. git-http-push issues a PROPFIND
> request to "/repo.git/alhost:8080/repo.git/refs/" to the server).
> 
> Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
> ---
>  http-push.c |   25 +++++++++++++++++++------
>  1 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/http-push.c b/http-push.c
> index 7c6460919bf3eba10c46cede11ffdd9c53fd2dd2..a4b7d08663504a57008f66a39fffe293f62c1d08 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -87,6 +87,7 @@ static struct object_list *objects;
>  struct repo
>  {
>  	char *url;
> +	char *path;
>  	int path_len;
>  	int has_info_refs;
>  	int can_update_info_refs;
> @@ -1424,9 +1425,19 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
>  				ls->userFunc(ls);
>  			}
>  		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
> -			ls->dentry_name = xmalloc(strlen(ctx->cdata) -
> +			char *path = ctx->cdata;
> +			if (*ctx->cdata == 'h') {
> +				path = strstr(path, "//");

I would make that a "://"

> +				if (path) {
> +					path = strchr(path+2, '/');

and s/2/3/, accordingly.

But I realize the existing code already does something like what your
are doing...

Mike
