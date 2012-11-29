From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [RFC/PATCH 2/2] reset: learn to reset on unborn branch
Date: Thu, 29 Nov 2012 10:32:55 -0800
Message-ID: <1354213975-17866-3-git-send-email-martinvonz@gmail.com>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
 <1354213975-17866-1-git-send-email-martinvonz@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 19:33:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te8vW-00009Z-In
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 19:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247Ab2K2SdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 13:33:08 -0500
Received: from mail-gg0-f202.google.com ([209.85.161.202]:57409 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab2K2SdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 13:33:07 -0500
Received: by mail-gg0-f202.google.com with SMTP id k1so708162ggn.1
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 10:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=kkNN3XowWc7NHAFdjw9MAdS9sAQcmemF/JJROpsA0nk=;
        b=h/DgsD/lNHnFogHVuCb9sj1f0001lt9Yq4PVXqlu1UIT0BIKPeni5i6SNVoHQL4no1
         Do1/zsBsEEbqUwogG/gt90QXpH3yqlH2ibqa9BiHTHu/fOfWtjRmNsGuYkFv8hFMVmH/
         GIkJAojOlWGjI1hazIAiCm/dhcAsCilX7e79ZCqtJmvmr/ZEKqazOcKToqYCcvx8ooBj
         d4SjyFni6sr95VxYZBGfmv2O7mlCelsFkzOHL2iDgJRXBLKCgB1N4k65y1Z3wEhSvnX6
         KZOT/N4hG8uiXEr4gnYqqxrMvZAy0Q3Z4EHKecME7UNr6Jr57353g6sUQFliljqrDbGR
         dOuw==
Received: by 10.236.83.235 with SMTP id q71mr15735855yhe.5.1354213986108;
        Thu, 29 Nov 2012 10:33:06 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id r6si162002yhc.7.2012.11.29.10.33.06
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 29 Nov 2012 10:33:06 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id E1EC882004A;
	Thu, 29 Nov 2012 10:33:05 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 96ABC102B21; Thu, 29 Nov 2012 10:33:05 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.240.ge8a1f5a
In-Reply-To: <1354213975-17866-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkbFLZHFSkgkO5i3WExl8QZXkDwKqMgsPFHGp0nWnZfqOKRu7geP88bhpOZbV19XOjout7kq6w1DQhW4RgVMc7N3RFfn1+2oS0vJXDoJZNB+iieU8jqR5JpvmDLIMXGI2YilTU9cwPfsRM4MxwzNE+MxBwijc38tkP1c+7zZtEAf+wwg0ZMkRIwSC8Ff63ZoPXaeL7D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210857>

When run on an unborn branch, "git reset" currently fails with:

  fatal: Failed to resolve 'HEAD' as a valid ref.

Fix this by interpreting it as a reset to the empty tree.

If --patch is given, we currently pass the revision specifier, as
given on the command line, to interactive_reset(). On an unborn
branch, HEAD can of course not be resolved, so we need to pass the
sha1 of the empty tree to interactive_reset() as well. This is fine
since interactive_reset only needs the parameter to be a treeish and
doesn't use it for display purposes.

---

Is it correct that interactive_reset does not use the revision
specifier for display purposes? Or, worse, that it requires it to be a
commit in some cases? I tried it and didn't see any problem.

 builtin/reset.c                | 10 +++++---
 t/t7106-reset-unborn-branch.sh | 52 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 3 deletions(-)
 create mode 100755 t/t7106-reset-unborn-branch.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index cec9874..3845225 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -229,7 +229,10 @@ static struct object *lookup_commit_or_tree(const char *rev) {
 	unsigned char sha1[20];
 	struct commit *commit;
 	struct tree *tree;
-	if (get_sha1_treeish(rev, sha1))
+	if (!strcmp(rev, "HEAD") && get_sha1("HEAD", sha1)) {
+		// unborn branch: reset to empty tree
+		hashcpy(sha1, EMPTY_TREE_SHA1_BIN);
+	} else if (get_sha1_treeish(rev, sha1))
 		die(_("Failed to resolve '%s' as a valid ref."), rev);
 	commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit)
@@ -292,7 +295,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		 * Otherwise, argv[i] could be either <rev> or <paths> and
 		 * has to be unambiguous.
 		 */
-		else if (!get_sha1_treeish(argv[i], sha1)) {
+		else if (!strcmp(argv[i], "HEAD") ||
+			 !get_sha1_treeish(argv[i], sha1)) {
 			/*
 			 * Ok, argv[i] looks like a rev; it should not
 			 * be a filename.
@@ -315,7 +319,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-		return interactive_reset(rev, argv + i, prefix);
+		return interactive_reset(sha1_to_hex(sha1), argv + i, prefix);
 	}
 
 	/* git reset tree [--] paths... can be used to
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
new file mode 100755
index 0000000..67d45be
--- /dev/null
+++ b/t/t7106-reset-unborn-branch.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='git reset should work on unborn branch'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo a >a &&
+	echo b >b
+'
+
+test_expect_success 'reset' '
+	git add a b &&
+	git reset &&
+	test "$(git ls-files)" == ""
+'
+
+test_expect_success 'reset HEAD' '
+	rm .git/index &&
+	git add a b &&
+	git reset HEAD &&
+	test "$(git ls-files)" == ""
+'
+
+test_expect_success 'reset $file' '
+	rm .git/index &&
+	git add a b &&
+	git reset a &&
+	test "$(git ls-files)" == "b"
+'
+
+test_expect_success 'reset -p' '
+	rm .git/index &&
+	git add a &&
+	echo y | git reset -p &&
+	test "$(git ls-files)" == ""
+'
+
+test_expect_success 'reset --soft not allowed' '
+	rm .git/index &&
+	git add a &&
+	test_must_fail git reset --soft
+'
+
+test_expect_success 'reset --hard' '
+	rm .git/index &&
+	git add a &&
+	git reset --hard &&
+	test "$(git ls-files)" == "" &&
+	test_path_is_missing a
+'
+
+test_done
-- 
1.8.0.1.240.ge8a1f5a
