From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCHv3 1/2] add basic tests for merge-tree
Date: Wed, 14 Jul 2010 18:04:06 +0100
Message-ID: <1279127047-3273-2-git-send-email-wmpalmer@gmail.com>
References: <1279127047-3273-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 19:04:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ5Np-0001m0-M2
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab0GNRE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 13:04:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40383 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab0GNRE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 13:04:28 -0400
Received: by wyb42 with SMTP id 42so41920wyb.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tOSI6mnGpno7K4ClXBJVAStnaFcZ9rKGmwK2hYePurY=;
        b=t8tvJGUYNQ3DzT2vF4LVPxulnzdN0i2yS0cw3EqInCixNWwV633BTR6ooMUW169xLg
         depmOWAdOV4/AebiRkSxgppFmab+M7IF9ffrUAfA84NbOutq2G0XlKmd+alX/mE6qKo6
         31waClBNrdc7HkGPwaMuLl6rXyldvfgyVJUC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ICX5eplQA0Ph17BWkQK+dgYCod0ioC6dJOh2krxeR5KcW6xmRuN5NThKJGE+Abyilz
         Kin0BvhkaZfestan7Vq/86HxBQSX57qtgznko/6OFCuJoI/iXKTAFJGdz8sXsww1JLBF
         qVisFHS+8If4npUfmkdb0sjvSxMtE302EV3kU=
Received: by 10.227.127.68 with SMTP id f4mr16384081wbs.94.1279127066679;
        Wed, 14 Jul 2010 10:04:26 -0700 (PDT)
