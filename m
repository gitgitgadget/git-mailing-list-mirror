From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/21] t1430: improve test coverage of deletion of badly-named refs
Date: Wed, 23 Mar 2016 11:04:22 +0100
Message-ID: <faabd92da429867a767599e6ce5a9f4832481d42.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:05:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiff0-0002WM-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbcCWKFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:05:00 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:51177 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754402AbcCWKE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:04:58 -0400
X-AuditID: 12074414-89fff70000005020-2e-56f26a46ebeb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 34.DC.20512.74A62F65; Wed, 23 Mar 2016 06:04:55 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1A018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:04:53 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqOue9SnM4O9idouuK91MFg29V5gt
	bq+Yz2zRPeUto8WPlh5mi5lXrR3YPP6+/8DksXPWXXaPZ717GD0uXlL22L90G5vH501yAWxR
	3DZJiSVlwZnpefp2CdwZZ7tuMhdsMqr496+duYFxi3YXIyeHhICJxOwjbxi7GLk4hAS2Mkqs
	f9zCDJIQEjjJJHH9oiyIzSagK7Gop5kJxBYRUJOY2HaIBaSBWWABo8TGxYvBGoQFgiUOfrrF
	CmKzCKhKnNn0nxHE5hWIkli08jgLxDYliQ0PLoAN4hSwkDh5cikjxDJzie0P1jJNYORZwMiw
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMknER2MB45KXeIUYCDUYmHt+Dc
	xzAh1sSy4srcQ4ySHExKorzngz6FCfEl5adUZiQWZ8QXleakFh9ilOBgVhLhPZgJlONNSays
	Si3Kh0lJc7AoifN+W6zuJySQnliSmp2aWpBaBJOV4eBQkuBtB2kULEpNT61Iy8wpQUgzcXCC
	DOeSEilOzUtJLUosLcmIB8VAfDEwCkBSPEB7D4HtLS5IzAWKQrSeYlSUEuf1BkkIgCQySvPg
	xsKSxCtGcaAvhXk5Qap4gAkGrvsV0GAmoMELfcAGlyQipKQaGKXYOpzu/FD5ueBRfzPn3KiH
	l85vdO5KCz/Ht1e97GrtZCUGwSUmUrrWhpF/5eY5vTvImB4w//qPF5PvsXobxqWdvPqPMb/r
	/9xvUrWF5qG+D99/kp4XNvVi5SR+jotXon3y/Fv0tSRzE8T7vJbs22Au9E1a6vjM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289609>

Check "branch -d broken...ref"

Check various combinations of

* Deleting using "update-ref -d"
* Deleting using "update-ref --no-deref -d"
* Deleting using "branch -d"

in the following combinations of symref -> ref:

* badname -> broken...ref
* badname -> broken...ref (dangling)
* broken...symref -> master
* broken...symref -> idonotexist (dangling)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1430-bad-ref-name.sh | 108 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 10 deletions(-)

diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 612cc32..25ddab4 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -171,16 +171,6 @@ test_expect_success 'for-each-ref emits warnings for broken names' '
 	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.symref" error
 '
 
-test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
-	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
-	test_path_is_file .git/refs/heads/badname &&
-	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
-	test_path_is_missing .git/refs/heads/badname &&
-	test_must_be_empty output &&
-	test_must_be_empty error
-'
-
 test_expect_success 'update-ref -d can delete broken name' '
 	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
 	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
@@ -192,6 +182,104 @@ test_expect_success 'update-ref -d can delete broken name' '
 	! grep -e "broken\.\.\.ref" output
 '
 
+test_expect_success 'branch -d can delete broken name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -d broken...ref >output 2>error &&
+	test_i18ngrep "Deleted branch broken...ref (was broken)" output &&
+	test_must_be_empty error &&
+	git branch >output 2>error &&
+	! grep -e "broken\.\.\.ref" error &&
+	! grep -e "broken\.\.\.ref" output
+'
+
+test_expect_success 'update-ref --no-deref -d can delete symref to broken name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
+	test_path_is_missing .git/refs/heads/badname &&
+	test_must_be_empty output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'branch -d can delete symref to broken name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	git branch -d badname >output 2>error &&
+	test_path_is_missing .git/refs/heads/badname &&
+	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'update-ref --no-deref -d can delete dangling symref to broken name' '
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
+	test_path_is_missing .git/refs/heads/badname &&
+	test_must_be_empty output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'branch -d can delete dangling symref to broken name' '
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	git branch -d badname >output 2>error &&
+	test_path_is_missing .git/refs/heads/badname &&
+	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'update-ref -d can delete broken name through symref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	git update-ref -d refs/heads/badname >output 2>error &&
+	test_path_is_missing .git/refs/heads/broken...ref &&
+	test_must_be_empty output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'update-ref --no-deref -d can delete symref with broken name' '
+	printf "ref: refs/heads/master\n" >.git/refs/heads/broken...symref &&
+	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
+	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_must_be_empty output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'branch -d can delete symref with broken name' '
+	printf "ref: refs/heads/master\n" >.git/refs/heads/broken...symref &&
+	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	git branch -d broken...symref >output 2>error &&
+	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_i18ngrep "Deleted branch broken...symref (was refs/heads/master)" output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'update-ref --no-deref -d can delete dangling symref with broken name' '
+	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
+	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	git update-ref --no-deref -d refs/heads/broken...symref >output 2>error &&
+	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_must_be_empty output &&
+	test_must_be_empty error
+'
+
+test_expect_success 'branch -d can delete dangling symref with broken name' '
+	printf "ref: refs/heads/idonotexist\n" >.git/refs/heads/broken...symref &&
+	test_when_finished "rm -f .git/refs/heads/broken...symref" &&
+	git branch -d broken...symref >output 2>error &&
+	test_path_is_missing .git/refs/heads/broken...symref &&
+	test_i18ngrep "Deleted branch broken...symref (was refs/heads/idonotexist)" output &&
+	test_must_be_empty error
+'
+
 test_expect_success 'update-ref -d cannot delete non-ref in .git dir' '
 	echo precious >.git/my-private-file &&
 	echo precious >expect &&
-- 
2.8.0.rc3
