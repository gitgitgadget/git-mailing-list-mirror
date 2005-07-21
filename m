From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH/RFC] Add git-changelog-script to show the changes between two commits
Date: Thu, 21 Jul 2005 15:41:38 -0400
Message-ID: <20050721194138.GP20369@mythryan2.michonline.com>
References: <20050721063143.GO20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jul 21 21:42:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dvgva-00065m-J2
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 21:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVGUTlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 15:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVGUTlo
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 15:41:44 -0400
Received: from mail.autoweb.net ([198.172.237.26]:4314 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261857AbVGUTll (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2005 15:41:41 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DvgvL-0001Hy-CX; Thu, 21 Jul 2005 15:41:39 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dvh3U-00088l-00; Thu, 21 Jul 2005 15:50:04 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DvgvK-0007iY-K0; Thu, 21 Jul 2005 15:41:38 -0400
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20050721063143.GO20369@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Nevermind, I apparently wanted:
	git-whatchanged HEAD ^$LAST_RELEASED_COMMIT

I'll see about writing up a description of the extended commit reference
scheme.  Currently I can't find a description of it anywhere in the
source tree.

On Thu, Jul 21, 2005 at 02:31:43AM -0400, Ryan Anderson wrote:
> I'll start by saying that, well, I'm pretty sure this patch is wrong.
> 
> I was trying to look at the changes between two commits, sanely, but
> failed to find a tool or example in the tree that hinted at how to do
> this.
> 
> After poking around at git-whatchanged trying to figure out what it is
> trying to do - I gave up and wrote something that *seems* to work
> correctly for the simple test cases I pulled together.  I just don't
> trust it.
> 
> My thinking here is that, when doing a release of a package such as git
> or Linux, the releaser could do something like:
> 
> 	git changelog $LAST_RELEASED_COMMIT HEAD | git-shortlog |\
> 		mail -s "Linux 2.7.0 finally open" linux-kernel
> 
> Where LAST_RELEASED is recorded somewhere or pulled from an internal
> changelog with something like:
> 	grep "Released commit-id:" changelog | awk -F: '{print $2}'" |\
> 		head -1
> 
> Signed-off-by: Ryan Anderson <ryan@michonline.com>
> 
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -36,7 +36,8 @@ SCRIPTS=git git-apply-patch-script git-m
>  	git-reset-script git-add-script git-checkout-script git-clone-script \
>  	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
>  	git-format-patch-script git-sh-setup-script git-push-script \
> -	git-branch-script git-parse-remote
> +	git-branch-script git-parse-remote \
> +	git-changelog-script git-revdiff-script
>  
>  PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
>  	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
> diff --git a/git-changelog-script b/git-changelog-script
> new file mode 100755
> --- /dev/null
> +++ b/git-changelog-script
> @@ -0,0 +1,3 @@
> +#!/bin/sh
> +
> +git-revdiff-script $@ | git-diff-tree --stdin --pretty -r | LESS="$LESS -S" ${PAGER:-less}
> diff --git a/git-revdiff-script b/git-revdiff-script
> new file mode 100755
> --- /dev/null
> +++ b/git-revdiff-script
> @@ -0,0 +1,18 @@
> +#!/usr/bin/perl
> +
> +use warnings;
> +use strict;
> +
> +my ($start,$end) = @ARGV;
> +
> +open(R,"-|","git-rev-list",$start)
> +	or die "Failed to pipe from git-rev-list: " . $!;
> +
> +my $rev;
> +while ($rev = <R>) {
> +	chomp $rev;
> +	print $rev,"\n";
> +	last if $end eq $rev;
> +}
> +
> +close(R);
> 
> 
> -- 
> 
> Ryan Anderson
>   sometimes Pug Majere
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Ryan Anderson
  sometimes Pug Majere
