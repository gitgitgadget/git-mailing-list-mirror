From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/4] apply, fmt-merge-msg: use relative filenames
Date: Sat, 23 May 2009 11:53:11 -0700
Message-ID: <1243104793-3254-3-git-send-email-bebarino@gmail.com>
References: <1243104793-3254-1-git-send-email-bebarino@gmail.com>
 <1243104793-3254-2-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 20:53:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wLs-0007xZ-6g
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 20:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbZEWSxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 14:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbZEWSxY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 14:53:24 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:54773 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbZEWSxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 14:53:23 -0400
Received: by mail-px0-f103.google.com with SMTP id 1so1894468pxi.33
        for <git@vger.kernel.org>; Sat, 23 May 2009 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=RTnRfy/zSnBBloUsIgWM1MLq9s215Es+bQGybaGIXiA=;
        b=naubu6i5xtyJT6iZUIAFOVew4xk8Eek3ahao3WxenIyDOocHtZ/ho4suYdhq8U70De
         m6r84Dye/koD2fzDjior24ae/9gpP6V1fJ4zGEUd1P/RfdKFtjVnFHU5l/WYd2Vsb4In
         rJVlMIH1E+lG/SpbLPMI4lck/IhBMudzIgfXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jRqe6pauXw4Z1nkuzr93MfKWdYQ5xWxY5UVJr0EbsLnL7uQGyJ4ko43KmDgLrvtvEq
         7HMbmHE7+EAipfn2AFnWmj3+e8O5QwJ/KCHmYyxGWwZJTlLDbVwdQImZABcuNJP842eO
         8VI+f2deNrn+AgUqvlx5id/ZysKejCDnYrZHA=
Received: by 10.114.134.20 with SMTP id h20mr10686373wad.71.1243104805142;
        Sat, 23 May 2009 11:53:25 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id j34sm5273984waf.29.2009.05.23.11.53.23
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 11:53:24 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 23 May 2009 11:53:21 -0700
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243104793-3254-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119784>

Commit dbd0f5c7 (Files given on the command line are relative to $cwd,
2008-08-06) only fixed git-commit and git-tag. But, git-apply and
git-fmt-merge-msg didn't get the update and exhibit the same behavior.

Fix them and add tests for "apply --build-fake-ancestor" and
"fmt-merge-msg -F".

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

If anyone knows a better way to test for build-fake-ancestor please
let me know. Right now it's just testing for file.

 builtin-apply.c                |    4 +++
 builtin-fmt-merge-msg.c        |    1 +
 t/t4131-apply-fake-ancestor.sh |   42 ++++++++++++++++++++++++++++++++++++++++
 t/t6200-fmt-merge-msg.sh       |   32 ++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100755 t/t4131-apply-fake-ancestor.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index 8a3771e..a40b982 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -3315,6 +3315,10 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 
 	argc = parse_options(argc, argv, builtin_apply_options,
 			apply_usage, 0);
+	fake_ancestor = parse_options_fix_filename(prefix, fake_ancestor);
+	if (fake_ancestor)
+		fake_ancestor = xstrdup(fake_ancestor);
+
 	if (apply_with_reject)
 		apply = apply_verbosely = 1;
 	if (!force_apply && (diffstat || numstat || summary || check || fake_ancestor))
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index a788369..fae1482 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -363,6 +363,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, options, fmt_merge_msg_usage, 0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
+	inpath = parse_options_fix_filename(prefix, inpath);
 
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
diff --git a/t/t4131-apply-fake-ancestor.sh b/t/t4131-apply-fake-ancestor.sh
new file mode 100755
index 0000000..94373ca
--- /dev/null
+++ b/t/t4131-apply-fake-ancestor.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Stephen Boyd
+#
+
+test_description='git apply --build-fake-ancestor handling.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit 1 &&
+	test_commit 2 &&
+	mkdir sub &&
+	test_commit 3 sub/3 &&
+	test_commit 4
+'
+
+test_expect_success 'apply --build-fake-ancestor' '
+	git checkout 2 &&
+	echo "A" > 1.t &&
+	git diff > 1.patch &&
+	git reset --hard &&
+	git checkout 1 &&
+	git apply --build-fake-ancestor 1.ancestor 1.patch
+'
+
+test_expect_success 'apply --build-fake-ancestor in a subdirectory' '
+	git checkout 3 &&
+	echo "C" > sub/3.t &&
+	git diff > 3.patch &&
+	git reset --hard &&
+	git checkout 4 &&
+	(
+		cd sub &&
+		git apply --build-fake-ancestor 3.ancestor ../3.patch &&
+		test -f 3.ancestor
+	) &&
+	git apply --build-fake-ancestor 3.ancestor 3.patch &&
+	test_cmp sub/3.ancestor 3.ancestor
+'
+
+test_done
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 2049ab6..42f6fff 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -208,4 +208,36 @@ test_expect_success 'merge-msg test #5-2' '
 	test_cmp expected actual
 '
 
+test_expect_success 'merge-msg -F' '
+
+	git config --unset-all merge.log
+	git config --unset-all merge.summary
+	git config merge.summary yes &&
+
+	git checkout master &&
+	setdate &&
+	git fetch . left right &&
+
+	git fmt-merge-msg -F .git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'merge-msg -F in subdirectory' '
+
+	git config --unset-all merge.log
+	git config --unset-all merge.summary
+	git config merge.summary yes &&
+
+	git checkout master &&
+	setdate &&
+	git fetch . left right &&
+	mkdir sub &&
+	cp .git/FETCH_HEAD sub/FETCH_HEAD &&
+	(
+		cd sub &&
+		git fmt-merge-msg -F FETCH_HEAD >../actual
+	) &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.6.3.1.145.gb74d77
