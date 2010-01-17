From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 14/20] t3305: Verify that adding many notes with git-notes
 triggers increased fanout
Date: Sun, 17 Jan 2010 22:04:31 +0100
Message-ID: <1263762277-31419-15-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:06:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcKL-0007dl-VB
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab0AQVFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754794Ab0AQVFj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:39 -0500
Received: from smtp.getmail.no ([84.208.15.66]:56386 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754784Ab0AQVFV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:21 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002KMT8UY850@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:18 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:18 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137336>

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
1.6.6.rc1.321.g0496e
