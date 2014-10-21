From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn performance
Date: Tue, 21 Oct 2014 09:00:56 +0000
Message-ID: <20141021090055.GA22184@dcvr.yhbt.net>
References: <CABBCAiv0WXNzo7W9PB_o_enLjtUO_rNRb4UBEqDPeSkBj1k-Ww@mail.gmail.com>
 <20141019003256.GA18532@dcvr.yhbt.net>
 <20141019022953.GA6537@dcvr.yhbt.net>
 <20141019023358.GA2946@dcvr.yhbt.net>
 <B5419560-60BC-4228-B1BA-9BAD5E4D58B9@2pi.dk>
 <20141020011601.GA17345@dcvr.yhbt.net>
 <00E02C52-67BC-461B-BF46-0EEDCFFFDFB1@2pi.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabian Schmied <fabian.schmied@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"sam@vilain.net" <sam@vilain.net>,
	"stevenrwalter@gmail.com" <stevenrwalter@gmail.com>,
	"waste.manager@gmx.de" <waste.manager@gmx.de>,
	"amyrick@apple.com" <amyrick@apple.com>,
	Hin-Tak Leung <htl10@users.sourceforge.net>
To: Jakob Stoklund Olesen <stoklund@2pi.dk>
X-From: git-owner@vger.kernel.org Tue Oct 21 11:01:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgVJW-0001NK-5n
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 11:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbaJUJBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 05:01:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49753 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754956AbaJUJA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 05:00:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E79F44C010;
	Tue, 21 Oct 2014 09:00:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <00E02C52-67BC-461B-BF46-0EEDCFFFDFB1@2pi.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakob Stoklund Olesen <stoklund@2pi.dk> wrote:
> Yes, but I think you can remove cached_mergeinfo_rev too. 

Thanks, pushed the patch at the bottom, too.
Also started working on some memory reductions here:
 http://mid.gmane.org/20141021033912.GA27462@dcvr.yhbt.net
But there seem to be more problems :<

----------------------------8<-----------------------------
From: Eric Wong <normalperson@yhbt.net>
Date: Tue, 21 Oct 2014 06:23:22 +0000
Subject: [PATCH] git-svn: remove mergeinfo rev caching

This should further reduce memory usage from the new mergeinfo
speedups without hurting performance too much, assuming
reasonable latency to the SVN server.

Cc: Hin-Tak Leung <htl10@users.sourceforge.net>
Suggested-by: Jakob Stoklund Olesen <stoklund@2pi.dk>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN.pm | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index f8a75b1..4364506 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1710,32 +1710,20 @@ sub mergeinfo_changes {
 	my %minfo = map {split ":", $_ } split "\n", $mergeinfo_prop;
 	my $old_minfo = {};
 
-	# Initialize cache on the first call.
-	unless (defined $self->{cached_mergeinfo_rev}) {
-		$self->{cached_mergeinfo_rev} = {};
-	}
-
-	my $cached_rev = $self->{cached_mergeinfo_rev}{$old_path};
-	unless (defined $cached_rev && $cached_rev == $old_rev) {
-		my $ra = $self->ra;
-		# Give up if $old_path isn't in the repo.
-		# This is probably a merge on a subtree.
-		if ($ra->check_path($old_path, $old_rev) != $SVN::Node::dir) {
-			warn "W: ignoring svn:mergeinfo on $old_path, ",
-				"directory didn't exist in r$old_rev\n";
-			return {};
-		}
-	}
-	my (undef, undef, $props) = $self->ra->get_dir($old_path, $old_rev);
+	my $ra = $self->ra;
+	# Give up if $old_path isn't in the repo.
+	# This is probably a merge on a subtree.
+	if ($ra->check_path($old_path, $old_rev) != $SVN::Node::dir) {
+		warn "W: ignoring svn:mergeinfo on $old_path, ",
+			"directory didn't exist in r$old_rev\n";
+		return {};
+	}
+	my (undef, undef, $props) = $ra->get_dir($old_path, $old_rev);
 	if (defined $props->{"svn:mergeinfo"}) {
 		my %omi = map {split ":", $_ } split "\n",
 			$props->{"svn:mergeinfo"};
 		$old_minfo = \%omi;
 	}
-	$self->{cached_mergeinfo_rev}{$old_path} = $old_rev;
-
-	# Cache the new mergeinfo.
-	$self->{cached_mergeinfo_rev}{$path} = $rev;
 
 	my %changes = ();
 	foreach my $p (keys %minfo) {
-- 
EW
