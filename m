From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 8/8] git-gc --auto: run "repack -A -d -l" as necessary.
Date: Mon, 17 Sep 2007 10:53:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709171044170.28586@racer.site>
References: <11900186941912-git-send-email-gitster@pobox.com>
 <1190018716666-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXDJG-0001Rf-UN
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbXIQJy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbXIQJy0
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:54:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:43140 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbXIQJyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:54:25 -0400
Received: (qmail invoked by alias); 17 Sep 2007 09:54:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 17 Sep 2007 11:54:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yjrpF76DySmgm5fkNIqLOXRu9yxLsq5XEs5fZoy
	JFUpeMQSsFcl5n
X-X-Sender: gene099@racer.site
In-Reply-To: <1190018716666-git-send-email-gitster@pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58422>

Hi,

On Mon, 17 Sep 2007, Junio C Hamano wrote:

> diff --git a/builtin-gc.c b/builtin-gc.c
> index 34ce35b..a82f6be 100644
> --- a/builtin-gc.c
> +++ b/builtin-gc.c
> @@ -78,6 +83,9 @@ static int too_many_loose_objects(void)
>  	int num_loose = 0;
>  	int needed = 0;
>  
> +	if (gc_auto_threshold <= 0)
> +		return 0;
> +

Heh, patch 6/8 explicitely moved this check out of the function.

> @@ -100,21 +108,58 @@ static int too_many_loose_objects(void)
>  	return needed;
>  }
>  
> +static int too_many_packs(void)
> +{
> +	struct packed_git *p;
> +	int cnt;
> +
> +	if (gc_auto_pack_limit <= 0)
> +		return 0;
> +
> +	for (cnt = 0, p = packed_git; p; p = p->next) {
> +		char *suffix;
> +		int keep;
> +		if (!p->pack_local)
> +			continue;
> +		suffix = p->pack_name + strlen(p->pack_name) - 5;

I suspect that you need something like

		int len;
		len = strlen(p->pack_name);
		if (len < 5)
			continue;

before this.

> +		if (memcmp(suffix, ".pack", 6))
> +			continue;
> +		memcpy(suffix, ".keep", 6);
> +		keep = access(p->pack_name, F_OK) && (errno == ENOENT);
> +		memcpy(suffix, ".pack", 6);

Heh.  Took me some looking around to see why this is allowed...

>  static int need_to_gc(void)
>  {
>  	int ac = 0;
>  
>  	/*
> -	 * Setting gc.auto to 0 or negative can disable the
> -	 * automatic gc
> +	 * Setting gc.auto and gc.autopacklimit to 0 or negative can
> +	 * disable the automatic gc.
>  	 */
> -	if (gc_auto_threshold <= 0)
> -		return 0;
> -
> -	if (!too_many_loose_objects())
> +	if (gc_auto_threshold <= 0 && gc_auto_pack_limit <= 0)
>  		return 0;
>  
> +	/*
> +	 * If there are too many loose objects, but not too many
> +	 * packs, we run "repack -d -l".  If there are too many packs,
> +	 * we run "repack -A -d -l".  Otherwise we tell the caller
> +	 * there is no need.
> +	 */
>  	argv_repack[ac++] = "repack";
> +	if (too_many_packs())
> +		argv_repack[ac++] = "-A";
> +	if (!too_many_loose_objects() && ac == 1)
> +		return 0;

Why not

	else if (!too_many_loose_objects())
		return 0;

Hmm?

Ciao,
Dscho
