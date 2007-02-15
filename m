From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] import-tars: use Archive::Tar instead of unpack()
Date: Wed, 14 Feb 2007 21:51:59 -0500
Message-ID: <20070215025159.GA29944@spearce.org>
References: <1171289831.629.6.camel@ibook.zvpunry.de> <20070212172848.GC29621@spearce.org> <1171468992.629.68.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Loeffler <zvpunry@zvpunry.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 03:52:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHWjH-0000HD-Tu
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 03:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbXBOCwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 21:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbXBOCwG
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 21:52:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57887 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964874AbXBOCwF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 21:52:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHWis-0005ST-34; Wed, 14 Feb 2007 21:51:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0F5D620FBAE; Wed, 14 Feb 2007 21:51:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1171468992.629.68.camel@ibook.zvpunry.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39793>

Michael Loeffler <zvpunry@zvpunry.de> wrote:
> In the Archive::Tar manpage they use gunzip and uncompress instead of
> zcat or gzcat, so what do you think about the following patch?
> 
> diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
> index 990c9e7..5585a8b 100755
> --- a/contrib/fast-import/import-tars.perl
> +++ b/contrib/fast-import/import-tars.perl
> @@ -25,11 +25,14 @@ foreach my $tar_file (@ARGV)
>  	my $tar_name = $1;
>  
>  	if ($tar_name =~ s/\.(tar\.gz|tgz)$//) {
> -		open(I, '-|', 'gzcat', $tar_file) or die "Unable to gzcat $tar_file: $!\n";
> +		open(I, '-|', 'gunzip', '-c', $tar_file)
> +			or die "Unable to gunzip -c $tar_file: $!\n";
>  	} elsif ($tar_name =~ s/\.(tar\.bz2|tbz2)$//) {
> -		open(I, '-|', 'bzcat', $tar_file) or die "Unable to bzcat $tar_file: $!\n";
> +		open(I, '-|', 'bunzip2', '-c', $tar_file)
> +			or die "Unable to bunzip2 -c $tar_file: $!\n";
>  	} elsif ($tar_name =~ s/\.tar\.Z$//) {
> -		open(I, '-|', 'zcat', $tar_file) or die "Unable to zcat $tar_file: $!\n";
> +		open(I, '-|', 'uncompress', '-c', $tar_file)
> +			or die "Unable to uncompress -c $tar_file: $!\n";
>  	} elsif ($tar_name =~ s/\.tar$//) {
>  		open(I, $tar_file) or die "Unable to open $tar_file: $!\n";
>  	} else {

Yes, that's what I should have done initially.  Thanks.  How about
the following message and sbo?

commit 908387056949c0fb8153fbb84f4dbeb6695611e6
Author: Michael Loeffler <zvpunry@zvpunry.de>
Date:   Wed Feb 14 17:03:12 2007 +0100

    Use gunzip -c over gzcat in import-tars example.
    
    Not everyone has gzcat or bzcat installed on their system, but
    gunzip -c and bunzip2 -c perform the same task and are available
    if the user has installed gzip support or bzip2 support.
    
    Signed-off-by: Michael Loeffler <zvpunry@zvpunry.de>
    Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
