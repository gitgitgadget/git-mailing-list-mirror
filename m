From: Andrew Myrick <amyrick@apple.com>
Subject: [PATCH 1/2] git-svn: ignore changeless commits when checking for a
 cherry-pick
Date: Wed, 06 Jan 2010 12:08:48 -0800
Message-ID: <1262808529-1575-1-git-send-email-amyrick@apple.com>
Content-Transfer-Encoding: 7BIT
Cc: sam@vilain.net, normalperson@yhbt.net,
	Andrew Myrick <amyrick@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 21:09:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NScC4-0006gd-Fa
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 21:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513Ab0AFUJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 15:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474Ab0AFUJQ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 15:09:16 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:60001 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457Ab0AFUJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 15:09:16 -0500
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id ABB86854889B
	for <git@vger.kernel.org>; Wed,  6 Jan 2010 12:09:14 -0800 (PST)
X-AuditID: 11807134-b7cd9ae000001002-29-4b44edea0050
Received: from elliott.apple.com (elliott.apple.com [17.151.62.13])
	by relay14.apple.com (Apple SCV relay) with SMTP id 43.9F.04098.AEDE44B4; Wed,  6 Jan 2010 12:09:14 -0800 (PST)
Received: from localhost.localdomain (agility.apple.com [17.201.24.116])
 by elliott.apple.com
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPSA id <0KVU00GX8DBBPM70@elliott.apple.com> for git@vger.kernel.org;
 Wed, 06 Jan 2010 12:09:14 -0800 (PST)
X-Mailer: git-send-email 1.6.6.2.g18c9a
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136293>

Update git-svn to ignore commits that do not change the tree when it is
deciding if an svn merge ticket represents a real branch merge or just a
cherry-pick.

Consider the following integration model in the svn repository:

   F---G  branch1
  /     \
 D  tag1 \   E  tag2
/         \ /
A---B      C  trunk

branch1 is merged to trunk in commit C.

With this patch, git-svn will correctly identify branch1 as a proper merge
parent, instead of incorrectly ignoring it as a cherry-pick.

Signed-off-by: Andrew Myrick <amyrick@apple.com>
---
 git-svn.perl |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 650c9e5..8c7c034 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3052,12 +3052,36 @@ sub check_cherry_pick {
 	for my $range ( @ranges ) {
 		delete @commits{_rev_list($range)};
 	}
+        for my $commit (keys %commits) {
+                if (has_no_changes($commit)) {
+                        delete $commits{$commit};
+                }
+        }
 	return (keys %commits);
 }
 
+sub has_no_changes {
+        my $commit = shift;
+
+        my @revs = split / /, command_oneline(
+                qw(rev-list --parents -1 -m), $commit);
+
+        # Commits with no parents, e.g. the start of a partial branch,
+        # have changes by definition.
+        return 1 if (@revs < 2);
+    
+        # Commits with multiple parents, e.g a merge, have no changes
+        # by definition.
+        return 0 if (@revs > 2);
+       
+        return (command_oneline("rev-parse", "$commit^{tree}") eq
+                command_oneline("rev-parse", "$commit~1^{tree}"));
+}
+
 BEGIN {
 	memoize 'lookup_svn_merge';
 	memoize 'check_cherry_pick';
+        memoize 'has_no_changes';
 }
 
 sub parents_exclude {
-- 
1.6.6.2.g18c9a
