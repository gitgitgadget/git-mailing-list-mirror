From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn performance
Date: Mon, 20 Oct 2014 01:16:01 +0000
Message-ID: <20141020011601.GA17345@dcvr.yhbt.net>
References: <CABBCAiv0WXNzo7W9PB_o_enLjtUO_rNRb4UBEqDPeSkBj1k-Ww@mail.gmail.com>
 <20141019003256.GA18532@dcvr.yhbt.net>
 <20141019022953.GA6537@dcvr.yhbt.net>
 <20141019023358.GA2946@dcvr.yhbt.net>
 <B5419560-60BC-4228-B1BA-9BAD5E4D58B9@2pi.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabian Schmied <fabian.schmied@gmail.com>, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com, Hin-Tak Leung <htl10@users.sourceforge.net>
To: Jakob Stoklund Olesen <stoklund@2pi.dk>
X-From: git-owner@vger.kernel.org Mon Oct 20 03:16:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xg1a6-0004zL-Ad
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 03:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbaJTBQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 21:16:05 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33265 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbaJTBQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 21:16:03 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BC844C00E;
	Mon, 20 Oct 2014 01:16:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <B5419560-60BC-4228-B1BA-9BAD5E4D58B9@2pi.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakob Stoklund Olesen <stoklund@2pi.dk> wrote:
> If cached_mergeinfo is using too much memory, you can probably drop
> that cache entirely. IIRC, it didn't give that much of a speed up.
> 
> I am surprised that it is using a lot of memory, though. There is only
> one entry per SVN branch.

Something like the below?  (on top of your original two patches)
Pushed to my master @ git://bogomips.org/git-svn.git

    Eric Wong (2):
          git-svn: reduce check_cherry_pick cache overhead
          git-svn: cache only mergeinfo revisions

    Jakob Stoklund Olesen (2):
          git-svn: only look at the new parts of svn:mergeinfo
          git-svn: only look at the root path for svn:mergeinfo

git-svn still seems to have some excessive memory usage problems,
even independenty of mergeinfo stuff.
--------------------------8<----------------------------
From: Eric Wong <normalperson@yhbt.net>
Date: Mon, 20 Oct 2014 01:02:53 +0000
Subject: [PATCH] git-svn: cache only mergeinfo revisions

This should reduce excessive memory usage from the new mergeinfo
caches without hurting performance too much, assuming reasonable
latency to the SVN server.

Cc: Hin-Tak Leung <htl10@users.sourceforge.net>
Suggested-by: Jakob Stoklund Olesen <stoklund@2pi.dk>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN.pm | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 171af37..f8a75b1 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1713,13 +1713,10 @@ sub mergeinfo_changes {
 	# Initialize cache on the first call.
 	unless (defined $self->{cached_mergeinfo_rev}) {
 		$self->{cached_mergeinfo_rev} = {};
-		$self->{cached_mergeinfo} = {};
 	}
 
 	my $cached_rev = $self->{cached_mergeinfo_rev}{$old_path};
-	if (defined $cached_rev && $cached_rev == $old_rev) {
-		$old_minfo = $self->{cached_mergeinfo}{$old_path};
-	} else {
+	unless (defined $cached_rev && $cached_rev == $old_rev) {
 		my $ra = $self->ra;
 		# Give up if $old_path isn't in the repo.
 		# This is probably a merge on a subtree.
@@ -1728,19 +1725,16 @@ sub mergeinfo_changes {
 				"directory didn't exist in r$old_rev\n";
 			return {};
 		}
-		my (undef, undef, $props) =
-			$self->ra->get_dir($old_path, $old_rev);
-		if (defined $props->{"svn:mergeinfo"}) {
-			my %omi = map {split ":", $_ } split "\n",
-				$props->{"svn:mergeinfo"};
-			$old_minfo = \%omi;
-		}
-		$self->{cached_mergeinfo}{$old_path} = $old_minfo;
-		$self->{cached_mergeinfo_rev}{$old_path} = $old_rev;
 	}
+	my (undef, undef, $props) = $self->ra->get_dir($old_path, $old_rev);
+	if (defined $props->{"svn:mergeinfo"}) {
+		my %omi = map {split ":", $_ } split "\n",
+			$props->{"svn:mergeinfo"};
+		$old_minfo = \%omi;
+	}
+	$self->{cached_mergeinfo_rev}{$old_path} = $old_rev;
 
 	# Cache the new mergeinfo.
-	$self->{cached_mergeinfo}{$path} = \%minfo;
 	$self->{cached_mergeinfo_rev}{$path} = $rev;
 
 	my %changes = ();
-- 
EW
