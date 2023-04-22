Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D3EC77B78
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 22:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDVWT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 18:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDVWT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 18:19:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFA126AD
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 15:19:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2f87c5b4635so2808783f8f.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682201963; x=1684793963;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ+aoC6ySzh7skTJeAMnkovekBqKSykLZlOBFW3/qEQ=;
        b=ffHotN7NCNWV2u4hoT/9ozsZvZwB9e8bIeVbl/A8o4+IWb6LvDdEFSLUp3MTVvsV3V
         muJyJ8MciCUMEZxxkSNlxRbuLsCi1u0Q6E67u5Xmim8OE2O+d0C6KWNoKVqShqExLgyj
         U5+XtdLYC5LWnhpH6Po6Pgp/6QzSKATNqeG2v8ISq6TIJL9scwdnFaXjFvpW/fhcayoB
         QGHNPBZkYXAUzQlZsbkNS9YUOmF/YkaOuK8HEZ8ECRWeALXREnU63ymhGeHgRq9NchhA
         mH4gSJDcsuUywc5mKI89Afpk4Df81p4YifUG9dky1G/8D0BsS9Wb9CEnIYgNM/a5Il3E
         o2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682201963; x=1684793963;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ+aoC6ySzh7skTJeAMnkovekBqKSykLZlOBFW3/qEQ=;
        b=U1i6tSxkFtJF1t6h9BxhuNZVMEBAoJNmOw6nJhvr9z+Bv7a6FWjLVq6fnJunMNUmGi
         a2knuuXA0NG2xbt5xHVUjS3+H/nIaRfhksyalfCg4SkHTCWN8O+Tkq7v/7vkR6UDWrRc
         2NLt5wbiFZywqRsFLIffJq4JiG8IXZsoU3nvs/fzRVx7CZV27UBgzbRBgyP8X+j4QkBG
         3tygjPCAzuLFOknQmbFXLS8/ZbhJ99mwGC1K0bbY48ZKHKPRFo9yUzOcn+5wWfpJxOLR
         pz4uunrVer6FZOBgcMAIQWAEv2KgOOCCBJssit/s2lkVXmY+DLyJOtGBwr+SIM2bxoho
         zqNQ==
X-Gm-Message-State: AAQBX9eKSp84OS9AI7nRheLs+tSCJDvtg2q/CIkyBkukM+xBAr5kYECy
        zJPlgGyOzbuCCUlGWsdBsgem4oSV1/Y=
X-Google-Smtp-Source: AKy350Yh1u2gkTffuXaMQiaB2A2sQUW273PiptNxQ9+554eR45LI1Tm/UJn4nVZlNcRAEQ8lxomBtw==
X-Received: by 2002:adf:cf0d:0:b0:2f1:e162:d48 with SMTP id o13-20020adfcf0d000000b002f1e1620d48mr6581118wrj.47.1682201963343;
        Sat, 22 Apr 2023 15:19:23 -0700 (PDT)
Received: from [192.168.2.52] (32.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.32])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b003f1738d0d13sm16016946wmq.1.2023.04.22.15.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 15:19:23 -0700 (PDT)
Subject: [PATCH 2/3] worktree: warn when removing a worktree with orphan
 commits
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
Message-ID: <1897dff1-bb4d-9715-dd1c-86763c052589@gmail.com>
Date:   Sun, 23 Apr 2023 00:19:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working in a detached worktree, the user can create some commits
which won't be automatically connected to any ref.

Eventually, that worktree can be removed and, if the user has not
created any ref connected to the HEAD in that worktree (e.g. branch,
tag), those commits will become unreachable.

Let's issue a warning to remind the user for safety, when deleting a
worktree whose HEAD is not connected to an existing ref.

Let's also add an option to modify the message we show in
orphaned_commit_warning(): "Previous HEAD position was..."; allowing to
omit the word "Previous" as it may cause confusion, erroneously
suggesting that there is a "Current HEAD" while the worktree has been
removed.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/checkout.c       |  2 +-
 builtin/worktree.c       |  8 ++++++++
 checkout.c               |  7 +++++--
 checkout.h               |  3 ++-
 t/t2403-worktree-move.sh | 10 ++++++++++
 5 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 991413ef1a..85ac4bca00 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1051,7 +1051,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	}
 
 	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
-		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
+		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit, 1);
 
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index a61bc32189..df269bccc8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1138,6 +1138,14 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 
 		ret |= delete_git_work_tree(wt);
 	}
+
+	if (!wt->head_ref && !is_null_oid(&wt->head_oid)) {
+		struct commit* wt_commit = lookup_commit_reference_gently(the_repository,
+									  &wt->head_oid, 1);
+		if (wt_commit)
+			orphaned_commit_warning(wt_commit, NULL, 0);
+	}
+
 	/*
 	 * continue on even if ret is non-zero, there's no going back
 	 * from here.
diff --git a/checkout.c b/checkout.c
index 18e7362043..5f7b0b3c49 100644
--- a/checkout.c
+++ b/checkout.c
@@ -171,7 +171,8 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
  * HEAD.  If it is not reachable from any ref, this is the last chance
  * for the user to do so without resorting to reflog.
  */
-void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit)
+void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit,
+			     int show_previous_position)
 {
 	struct rev_info revs;
 	struct object *object = &old_commit->object;
@@ -192,8 +193,10 @@ void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commi
 		die(_("internal error in revision walk"));
 	if (!(old_commit->object.flags & UNINTERESTING))
 		suggest_reattach(old_commit, &revs);
-	else
+	else if (show_previous_position)
 		describe_detached_head(_("Previous HEAD position was"), old_commit);
+	else
+		describe_detached_head(_("HEAD position was"), old_commit);
 
 	/* Clean up objects used, as they will be reused. */
 	repo_clear_commit_marks(the_repository, ALL_REV_FLAGS);
diff --git a/checkout.h b/checkout.h
index c7dc056544..ee400376d5 100644
--- a/checkout.h
+++ b/checkout.h
@@ -18,7 +18,8 @@ const char *unique_tracking_name(const char *name,
  * HEAD.  If it is not reachable from any ref, this is the last chance
  * for the user to do so without resorting to reflog.
  */
-void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit);
+void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit,
+			     int show_previous_position);
 
 void describe_detached_head(const char *msg, struct commit *commit);
 #endif /* CHECKOUT_H */
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 230a55e99a..f2756f7137 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -247,4 +247,14 @@ test_expect_success 'not remove a repo with initialized submodule' '
 	)
 '
 
+test_expect_success 'warn when removing a worktree with orphan commits' '
+	git worktree add --detach foo &&
+	git -C foo commit -m one --allow-empty &&
+	git -C foo commit -m two --allow-empty &&
+	git worktree remove foo 2>err &&
+	test_i18ngrep "you are leaving 2 commits behind" err &&
+	test_i18ngrep ! "Previous HEAD position was" err
+	test_i18ngrep "HEAD position was" err
+'
+
 test_done
-- 
2.39.2
