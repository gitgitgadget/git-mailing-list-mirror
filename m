From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] import-tars: use Archive::Tar instead of unpack()
Date: Mon, 12 Feb 2007 12:28:48 -0500
Message-ID: <20070212172848.GC29621@spearce.org>
References: <1171289831.629.6.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Loeffler <zvpunry@zvpunry.de>
X-From: git-owner@vger.kernel.org Mon Feb 12 18:29:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGez4-0007hS-RK
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 18:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbXBLR24 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 12:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbXBLR2z
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 12:28:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59059 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964978AbXBLR2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 12:28:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGeyq-0007ad-Ki; Mon, 12 Feb 2007 12:28:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 042B720FBAE; Mon, 12 Feb 2007 12:28:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1171289831.629.6.camel@ibook.zvpunry.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39419>

Michael Loeffler <zvpunry@zvpunry.de> wrote:
> This version does no longer support bzip2 or compress which will be fixed in
> an amend. I did this patch to solve 2 problems. Maybe I do another patch with
> GetoptLong and bzip2/compress support.

bzip2 and compress are popular formats applied to tars.
 
> @@ -10,6 +10,10 @@
>  ##
>  
>  use strict;
> +use Archive::Tar;
> +use Archive::Tar::File;
> +use Archive::Tar::Constant;
> +

I did not apply this hunk.  Not everyone has Archive::Tar installed.
But then again, not everyone will use this example program either.
I'm debating it.  Archive::Tar's parser will certainly be much
more robust than the one I hand-crafted.  It might also let us deal
with symlinks.  ;)

I would considering applying something like this if it would also
support at least bz2.  This is an example program meant to teach
people how to use fast-import, and maybe also to help someone who
wants to quickly import one or more .tar.gz for use with git-grep.
Requiring Archive::Tar here is not the end of Git as we know it. :)

> @@ -83,10 +64,8 @@ EOF
>  	foreach my $path (keys %files)
>  	{
>  		my ($mark, $mode) = @{$files{$path}};
> -		my $git_mode = 0644;
> -		$git_mode |= 0700 if $mode & 0111;
>  		$path =~ s,^([^/]+)/,, if $have_top_dir;
> -		printf FI "M %o :%i %s\n", $git_mode, $mark, $path;
> +		printf FI "M %o :%i %s\n", $mode & 0111 ? 0755 : 0644, $mark, $path;
>  	}
>  	print FI "\n";

This hunk is completely unrelated to the Archive::Tar rewrite.
It also fixes a rather embarrassing bug on my part; I should
have been able to get the mode right!  :-)

I've applied this hunk (and only this hunk) to my fastimport tree
and pushed it out.

-- 
Shawn.
