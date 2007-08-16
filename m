From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] pack-objects: remove bogus arguments to delta_cacheable()
Date: Thu, 16 Aug 2007 08:18:13 +0200
Message-ID: <20070816061813.GA4384@auto.tuwien.ac.at>
References: <alpine.LFD.0.999.0708152241430.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 08:18:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILYgj-0000vW-Us
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 08:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757793AbXHPGSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 02:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbXHPGSR
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 02:18:17 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:52852 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbXHPGSP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 02:18:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 6A9EF7437BF8;
	Thu, 16 Aug 2007 08:18:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4N1fvyXJSn-5; Thu, 16 Aug 2007 08:18:14 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id F24CB68018F2; Thu, 16 Aug 2007 08:18:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708152241430.16727@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55980>

On Wed, Aug 15, 2007 at 10:46:01PM -0400, Nicolas Pitre wrote:
> Not only are they unused, but the order in the function declaration
> and the actual usage don't match.

The wrong order of the parameters is my fault. 

I added the parameters for struct unpacked, because delta_cacheable
was intended as generic policy handler, which can take any decission based on
the available information of the source and the target entry (which can be
found through struct unpacked).

I have no objections againsts removing them, as they can be added again, if a (new)
policy algorithm needs more inforation.

> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 51a850e..24926db 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1273,9 +1273,8 @@ struct unpacked {
>  	unsigned depth;
>  };
>  
> -static int delta_cacheable(struct unpacked *trg, struct unpacked *src,
> -			    unsigned long src_size, unsigned long trg_size,
> -			    unsigned long delta_size)
> +static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
> +			   unsigned long delta_size)
>  {
>  	if (max_delta_cache_size && delta_cache_size + delta_size > max_delta_cache_size)
>  		return 0;
> @@ -1397,7 +1396,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>  	trg_entry->delta_size = delta_size;
>  	trg->depth = src->depth + 1;
>  
> -	if (delta_cacheable(src, trg, src_size, trg_size, delta_size)) {
> +	if (delta_cacheable(src_size, trg_size, delta_size)) {
>  		trg_entry->delta_data = xrealloc(delta_buf, delta_size);
>  		delta_cache_size += trg_entry->delta_size;
>  	} else
