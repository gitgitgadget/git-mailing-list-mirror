Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F1D820A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeLOAAM (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:00:12 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51637 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeLOAAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:00:11 -0500
Received: by mail-pf1-f202.google.com with SMTP id q64so5669724pfa.18
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QzPAjsWnTRfjGUXUWkmAjtVmCqnKCLZ1xUoMHOdTYSc=;
        b=SPSmrNiLhnbwXRUUGrOfAderxAftSc5X8XRO2Bi3HsH3gqKOxtGEWZe9stJ0+MZQcX
         foUYFkV0xA4b/W2ftFJ+JRExtcEGN14qoO0qyoeKvWxxIZDxIInRUhMnZFBcfXvUnwg/
         +vKbI6l5ApFVlKWSZKbG1uRVEfI9TA4m8ofLadjT0PyMoUxcVLRu77fO82ruyYE0KN84
         GlapnFrgCtDNKoBmNgNvxA1h9D1ZqFregTSDuGkvNqYrfvPa+ovnrdpus+gfK/dnBtsO
         gcqLQwwg4SphuA4jfTBH6VLUd8hugtD80IUGHKtvJDKNQqij0CLsO9Da9Npl9pNnLxw8
         ayWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QzPAjsWnTRfjGUXUWkmAjtVmCqnKCLZ1xUoMHOdTYSc=;
        b=SR37ZNxQSchRdW+CLejcTX1rYInGSLn/izrBlDmv4Ga5vPBjpp1NiXlA+V3jEo89kf
         TVmaf1JVrT0zItmh7bj6EM09CxLuhlZWc59Pj3yncpuGxaPzjVn7lR3yas6E6/jydBVZ
         DFRZUlGuNr2o06CscLS4T7IxKbMYQTioPnHPSc8ZDV8qQSEYS4Q1dz+W8K9OH5W3qU59
         Uc/EhIKrzFnNYx4cZ7JMDadmFbK04WDPnpmeL4fkdN6oo57MsBUimzw6clldYZYLgYsY
         av/NyFP2CA4AAn5VKiKAj5FB6NoFmUsC95UMhLObrRbNdLgG60gBwDIpvjGMZaubEDvr
         18WQ==
X-Gm-Message-State: AA+aEWbEst3QFVtk8dsJxHNcB0fCipWWLoQM4w+1lDDpM9GV8f8jt2QV
        5Ie9Bus6Tx+bsuWIZLGabh3qCaL33YVY
X-Google-Smtp-Source: AFSGD/U/O8fu9JpGCYLCtygUbV7PhhIkSIOqa34isXacIHOAl1YhF04fmSqER19f3TSg8R0Qf96p3e7/xiAV
X-Received: by 2002:a62:5986:: with SMTP id k6mr2735453pfj.145.1544832010692;
 Fri, 14 Dec 2018 16:00:10 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:59:43 -0800
In-Reply-To: <20181214235945.41191-1-sbeller@google.com>
Message-Id: <20181214235945.41191-3-sbeller@google.com>
Mime-Version: 1.0
References: <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com> <20181214235945.41191-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 2/4] submodule: unset core.worktree if no working tree is present
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodules work tree is removed, we should unset its core.worktree
setting as the worktree is no longer present. This is not just in line
with the conceptual view of submodules, but it fixes an inconvenience
for looking at submodules that are not checked out:

    git clone --recurse-submodules git://github.com/git/git && cd git &&
    git checkout --recurse-submodules v2.13.0
    git -C .git/modules/sha1collisiondetection log
    fatal: cannot chdir to '../../../sha1collisiondetection': \
        No such file or directory

With this patch applied, the final call to git log works instead of dying
in its setup, as the checkout will unset the core.worktree setting such
that following log will be run in a bare repository.

This patch covers all commands that are in the unpack machinery, i.e.
checkout, read-tree, reset. A follow up patch will address
"git submodule deinit", which will also make use of the new function
submodule_unset_core_worktree(), which is why we expose it in this patch.

This patch was authored as 4fa4f90ccd (submodule: unset core.worktree if
no working tree is present, 2018-06-12), which was reverted as part of
f178c13fda (Revert "Merge branch 'sb/submodule-core-worktree'",
2018-09-07). The revert was needed as the nearby commit e98317508c
(submodule: ensure core.worktree is set after update, 2018-06-18) is
faulty and at the time of 7e25437d35 (Merge branch
'sb/submodule-core-worktree', 2018-07-18) we could not revert the faulty
commit only, as they were depending on each other: If core.worktree is
unset, we have to have ways to ensure that it is set again once
the working tree reappears again.

Now that 4d6d6ef1fc (Merge branch 'sb/submodule-update-in-c', 2018-09-17),
specifically 74d4731da1 (submodule--helper: replace
connect-gitdir-workingtree by ensure-core-worktree, 2018-08-13) is
present, we already check and ensure core.worktree is set when
populating a new work tree, such that we can re-introduce the commits
that unset core.worktree when removing the worktree.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               | 14 ++++++++++++++
 submodule.h               |  2 ++
 t/lib-submodule-update.sh |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 6415cc5580..d393e947e6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1561,6 +1561,18 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	return ret;
 }
 
+void submodule_unset_core_worktree(const struct submodule *sub)
+{
+	char *config_path = xstrfmt("%s/modules/%s/config",
+				    get_git_common_dir(), sub->name);
+
+	if (git_config_set_in_file_gently(config_path, "core.worktree", NULL))
+		warning(_("Could not unset core.worktree setting in submodule '%s'"),
+			  sub->path);
+
+	free(config_path);
+}
+
 static const char *get_super_prefix_or_empty(void)
 {
 	const char *s = get_super_prefix();
@@ -1726,6 +1738,8 @@ int submodule_move_head(const char *path,
 
 			if (is_empty_dir(path))
 				rmdir_or_warn(path);
+
+			submodule_unset_core_worktree(sub);
 		}
 	}
 out:
diff --git a/submodule.h b/submodule.h
index a680214c01..9e18e9b807 100644
--- a/submodule.h
+++ b/submodule.h
@@ -131,6 +131,8 @@ int submodule_move_head(const char *path,
 			const char *new_head,
 			unsigned flags);
 
+void submodule_unset_core_worktree(const struct submodule *sub);
+
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific environment variables, but
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 016391723c..51d4555549 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -709,7 +709,8 @@ test_submodule_recursing_with_args_common() {
 			git branch -t remove_sub1 origin/remove_sub1 &&
 			$command remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
-			! test -e sub1
+			! test -e sub1 &&
+			test_must_fail git config -f .git/modules/sub1/config core.worktree
 		)
 	'
 	# ... absorbing a .git directory along the way.
-- 
2.20.0.405.gbc1bbc6f85-goog

