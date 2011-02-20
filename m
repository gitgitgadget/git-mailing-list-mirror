From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v4 1/4] t3507: introduce pristine-detach helper
Date: Sat, 19 Feb 2011 23:12:26 -0500
Message-ID: <1298175149-41178-2-git-send-email-jaysoffian@gmail.com>
References: <1298175149-41178-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 20 05:13:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr0fg-0002em-V6
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 05:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab1BTENL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 23:13:11 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53232 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab1BTENK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 23:13:10 -0500
Received: by mail-qw0-f46.google.com with SMTP id 7so1290012qwd.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 20:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=5o197twHuiJPOQlFIa7SvsLKDZKhxAor6wsb0mJSoC8=;
        b=l5/zJcyUd9zZz1zMBGq9iNFlVH+XoBLbMonM/O9RPjUm5sDnRRqHrDnIqjk+JdAukB
         lCj2UHxQveoJNIeUX2d4NI+cXUMZb98/jA9zVP6eaxVu0rG6Soq8c48+sgOjYsdcR1zF
         a566+SXeVuH3CAv9rv5ECC2SnmxJLbnh2iQx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UeIukKQ5pmfMXTIArsuWAFzpoaoM9vpefCvr10hi9fK6jZL+cBNKPBaaxDSK8SIipv
         ottewXPWMI19jJBPgazBF6WwiG7xIfASLk0M7Ek9V0o30grgGXI2Q8NsQzrJgeD4G18i
         bl2KlQAgnjgKzh+4mpZFk6EcWpEL0tYpyjNl8=
Received: by 10.224.73.133 with SMTP id q5mr1989418qaj.234.1298175189760;
        Sat, 19 Feb 2011 20:13:09 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id l12sm2784493qcu.43.2011.02.19.20.13.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 20:13:09 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.51.g615e0
In-Reply-To: <1298175149-41178-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167396>

From: Jonathan Nieder <jrnieder@gmail.com>

All the tests in t3507 (cherry-pick with conflicts) begin with the
same checkout + read-tree + clean incantation to ensure a predictable
starting point.  Factor out a function for that so the interesting
part of the tests is easier to read.

The "update-index --refresh" and "diff-index --exit-code HEAD" are not
necessary as the point of this testsuite is not about testing
"read-tree --reset".

Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh |   76 +++++++++++---------------------------
 1 files changed, 22 insertions(+), 54 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 607bf25..2313d79 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -11,6 +11,18 @@ test_description='test cherry-pick and revert with conflicts
 
 . ./test-lib.sh
 
+test_cmp_rev () {
+	git rev-parse --verify "$1" >expect.rev &&
+	git rev-parse --verify "$2" >actual.rev &&
+	test_cmp expect.rev actual.rev
+}
+
+pristine_detach () {
+	git checkout -f "$1^0" &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x
+}
+
 test_expect_success setup '
 
 	echo unrelated >unrelated &&
@@ -23,13 +35,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'failed cherry-pick does not advance HEAD' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	pristine_detach initial &&
 
 	head=$(git rev-parse HEAD) &&
 	test_must_fail git cherry-pick picked &&
@@ -39,12 +45,7 @@ test_expect_success 'failed cherry-pick does not advance HEAD' '
 '
 
 test_expect_success 'advice from failed cherry-pick' "
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	pristine_detach initial &&
 
 	picked=\$(git rev-parse --short picked) &&
 	cat <<-EOF >expected &&
@@ -59,13 +60,7 @@ test_expect_success 'advice from failed cherry-pick' "
 "
 
 test_expect_success 'failed cherry-pick produces dirty index' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	pristine_detach initial &&
 
 	test_must_fail git cherry-pick picked &&
 
@@ -74,9 +69,7 @@ test_expect_success 'failed cherry-pick produces dirty index' '
 '
 
 test_expect_success 'failed cherry-pick registers participants in index' '
-
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
+	pristine_detach initial &&
 	{
 		git checkout base -- foo &&
 		git ls-files --stage foo &&
@@ -90,10 +83,7 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 		2 s/ 0	/ 2	/
 		3 s/ 0	/ 3	/
 	" < stages > expected &&
-	git checkout -f initial^0 &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	git read-tree -u --reset HEAD &&
 
 	test_must_fail git cherry-pick picked &&
 	git ls-files --stage --unmerged > actual &&
@@ -102,10 +92,7 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 '
 
 test_expect_success 'failed cherry-pick describes conflict in work tree' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
+	pristine_detach initial &&
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
@@ -114,9 +101,6 @@ test_expect_success 'failed cherry-pick describes conflict in work tree' '
 	>>>>>>> objid picked
 	EOF
 
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
-
 	test_must_fail git cherry-pick picked &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
@@ -124,11 +108,8 @@ test_expect_success 'failed cherry-pick describes conflict in work tree' '
 '
 
 test_expect_success 'diff3 -m style' '
-
+	pristine_detach initial &&
 	git config merge.conflictstyle diff3 &&
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
@@ -139,9 +120,6 @@ test_expect_success 'diff3 -m style' '
 	>>>>>>> objid picked
 	EOF
 
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
-
 	test_must_fail git cherry-pick picked &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
@@ -149,10 +127,8 @@ test_expect_success 'diff3 -m style' '
 '
 
 test_expect_success 'revert also handles conflicts sanely' '
-
 	git config --unset merge.conflictstyle &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
+	pristine_detach initial &&
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
@@ -173,10 +149,7 @@ test_expect_success 'revert also handles conflicts sanely' '
 		2 s/ 0	/ 2	/
 		3 s/ 0	/ 3	/
 	" < stages > expected-stages &&
-	git checkout -f initial^0 &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	git read-tree -u --reset HEAD &&
 
 	head=$(git rev-parse HEAD) &&
 	test_must_fail git revert picked &&
@@ -192,10 +165,8 @@ test_expect_success 'revert also handles conflicts sanely' '
 '
 
 test_expect_success 'revert conflict, diff3 -m style' '
+	pristine_detach initial &&
 	git config merge.conflictstyle diff3 &&
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
@@ -206,9 +177,6 @@ test_expect_success 'revert conflict, diff3 -m style' '
 	>>>>>>> parent of objid picked
 	EOF
 
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
-
 	test_must_fail git revert picked &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
-- 
1.7.4.1.51.g615e0
