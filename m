Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25947C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 23:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhLTXfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbhLTXfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 18:35:17 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B64C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:35:17 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id y2-20020a17090a1f4200b001b103d6b6d0so424281pjy.1
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 15:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D07hJCwcx4LPgrd9giR6N9HIT7APn6bUkI8Pe4Y64JU=;
        b=RzHDfC2v64arM2We1DMhz6aTRV+8CsXJoPsaLkHRTHpE9hQSa5IkalYMRuUAdqH8tn
         IAI1Jmbu60eXXkQhC28OWurrxeh6qvVY55U75EAmd8WIla4V9oSKETOkZi+kPsotHuw9
         rz4wrqesTNX21c44do+2xSv+BTf7dzulwM5zeRt1m/m/OXWkZvinszXKBu8iQZmEPN8u
         MdlCFfT8M9EbIZVidtZNK9ZzMdQdYufkLR5dKKAIM1h8mSvisBghzFagKQIjZ4Z/NEg3
         +9SvYpr8TEV2im+huBvUYsu3wevnrq+5PJRCvY91ziH1yslFiqXWT3Ovd1vXV8Gl6K+I
         //nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D07hJCwcx4LPgrd9giR6N9HIT7APn6bUkI8Pe4Y64JU=;
        b=5VB996TtyHef+ARkZvuYKN+/LMO8i+PbgL31qwzAlNOODBbNkDzvc9p6Ama0B6VTXb
         qiIjkSIj2JT+SLjCwv1iGoM+gjlbyIt6JcftnayTpq8KzT7isyXQOc99DJgkoGuKNUx5
         uR8rBn53cTUdYjFFaPt4qrBSEh+1UpUYo6wyC7+o2kURKTVS05TywCSaAxKK97KRGlFh
         SPkviEYOP/NXrr89//8vcDAhXvanwbiInVxAZd9e4MomfYPZdhIjOO35aTd/+IhnZusj
         giB5zUpUp8pRnJNEsGXahpgZkW1n6UYnhBxJvv1OwCfeHPlGYICVQ7qTkoR2KZgomGxU
         grTA==
X-Gm-Message-State: AOAM5309yeD1eWNmPCahjFF83bKZPL7LN9t8m1VcFrANdYUK5wtWySun
        fmgQiw9wb3HctZP88vmoyQA4O6A+2ux69pZQssvnXnQG8BFZXtOrUWOE5hgx6mRtQASIHTgWbfA
        d1seJU7Zux1d7p7+L2lLSe7RBDosQEYTlpdBH2OsXUxO9rYRzZ3yBAz6SfuJGre0=
X-Google-Smtp-Source: ABdhPJygWj6I5BfDoynT9iGSLz163pstazojCyBM2CLMzbysG9ti904emPSXUdUShgXw0XrBPo2w7JkW/n0N5Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:30c9:: with SMTP id
 hi9mr490106pjb.216.1640043317119; Mon, 20 Dec 2021 15:35:17 -0800 (PST)
Date:   Mon, 20 Dec 2021 15:34:57 -0800
In-Reply-To: <20211220233459.45739-1-chooglen@google.com>
Message-Id: <20211220233459.45739-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211216233324.65126-1-chooglen@google.com> <20211220233459.45739-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v6 3/5] branch: add a dry_run parameter to create_branch()
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
index de680f311d..55c7ba4a25 100644
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
index 16a7e80df5..9b300cf42f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -859,7 +859,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		create_branch(the_repository,
 			      argv[0], (argc == 2) ? argv[1] : head,
-			      force, 0, reflog, quiet, track);
+			      force, 0, reflog, quiet, track, 0);
 
 	} else
 		usage_with_options(builtin_branch_usage, options);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bbbfabb871..629a288dd8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -904,7 +904,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
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

