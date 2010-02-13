From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 18/30] t3305: Verify that removing notes triggers automatic
 fanout consolidation
Date: Sat, 13 Feb 2010 22:28:26 +0100
Message-ID: <1266096518-2104-19-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:30:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPZH-0001iD-3i
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113Ab0BMV3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:47 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51414 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758085Ab0BMV3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:40 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00EG0UDDVE80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:37 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:37 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139849>

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3305-notes-fanout.sh |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 823b0ff..c6d263b 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Test that adding many notes triggers automatic fanout restructuring'
+test_description='Test that adding/removing many notes triggers automatic fanout restructuring'
 
 . ./test-lib.sh
 
@@ -47,4 +47,49 @@ test_expect_success 'many notes created with git-notes triggers fanout' '
 	done
 '
 
+test_expect_success 'deleting most notes with git-notes' '
+	num_notes=250 &&
+	i=0 &&
+	git rev-list HEAD |
+	while read sha1
+	do
+		i=$(($i + 1)) &&
+		if test $i -gt $num_notes
+		then
+			break
+		fi &&
+		test_tick &&
+		git notes remove "$sha1"
+	done
+'
+
+test_expect_success 'most notes deleted correctly with git-notes' '
+	git log HEAD~250 | grep "^    " > output &&
+	i=50 &&
+	while test $i -gt 0
+	do
+		echo "    commit #$i" &&
+		echo "    note #$i" &&
+		i=$(($i - 1));
+	done > expect &&
+	test_cmp expect output
+'
+
+test_expect_success 'deleting most notes triggers fanout consolidation' '
+	# Expect entire notes tree to have a fanout == 0
+	git ls-tree -r --name-only refs/notes/commits |
+	while read path
+	do
+		case "$path" in
+		????????????????????????????????????????)
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
 test_done
-- 
1.7.0.rc1.141.gd3fd
