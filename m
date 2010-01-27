From: Johan Herland <johan@herland.net>
Subject: [PATCHv12 18/23] t3305: Verify that removing notes triggers automatic
 fanout consolidation
Date: Wed, 27 Jan 2010 12:51:55 +0100
Message-ID: <1264593120-4428-19-git-send-email-johan@herland.net>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 27 12:53:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6Se-0000gj-5r
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab0A0LxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549Ab0A0Lw7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:52:59 -0500
Received: from smtp.getmail.no ([84.208.15.66]:59320 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753440Ab0A0Lwr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:52:47 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00FDYMBYFU60@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:46 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00EZ7MAZN340@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:45 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.113919
X-Mailer: git-send-email 1.6.6.405.g80ed6
In-reply-to: <1264593120-4428-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138140>

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
1.6.6.405.g80ed6
