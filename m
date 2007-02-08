From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] fast-import: Fix compile warnings
Date: Thu, 8 Feb 2007 02:03:42 -0500
Message-ID: <20070208070342.GA3746@spearce.org>
References: <Pine.LNX.4.63.0702071237360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 08:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF3Jz-0002mi-3v
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 08:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422898AbXBHHDs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 02:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422914AbXBHHDs
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 02:03:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58478 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422898AbXBHHDr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 02:03:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HF3Jp-00066x-2A; Thu, 08 Feb 2007 02:03:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DC69B20FBAE; Thu,  8 Feb 2007 02:03:42 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702071237360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39033>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Not on all platforms are size_t and unsigned long equivalent.
> Since I do not know how portable %z is, I play safe, and just
> cast the respective variables to unsigned long.

We do this elsewhere in Git.  blobs are using unsigned long in
sha1_file.c for their length; I chose to size_t in gfi as that's
what the type is for...  but then look at the mess.

I applied this patch to my tree and pushed it to repo.or.cz.
This last hunk:
 
> @@ -2028,7 +2030,8 @@ int main(int argc, const char **argv)
>  	fprintf(stderr, "      marks:     %10ju (%10ju unique    )\n", (((uintmax_t)1) << marks->shift) * 1024, marks_set_count);
>  	fprintf(stderr, "      atoms:     %10u\n", atom_cnt);
>  	fprintf(stderr, "Memory total:    %10ju KiB\n", (total_allocd + alloc_count*sizeof(struct object_entry))/1024);
> -	fprintf(stderr, "       pools:    %10lu KiB\n", total_allocd/1024);
> +	fprintf(stderr, "       pools:    %10lu KiB\n",
> +		(unsigned long)(total_allocd / 1024));
>  	fprintf(stderr, "     objects:    %10ju KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
>  	fprintf(stderr, "---------------------------------------------------------------------\n");
>  	pack_report();

was the only part that did not apply cleanly, but that was easily
fixed by tossing an extra tab at the start of each line, as this
hunk was shifted in one level by a recent commit that Junio has
not pushed out to master.

-- 
Shawn.
