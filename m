From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] When renaming config sections delete conflicting sections
Date: Wed, 17 Oct 2007 02:34:18 +0200
Message-ID: <20071017003418.GA11013@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 02:37:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihwuh-0000X4-S3
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 02:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601AbXJQAhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 20:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXJQAhU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 20:37:20 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:48822 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbXJQAhU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 20:37:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id DF4B377802C;
	Wed, 17 Oct 2007 02:37:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gvxeX+nzq2IB; Wed, 17 Oct 2007 02:37:16 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 3225686804E;
	Wed, 17 Oct 2007 02:34:19 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1D4D96DFB71; Wed, 17 Oct 2007 02:34:10 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 1B9225B8001; Wed, 17 Oct 2007 02:34:19 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61291>

The old behavior of keeping config sections matching the new name caused
problems leading to warnings being emitted by git-remote when renaming
branches where information about tracked remote branches differed. To
fix this any config sections that will conflict with the new name are
removed from the config file. Update test to check for this.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 config.c               |    9 ++++++++-
 t/t1300-repo-config.sh |   17 +++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

 This command sequence was causing problems for me:

	git checkout -b test madcoder/next
	git checkout -b test2 spearce/next
	git branch -M test

 On top of spearce/next ...

diff --git a/config.c b/config.c
index dc3148d..578849a 100644
--- a/config.c
+++ b/config.c
@@ -1013,6 +1013,14 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 			; /* do nothing */
 		if (buf[i] == '[') {
 			/* it's a section */
+			remove = 0;
+			if (new_name != NULL
+			    && section_name_match (&buf[i+1], new_name)) {
+				/* Remove any existing occurences of the
+				 * new section. */
+				remove = 1;
+				continue;
+			}
 			if (section_name_match (&buf[i+1], old_name)) {
 				ret++;
 				if (new_name == NULL) {
@@ -1026,7 +1034,6 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 				}
 				continue;
 			}
-			remove = 0;
 		}
 		if (remove)
 			continue;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 1d2bf2c..63b969e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -419,6 +419,23 @@ EOF
 test_expect_success "section was removed properly" \
 	"git diff -u expect .git/config"
 
+cat > .git/config << EOF
+[branch "new-name"]
+	x = 1
+[branch "old-name"]
+	y = 1
+EOF
+
+test_expect_success "rename and remove old section" \
+	'git config --rename-section branch.old-name branch.new-name'
+
+cat > expect << EOF
+[branch "new-name"]
+	y = 1
+EOF
+
+test_expect_success "rename and remove succeeded" "git diff expect .git/config"
+
 rm .git/config
 
 cat > expect << EOF
-- 
1.5.3.4.1206.g5f96-dirty

-- 
Jonas Fonseca
