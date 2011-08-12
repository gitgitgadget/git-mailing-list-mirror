From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 06/56] t6042: Ensure rename/rename conflicts leave index and workdir in sane state
Date: Thu, 11 Aug 2011 23:19:39 -0600
Message-ID: <1313126429-17368-7-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkB5-0004ab-LO
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab1HLFVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:00 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40974 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab1HLFUo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:44 -0400
Received: by yxj19 with SMTP id 19so1756068yxj.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=F8qq0kyzeZ8Tc4PdtDP6A8afUJnoHa2vl1i+PkpuzjY=;
        b=LTBLfK5yXwcrFz5AjaoGN34CslFxxOM/wb08WFtr5N7c3ny5zORmpZgyCIP0joe5e2
         wpif11wgJDsRfCRJ3eys3svqLnPi2bSFlLbYi2WbqFke59gfGtQw2d2TxeWLAOqtaRRb
         TUwfKnRNi3OvMp4FScjr4JzDheedMaayrzQVE=
Received: by 10.43.132.73 with SMTP id ht9mr589120icc.54.1313126444184;
        Thu, 11 Aug 2011 22:20:44 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.42
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179170>

rename/rename conflicts, both with one file being renamed to two different
files and with two files being renamed to the same file, should leave the
index and the working copy in a sane state with appropriate conflict
recording, auxiliary files, etc.  Git seems to handle one of the two cases
alright, but has some problems with the two files being renamed to one
case.  Add tests for both cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 t/t6042-merge-rename-corner-cases.sh |  102 ++++++++++++++++++++++++++++++++++
 1 files changed, 102 insertions(+), 0 deletions(-)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index b465667..371fb39 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -339,4 +339,106 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
 	test -f sub
 '
 
+# Test for all kinds of things that can go wrong with rename/rename (2to1):
+#   Commit A: new files: a & b
+#   Commit B: rename a->c, modify b
+#   Commit C: rename b->c, modify a
+#
+# Merging of B & C should NOT be clean.  Questions:
+#   * Both a & b should be removed by the merge; are they?
+#   * The two c's should contain modifications to a & b; do they?
+#   * The index should contain two files, both for c; does it?
+#   * The working copy should have two files, both of form c~<unique>; does it?
+#   * Nothing else should be present.  Is anything?
+
+test_expect_success 'setup rename/rename (2to1) + modify/modify' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n" >a &&
+	printf "5\n4\n3\n2\n1\n" >b &&
+	git add a b &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a c &&
+	echo 0 >>b &&
+	git add b &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv b c &&
+	echo 6 >>a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_failure 'handle rename/rename (2to1) conflict correctly' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 >out &&
+	grep "CONFLICT (rename/rename)" out &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 2 -eq $(git ls-files -u c | wc -l) &&
+	test 3 -eq $(git ls-files -o | wc -l) &&
+
+	test ! -f a &&
+	test ! -f b &&
+	test -f c~HEAD &&
+	test -f c~C^0 &&
+
+	test $(git hash-object c~HEAD) = $(git rev-parse C:a) &&
+	test $(git hash-object c~C^0) = $(git rev-parse B:b)
+'
+
+# Testcase setup for simple rename/rename (1to2) conflict:
+#   Commit A: new file: a
+#   Commit B: rename a->b
+#   Commit C: rename a->c
+test_expect_success 'setup simple rename/rename (1to2) conflict' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	echo stuff >a &&
+	git add a &&
+	test_tick &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	test_tick &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a c &&
+	test_tick &&
+	git commit -m C
+'
+
+test_expect_success 'merge has correct working tree contents' '
+	git checkout C^0 &&
+
+	test_must_fail git merge -s recursive B^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
+	test $(git rev-parse :3:b) = $(git rev-parse A:a) &&
+	test $(git rev-parse :2:c) = $(git rev-parse A:a) &&
+
+	test ! -f a &&
+	test $(git hash-object b) = $(git rev-parse A:a) &&
+	test $(git hash-object c) = $(git rev-parse A:a)
+'
+
 test_done
-- 
1.7.6.100.gac5c1
