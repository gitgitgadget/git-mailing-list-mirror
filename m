From: Andrew Myrick <amyrick@apple.com>
Subject: [PATCH 2/2] git-svn: handle merge-base failures
Date: Wed, 06 Jan 2010 16:25:22 -0800
Message-ID: <1262823922-3415-2-git-send-email-amyrick@apple.com>
References: <E10FB265-0C47-44C7-9347-687A9F447603@apple.com>
 <1262823922-3415-1-git-send-email-amyrick@apple.com>
Content-Transfer-Encoding: 7BIT
Cc: sam@vilain.net, normalperson@yhbt.net,
	Andrew Myrick <amyrick@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 01:25:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSgC6-0002lc-T4
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 01:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591Ab0AGAZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 19:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584Ab0AGAZk
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 19:25:40 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:51745 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932554Ab0AGAZi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 19:25:38 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id CDC308551C91
	for <git@vger.kernel.org>; Wed,  6 Jan 2010 16:25:37 -0800 (PST)
X-AuditID: 11807130-b7b0aae00000102c-2e-4b452a015b53
Received: from et.apple.com (et.apple.com [17.151.62.12])
	by relay11.apple.com (Apple SCV relay) with SMTP id A7.D6.04140.10A254B4; Wed,  6 Jan 2010 16:25:37 -0800 (PST)
Received: from localhost.localdomain (agility.apple.com [17.201.24.116])
 by et.apple.com
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPSA id <0KVU00J2PP6LJ370@et.apple.com> for git@vger.kernel.org; Wed,
 06 Jan 2010 16:25:37 -0800 (PST)
X-Mailer: git-send-email 1.6.6.2.g18c9a
In-reply-to: <1262823922-3415-1-git-send-email-amyrick@apple.com>
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136311>

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
index 947184a..1f201e4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3158,10 +3158,21 @@ sub find_extra_svn_parents {
 		my $ranges = $ranges{$merge_tip};
 
 		# check out 'new' tips
-		my $merge_base = command_oneline(
-			"merge-base",
-			@$parents, $merge_tip,
-		       );
+		my $merge_base;
+		eval {
+			$merge_base = command_oneline(
+				"merge-base",
+				@$parents, $merge_tip,
+			);
+		};
+		if ($@) {
+			die "An error occurred during merge-base"
+				unless $@->isa("Git::Error::Command");
+
+			warn "W: Cannot find common ancestor between ".
+				"@$parents and $merge_tip. Ignoring merge info.\n";
+			next;
+		}
 
 		# double check that there are no missing non-merge commits
 		my (@incomplete) = check_cherry_pick(
-- 
1.6.6.2.g18c9a
