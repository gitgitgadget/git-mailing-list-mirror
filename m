Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31CEC4332F
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhLPXdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhLPXdd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:33:33 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8B1C061748
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:33 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id u11-20020a17090a4bcb00b001a6e77f7312so458308pjl.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0u+G89ddGa3gYaAQcbMWD87gibX1Z+jCUH+8U86ltjU=;
        b=LcIqEk95IGxxuHjbdcsVyu3sV4NgRmti7rVM4GL6dcxGITSXNhWZHw2lorrhjrWnGP
         ZXXrdXirWHp600zGOGFNtiikNLFo8Gu4VUzXw/Ngs/m83NDBx5gQEwkczL40aqqw1tD3
         HBxozKp4u+/tj7+kt0JvJbHHBxS1Csamt6OUNKZ31SzoPFU068f8XNsrG0piHT9P52u/
         YNMgTgJsR/XJeQFTovAOf1P1Ee+A8FADcccSYtBihhs3DlW/NEX3c0Oz6/v8AocCeDTs
         gUPnn2E5UTtyyWK+B/H4WUKyawcLu7cDdpAlaZ0sIlJqGpzkzsICBOO1JpIw5GLHpU0P
         ZOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0u+G89ddGa3gYaAQcbMWD87gibX1Z+jCUH+8U86ltjU=;
        b=iYIjZQIZ777jk4JcIOwanKZ7yVwbG1Ja8k6gbBRXWh2/7OdSCvJUItpsvlHdy0xwSr
         s+glFp+emBaSxkP5j0flpinitGdSvrG5dVMFqM+tPPVgd6VHTECCpWaAGsZCpmyu4Nvw
         eqkYhQBGRd5UnQ3GqsAcH62WbVdTig/qJQ7ijOWfC34/Jpj12/mDVt5/t/9ry736hWvv
         rPFdPa45xGiXalN9/MefvOXZEtFiX2jzOxrWDZcueT/xRty4gGWg1bPU+MScxWuoiwLr
         U8EWcItWJr4Ktll302BdREPQzgomQnCOVq5J1D2cJAqg0Wt3LRqQh/419vU+3obVq3vt
         7kDw==
X-Gm-Message-State: AOAM532rG3MYWaSgtouNG8jLPGCEikxEDgJMaSJP19TpRxoJYqea0/Xd
        hyLARaon0CTtbE44BLL17ivBPhgQdnAcjD0mk2tkDXBlMf6bnkX+9FkWBkg1pIE7IeZW2ocZesU
        Fg//YyFSUS6mGZ0/LAND7esKngB6kCycEOC7x/CzOHH0hHXBfE1yHvFv9hWr/OQA=
X-Google-Smtp-Source: ABdhPJzoJI5GN5ydmSLm01v/RRs/9lOcTUiiGy8lEHWG0JNdu3N5UxsisU2DHpXNFDQcPlwsOK2cZ85Nn6BZ6g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:af19:: with SMTP id
 w25mr448428pge.438.1639697613063; Thu, 16 Dec 2021 15:33:33 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:33:22 -0800
In-Reply-To: <20211216233324.65126-1-chooglen@google.com>
Message-Id: <20211216233324.65126-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211216003213.99135-1-chooglen@google.com> <20211216233324.65126-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 3/5] branch: add a dry_run parameter to create_branch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a dry_run parameter to create_branch() such that dry_run = 1 will
validate a new branch without trying to create it. This will be used in
`git branch --recurse-submodules` to ensure that the new branch can be
created in all submodules.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c           | 5 ++++-
 branch.h           | 9 +++++----
 builtin/branch.c   | 2 +-
 builtin/checkout.c | 3 ++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index 6f474a5505..047d9958fc 100644
--- a/branch.c
+++ b/branch.c
@@ -420,7 +420,7 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
 
 void create_branch(struct repository *r, const char *name,
 		   const char *start_name, int force, int clobber_head_ok,
-		   int reflog, int quiet, enum branch_track track)
+		   int reflog, int quiet, enum branch_track track, int dry_run)
 {
 	struct object_id oid;
 	char *real_ref;
@@ -440,6 +440,8 @@ void create_branch(struct repository *r, const char *name,
 	}
 
 	dwim_branch_start(r, start_name, track, &real_ref, &oid);
+	if (dry_run)
+		goto cleanup;
 
 	if (reflog)
 		log_all_ref_updates = LOG_REFS_NORMAL;
@@ -462,6 +464,7 @@ void create_branch(struct repository *r, const char *name,
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
+cleanup:
 	strbuf_release(&ref);
 	free(real_ref);
 }
diff --git a/branch.h b/branch.h
index cf3a4d3ff3..8009266343 100644
--- a/branch.h
+++ b/branch.h
@@ -62,11 +62,12 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
  *   - track causes the new branch to be configured to merge the remote branch
  *     that start_name is a tracking branch for (if any).
  *
+ *   - dry_run causes the branch to be validated but not created.
+ *
  */
-void create_branch(struct repository *r,
-		   const char *name, const char *start_name,
-		   int force, int clobber_head_ok,
-		   int reflog, int quiet, enum branch_track track);
+void create_branch(struct repository *r, const char *name,
+		   const char *start_name, int force, int clobber_head_ok,
+		   int reflog, int quiet, enum branch_track track, int dry_run);
 
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
diff --git a/builtin/branch.c b/builtin/branch.c
index 4a9e0f5727..d785ebdba0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -864,7 +864,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		create_branch(the_repository,
 			      argv[0], (argc == 2) ? argv[1] : head,
-			      force, 0, reflog, quiet, track);
+			      force, 0, reflog, quiet, track, 0);
 
 	} else
 		usage_with_options(builtin_branch_usage, options);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a1ba3e2b56..da183724d3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -905,7 +905,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_log,
 				      opts->quiet,
-				      opts->track);
+				      opts->track,
+				      0);
 		free(new_branch_info->name);
 		free(new_branch_info->refname);
 		new_branch_info->name = xstrdup(opts->new_branch);
-- 
2.33.GIT

