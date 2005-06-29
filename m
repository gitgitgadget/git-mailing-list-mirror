From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] assorted delta code cleanup
Date: Wed, 29 Jun 2005 09:10:20 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.29.07.10.16.473252@smurf.noris.de>
References: <Pine.LNX.4.63.0506290246130.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Jun 29 09:07:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnWfI-0002Ux-FO
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 09:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVF2HOD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 03:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVF2HLo
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 03:11:44 -0400
Received: from main.gmane.org ([80.91.229.2]:59849 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262469AbVF2HKy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 03:10:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DnWbc-000203-Jl
	for git@vger.kernel.org; Wed, 29 Jun 2005 09:03:32 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jun 2005 09:03:32 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jun 2005 09:03:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Nicolas Pitre wrote:

> This is a wrap-up patch including all the cleanups I've done to the
> delta code and its usage. 

FWIW, I think Linus said he'd prefer a do/while loop. In fact this old
code ...

> -static unsigned long parse_delta_size(unsigned char **p)
> -{
> -	unsigned char c;
> -	unsigned long size = 0;
> -	unsigned shift = 0;
> -	unsigned char *data = *p;
> -
> -	do {
> -		c = *data++;
> -		size += (c & 0x7f) << shift;
> -		shift += 7;
> -	} while (c & 0x80);
> -	*p = data;
> -	return size;
> -}
> -

... is IMHO much more readable than this ...

> +static inline unsigned long get_delta_hdr_size(const unsigned char **datap)
> +{
> +	const unsigned char *data = *datap;
> +	unsigned char cmd = *data++;
> +	unsigned long size = cmd & ~0x80;
> +	int i = 7;
> +	while (cmd & 0x80) {
> +		cmd = *data++;
> +		size |= (cmd & ~0x80) << i;
> +		i += 7;
> +	}
> +	*datap = data;
> +	return size;
> +}
> +

(except that the first += should be |= ).

Yeah, I know, it's nitpicking. Regard it as a testimony to the code's
quality that I didn't see worse. ;-)

NB, it might be a good idea to exit with an error if the shift exceeds 31.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
When it's fall in New York, the air smells as if someone's been frying
goats in it, and if you are keen to breathe the best plan is to open a
window and stick your head in a building.
		-- The Hitch Hiker's Guide to the Galaxy
