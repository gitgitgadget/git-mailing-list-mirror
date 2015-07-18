From: Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v4] gitk: Add a "Copy commit summary" command
Date: Sat, 18 Jul 2015 13:15:39 +0200
Message-ID: <1437218139-7031-1-git-send-email-dev+git@drbeat.li>
Cc: Beat Bolli <dev+git@drbeat.li>, Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 13:16:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGQ6A-0005Nd-JQ
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 13:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbbGRLPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 07:15:53 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:35040 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844AbbGRLPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 07:15:52 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id C38CAC3442;
	Sat, 18 Jul 2015 13:15:48 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id A0DD6C343E;
	Sat, 18 Jul 2015 13:15:48 +0200 (CEST)
Received: by drbeat.li (Postfix, from userid 1000)
	id 7079E20322; Sat, 18 Jul 2015 13:15:48 +0200 (CEST)
X-Mailer: git-send-email 2.1.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274161>

When referring to earlier commits in commit messages or other text, one
of the established formats is

    <abbrev-sha> ("<summary>", <author-date>)

Add a "Copy commit summary" command to the context menu that puts this
text for the currently selected commit on the clipboard. This makes it
easy for our users to create well-formatted commit references.

The <abbrev-sha> is produced with the %h format specifier to make it
unique. Its length can be controlled with the gitk preference
"Auto-select SHA1 (length)", or, if this preference is set to its
default value (40), with the Git config setting core.abbrev.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Cc: Paul Mackerras <paulus@samba.org>
---
Changes since v3:
- consider $autosellen for the --abbrev value

Changes since v2:
- call git show to produce a unique <abbrev-sha>
- use the short date format

Changes since v1:
- drop the "commit " literal in front of the <abbrev-sha>

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 gitk-git/gitk | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9a2daf3..d05169a 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2617,6 +2617,7 @@ proc makewindow {} {
 	{mc "Diff selected -> this" command {diffvssel 1}}
 	{mc "Make patch" command mkpatch}
 	{mc "Create tag" command mktag}
+	{mc "Copy commit summary" command copysummary}
 	{mc "Write commit to file" command writecommit}
 	{mc "Create new branch" command mkbranch}
 	{mc "Cherry-pick this commit" command cherrypick}
@@ -9341,6 +9342,20 @@ proc mktaggo {} {
     mktagcan
 }
 
+proc copysummary {} {
+    global rowmenuid autosellen
+
+    set format "%h (\"%s\", %ad)"
+    set cmd [list git show -s --pretty=format:$format --date=short]
+    if {$autosellen < 40} {
+        lappend cmd --abbrev=$autosellen
+    }
+    set summary [eval exec $cmd $rowmenuid]
+
+    clipboard clear
+    clipboard append $summary
+}
+
 proc writecommit {} {
     global rowmenuid wrcomtop commitinfo wrcomcmd NS
 
-- 
2.1.4
