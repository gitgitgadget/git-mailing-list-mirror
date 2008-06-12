From: Patrick Higgins <patrick.higgins@cexp.com>
Subject: [PATCH] Added mergetool.kdiff3.doubledash config option
Date: Thu, 12 Jun 2008 13:55:05 -0600
Message-ID: <1213300505-3867-1-git-send-email-patrick.higgins@cexp.com>
Cc: gitster@pobox.com, Patrick Higgins <patrick.higgins@cexp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 22:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tK7-0008Ct-Aj
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbYFLUWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbYFLUWN
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:22:13 -0400
Received: from mx02.cexp.com ([170.131.136.83]:64269 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbYFLUWM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:22:12 -0400
X-Greylist: delayed 1625 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jun 2008 16:22:12 EDT
Received: from mailgate2.cexp.com (uscobrmfa-se-07.cexp.com [170.131.144.37])
	by mx02.cexp.com (Postfix) with ESMTP id 9272C222A09
	for <git@vger.kernel.org>; Thu, 12 Jun 2008 13:55:06 -0600 (MDT)
Received: from localhost.localdomain ([10.128.5.63]) by USCOBRMFA-SE-52.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jun 2008 13:55:06 -0600
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.1/8.13.1) with ESMTP id m5CJt6SI003888;
	Thu, 12 Jun 2008 13:55:06 -0600
Received: (from phiggins@localhost)
	by localhost.localdomain (8.13.1/8.13.1/Submit) id m5CJt51x003887;
	Thu, 12 Jun 2008 13:55:05 -0600
X-Mailer: git-send-email 1.5.6.rc2
X-OriginalArrivalTime: 12 Jun 2008 19:55:06.0647 (UTC) FILETIME=[364A0270:01C8CCC6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84784>

Qt-only builds of kdiff3 (no KDE) do not support a bare '--' on the command
line. It will fail silently and mysteriously.

Signed-off-by: Patrick Higgins <patrick.higgins@cexp.com>
---
 Documentation/config.txt |    6 ++++++
 git-mergetool.sh         |   11 +++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5331b45..da40c2e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -884,6 +884,12 @@ mergetool.<tool>.trustExitCode::
 	if the file has been updated, otherwise the user is prompted to
 	indicate the success of the merge.
 
+mergetool.kdiff3.doubledash::
+	A boolean to indicate whether or not your kdiff3 supports a '--'
+	on the command line to separate options from filenames. If you
+	built it without KDE, it probably doesn't have this support and
+	you	should set this to false.  Defaults to true.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/git-mergetool.sh b/git-mergetool.sh
index fcdec4a..57cbac0 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -181,12 +181,19 @@ merge_file () {
 
     case "$merge_tool" in
 	kdiff3)
+	    doubledash=`git config --bool mergetool.kdiff3.doubledash`
+	    if test "$doubledash" = "false"; then
+		double_dash=""
+	    else
+		double_dash="--"
+	    fi
+
 	    if base_present ; then
 		("$merge_tool_path" --auto --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
-		    -o "$MERGED" -- "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		    -o "$MERGED" $double_dash "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    else
 		("$merge_tool_path" --auto --L1 "$MERGED (Local)" --L2 "$MERGED (Remote)" \
-		    -o "$MERGED" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		    -o "$MERGED" $double_dash "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    fi
 	    status=$?
 	    ;;
-- 
1.5.6.rc2
