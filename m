From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 03/20] Add tests for checking correct handling of
 $GIT_NOTES_REF and core.notesRef
Date: Sun, 17 Jan 2010 22:04:20 +0100
Message-ID: <1263762277-31419-4-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:05:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcJW-0007Cz-Ti
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab0AQVFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725Ab0AQVFE
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:04 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62433 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754641Ab0AQVFB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:01 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002BRT8B0RE0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:04:59 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:04:59 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137324>

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3301-notes.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 1e34f48..3985d2a 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -147,4 +147,52 @@ test_expect_success 'show -m and -F notes' '
 	test_cmp expect-m-and-F output
 '
 
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
1.6.6.rc1.321.g0496e
