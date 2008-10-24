From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] add -p: warn if only binary changes present
Date: Fri, 24 Oct 2008 23:48:36 +0200
Message-ID: <1224884916-20369-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 23:49:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtUXd-0002wj-9R
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 23:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758150AbYJXVsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 17:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757338AbYJXVsm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 17:48:42 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:27736 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758150AbYJXVsl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 17:48:41 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 23:48:38 +0200
Received: from localhost.localdomain ([84.75.157.245]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 23:48:38 +0200
X-Mailer: git-send-email 1.6.0.3.785.g54a3
X-OriginalArrivalTime: 24 Oct 2008 21:48:38.0225 (UTC) FILETIME=[45A8D410:01C93622]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99069>

Current 'git add -p' will say "No changes." if there are no changes to
text files, which can be confusing if there _are_ changes to binary
files.  Add some code to distinguish the two cases, and give a
different message in the latter one.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 git-add--interactive.perl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index da768ee..a560133 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -811,11 +811,16 @@ EOF
 }
 
 sub patch_update_cmd {
-	my @mods = grep { !($_->{BINARY}) } list_modified('file-only');
+	my @all_mods = list_modified('file-only');
+	my @mods = grep { !($_->{BINARY}) } @all_mods;
 	my @them;
 
 	if (!@mods) {
-		print STDERR "No changes.\n";
+		if (@all_mods) {
+			print STDERR "No changes except to binary files.\n";
+		} else {
+			print STDERR "No changes.\n";
+		}
 		return 0;
 	}
 	if ($patch_mode) {
-- 
tg: (759ad19..) t/add-p-binary-warn (depends on: origin/master)
