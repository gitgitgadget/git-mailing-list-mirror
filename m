From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] t4254: modernize tests
Date: Wed, 16 Oct 2013 14:27:16 +0200
Message-ID: <1381926436-12493-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 16 14:27:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWQCG-0004WQ-8x
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 14:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934159Ab3JPM1Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Oct 2013 08:27:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:61477 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406Ab3JPM1X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 08:27:23 -0400
Received: from localhost6.localdomain6 (f051145140.adsl.alicedsl.de [78.51.145.140])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MQ7pz-1VRlMn1bIh-004kzV; Wed, 16 Oct 2013 14:27:22 +0200
X-Mailer: git-send-email 1.8.4.1.495.gd8d272e
X-Provags-ID: V02:K0:g4nAO+kk+V8FCjZSX1DiMML+QjveQ7Twn2iiHXHSzVn
 05z9Y2L44AzC3fUH9hYqdE7UoRMA0sNJPZzqUki8gKOXUI+qB+
 a8WEArDk0GgOjk3c/rdUAq/Nl+66fWm0L6FxI4kCqxYB7f1bsr
 1lXm5FmGiU7RfX4SIdjDxuYqt29OLy9OeI36ZGYnliToA4e0fL
 J5O37pGrQmKR43Kp0MiseTanQWnCWF4LoylTs/bz4kYI6xQPK1
 ufSOM1JnHkELrYQ00Mz8HFwFQhah1fUujz9Fby8Q5VmFifUjVP
 LIevegjqZbVJ5Yj6UxDrBfavf0/ShHtu55O3ZEMr+DJhXTxoQW
 3S8Nan8JUxfRheqJLQ3EVSFvt2z2hDiTMrlvdylFbexJau5u4H
 jiicMwQW8JsCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236245>

- Don't start tests with 'test $? =3D 0' ;)
- Move writing the bogus patch and the expected output into the
  appropriate test_expect_success blocks.
- Use the test_must_fail helper instead of manually checking for
  non-zero exit code.
- Use the debug-friendly test_path_is_file helper instead of 'test -f'.
- No space after '>'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
Is the exact match of 'git am's exit code important?  I think it doesn'=
t
matter as long as it fails, hence test_must_fail instead of
test_expect_code 1.

 t/t4254-am-corrupt.sh | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index b7da95fac5..85716dd6ec 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -3,20 +3,19 @@
 test_description=3D'git am with corrupt input'
 . ./test-lib.sh
=20
-# Note the missing "+++" line:
-cat > bad-patch.diff <<'EOF'
-From: A U Thor <au.thor@example.com>
-diff --git a/f b/f
-index 7898192..6178079 100644
---- a/f
-@@ -1 +1 @@
--a
-+b
-EOF
-
 test_expect_success setup '
-	test $? =3D 0 &&
-	echo a > f &&
+	# Note the missing "+++" line:
+	cat >bad-patch.diff <<-\EOF &&
+	From: A U Thor <au.thor@example.com>
+	diff --git a/f b/f
+	index 7898192..6178079 100644
+	--- a/f
+	@@ -1 +1 @@
+	-a
+	+b
+	EOF
+
+	echo a >f &&
 	git add f &&
 	test_tick &&
 	git commit -m initial
@@ -26,17 +25,12 @@ test_expect_success setup '
 #   fatal: unable to write file '(null)' mode 100644: Bad address
 # Also, it had the unwanted side-effect of deleting f.
 test_expect_success 'try to apply corrupted patch' '
-	git am bad-patch.diff 2> actual
-	test $? =3D 1
+	test_must_fail git am bad-patch.diff 2>actual
 '
=20
-cat > expected <<EOF
-fatal: git diff header lacks filename information (line 4)
-EOF
-
 test_expect_success 'compare diagnostic; ensure file is still here' '
-	test $? =3D 0 &&
-	test -f f &&
+	echo "fatal: git diff header lacks filename information (line 4)" >ex=
pected &&
+	test_path_is_file f &&
 	test_cmp expected actual
 '
=20
--=20
1.8.4.1.495.gd8d272e
