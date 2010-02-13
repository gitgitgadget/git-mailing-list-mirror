From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 03/30] Add tests for checking correct handling of
 $GIT_NOTES_REF and core.notesRef
Date: Sat, 13 Feb 2010 22:28:11 +0100
Message-ID: <1266096518-2104-4-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:29:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPYJ-00018f-Em
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab0BMV3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:01 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51162 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757963Ab0BMV26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:28:58 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00EEKUC9VE80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:28:57 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:28:57 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139833>

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3301-notes.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 5d9604b..18aad53 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -206,4 +206,52 @@ do
 	'
 done
 
+test_expect_success 'create other note on a different notes ref (setup)' '
+	: > a5 &&
+	git add a5 &&
+	test_tick &&
+	git commit -m 5th &&
+	GIT_NOTES_REF="refs/notes/other" git notes edit -m "other note"
+'
+
+cat > expect-other << EOF
+commit bd1753200303d0a0344be813e504253b3d98e74d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:17:13 2005 -0700
+
+    5th
+
+Notes:
+    other note
+EOF
+
+cat > expect-not-other << EOF
+commit bd1753200303d0a0344be813e504253b3d98e74d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:17:13 2005 -0700
+
+    5th
+EOF
+
+test_expect_success 'Do not show note on other ref by default' '
+	git log -1 > output &&
+	test_cmp expect-not-other output
+'
+
+test_expect_success 'Do show note when ref is given in GIT_NOTES_REF' '
+	GIT_NOTES_REF="refs/notes/other" git log -1 > output &&
+	test_cmp expect-other output
+'
+
+test_expect_success 'Do show note when ref is given in core.notesRef config' '
+	git config core.notesRef "refs/notes/other" &&
+	git log -1 > output &&
+	test_cmp expect-other output
+'
+
+test_expect_success 'Do not show note when core.notesRef is overridden' '
+	GIT_NOTES_REF="refs/notes/wrong" git log -1 > output &&
+	test_cmp expect-not-other output
+'
+
 test_done
-- 
1.7.0.rc1.141.gd3fd
