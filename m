Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97D5C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbiCHAQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245174AbiCHAQL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:16:11 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34ED2B19E
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:15:12 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j9-20020a170903024900b0015195e68490so8181980plh.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vdbgcs2Fpier1UCS12yHjFqUWjg8CLpnX1fa82efzXc=;
        b=ZkeOOffj8FsoFYc/Vp0CoOzlGnaii5+8bdw39dQZ+SosXYv7GrzeS6M4Skf+NmIdx9
         sKXOMG9HCO5mBLYKzcGv767QD4tIN/yjB2hOlwPzNgqlZ+UkX1xgKtcqb13MpwvLysVc
         A3/HissloLlYI5Baco3oFpotOkB6MjYP+f7pA/es1QC4qhicfkBNLqEOU1oNfcMlztPq
         bIEVcNvW21QzQ1CmnR0tY3UuQYt6RK2NB5s67g8PzbZYwPBY7/PyLs0ZEOdCa2Xhc1TB
         lOj6CKO6aPQazCXf4/RH26agP0u6HFR39BFDb7bRSsehwHOuRmQGJNrWY4AzXLc9mfn4
         ORng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vdbgcs2Fpier1UCS12yHjFqUWjg8CLpnX1fa82efzXc=;
        b=Orif+DmW2w8I1HovqgBnGJBkLqTARAyVS94/3EXt1ko6iGYux1bvQMVlWwWQzsG7s8
         TFp2zzOBw9teZEOmduupQcBuOrlv7pQioX5a2F7W+dHPyHJlfNZVe1X/vj6SbFlVnNtI
         2DtwLZycz6rhzylpkSxoZCKQwNAAligmulsZjOHXUU9Ho1X/2Y80jjRlNwb/Q4VXG0sn
         iGOm2s3bsjGbC8DyH3wrjTjzX/vjpMZ6VydNJY0FKwkkpR/ENCItrT+syaRE5p2idfL0
         jnyVpMNTXpMuOBZ6uueS8HmPbIjnMJBsde4KDEaWAES3wN5bhlBWAHGzL4fdBjx3tw6O
         41eg==
X-Gm-Message-State: AOAM5305Na6gxlSbHm65m8YUmBaJEdL3uoqpige6qpoykTfCnBWmsOWI
        m+/740oOXgjmTze/anxP7KWOJels6paS+h4gf6NOBy/AaPGFjNbGboy4geSi9fI5+Dkme4VPEc6
        8o/0vSqxq05JmPLhQsCriGePbqFOlMCywIJO08w97Fi6MteGyah6BeL4NC2WnbXk=
X-Google-Smtp-Source: ABdhPJwsm2ade07kKwInfTNNsj+xvIGixd+LZHgfe0ogJHHZrxNrdHown0C6xHyAwzxieLnqouM12A82GC+c0Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:1f4d:b0:1bb:ff88:c67a with SMTP
 id y13-20020a17090a1f4d00b001bbff88c67amr1653122pjy.191.1646698512259; Mon,
 07 Mar 2022 16:15:12 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:14:33 -0800
In-Reply-To: <20220308001433.94995-1-chooglen@google.com>
Message-Id: <20220308001433.94995-11-chooglen@google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 10/10] submodule: fix latent check_has_commit() bug
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When check_has_commit() is called on a missing submodule, initialization
of the struct repository fails, but it attempts to clear the struct
anyway (which is a fatal error). This bug is masked by its only caller,
submodule_has_commits(), first calling add_submodule_odb(). The latter
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
index 1f5f39ce18..6e6b2d04e4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -167,26 +167,6 @@ void stage_updated_gitmodules(struct index_state *istate)
 
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
@@ -971,7 +951,8 @@ static int check_has_commit(const struct object_id *oid, void *data)
 
 	if (repo_submodule_init(&subrepo, cb->repo, cb->path, cb->super_oid)) {
 		cb->result = 0;
-		goto cleanup;
+		/* subrepo failed to init, so don't clean it up. */
+		return 0;
 	}
 
 	type = oid_object_info(&subrepo, oid, NULL);
@@ -1007,18 +988,6 @@ static int submodule_has_commits(struct repository *r,
 		.super_oid = super_oid
 	};
 
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

