From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/5] archimport: don't die on merge-base failure
Date: Sat, 12 Nov 2005 01:27:22 -0800
Message-ID: <20051112092721.GC16218@Muzzle>
References: <20051112092336.GA16218@Muzzle> <20051112092533.GB16218@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 10:27:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EarfS-0005ld-Kx
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 10:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVKLJ1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 04:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVKLJ1Y
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 04:27:24 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39821 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932260AbVKLJ1X (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 04:27:23 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id 842E12DC03B;
	Sat, 12 Nov 2005 01:27:22 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sat, 12 Nov 2005 01:27:22 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051112092533.GB16218@Muzzle>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11664>

Don't die if we can't find a merge base, Arch allows arbitrary
cherry-picks between unrelated branches and we should not
die when that happens

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

applies-to: 07dfd96ba53890d6a20fa0b028cf96e0e49bc027
7d099adadc041d74a0defc107656f273b35f57cb
diff --git a/git-archimport.perl b/git-archimport.perl
index 7c15184..699d5f6 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -693,7 +693,13 @@ sub find_parents {
 	next unless -e "$git_dir/refs/heads/$branch";
 
 	my $mergebase = `git-merge-base $branch $ps->{branch}`;
-	die "Cannot find merge base for $branch and $ps->{branch}" if $?;
+ 	if ($?) { 
+ 	    # Don't die here, Arch supports one-way cherry-picking
+ 	    # between branches with no common base (or any relationship
+ 	    # at all beforehand)
+ 	    warn "Cannot find merge base for $branch and $ps->{branch}";
+ 	    next;
+ 	}
 	chomp $mergebase;
 
 	# now walk up to the mergepoint collecting what patches we have
---
0.99.9.GIT
