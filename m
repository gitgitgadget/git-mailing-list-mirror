From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 03/10] replace: add test for --graft
Date: Mon, 07 Jul 2014 08:35:32 +0200
Message-ID: <20140707063540.3708.9611.chriscool@tuxfamily.org>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:37:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X42Xp-0007iA-Lw
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 08:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbaGGGgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 02:36:52 -0400
Received: from [194.158.98.14] ([194.158.98.14]:56996 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751298AbaGGGgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 02:36:35 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 864A26C;
	Mon,  7 Jul 2014 08:36:14 +0200 (CEST)
X-git-sha1: 400dfb5d81024d155d7599b671b80fecef6121ac 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140707063342.3708.83493.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252954>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6050-replace.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index fb07ad2..d80a89e 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -18,6 +18,33 @@ add_and_commit_file()
     git commit --quiet -m "$_file: $_msg"
 }
 
+commit_buffer_contains_parents()
+{
+    git cat-file commit "$1" >payload &&
+    sed -n -e '/^$/q' -e '/^parent /p' <payload >actual &&
+    shift &&
+    : >expected &&
+    for _parent
+    do
+	echo "parent $_parent" >>expected || return 1
+    done &&
+    test_cmp actual expected
+}
+
+commit_has_parents()
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
 HASH1=
 HASH2=
 HASH3=
@@ -351,4 +378,17 @@ test_expect_success 'replace ref cleanup' '
 	test -z "$(git replace)"
 '
 
+test_expect_success '--graft with and without already replaced object' '
+	test $(git log --oneline | wc -l) = 7 &&
+	git replace --graft $HASH5 &&
+	test $(git log --oneline | wc -l) = 3 &&
+	commit_buffer_contains_parents $HASH5 &&
+	commit_has_parents $HASH5 &&
+	test_must_fail git replace --graft $HASH5 $HASH4 $HASH3 &&
+	git replace --force -g $HASH5 $HASH4 $HASH3 &&
+	commit_buffer_contains_parents $HASH5 $HASH4 $HASH3 &&
+	commit_has_parents $HASH5 $HASH4 $HASH3 &&
+	git replace -d $HASH5
+'
+
 test_done
-- 
2.0.0.421.g786a89d.dirty
