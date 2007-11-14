From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Don't allow fast-import tree delta chains to exceed maximum depth
Date: Wed, 14 Nov 2007 00:54:34 -0500
Message-ID: <20071114055434.GG14735@spearce.org>
References: <20071114044842.GA6876@spearce.org> <7vhcjpnzvq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 06:55:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsBDJ-0006OZ-Jy
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 06:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763998AbXKNFyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 00:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763953AbXKNFyk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 00:54:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53527 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763785AbXKNFyi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 00:54:38 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IsBCu-0006So-GA; Wed, 14 Nov 2007 00:54:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E4D2020FBAE; Wed, 14 Nov 2007 00:54:34 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vhcjpnzvq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64951>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > +	uint32_t type : TYPE_BITS,
> > +		pack_id : PACK_ID_BITS,
> > +		depth : DEPTH_BITS;
> 
> uint32_t with bit-width specifiers look somewhat funny here...

Sure.  But the prior item is also uint32_t and before that a pointer
so it aligns out nice.  And we're using exactly 32 bits in this field.
So it just sort of made sense to me to declare it was a uint32_t.
 
> > @@ -1105,7 +1108,7 @@ static int store_object(
> >  		unsigned pos = sizeof(hdr) - 1;
> >  
> >  		delta_count_by_type[type]++;
> > -		last->depth++;
> > +		e->depth = ++last->depth++;
> 
> "lvalue required as increment operand"?
> 
> Wouldn't it be easier to read like this?

Yes.  Good call.  :-)
 
> diff --git a/fast-import.c b/fast-import.c
> index 7544949..d32c412 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -161,7 +161,7 @@ struct object_entry
>  {
>  	struct object_entry *next;
>  	uint32_t offset;
> -	uint32_t type : TYPE_BITS,
> +	unsigned type : TYPE_BITS,
>  		pack_id : PACK_ID_BITS,
>  		depth : DEPTH_BITS;
>  	unsigned char sha1[20];
> @@ -1108,7 +1108,7 @@ static int store_object(
>  		unsigned pos = sizeof(hdr) - 1;
>  
>  		delta_count_by_type[type]++;
> -		e->depth = ++last->depth++;
> +		e->depth = last->depth + 1;
>  
>  		hdrlen = encode_header(OBJ_OFS_DELTA, deltalen, hdr);
>  		write_or_die(pack_data->pack_fd, hdr, hdrlen);
> @@ -1121,8 +1121,6 @@ static int store_object(
>  		pack_size += sizeof(hdr) - pos;
>  	} else {
>  		e->depth = 0;
> -		if (last)
> -			last->depth = 0;
>  		hdrlen = encode_header(type, datlen, hdr);
>  		write_or_die(pack_data->pack_fd, hdr, hdrlen);
>  		pack_size += hdrlen;
> @@ -1138,6 +1136,7 @@ static int store_object(
>  			free(last->data);
>  		last->data = dat;
>  		last->offset = e->offset;
> +		last->depth = e->depth;
>  		last->len = datlen;
>  	}
>  	return 0;

-- 
Shawn.
