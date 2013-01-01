From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH V2] t9810: Do not use sed -i
Date: Wed, 2 Jan 2013 00:20:19 +0100
Message-ID: <201301020020.38535.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org, pw@padd.com
X-From: git-owner@vger.kernel.org Wed Jan 02 00:21:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqB9I-00089h-6n
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 00:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab3AAXVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 18:21:00 -0500
Received: from mout.web.de ([212.227.15.4]:58809 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407Ab3AAXU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 18:20:59 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MWBA1-1TW0cz05QP-00X1f0; Wed, 02 Jan 2013 00:20:56 +0100
X-Provags-ID: V02:K0:kS+uq5evz4f13OeYBRkw3Sk4AR1q6i8tFRsWn4LQkaW
 WQdP9/FQ3TZYMlJwiknNaMQ5r4ha6huvtIfIcLFdnluKHQR91i
 vhOxrgHY//WoMkyqOX8NwedX70tnUwsGKHXoqFn4fGs+O3+Inq
 SzP7e3WIwPbMMz7VmyrbPcP660xnjL+oiUk66Bml66EpMTNJ7u
 Ep2M+E6NnqBQMvVE2mvFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212469>

sed -i is not portable on all systems.
Use sed with different input and output files.
Utilize a tmp file whenever needed

Added missing && at 2 places

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since v1:
Use "sed <infile >outfile"
Added missing && at 2 places (thanks for catching)
 t/t9810-git-p4-rcs.sh | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 0c2fc3e..01a9921 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -26,10 +26,8 @@ test_expect_success 'init depot' '
 		line7
 		line8
 		EOF
-		cp filek fileko &&
-		sed -i "s/Revision/Revision: do not scrub me/" fileko
-		cp fileko file_text &&
-		sed -i "s/Id/Id: do not scrub me/" file_text
+		sed "s/Revision/Revision: do not scrub me/" <filek >fileko &&
+		sed "s/Id/Id: do not scrub me/" <fileko >file_text &&
 		p4 add -t text+k filek &&
 		p4 submit -d "filek" &&
 		p4 add -t text+ko fileko &&
@@ -88,7 +86,8 @@ test_expect_success 'edit far away from RCS lines' '
 	(
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
-		sed -i "s/^line7/line7 edit/" filek &&
+		sed "s/^line7/line7 edit/" <filek >filek.tmp &&
+		mv -f filek.tmp filek &&
 		git commit -m "filek line7 edit" filek &&
 		git p4 submit &&
 		scrub_k_check filek
@@ -105,7 +104,8 @@ test_expect_success 'edit near RCS lines' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.attemptRCSCleanup true &&
-		sed -i "s/^line4/line4 edit/" filek &&
+		sed "s/^line4/line4 edit/" <filek >filek.tmp &&
+		mv -f filek.tmp filek &&
 		git commit -m "filek line4 edit" filek &&
 		git p4 submit &&
 		scrub_k_check filek
@@ -122,7 +122,8 @@ test_expect_success 'edit keyword lines' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.attemptRCSCleanup true &&
-		sed -i "/Revision/d" filek &&
+		sed "/Revision/d" <filek >filek.tmp &&
+		mv -f filek.tmp filek &&
 		git commit -m "filek remove Revision line" filek &&
 		git p4 submit &&
 		scrub_k_check filek
@@ -139,7 +140,8 @@ test_expect_success 'scrub ko files differently' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.attemptRCSCleanup true &&
-		sed -i "s/^line4/line4 edit/" fileko &&
+		sed <fileko "s/^line4/line4 edit/" >fileko.tmp &&
+		mv -f fileko.tmp fileko &&
 		git commit -m "fileko line4 edit" fileko &&
 		git p4 submit &&
 		scrub_ko_check fileko &&
@@ -189,12 +191,14 @@ test_expect_success 'do not scrub plain text' '
 		cd "$git" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.attemptRCSCleanup true &&
-		sed -i "s/^line4/line4 edit/" file_text &&
+		sed "s/^line4/line4 edit/" <file_text >file_text.tmp &&
+		mv -f file_text.tmp file_text &&
 		git commit -m "file_text line4 edit" file_text &&
 		(
 			cd "$cli" &&
 			p4 open file_text &&
-			sed -i "s/^line5/line5 p4 edit/" file_text &&
+			sed "s/^line5/line5 p4 edit/" <file_text >file_text.tmp &&
+			mv -f file_text.tmp file_text &&
 			p4 submit -d "file5 p4 edit"
 		) &&
 		echo s | test_expect_code 1 git p4 submit &&
--=20
1.8.0.197.g5a90748
