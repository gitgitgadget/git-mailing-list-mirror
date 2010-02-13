From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 14/30] t3305: Verify that adding many notes with git-notes
 triggers increased fanout
Date: Sat, 13 Feb 2010 22:28:22 +0100
Message-ID: <1266096518-2104-15-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:30:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPZE-0001iD-1K
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758095Ab0BMV3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:34 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62362 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758016Ab0BMV33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:29 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FJUUD25490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:26 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:26 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139848>

Add a test verifying that the notes code automatically restructures the
notes tree into a deeper fanout level, when many notes are added with
"git notes".

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3305-notes-fanout.sh |   50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100755 t/t3305-notes-fanout.sh

diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
new file mode 100755
index 0000000..823b0ff
--- /dev/null
+++ b/t/t3305-notes-fanout.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='Test that adding many notes triggers automatic fanout restructuring'
+
+. ./test-lib.sh
+
+test_expect_success 'creating many notes with git-notes' '
+	num_notes=300 &&
+	i=0 &&
+	while test $i -lt $num_notes
+	do
+		i=$(($i + 1)) &&
+		test_tick &&
+		echo "file for commit #$i" > file &&
+		git add file &&
+		git commit -q -m "commit #$i" &&
+		git notes edit -m "note #$i" || return 1
+	done
+'
+
+test_expect_success 'many notes created correctly with git-notes' '
+	git log | grep "^    " > output &&
+	i=300 &&
+	while test $i -gt 0
+	do
+		echo "    commit #$i" &&
+		echo "    note #$i" &&
+		i=$(($i - 1));
+	done > expect &&
+	test_cmp expect output
+'
+
+test_expect_success 'many notes created with git-notes triggers fanout' '
+	# Expect entire notes tree to have a fanout == 1
+	git ls-tree -r --name-only refs/notes/commits |
+	while read path
+	do
+		case "$path" in
+		??/??????????????????????????????????????)
+			: true
+			;;
+		*)
+			echo "Invalid path \"$path\"" &&
+			return 1
+			;;
+		esac
+	done
+'
+
+test_done
-- 
1.7.0.rc1.141.gd3fd
