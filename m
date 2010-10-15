From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCHv2 4/5] add test for git grep --recursive
Date: Fri, 15 Oct 2010 16:26:43 -0700
Message-ID: <1287185204-843-5-git-send-email-judge.packham@gmail.com>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Cc: Jens.Lehmann@web.de, pclouds@gmail.com, gitster@pobox.com,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 16 01:27:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6tgT-0001CE-JZ
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 01:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab0JOX1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 19:27:14 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54764 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab0JOX1L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 19:27:11 -0400
Received: by pzk33 with SMTP id 33so195843pzk.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 16:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zofuN3jpEakFuC1QMOIxraycI0Q8zlQQJWKlvFp0wYk=;
        b=QaVl2WFA+RTutzQc4Ir+d61E8W78VU3v3Nzw1UTvRET53p9Zmco2VREoblz8i9pN3f
         NavC8xCZp7HQSgyGxoVw6tdoU2yKQyH0no5Xp3n/gF7VBKIyv2+bSYOK/cbxh0vuJV1a
         DV/E2tx+G/hoIdVPN/gzmcPJ9J44uNsYLS+1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QgLqstL2Co4oGHJh7I6hF4d0S2RcQz+FTuseSLb7QMbWD6hSy9D0lw/pHY79kftoH6
         GAqR2g5ac9PWR02i7qTcUkqixAgzcmdHS8pMwmTeHmlKyxYLFYqhJ9ruaLLiv/l7JtEn
         rPYTxpEI2l0Yb9vmorG12OC1zwKoh70sK3wKQ=
Received: by 10.142.157.11 with SMTP id f11mr1172698wfe.94.1287185231386;
        Fri, 15 Oct 2010 16:27:11 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id y42sm10506678wfd.10.2010.10.15.16.27.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 16:27:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159147>

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 t/t7820-grep-recursive.sh |  183 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 183 insertions(+), 0 deletions(-)
 create mode 100644 t/t7820-grep-recursive.sh

diff --git a/t/t7820-grep-recursive.sh b/t/t7820-grep-recursive.sh
new file mode 100644
index 0000000..3c386b4
--- /dev/null
+++ b/t/t7820-grep-recursive.sh
@@ -0,0 +1,183 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Chris Packham
+#
+
+test_description='git grep --recursive test
+
+This test checks the ability of git grep to search within submodules when told
+to do so with the --recursive option'
+
+. ./test-lib.sh
+
+restore_test_defaults()
+{
+	unset GIT_SUPER_REFNAME
+}
+
+test_expect_success 'setup' '
+	cat >t <<-\EOF &&
+	one two three
+	four five six
+	seven eight nine
+	EOF
+	git add t &&
+	git commit -m "initial commit"
+'
+submodurl=$TRASH_DIRECTORY
+
+test_expect_success 'setup submodules' '
+	for mod in submodule1 submodule2 submodule3 submodule4 submodule5; do
+		git submodule add "$submodurl" $mod &&
+		git submodule init $mod
+	done &&
+	git commit -m "setup submodules for test"
+'
+
+test_expect_success 'update data in each submodule' '
+	for n in 1 2 3 4 5; do
+		(cd submodule$n &&
+			sed -i "s/^four.*/& #$n/" t &&
+			git commit -a -m"update") &&
+		git add submodule$n
+	done &&
+	git commit -m "update data in each submodule"
+'
+
+test_expect_success 'non-recursive grep in base' '
+	cat >expected <<-\EOF &&
+	t:four five six
+	EOF
+	git grep "five" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule-ref option' '
+	cat >expected <<-\EOF &&
+	bar:t:four five six
+	EOF
+	GIT_SUPER_REFNAME=bar &&
+	export GIT_SUPER_REFNAME &&
+	git grep "five" master >actual &&
+	test_cmp expected actual &&
+	restore_test_defaults
+'
+
+test_expect_success 'non-recursive grep in submodule' '
+	(
+		cd submodule1 &&
+		cat >expected <<-\EOF &&
+		t:four five six #1
+		EOF
+		git grep "five" >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'recursive grep' '
+	cat >expected <<-\EOF &&
+	submodule1/t:four five six #1
+	submodule2/t:four five six #2
+	submodule3/t:four five six #3
+	submodule4/t:four five six #4
+	submodule5/t:four five six #5
+	t:four five six
+	EOF
+	git grep --recursive "five" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'recursive grep (with -n)' '
+	cat >expected <<-\EOF &&
+	submodule1/t:2:four five six #1
+	submodule2/t:2:four five six #2
+	submodule3/t:2:four five six #3
+	submodule4/t:2:four five six #4
+	submodule5/t:2:four five six #5
+	t:2:four five six
+	EOF
+	git grep --recursive -n "five" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'recursive grep (with -l)' '
+	cat >expected <<-\EOF &&
+	submodule1/t
+	submodule2/t
+	submodule3/t
+	submodule4/t
+	submodule5/t
+	t
+	EOF
+	git grep --recursive -l "five" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'recursive grep (with --or)' '
+	cat >expected <<-\EOF &&
+	submodule1/t:one two three
+	submodule1/t:four five six #1
+	submodule2/t:one two three
+	submodule2/t:four five six #2
+	submodule3/t:one two three
+	submodule3/t:four five six #3
+	submodule4/t:one two three
+	submodule4/t:four five six #4
+	submodule5/t:one two three
+	submodule5/t:four five six #5
+	t:one two three
+	t:four five six
+	EOF
+	git grep --recursive \( -e "five" --or -e "two" \) >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'recursive grep (with --and --not)' '
+	cat >expected <<-\EOF &&
+	submodule2/t:four five six #2
+	submodule3/t:four five six #3
+	submodule4/t:four five six #4
+	submodule5/t:four five six #5
+	t:four five six
+	EOF
+	git grep --recursive \( -e "five" --and --not -e "#1" \) >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'recursive grep with refspec' '
+	cat >expected <<-\EOF &&
+	master:submodule1/t:four five six #1
+	master:submodule2/t:four five six #2
+	master:submodule3/t:four five six #3
+	master:submodule4/t:four five six #4
+	master:submodule5/t:four five six #5
+	master:t:four five six
+	EOF
+	git grep --recursive five master >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'recursive grep with pathspec' '
+	cat >expected <<-\EOF &&
+	submodule2/t:four five six #2
+	EOF
+	git grep --recursive five -- submodule2 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'recursive grep with pathspec and refspec' '
+	cat >expected <<-\EOF &&
+	master:submodule2/t:four five six #2
+	EOF
+	git grep --recursive five master -- submodule2 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'recursive grep with --max-depth' '
+	cat >expected <<-\EOF &&
+	t:four five six
+	EOF
+	git grep --recursive --max-depth=1 five  >actual &&
+	test_cmp expected actual
+'
+test_done
-- 
1.7.3.1
