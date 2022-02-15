Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32B3C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 17:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbiBORY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 12:24:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242506AbiBORYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 12:24:22 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB47DB858
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:24:07 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b9-20020a17090aa58900b001b8b14b4aabso2181475pjq.9
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dhNROOWvhpq6Se+XakL43bU4Q/fyYkU921uUB/pgwFk=;
        b=hUY9rw4UxRWNvIIkW0/qlE+JMvZ3ikVPoabNTkoxVwXgtZJQkeD7xna9usNCFGP+UY
         Sao+YtnNhr/CJdubwsOtY5bO7zeb0ZnU4bUTxXoSieTVfG1ohrycC+mdXtaapuXKLOvB
         Sc/eSRJenQxmccntWyzjpQOY+1GenOfihJZCBv79t1Oe2yaWjeE/qDr28oU+YR5aR/kq
         23kSM0skCty8Eblsh/8cblI6opAc3PB5MtFE7Wp+V2iFAkWnGx4xnA5e2r7xwy/+drrk
         TrCVuth354kO7Bvrtc2Cv6u8nqwx/MldCCHhlTmDT9ipNPqjtHw5z6/aOak2CqR5od24
         z8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dhNROOWvhpq6Se+XakL43bU4Q/fyYkU921uUB/pgwFk=;
        b=uoJT5na2LlBZiK5oo+0qTVYMz5Nac4Z0OdhrA/IJmCdC0M5GnM3tskTVYuc6aUtwTN
         031BbyLs4x0IblMQRwrHIExZljhxZXrco6gHlzU7ohHdS8bgUxA/UnYjsPUXplhoSR+i
         e4JVhnd7YkCYtoCkSuZKcZ+LREhHrp+tqWgRRzqcmHiiqOBdIVputL7Hd2d+Xi9+Xea3
         NFZ4YkvxeVGVR18Y00EOgOdQ/YJ33HDGxM9djLY1m7/5sBnQ8QjvCAR2qMbw28upXNmc
         l1ZysAWF7lh/H+g+z3/T+wReWBng3lEzTTBOh3k2JjnYk0nMNRgkOJRvp4GzvT1dee0J
         QD5w==
X-Gm-Message-State: AOAM531nFj1kJAjZV6Dmua4x1o5x2QfK4HNrZv/68AEXhsAIkf2jd9ha
        ekxMhG0gRQlOCis0QWHnFpX0Ds3W001VdtLaz11qCHptI+eb/fB6mxy3HOflI36aUHBknllcTOK
        cbw7E1NXJRA/kYy3FM/Ov7/47Am+BY5HJYBxdQRsgI4brwF9yw8e0yOaUKvgGW1g=
X-Google-Smtp-Source: ABdhPJwbIsfqYwjF/qEs2JOPF2qPlg6952XqZMho1Z/jBP433mlU3pDvAn1z6sE07KuchWiTLuVcNQFZ7Er3eg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:95a5:: with SMTP id
 a5mr793734pfk.12.1644945846478; Tue, 15 Feb 2022 09:24:06 -0800 (PST)
Date:   Wed, 16 Feb 2022 01:23:18 +0800
In-Reply-To: <20220215172318.73533-1-chooglen@google.com>
Message-Id: <20220215172318.73533-10-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220215172318.73533-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 9/9] submodule: fix latent check_has_commit() bug
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When check_has_commit() is called on a missing submodule, initialization
of the struct repository fails, but it attempts to clear the struct
anyway (which is a fatal error). This bug is masked by its only caller,
submodule_has_commits(), first calling add_submodule_odb() - the latter
fails if the submodule does not exist, making submodule_has_commits()
exit early and not invoke check_has_commit().

Fix this bug, and because calling add_submodule_odb() is no longer
necessary as of 13a2f620b2 (submodule: pass repo to
check_has_commit(), 2021-10-08), remove that call too.

This is the last caller of add_submodule_odb(), so remove that
function. (Submodule ODBs are still added as alternates via
add_submodule_odb_by_path().)

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 35 ++---------------------------------
 submodule.h |  9 ++++-----
 2 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/submodule.c b/submodule.c
index e62619bee0..2b17440777 100644
--- a/submodule.c
+++ b/submodule.c
@@ -168,26 +168,6 @@ void stage_updated_gitmodules(struct index_state *istate)
 
 static struct string_list added_submodule_odb_paths = STRING_LIST_INIT_NODUP;
 
-/* TODO: remove this function, use repo_submodule_init instead. */
-int add_submodule_odb(const char *path)
-{
-	struct strbuf objects_directory = STRBUF_INIT;
-	int ret = 0;
-
-	ret = strbuf_git_path_submodule(&objects_directory, path, "objects/");
-	if (ret)
-		goto done;
-	if (!is_directory(objects_directory.buf)) {
-		ret = -1;
-		goto done;
-	}
-	string_list_insert(&added_submodule_odb_paths,
-			   strbuf_detach(&objects_directory, NULL));
-done:
-	strbuf_release(&objects_directory);
-	return ret;
-}
-
 void add_submodule_odb_by_path(const char *path)
 {
 	string_list_insert(&added_submodule_odb_paths, xstrdup(path));
@@ -966,7 +946,8 @@ static int check_has_commit(const struct object_id *oid, void *data)
 
 	if (repo_submodule_init(&subrepo, cb->repo, cb->path, cb->super_oid)) {
 		cb->result = 0;
-		goto cleanup;
+		/* subrepo failed to init, so don't clean it up. */
+		return 0;
 	}
 
 	type = oid_object_info(&subrepo, oid, NULL);
@@ -997,18 +978,6 @@ static int submodule_has_commits(struct repository *r,
 {
 	struct has_commit_data has_commit = { r, 1, path, super_oid };
 
-	/*
-	 * Perform a cheap, but incorrect check for the existence of 'commits'.
-	 * This is done by adding the submodule's object store to the in-core
-	 * object store, and then querying for each commit's existence.  If we
-	 * do not have the commit object anywhere, there is no chance we have
-	 * it in the object store of the correct submodule and have it
-	 * reachable from a ref, so we can fail early without spawning rev-list
-	 * which is expensive.
-	 */
-	if (add_submodule_odb(path))
-		return 0;
-
 	oid_array_for_each_unique(commits, check_has_commit, &has_commit);
 
 	if (has_commit.result) {
diff --git a/submodule.h b/submodule.h
index 61bebde319..40c1445237 100644
--- a/submodule.h
+++ b/submodule.h
@@ -103,12 +103,11 @@ int submodule_uses_gitfile(const char *path);
 int bad_to_remove_submodule(const char *path, unsigned flags);
 
 /*
- * Call add_submodule_odb() to add the submodule at the given path to a list.
- * When register_all_submodule_odb_as_alternates() is called, the object stores
- * of all submodules in that list will be added as alternates in
- * the_repository.
+ * Call add_submodule_odb_by_path() to add the submodule at the given
+ * path to a list. When register_all_submodule_odb_as_alternates() is
+ * called, the object stores of all submodules in that list will be
+ * added as alternates in the_repository.
  */
-int add_submodule_odb(const char *path);
 void add_submodule_odb_by_path(const char *path);
 int register_all_submodule_odb_as_alternates(void);
 
-- 
2.33.GIT

