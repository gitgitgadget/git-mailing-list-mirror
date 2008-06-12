From: Patrick Higgins <patrick.higgins@cexp.com>
Subject: [PATCH v2] Detect if kdiff3 supports '--' and do not supply it if not supported
Date: Thu, 12 Jun 2008 17:03:37 -0600
Message-ID: <1213311817-4673-1-git-send-email-patrick.higgins@cexp.com>
Cc: tytso@mit.edu, Patrick Higgins <patrick.higgins@cexp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 01:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6vr4-0000Vc-Lc
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 01:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbYFLXEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 19:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753787AbYFLXEY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 19:04:24 -0400
Received: from mx02.cexp.com ([170.131.136.83]:43885 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400AbYFLXEY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 19:04:24 -0400
Received: from mailgate2.cexp.com (uscobrmfa-se-07.cexp.com [170.131.144.37])
	by mx02.cexp.com (Postfix) with ESMTP id 9164C1E4D8E
	for <git@vger.kernel.org>; Thu, 12 Jun 2008 17:03:39 -0600 (MDT)
Received: from localhost.localdomain ([10.128.5.63]) by USCOBRMFA-SE-51.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jun 2008 17:03:38 -0600
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.1/8.13.1) with ESMTP id m5CN3bkI004697;
	Thu, 12 Jun 2008 17:03:37 -0600
Received: (from phiggins@localhost)
	by localhost.localdomain (8.13.1/8.13.1/Submit) id m5CN3bsB004696;
	Thu, 12 Jun 2008 17:03:37 -0600
X-Mailer: git-send-email 1.5.6.rc2
X-OriginalArrivalTime: 12 Jun 2008 23:03:38.0605 (UTC) FILETIME=[8CBDD1D0:01C8CCE0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84810>

kdiff3 can be compiled with Qt only or with KDE support. If compiled with
Qt only, it does not support '--' and mergetool fails silently.

Signed-off-by: Patrick Higgins <patrick.higgins@cexp.com>
---
 git-mergetool.sh |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index fcdec4a..85ce004 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -181,12 +181,19 @@ merge_file () {
 
     case "$merge_tool" in
 	kdiff3)
+	    "$merge_tool_path" --auto -o /dev/null -- /dev/null /dev/null
+	    if test $? -ne 0; then
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
