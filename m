From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add description of OFS_DELTA to the pack format description
Date: Sun, 6 Apr 2008 15:07:24 -0400
Message-ID: <20080406190724.GG10274@spearce.org>
References: <20080406134739.GA29815@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Sun Apr 06 21:08:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiaDr-0002s1-6o
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 21:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbYDFTH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 15:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbYDFTH2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 15:07:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59436 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbYDFTH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 15:07:27 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JiaD0-00014i-3k; Sun, 06 Apr 2008 15:07:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7BEAB20FBAE; Sun,  6 Apr 2008 15:07:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080406134739.GA29815@bohr.gbar.dtu.dk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78915>

Peter Eriksen <s022018@student.dtu.dk> wrote:
> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
> index aa87756..f6b1405 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -103,10 +103,20 @@ Pack file entry: <+
>       packed object data:
>          If it is not DELTA, then deflated bytes (the size above
>  		is the size before compression).
> -	If it is DELTA, then
> +	If it is REF_DELTA, then
>  	  20-byte base object name SHA1 (the size above is the
>  		size of the delta data that follows).
>            delta data, deflated.
> +	If it is OFS_DELTA, then
> +	  n-byte offset (see below) (the size above is the
> +		size of the delta data that follows).
> +          delta data, deflated.

You are missing the description that the position within _this_
packfile is determined by:

	offset_of_type_byte - n_byte_offset

The above can still be taken to mean the offset is from the start
of the packfile or something like that.

> +     offset encoding:
> +          n bytes with MSB set in all but the last one.
> +          The offset is then the number constructed by
> +          concatenating the lower 7 bit of each byte, and
> +          adding 2^7 + 2^14 + ... + 2^(7*(n-1)) to the result.

Hmm.  I've just spent 5 minutes reading this and I'm still not
certain what the result is.  2^0 only gets added to the result if
there is at least 2 bytes of data in the offset encoding; in your
description above it sounds like we should add 2^0 (1) even when
there is only 1 offset byte (n=1), which is not correct.

-- 
Shawn.
