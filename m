From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 1/3] tests: consolidate CR removal/addition functions
Date: Mon, 25 Jan 2010 16:33:57 -0800
Message-ID: <1264466039-22431-2-git-send-email-bebarino@gmail.com>
References: <1264466039-22431-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Blake <ebb9@byu.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 01:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZZNn-0003sS-GE
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 01:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab0AZAeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 19:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122Ab0AZAeI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 19:34:08 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:53344 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab0AZAeG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 19:34:06 -0500
Received: by gxk9 with SMTP id 9so6019434gxk.8
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 16:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yDXon7aOFGUT7bAk9m4aWxX3aO0GMweP7xA7jjD15Cc=;
        b=gR76mQ3K9JbzTbkq81kkEt3ubARnaVEYVGUua4Tsn/pxeTxdPbSy8Gpp4o9plYbxFW
         PTOpOM+3CYRbZTa0W6Uk4IIjh07qeL8XpupKG6/dRTZwJUwS6dofyDPtgjROg2kdBCz3
         SNG8InzxdNlfxf7PnjNBRWpyfhopQGz9kjdHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=c/gfi3cE6Si/ipG/vtKMOupHkKCSudr3La4Wc40c2pFZaWdIzYDoND1htxsk7i1Edx
         5zhTLdv0flxhj0noCKziCWdLx4blrMLUUotvkIK/uxAWQocdCe1zj3E34AiJyMUPOH3g
         r+7MbguCXGE3eMYsuEm043KKY5AuqiAI4RXVg=
Received: by 10.100.54.34 with SMTP id c34mr788477ana.162.1264466045379;
        Mon, 25 Jan 2010 16:34:05 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 8sm1914965ywg.4.2010.01.25.16.34.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 16:34:04 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc0
In-Reply-To: <1264466039-22431-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138011>

append_cr(), remove_cr(), q_to_nul() and q_to_cr() are defined in multiple
tests. Consolidate them into test-lib.sh so we can stop redefining them.
The use of remove_cr() in t0020 to test for a CR is replaced with a new
function has_cr() to accurately reflect what is intended (the output of
remove_cr() was being thrown away).

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 t/t0020-crlf.sh               |   55 +++++++++++++++-------------------------
 t/t3400-rebase.sh             |    4 ---
 t/t4012-diff-binary.sh        |    4 ---
 t/t6033-merge-crlf.sh         |    8 ------
 t/t9401-git-cvsserver-crlf.sh |    8 ------
 t/test-lib.sh                 |   16 ++++++++++++
 6 files changed, 37 insertions(+), 58 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 4e72b53..c3e7e32 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -4,21 +4,8 @@ test_description='CRLF conversion'
 
 . ./test-lib.sh
 
