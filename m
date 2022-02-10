Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5C6C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiBJEmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:42:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiBJEmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:42:14 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA7D1E3
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:42:13 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id t14-20020a1709027fce00b0014d5ddc9dfbso663783plb.22
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X2My/v548O0WSWonCNPHRXOJOwdhMaIOacjPpvhpI+k=;
        b=Rw8mJgofMHUqMGyFoXLjvRiil6OTTIxKgtdEUK6Oam/fuckkW8zuwrvUxHkhumpHmb
         h6qeninzZo0An8N8frgJ/EK4vTVLQ2UsGWGnyOOPERtAsXw+Zb/B+cNsYHRw7SQqCQlt
         vc0hs21XI64rMx+gcvdQkE/FTfkKm6PFdi4v5Hhd9EUD/Q+lFGQRGlJBnkwPUW1OHvda
         kW69EPSb/C6/BAdX9+5xjwpk81FG7mhqTPWGIFx6/N5z+tPvwaM07GwQ/+ioqCzeoQjK
         n258KlfcJ/NfL44QaT5iWje6iOtuKIn6C/gxBEincUT5unpU7vXoQ/zqVJQrL98IxckK
         QqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X2My/v548O0WSWonCNPHRXOJOwdhMaIOacjPpvhpI+k=;
        b=aNnpIwztFrb5An4iGSSqTX9yaWB9mW/YBN3BN+6eAN2kU+iVpAcGTPKF2adEUDn1b6
         oj7CGQp0T5Armkwj4+I5NYX8TFvXTPbfC3bwc4h9Oo8ctivhogSzU3uTl8nGtrJpCbIo
         kCvbUqGcQB2YFdE1vThTnUAef6Qduhr4qShtiEa2kpNQMxEzIBpd33AMa+ZKoj+ryXba
         ckcPnpxN99kUEPFh70lihiUZW8LBTAqmIhbUAm5j4V7SHb9lEPfeFoWPwlNa/8sGhcZF
         T5aC5Ecv6p/C2t5AUgQ7lXQf7kI6pOcZb6Vq4fWTCq7HErK6Kasj/ZjqRxBHU7PIh4qj
         COFw==
X-Gm-Message-State: AOAM5305KOoSyFtLe42pypjWilTh0/WFksF+5uVaRPlzePkG7dfKE12X
        CgMYV9Vn5Ew01R9wHKjnWm05V+T4VLzbgZKkuYKI7QYHsAbb6sDjYCxFz4YF9o5g2ntkraaWY5r
        3r7Dn585PnKddKv48VhP5h8bPgNHzpPULgM/HMLVGEtZSJHEr3tOketGztfR5qDs=
X-Google-Smtp-Source: ABdhPJzxFQiQSzVOP33I+HzCRz7bzSyxbLDdQeIhFtL8FTQlYuyAzjtOzrXHIGhgmOSy+46BX/D8clVm32L+qQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:a8e:: with SMTP id
 b14mr5799567pfl.32.1644468132414; Wed, 09 Feb 2022 20:42:12 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:41:52 +0800
In-Reply-To: <20220210044152.78352-1-chooglen@google.com>
Message-Id: <20220210044152.78352-9-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 8/8] submodule: fix bug and remove add_submodule_odb()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

add_submodule_odb() is a hack - it adds a submodule's odb as an
alternate, allowing the submodule's objects to be read via
the_repository. Its last caller is submodule_has_commits(), which calls
add_submodule_odb() to prepare for check_has_commit(). This used to be
necessary because check_has_commit() used the_repository's odb, but this
is longer true as of 13a2f620b2 (submodule: pass repo to
check_has_commit(), 2021-10-08).

Removing add_submodule_odb() reveals a bug in check_has_commit(), where
check_has_commit() will segfault if the submodule is missing (e.g. the
user has not init-ed the submodule). This happens because the
submodule's struct repository cannot be initialized, but
check_has_commit() tries to cleanup the uninitialized struct anyway.
This was masked by add_submodule_odb(), because add_submodule_odb()
fails when the submodule is missing, causing the caller to return early
and avoid calling check_has_commit().

Fix the bug and remove the call to add_submodule_odb(). Since
add_submodule_odb() has no more callers, remove it too.

Note that submodule odbs can still by added as alternates via
add_submodule_odb_by_path().

Signed-off-by: Glen Choo <chooglen@google.com>
---
This bug only exists because we can't call repo_clear() twice on the
same struct repository. So instead of just fixing this site, an
alternative (and maybe better) fix would be to fix repo_clear(). If
others think that's a good idea, I'll do that instead.

 submodule.c | 35 ++---------------------------------
 submodule.h |  9 ++++-----
 2 files changed, 6 insertions(+), 38 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0c02bbc9c3..fdfddd3aac 100644
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
@@ -972,7 +952,8 @@ static int check_has_commit(const struct object_id *oid, void *data)
 
 	if (repo_submodule_init(&subrepo, cb->repo, cb->path, cb->super_oid)) {
 		cb->result = 0;
-		goto cleanup;
+		/* subrepo failed to init, so don't clean it up. */
+		return 0;
 	}
 
 	type = oid_object_info(&subrepo, oid, NULL);
@@ -1003,18 +984,6 @@ static int submodule_has_commits(struct repository *r,
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
index 784ceffc0e..ca1f12b78b 100644
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

