From: Tommaso Colombo <tommaso.colombo@outlook.com>
Subject: [PATCH] git-svn: merge: fix rooturl/branchurl match check
Date: Wed, 15 Oct 2014 14:39:01 +0200
Message-ID: <BLU437-SMTP152A16338E427B250EB601FBAA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tommaso Colombo <zibo86@hotmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 14:44:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeNwG-0005pV-VP
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 14:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbaJOMoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 08:44:21 -0400
Received: from blu004-omc3s19.hotmail.com ([65.55.116.94]:50353 "EHLO
	BLU004-OMC3S19.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751928AbaJOMoU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 08:44:20 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Oct 2014 08:44:20 EDT
Received: from BLU437-SMTP15 ([65.55.116.72]) by BLU004-OMC3S19.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.22751);
	 Wed, 15 Oct 2014 05:39:20 -0700
X-TMN: [NpSTaiDUlp4KL/dai4bn/z+VihdwRUTk]
X-Originating-Email: [tommaso.colombo@outlook.com]
X-Mailer: git-send-email 2.1.2.443.g670a3c1.dirty
X-OriginalArrivalTime: 15 Oct 2014 12:39:18.0754 (UTC) FILETIME=[09A32C20:01CFE875]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When populating svn:mergeinfo, git-svn merge checks if the merge parent
of the merged branch is under the same root as the git-svn repository.
This was implemented comparing $gs->repos_root with the return value of
of cmt_metadata for the merge parent. However, the first may contain a
username, whereas the second does not. In this case the comparison
fails.

Remove the username from $gs->repos_root before performing the
comparison.
---
 git-svn.perl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b6e2186..0a5a5ff 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -707,7 +707,8 @@ sub populate_merge_info {
 		my $all_parents_ok = 1;
 		my $aggregate_mergeinfo = '';
 		my $rooturl = $gs->repos_root;
-		my ($target_branch) = $gs->full_pushurl =~ /^\Q$rooturl\E(.*)/;
+		Git::SVN::remove_username($rooturl);
+		my $target_branch = $gs->path;
 
 		if (defined($rewritten_parent)) {
 			# Replace first parent with newly-rewritten version
@@ -729,7 +730,7 @@ sub populate_merge_info {
 			}
 			my $branchpath = $1;
 
-			my $ra = Git::SVN::Ra->new($branchurl);
+			my $ra = Git::SVN::Ra->new(add_path_to_url($gs->repos_root, $branchpath));
 			my (undef, undef, $props) =
 				$ra->get_dir(canonicalize_path("."), $svnrev);
 			my $par_mergeinfo = $props->{'svn:mergeinfo'};
@@ -921,6 +922,7 @@ sub cmd_dcommit {
 		# information from different SVN repos, and paths
 		# which are not underneath this repository root.
 		my $rooturl = $gs->repos_root;
+		Git::SVN::remove_username($rooturl);
 		foreach my $d (@$linear_refs) {
 			my %parentshash;
 			read_commit_parents(\%parentshash, $d);
-- 
2.1.2.443.g670a3c1.dirty