-q_to_nul () {
-	perl -pe 'y/Q/\000/'
-}
-
-q_to_cr () {
-	tr Q '\015'
-}
-
-append_cr () {
-	sed -e 's/$/Q/' | tr Q '\015'
-}
-
-remove_cr () {
-	tr '\015' Q <"$1" | grep Q >/dev/null &&
-	tr '\015' Q <"$1" | sed -ne 's/Q$//p'
+has_cr() {
+	tr '\015' Q <"$1" | grep Q >/dev/null
 }
 
 test_expect_success setup '
@@ -156,7 +143,7 @@ test_expect_success 'checkout with autocrlf=true' '
 
 	for f in one dir/two
 	do
-		remove_cr "$f" >tmp && mv -f tmp $f &&
+		remove_cr <"$f" >tmp && mv -f tmp $f &&
 		git update-index -- $f || {
 			echo "Eh? $f"
 			false
@@ -180,7 +167,7 @@ test_expect_success 'checkout with autocrlf=input' '
 
 	for f in one dir/two
 	do
-		if remove_cr "$f" >/dev/null
+		if has_cr "$f"
 		then
 			echo "Eh? $f"
 			false
@@ -245,7 +232,7 @@ test_expect_success 'apply patch (autocrlf=true)' '
 	git read-tree --reset -u HEAD &&
 
 	git apply patch.file &&
-	test "$patched" = "`remove_cr one | git hash-object --stdin`" || {
+	test "$patched" = "`remove_cr <one | git hash-object --stdin`" || {
 		echo "Eh?  apply without index"
 		false
 	}
@@ -272,7 +259,7 @@ test_expect_success 'apply patch --index (autocrlf=true)' '
 
 	git apply --index patch.file &&
 	test "$patched" = `git rev-parse :one` &&
-	test "$patched" = "`remove_cr one | git hash-object --stdin`" || {
+	test "$patched" = "`remove_cr <one | git hash-object --stdin`" || {
 		echo "Eh?  apply with --index"
 		false
 	}
@@ -285,7 +272,7 @@ test_expect_success '.gitattributes says two is binary' '
 	git config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
 
-	if remove_cr dir/two >/dev/null
+	if has_cr dir/two
 	then
 		echo "Huh?"
 		false
@@ -293,7 +280,7 @@ test_expect_success '.gitattributes says two is binary' '
 		: happy
 	fi &&
 
-	if remove_cr one >/dev/null
+	if has_cr one
 	then
 		: happy
 	else
@@ -301,7 +288,7 @@ test_expect_success '.gitattributes says two is binary' '
 		false
 	fi &&
 
-	if remove_cr three >/dev/null
+	if has_cr three
 	then
 		echo "Huh?"
 		false
@@ -316,7 +303,7 @@ test_expect_success '.gitattributes says two is input' '
 	echo "two crlf=input" >.gitattributes &&
 	git read-tree --reset -u HEAD &&
 
-	if remove_cr dir/two >/dev/null
+	if has_cr dir/two
 	then
 		echo "Huh?"
 		false
@@ -331,7 +318,7 @@ test_expect_success '.gitattributes says two and three are text' '
 	echo "t* crlf" >.gitattributes &&
 	git read-tree --reset -u HEAD &&
 
-	if remove_cr dir/two >/dev/null
+	if has_cr dir/two
 	then
 		: happy
 	else
@@ -339,7 +326,7 @@ test_expect_success '.gitattributes says two and three are text' '
 		false
 	fi &&
 
-	if remove_cr three >/dev/null
+	if has_cr three
 	then
 		: happy
 	else
@@ -357,14 +344,14 @@ test_expect_success 'in-tree .gitattributes (1)' '
 	rm -rf tmp one dir .gitattributes patch.file three &&
 	git read-tree --reset -u HEAD &&
 
-	if remove_cr one >/dev/null
+	if has_cr one
 	then
 		echo "Eh? one should not have CRLF"
 		false
 	else
 		: happy
 	fi &&
-	remove_cr three >/dev/null || {
+	has_cr three || {
 		echo "Eh? three should still have CRLF"
 		false
 	}
@@ -376,14 +363,14 @@ test_expect_success 'in-tree .gitattributes (2)' '
 	git read-tree --reset HEAD &&
 	git checkout-index -f -q -u -a &&
 
-	if remove_cr one >/dev/null
+	if has_cr one
 	then
 		echo "Eh? one should not have CRLF"
 		false
 	else
 		: happy
 	fi &&
-	remove_cr three >/dev/null || {
+	has_cr three || {
 		echo "Eh? three should still have CRLF"
 		false
 	}
@@ -396,14 +383,14 @@ test_expect_success 'in-tree .gitattributes (3)' '
 	git checkout-index -u .gitattributes &&
 	git checkout-index -u one dir/two three &&
 
-	if remove_cr one >/dev/null
+	if has_cr one
 	then
 		echo "Eh? one should not have CRLF"
 		false
 	else
 		: happy
 	fi &&
-	remove_cr three >/dev/null || {
+	has_cr three || {
 		echo "Eh? three should still have CRLF"
 		false
 	}
@@ -416,14 +403,14 @@ test_expect_success 'in-tree .gitattributes (4)' '
 	git checkout-index -u one dir/two three &&
 	git checkout-index -u .gitattributes &&
 
-	if remove_cr one >/dev/null
+	if has_cr one
 	then
 		echo "Eh? one should not have CRLF"
 		false
 	else
 		: happy
 	fi &&
-	remove_cr three >/dev/null || {
+	has_cr three || {
 		echo "Eh? three should still have CRLF"
 		false
 	}
@@ -456,7 +443,7 @@ test_expect_success 'checkout when deleting .gitattributes' '
 
 	git checkout master~1 &&
 	git checkout master &&
-	remove_cr .file2 >/dev/null
+	has_cr .file2
 
 '
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 4e6a44b..4314ad2 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -134,10 +134,6 @@ test_expect_success 'rebase -q is quiet' '
      test ! -s output.out
 '
 
-q_to_cr () {
-	tr Q '\015'
-}
-
 test_expect_success 'Rebase a commit that sprinkles CRs in' '
 	(
 		echo "One"
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index f64aa48..bc46563 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -77,10 +77,6 @@ test_expect_success 'apply binary patch' \
 	 tree1=`git write-tree` &&
 	 test "$tree1" = "$tree0"'
 
-q_to_nul() {
-	perl -pe 'y/Q/\000/'
-}
-
 nul_to_q() {
 	perl -pe 'y/\000/Q/'
 }
diff --git a/t/t6033-merge-crlf.sh b/t/t6033-merge-crlf.sh
index 75d9602..e8d65ee 100755
--- a/t/t6033-merge-crlf.sh
+++ b/t/t6033-merge-crlf.sh
@@ -1,13 +1,5 @@
 #!/bin/sh
 
-append_cr () {
-	sed -e 's/$/Q/' | tr Q '\015'
-}
-
-remove_cr () {
-	tr '\015' Q | sed -e 's/Q$//'
-}
-
 test_description='merge conflict in crlf repo
 
 		b---M
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 40637d6..ed7b513 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -11,14 +11,6 @@ repository using cvs CLI client via git-cvsserver server'
 
 . ./test-lib.sh
 
-q_to_nul () {
-    perl -pe 'y/Q/\000/'
-}
-
-q_to_cr () {
-    tr Q '\015'
-}
-
 marked_as () {
     foundEntry="$(grep "^/$2/" "$1/CVS/Entries")"
     if [ x"$foundEntry" = x"" ] ; then
diff --git a/t/test-lib.sh b/t/test-lib.sh
index baa4093..afd3053 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -230,6 +230,22 @@ test_decode_color () {
 		-e 's/.\[m/<RESET>/g'
 }
 
+q_to_nul () {
+	perl -pe 'y/Q/\000/'
+}
+
+q_to_cr () {
+	tr Q '\015'
+}
+
+append_cr () {
+	sed -e 's/$/Q/' | tr Q '\015'
+}
+
+remove_cr () {
+	tr '\015' Q | sed -e 's/Q$//'
+}
+
 test_tick () {
 	if test -z "${test_tick+set}"
 	then
-- 
1.7.0.rc0
