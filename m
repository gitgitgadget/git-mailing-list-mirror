From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 3/9] replace: add test for --graft
Date: Sat, 19 Jul 2014 17:01:09 +0200
Message-ID: <20140719150116.9564.48264.chriscool@tuxfamily.org>
References: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 17:42:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Wm2-00087f-7D
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 17:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbaGSPlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 11:41:51 -0400
Received: from [194.158.98.15] ([194.158.98.15]:49381 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755063AbaGSPlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 11:41:46 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 0B9F174;
	Sat, 19 Jul 2014 17:41:25 +0200 (CEST)
X-git-sha1: a45fec9ff80bf6210b8c8ab47c72a49f3c5e43c9 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253888>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6050-replace.sh | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index fb07ad2..f854dae 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -8,7 +8,7 @@ exec </dev/null
 
 . ./test-lib.sh
 
-add_and_commit_file()
+add_and_commit_file ()
 {
     _file="$1"
     _msg="$2"
@@ -18,6 +18,38 @@ add_and_commit_file()
     git commit --quiet -m "$_file: $_msg"
 }
 
+commit_buffer_contains_parents ()
+{
+    git cat-file commit "$1" >payload &&
+    sed -n -e '/^$/q' -e '/^parent /p' <payload >actual &&
+    shift &&
+    for _parent
+    do
+	echo "parent $_parent"
+    done >expected &&
+    test_cmp expected actual
+}
+
+commit_peeling_shows_parents ()
+{
+    _parent_number=1
+    _commit="$1"
+    shift &&
+    for _parent
+    do
+	_found=$(git rev-parse --verify $_commit^$_parent_number) || return 1
+	test "$_found" = "$_parent" || return 1
+	_parent_number=$(( $_parent_number + 1 ))
+    done &&
+    test_must_fail git rev-parse --verify $_commit^$_parent_number
+}
+
+commit_has_parents ()
+{
+    commit_buffer_contains_parents "$@" &&
+    commit_peeling_shows_parents "$@"
+}
+
 HASH1=
 HASH2=
 HASH3=
@@ -351,4 +383,15 @@ test_expect_success 'replace ref cleanup' '
 	test -z "$(git replace)"
 '
 
+test_expect_success '--graft with and without already replaced object' '
+	test $(git log --oneline | wc -l) = 7 &&
+	git replace --graft $HASH5 &&
+	test $(git log --oneline | wc -l) = 3 &&
+	commit_has_parents $HASH5 &&
+	test_must_fail git replace --graft $HASH5 $HASH4 $HASH3 &&
+	git replace --force -g $HASH5 $HASH4 $HASH3 &&
+	commit_has_parents $HASH5 $HASH4 $HASH3 &&
+	git replace -d $HASH5
+'
+
 test_done
-- 
2.0.0.421.g786a89d.dirty
