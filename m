From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: unlink index files that were globbed, too
Date: Wed,  2 Jan 2008 10:10:03 -0800
Message-ID: <1199297404-20030-1-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 19:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA830-00071t-GU
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 19:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbYABSKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 13:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbYABSKF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 13:10:05 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55863 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbYABSKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 13:10:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 167322DC035;
	Wed,  2 Jan 2008 10:10:04 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.16.g3ffc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69481>

commit 3157dd9e89a71e80673d0bc21b5c0630f3b1fe68 introduced
unlinking index files after fetching.  However, this missed
indices for refs that were created by globbing branches and
tags.  This will track all refs we ever touch during a fetch and
unlink them at exit time.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9b1113a..2c97b05 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1283,8 +1283,11 @@ BEGIN {
 	}
 }
 
-my %LOCKFILES;
-END { unlink keys %LOCKFILES if %LOCKFILES }
+my (%LOCKFILES, %INDEX_FILES);
+END {
+	unlink keys %LOCKFILES if %LOCKFILES;
+	unlink keys %INDEX_FILES if %INDEX_FILES;
+}
 
 sub resolve_local_globs {
 	my ($url, $fetch, $glob_spec) = @_;
@@ -1376,7 +1379,6 @@ sub fetch_all {
 
 	($base, $head) = parse_revision_argument($base, $head);
 	$ra->gs_fetch_loop_common($base, $head, \@gs, \@globs);
-	unlink $_->{index} foreach @gs;
 }
 
 sub read_all_remotes {
@@ -3945,6 +3947,7 @@ sub gs_fetch_loop_common {
 				if ($log_entry) {
 					$gs->do_git_commit($log_entry);
 				}
+				$INDEX_FILES{$gs->{index}} = 1;
 			}
 			foreach my $g (@$globs) {
 				my $k = "svn-remote.$g->{remote}." .
-- 
1.5.4.rc2.7.g6277-dirty