Received: from localhost.localdomain (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id o11sm3259854wej.21.2010.07.14.10.04.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 10:04:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.703.g42c01
In-Reply-To: <1279127047-3273-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151011>

merge-tree had no test cases, so here we add some very basic tests for
it, including some known-breakages.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 t/t4300-merge-tree.sh |  257 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 257 insertions(+), 0 deletions(-)
 create mode 100755 t/t4300-merge-tree.sh

diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
new file mode 100755
index 0000000..c02c986
--- /dev/null
+++ b/t/t4300-merge-tree.sh
@@ -0,0 +1,257 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Will Palmer
+#
+
+test_description='git merge-tree'
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit "initial" "initial-file" "initial"
+'
+
+test_expect_'file add A, !B' '
+	cat >expected <<\EXPECTED
+added in remote
+  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+@@ -0,0 +1 @@
++AAA
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "add-a-not-b" "ONE" "AAA" &&
+	git merge-tree initial initial add-a-not-b >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'file add !A, B' '
+	cat >expected <<\EXPECTED
+added in local
+  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "add-not-a-b" "ONE" "AAA" &&
+	git merge-tree initial add-not-a-b initial >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'file add A, B (same)' '
+	cat >expected <<\EXPECTED
+added in both
+  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "add-a-b-same-A" "ONE" "AAA" &&
+	git reset --hard initial &&
+	test_commit "add-a-b-same-B" "ONE" "AAA" &&
+	git merge-tree initial add-a-b-same-A add-a-b-same-B >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'file add A, B (different)' '
+	cat >expected <<\EXPECTED
+added in both
+  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+  their  100644 ba629238ca89489f2b350e196ca445e09d8bb834 ONE
+@@ -1 +1,5 @@
++<<<<<<< .our
+ AAA
++=======
++BBB
++>>>>>>> .their
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "add-a-b-diff-A" "ONE" "AAA" &&
+	git reset --hard initial &&
+	test_commit "add-a-b-diff-B" "ONE" "BBB" &&
+	git merge-tree initial add-a-b-diff-A add-a-b-diff-B >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'file change A, !B' '
+	cat >expected <<\EXPECTED
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "change-a-not-b" "initial-file" "BBB" &&
+	git merge-tree initial change-a-not-b initial >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'file change !A, B' '
+	cat >expected <<\EXPECTED
+merged
+  result 100644 ba629238ca89489f2b350e196ca445e09d8bb834 initial-file
+  our    100644 e79c5e8f964493290a409888d5413a737e8e5dd5 initial-file
+@@ -1 +1 @@
+-initial
++BBB
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "change-not-a-b" "initial-file" "BBB" &&
+	git merge-tree initial initial change-not-a-b >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'file change A, B (same)' '
+	cat >expected <<\EXPECTED
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "change-a-b-same-A" "initial-file" "AAA" &&
+	git reset --hard initial &&
+	test_commit "change-a-b-same-B" "initial-file" "AAA" &&
+	git merge-tree initial change-a-b-same-A change-a-b-same-B >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'file change A, B (different)' '
+	cat >expected <<\EXPECTED
+changed in both
+  base   100644 e79c5e8f964493290a409888d5413a737e8e5dd5 initial-file
+  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d initial-file
+  their  100644 ba629238ca89489f2b350e196ca445e09d8bb834 initial-file
+@@ -1 +1,5 @@
++<<<<<<< .our
+ AAA
++=======
++BBB
++>>>>>>> .their
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "change-a-b-diff-A" "initial-file" "AAA" &&
+	git reset --hard initial &&
+	test_commit "change-a-b-diff-B" "initial-file" "BBB" &&
+	git merge-tree initial change-a-b-diff-A change-a-b-diff-B >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'file change A, B (mixed)' '
+	cat >expected <<\EXPECTED
+changed in both
+  base   100644 f4f1f998c7776568c4ff38f516d77fef9399b5a7 ONE
+  our    100644 af14c2c3475337c73759d561ef70b59e5c731176 ONE
+  their  100644 372d761493f524d44d59bd24700c3bdf914c973c ONE
+@@ -7,7 +7,11 @@
+ AAA
+ AAA
+ AAA
++<<<<<<< .our
+ BBB
++=======
++CCC
++>>>>>>> .their
+ AAA
+ AAA
+ AAA
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "change-a-b-mix-base" "ONE" "
+AAA
+AAA
+AAA
+AAA
+AAA
+AAA
+AAA
+AAA
+AAA
+AAA
+AAA
+AAA
+AAA
+AAA
+AAA" &&
+	test_commit "change-a-b-mix-A" "ONE" \
+		"$(sed -e "1{s/AAA/BBB/;}" -e "10{s/AAA/BBB/;}" <ONE)" &&
+	git reset --hard change-a-b-mix-base &&
+	test_commit "change-a-b-mix-B" "ONE" \
+		"$(sed -e "1{s/AAA/BBB/;}" -e "10{s/AAA/CCC/;}" <ONE)" &&
+	git merge-tree change-a-b-mix-base change-a-b-mix-A change-a-b-mix-B \
+		>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'file remove A, !B' '
+	cat >expected <<\EXPECTED
+removed in local
+  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+  their  100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "rm-a-not-b-base" "ONE" "AAA" &&
+	git rm ONE &&
+	git commit -m "rm-a-not-b" &&
+	git tag "rm-a-not-b" &&
+	git merge-tree rm-a-not-b-base rm-a-not-b rm-a-not-b-base >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'file remove !A, B' '
+	cat >expected <<\EXPECTED
+removed in remote
+  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+  our    100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+@@ -1 +0,0 @@
+-AAA
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "rm-not-a-b-base" "ONE" "AAA" &&
+	git rm ONE &&
+	git commit -m "rm-not-a-b" &&
+	git tag "rm-not-a-b" &&
+	git merge-tree rm-a-not-b-base rm-a-not-b-base rm-a-not-b >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'file change A, remove B' '
+	cat >expected <<\EXPECTED
+removed in remote
+  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+  our    100644 ba629238ca89489f2b350e196ca445e09d8bb834 ONE
+@@ -1 +0,0 @@
+-BBB
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "change-a-rm-b-base" "ONE" "AAA" &&
+	test_commit "change-a-rm-b-A" "ONE" "BBB" &&
+	git reset --hard change-a-rm-b-base &&
+	git rm ONE &&
+	git commit -m "change-a-rm-b-B" &&
+	git tag "change-a-rm-b-B" &&
+	git merge-tree change-a-rm-b-base change-a-rm-b-A change-a-rm-b-B \
+		>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'file remove A, change B' '
+	cat >expected <<\EXPECTED
+removed in local
+  base   100644 43d5a8ed6ef6c00ff775008633f95787d088285d ONE
+  their  100644 ba629238ca89489f2b350e196ca445e09d8bb834 ONE
+EXPECTED
+
+	git reset --hard initial &&
+	test_commit "rm-a-change-b-base" "ONE" "AAA" &&
+
+	git rm ONE &&
+	git commit -m "rm-a-change-b-A" &&
+	git tag "rm-a-change-b-A" &&
+	git reset --hard rm-a-change-b-base &&
+	test_commit "rm-a-change-b-B" "ONE" "BBB" &&
+	git merge-tree rm-a-change-b-base rm-a-change-b-A rm-a-change-b-B \
+		>actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.7.1.703.g42c01
