From: Andrew Myrick <amyrick@apple.com>
Subject: [PATCH 2/2] git-svn: handle merge-base failures
Date: Wed, 06 Jan 2010 12:08:49 -0800
Message-ID: <1262808529-1575-2-git-send-email-amyrick@apple.com>
References: <1262808529-1575-1-git-send-email-amyrick@apple.com>
Content-Transfer-Encoding: 7BIT
Cc: sam@vilain.net, normalperson@yhbt.net,
	Andrew Myrick <amyrick@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 21:09:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NScC5-0006gd-1K
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 21:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708Ab0AFUJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 15:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694Ab0AFUJT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 15:09:19 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:60009 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474Ab0AFUJS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 15:09:18 -0500
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id B51B785488A7
	for <git@vger.kernel.org>; Wed,  6 Jan 2010 12:09:17 -0800 (PST)
X-AuditID: 11807134-b7cd9ae000001002-3d-4b44eded64d8
Received: from elliott.apple.com (elliott.apple.com [17.151.62.13])
	by relay14.apple.com (Apple SCV relay) with SMTP id 66.9F.04098.DEDE44B4; Wed,  6 Jan 2010 12:09:17 -0800 (PST)
Received: from localhost.localdomain (agility.apple.com [17.201.24.116])
 by elliott.apple.com
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPSA id <0KVU00GX8DBBPM70@elliott.apple.com> for git@vger.kernel.org;
 Wed, 06 Jan 2010 12:09:17 -0800 (PST)
X-Mailer: git-send-email 1.6.6.2.g18c9a
In-reply-to: <1262808529-1575-1-git-send-email-amyrick@apple.com>
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136294>

Change git-svn to warn and continue when merge-base fails while processing svn
merge tickets.

merge-base can fail when a partial branch is created and merged back to trunk
in svn, because it cannot find a common ancestor between the partial branch and
trunk.

Signed-off-by: Andrew Myrick <amyrick@apple.com>
---
 git-svn.perl |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 8c7c034..d58982b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3158,10 +3158,21 @@ sub find_extra_svn_parents {
 		my $ranges = $ranges{$merge_tip};
 
 		# check out 'new' tips
-		my $merge_base = command_oneline(
-			"merge-base",
-			@$parents, $merge_tip,
-		       );
+                my $merge_base;
+                eval {
+                        $merge_base = command_oneline(
+                                "merge-base",
+                                @$parents, $merge_tip,
+                               );
+                };
+                if ($@) {
+                        die "An error occurred during merge-base"
+                            unless $@->isa("Git::Error::Command");
+
+                        warn "W: Cannot find common ancestor between ".
+                            "@$parents and $merge_tip. Ignoring merge info.\n";
+                        next;
+                }
 
 		# double check that there are no missing non-merge commits
 		my (@incomplete) = check_cherry_pick(
-- 
1.6.6.2.g18c9a
