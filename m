Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00581C4167B
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 01:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiLWBAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 20:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiLWA7m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 19:59:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDC92229D
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 16:58:24 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so5173004wma.1
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 16:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISehqMrRMBPP/YrKq0rUIYCYpQwaYTqMYWS3UUOrSV8=;
        b=RoJ2tBGbbo7Z8NUN7fhOHzc+QKVp2+ko1iD/au3WvW5jvZMAH+CJIihfrL09ZSvm1z
         EYNXZMcWpbcL6O1UcwKNEh9Qdiq9A6tOFAhIw93GlYYc9Qq3MWBTUK+6dVPMEnYd0NTT
         CsLgFLUYvwLgwFg/VOuQ7N2iqn0MkDrgKt7qDBAPrG91arpTXr9Qx+2+cB+VG7gF29F8
         y8uz95b/G4Zfn/r3/GdPRaiUjYGSAXYjwYRLXeKvpG6whNDGMTmfKyo2AWndxEmCaNLp
         ShQ6UzVULhOGbSqdUDqaSGwRM0e4c09aggAai0gM8KB5D895KkyXiZLqhXOaC8E/zuwF
         eEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISehqMrRMBPP/YrKq0rUIYCYpQwaYTqMYWS3UUOrSV8=;
        b=k1O8zXrMLdMoX03MkDnC5oG9q+V1sstBJ7zmgwPzeJ380DfyzZQGgGjM9fH3ZEbq9n
         kNez7eRqtpLJ6NV7wdbY4Zhgkc1WLWJTXXJzwm4PNXMl4HcZeg3Wbg32TGvbiGiQpjif
         bbaTtTA5OfFyYVq5gxtgn38aFMwoJyS/OmhbgiVvdMt1AwIDapHW/b5mCNfJQwZ5Nd/n
         bBy1ZV9dsrvf84E4WqS1d7viwQVy/OlegL9T8K0xIlQ2mn1tTd73n9djKiKkmc9Tom1v
         5RIXvJPns+vyDEMVdRFrE8DYeVwk/SomxqvjySCJ0N4cxj0clObcJFf6mNl08FYYon17
         aMDQ==
X-Gm-Message-State: AFqh2kq0YEknZW6hIeeVcT4W33khJ8JCa3gpkRjNR8NZG4sgzcpGXFDn
        dwkTZfAs9/RqYNysje3Zkjc=
X-Google-Smtp-Source: AMrXdXtRJ2I4mAIxArJ4WKbwIVOT0EUBnQ4vHGxdkxCMhYMe78r3+HfoMJVz7fMHfKg8q+zAyRFQmw==
X-Received: by 2002:a05:600c:358f:b0:3d1:cdf7:debf with SMTP id p15-20020a05600c358f00b003d1cdf7debfmr5841442wmq.26.1671757094396;
        Thu, 22 Dec 2022 16:58:14 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003d237d60318sm2986118wmo.2.2022.12.22.16.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 16:58:13 -0800 (PST)
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] branch: consider orphans when validate_branchname()
Message-ID: <4247f730-5592-de10-a238-5582eac2952d@gmail.com>
Date:   Fri, 23 Dec 2022 01:58:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a branch does not yet have a commit, we call that an orphan branch.
More technically, an orphan branch is a HEAD that points to a
nonexistent ref.

Orphan branches are not normal branches; can only be created, we cannot
simply switch to them.  The initial branch in an empty repository is
an orphan branch.  We can create new orphan branches using
"switch --orphan".

An orphan branch becomes an ordinary branch when the ref it points to is
created, i.e. when the first commit for the branch is done or the branch
is reset to an existing commit.

When we are asked to create a new branch, orphan or not, we use
validate_branchname() to check if a branch already exists in the
repository with the same desired name for the new branch.  In that
function we use ref_exists(), so we are not considering any orphan
branches as there is no ref related to an orphan branch.

If we switch from an orphan branch to a different one, orphan or not,
the initial orphan branch is simply lost.  We cannot switch back to it,
there is nothing to switch back to.  Therefore, there is no major
problem if we only check for valid refs when creating branches, orphans
or not, as there is no orphan branches to consider in the worktree.

Since 529fef20 (checkout: support checking out into a new working
directory, 2014-12-01) we have a safe way to use multiple worktrees with
a Git repository.

This allows the possibility of having multiple (ordinary and orphan)
branches simultaneously, and since we do not check for orphan branches
in validate_branchname(), the same orphan branch name can be used
multiple times.  Once any one of them becomes an ordinary branch, or a
new ordinary branch with the same name is created, all of them will be
/switched/ to that new branch.

It also opens the possibility to copy or rename a normal branch to a
name currently used by an orphan branch, with similar results.

Since 31ad6b61bd (branch: add branch_checked_out() helper, 2022-06-15)
we have a convenient way to see if a branch is checked out in any
worktree.

Let's use branch_checked_out() in validate_branchname() to prevent using
the same branch name multiple times, considering orphan branches too.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c                |  2 +-
 t/t2400-worktree-add.sh | 10 ++++++++++
 t/t3200-branch.sh       | 10 ++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index d182756827..4029721806 100644
--- a/branch.c
+++ b/branch.c
@@ -367,7 +367,7 @@ int validate_branchname(const char *name, struct strbuf *ref)
 	if (strbuf_check_branch_ref(ref, name))
 		die(_("'%s' is not a valid branch name"), name);
 
-	return ref_exists(ref->buf);
+	return ref_exists(ref->buf) || branch_checked_out(ref->buf);
 }
 
 static int initialized_checked_out_branches;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index d587e0b20d..f1e4b605da 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -118,6 +118,16 @@ test_expect_success '"add" worktree creating new branch' '
 	)
 '
 
+test_expect_success 'do not allow multiple worktrees with same orphan branch' '
+	test_when_finished "git worktree remove --force detached-wt-A" &&
+	test_when_finished "git worktree remove --force detached-wt-B" &&
+	git worktree add --detach detached-wt-A &&
+	git -C detached-wt-A checkout --orphan orphan-branch &&
+	git worktree add --detach detached-wt-B &&
+	test_must_fail git -C detached-wt-B checkout --orphan orphan-branch &&
+	test_must_fail git checkout --orphan orphan-branch
+'
+
 test_expect_success 'die the same branch is already checked out' '
 	(
 		cd here &&
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5a169b68d6..68bc579fff 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -192,6 +192,16 @@ test_expect_success 'git branch -M foo bar should fail when bar is checked out i
 	test_must_fail git branch -M bar wt
 '
 
+test_expect_success 'git branch -M/-C bar should fail when destination exists as orphan' '
+	test_when_finished "git worktree remove --force orphan-worktree" &&
+	git worktree add --detach orphan-worktree &&
+	git -C orphan-worktree checkout --orphan orphan-branch &&
+	test_must_fail git checkout --orphan orphan-branch &&
+	test_must_fail git branch orphan-branch &&
+	test_must_fail git branch -M orphan-branch &&
+	test_must_fail git branch -C orphan-branch
+'
+
 test_expect_success 'git branch -M baz bam should succeed when baz is checked out' '
 	git checkout -b baz &&
 	git branch bam &&
-- 
2.36.1

