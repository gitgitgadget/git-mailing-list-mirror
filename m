From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rerere: fix memory leak if rerere images can't be read
Date: Tue, 23 Feb 2010 22:26:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002232225480.3980@intel-tinevez-2-302>
References: <1266955913-4943-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:26:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2HS-0004Ag-CK
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab0BWV0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:26:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:45130 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753779Ab0BWV0w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:26:52 -0500
Received: (qmail invoked by alias); 23 Feb 2010 21:26:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp007) with SMTP; 23 Feb 2010 22:26:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CcU9TmVRCYYjKXOaGOwtXcbVbc/sf8egYCGkk0j
	R/7nBHdUFUfIBR
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1266955913-4943-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140842>

Hi,

On Tue, 23 Feb 2010, Bert Wesarg wrote:

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  rerere.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

Looks good to me, except...

> diff --git a/rerere.c b/rerere.c
> index d1d3e75..9ca4cb8 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -364,16 +364,17 @@ static int find_conflict(struct string_list *conflict)
>  static int merge(const char *name, const char *path)
>  {
>  	int ret;
> -	mmfile_t cur, base, other;
> +	mmfile_t cur = {NULL, 0}, base = {NULL, 0}, other = {NULL, 0};
>  	mmbuffer_t result = {NULL, 0};
>  
>  	if (handle_file(path, NULL, rerere_path(name, "thisimage")) < 0)
>  		return 1;
>  
> +	ret = 1;

This initialization can come earlier, at declaration time.

>  	if (read_mmfile(&cur, rerere_path(name, "thisimage")) ||
>  			read_mmfile(&base, rerere_path(name, "preimage")) ||
>  			read_mmfile(&other, rerere_path(name, "postimage")))
> -		return 1;
> +		goto out;
>  	ret = ll_merge(&result, path, &base, &cur, "", &other, "", 0);
>  	if (!ret) {
>  		FILE *f = fopen(path, "w");

Ciao,
Dscho
