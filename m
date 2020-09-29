Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED374C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8862A20936
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="LGt/od/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgI2QNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgI2QNX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 12:13:23 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A1FC0613D0
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X/PpFnekMM2G/iQaKzM/ZzGJW2ef6MR3EI/dO62FPnU=; b=LGt/od/UTL6wPhrS9ub/vPA0iU
        OOa/Ck46/NAILKpd3TB85LLkrWtrnN0YPr/q9vTRwoMk7bFh5x+cAKG1felToMm2Ued0ZF0c70tLe
        JcJ+ueCtszO5P5Fe5fdq4+NFDhfrOyM8hW6v/6xRAORJ5GdHh19NwzEW6a6gyInP3q3w=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <andrew@adoakley.name>)
        id 1kNHx9-0004AY-37; Tue, 29 Sep 2020 15:54:07 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH 6/7] submodule: remove add_submodule_odb
Date:   Tue, 29 Sep 2020 16:53:49 +0100
Message-Id: <20200929155350.49066-7-andrew@adoakley.name>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929155350.49066-1-andrew@adoakley.name>
References: <20200929155350.49066-1-andrew@adoakley.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The remaining callers to get_submodule_ref_store do not require access
to the objects, and do not call add_submodule_odb.  This function can
therefore be removed and the refstore marked as not having access to the
objects.

The submodule ref-store tests have been updated to reflect the fact that
the objects are no longer available in the ref-store.

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
---
 refs.c                         |  5 +----
 refs.h                         | 37 +++-------------------------------
 submodule.c                    | 19 -----------------
 submodule.h                    |  2 --
 t/helper/test-ref-store.c      |  1 -
 t/t1406-submodule-ref-store.sh | 17 ++--------------
 6 files changed, 6 insertions(+), 75 deletions(-)

diff --git a/refs.c b/refs.c
index ceff6d2af5..0a1960b4fe 100644
--- a/refs.c
+++ b/refs.c
@@ -1832,10 +1832,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	if (submodule_to_gitdir(&submodule_sb, submodule))
 		goto done;
 
-	/* assume that add_submodule_odb() has been called */
-	refs = ref_store_init(the_repository,
-			      submodule_sb.buf,
-			      REF_STORE_READ | REF_STORE_ODB);
+	refs = ref_store_init(NULL, submodule_sb.buf, REF_STORE_READ);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
 
diff --git a/refs.h b/refs.h
index 6695518156..a1b381437b 100644
--- a/refs.h
+++ b/refs.h
@@ -831,40 +831,6 @@ int ref_storage_backend_exists(const char *name);
 
 struct ref_store *get_main_ref_store(struct repository *r);
 
-/**
- * Submodules
- * ----------
- *
- * If you want to iterate the refs of a submodule you first need to add the
- * submodules object database. You can do this by a code-snippet like
- * this:
- *
- * 	const char *path = "path/to/submodule"
- * 	if (add_submodule_odb(path))
- * 		die("Error submodule '%s' not populated.", path);
- *
- * `add_submodule_odb()` will return zero on success. If you
- * do not do this you will get an error for each ref that it does not point
- * to a valid object.
- *
- * Note: As a side-effect of this you cannot safely assume that all
- * objects you lookup are available in superproject. All submodule objects
- * will be available the same way as the superprojects objects.
- *
- * Example:
- * --------
- *
- * ----
- * static int handle_remote_ref(const char *refname,
- * 		const unsigned char *sha1, int flags, void *cb_data)
- * {
- * 	struct strbuf *output = cb_data;
- * 	strbuf_addf(output, "%s\n", refname);
- * 	return 0;
- * }
- *
- */
-
 /*
  * Return the ref_store instance for the specified submodule. For the
  * main repository, use submodule==NULL; such a call cannot fail. For
@@ -874,6 +840,9 @@ struct ref_store *get_main_ref_store(struct repository *r);
  *
  * For backwards compatibility, submodule=="" is treated the same as
  * submodule==NULL.
+ *
+ * The ref_store for a submodule will be read only and have no access to the
+ * object database.  Only raw access to the refs is possible.
  */
 struct ref_store *get_submodule_ref_store(const char *submodule);
 struct ref_store *get_worktree_ref_store(const struct worktree *wt);
diff --git a/submodule.c b/submodule.c
index 1671800340..cf7db6815e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -165,25 +165,6 @@ void stage_updated_gitmodules(struct index_state *istate)
 		die(_("staging updated .gitmodules failed"));
 }
 
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
-	add_to_alternates_memory(objects_directory.buf);
-done:
-	strbuf_release(&objects_directory);
-	return ret;
-}
-
 void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 					     const char *path)
 {
diff --git a/submodule.h b/submodule.h
index 6a66d3e05f..0260c75e06 100644
--- a/submodule.h
+++ b/submodule.h
@@ -97,8 +97,6 @@ int submodule_uses_gitfile(const char *path);
 #define SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED (1<<2)
 int bad_to_remove_submodule(const char *path, unsigned flags);
 
-int add_submodule_odb(const char *path);
-
 /*
  * Initialize a repository struct for a submodule based on the provided 'path'.
  *
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 759e69dc54..1ec9f1b764 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -32,7 +32,6 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 		ret = strbuf_git_path_submodule(&sb, gitdir, "objects/");
 		if (ret)
 			die("strbuf_git_path_submodule failed: %d", ret);
-		add_to_alternates_memory(sb.buf);
 		strbuf_release(&sb);
 
 		*refs = get_submodule_ref_store(gitdir);
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 36b7ef5046..f4fbf26149 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -20,10 +20,8 @@ test_expect_success 'pack_refs() not allowed' '
 '
 
 test_expect_success 'peel_ref(new-tag)' '
-	git -C sub rev-parse HEAD >expected &&
 	git -C sub tag -a -m new-tag new-tag HEAD &&
-	$RUN peel-ref refs/tags/new-tag >actual &&
-	test_cmp expected actual
+	test_must_fail $RUN peel-ref refs/tags/new-tag
 '
 
 test_expect_success 'create_symref() not allowed' '
@@ -39,18 +37,7 @@ test_expect_success 'rename_refs() not allowed' '
 '
 
 test_expect_success 'for_each_ref(refs/heads/)' '
-	$RUN for-each-ref refs/heads/ | cut -d" " -f 2- >actual &&
-	cat >expected <<-\EOF &&
-	master 0x0
-	new-master 0x0
-	EOF
-	test_cmp expected actual
-'
-
-test_expect_success 'for_each_ref() is sorted' '
-	$RUN for-each-ref refs/heads/ | cut -d" " -f 2- >actual &&
-	sort actual > expected &&
-	test_cmp expected actual
+	test_must_fail $RUN for-each-ref refs/heads/
 '
 
 test_expect_success 'resolve_ref(master)' '
-- 
2.26.2

