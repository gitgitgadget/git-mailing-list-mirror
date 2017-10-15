Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B40B220372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbdJOWHv (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:07:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55054 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751512AbdJOWHp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5F48F60450;
        Sun, 15 Oct 2017 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105264;
        bh=jaSP0MKhX0yXZJ/G2Uh2FBM5E8RO64QpIdQjRzRNKNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=T7pj4/7ED4nbGFu39zUiO28YRRyZG7mTV4wWHiYTMag3b8+doenL6EbYO6RIhQrOC
         qv8mu7Ggvc0BKsuL0bSikKQtjCDdWHNQIqSlaED4tsIX8GaubCZ4zPY1LhkWJN1Tv6
         VzxqqkQjWAhfov9Hs6rN29BY0lrpHAKXaaHDF0rPjmAQoCw4weFcnnNHVcHg2fWmPj
         awNpbaGfYwddyEa3Vtkb2hcp9EycwU6wPbjtipk6Pf6iWSCCQP0ScyiMP57tePmCqS
         26IlztD4tP12u7nvIht0/+mQYNFG+P8MPTJkdzaJXfT3xA6KAXZDPXr56ma/XKc7iD
         aqdup+7O/JzUkxmiwuguwqqxyMHY+z/0lHvCo8tfptSrqjCx0UNmvK8rE5FlRJHijK
         a/aamnOcPyN+G8KQTgedQvmbW+NoV6M9EBzzSMKIC8EwuTwlK2U3nFIEYBgwNEkHTR
         wWMTzjd+SYXT1C+AP9uCOiQ57iNwaOf8GOehWRImrVESR1MBZGZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 08/25] refs: convert resolve_refdup and refs_resolve_refdup to struct object_id
Date:   Sun, 15 Oct 2017 22:06:55 +0000
Message-Id: <20171015220712.97308-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the callers already pass the hash member of struct object_id, so
update them to pass a pointer to the struct directly,

This transformation was done with an update to declaration and
definition and the following semantic patch:

@@
expression E1, E2, E3, E4;
@@
- resolve_refdup(E1, E2, E3.hash, E4)
+ resolve_refdup(E1, E2, &E3, E4)

@@
expression E1, E2, E3, E4;
@@
- resolve_refdup(E1, E2, E3->hash, E4)
+ resolve_refdup(E1, E2, E3, E4)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c                | 2 +-
 builtin/branch.c            | 6 +++---
 builtin/checkout.c          | 2 +-
 builtin/clone.c             | 2 +-
 builtin/fmt-merge-msg.c     | 2 +-
 builtin/merge.c             | 2 +-
 builtin/notes.c             | 2 +-
 builtin/show-branch.c       | 6 +++---
 builtin/submodule--helper.c | 2 +-
 refs.c                      | 8 ++++----
 refs.h                      | 4 ++--
 submodule.c                 | 2 +-
 12 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 32120f42df..c9bb14a6c2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2135,7 +2135,7 @@ static void am_abort(struct am_state *state)
 
 	am_rerere_clear();
 
-	curr_branch = resolve_refdup("HEAD", 0, curr_head.hash, NULL);
+	curr_branch = resolve_refdup("HEAD", 0, &curr_head, NULL);
 	has_curr_head = curr_branch && !is_null_oid(&curr_head);
 	if (!has_curr_head)
 		hashcpy(curr_head.hash, EMPTY_TREE_SHA1_BIN);
diff --git a/builtin/branch.c b/builtin/branch.c
index f5237541a2..c5f88b59ef 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -125,7 +125,7 @@ static int branch_merged(int kind, const char *name,
 		if (upstream &&
 		    (reference_name = reference_name_to_free =
 		     resolve_refdup(upstream, RESOLVE_REF_READING,
-				    oid.hash, NULL)) != NULL)
+				    &oid, NULL)) != NULL)
 			reference_rev = lookup_commit_reference(&oid);
 	}
 	if (!reference_rev)
@@ -241,7 +241,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					RESOLVE_REF_READING
 					| RESOLVE_REF_NO_RECURSE
 					| RESOLVE_REF_ALLOW_BAD_NAME,
-					oid.hash, &flags);
+					&oid, &flags);
 		if (!target) {
 			error(remote_branch
 			      ? _("remote-tracking branch '%s' not found.")
@@ -636,7 +636,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	track = git_branch_track;
 
-	head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
+	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
 	if (!strcmp(head, "HEAD"))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2bb009ec0e..c33dbb70fb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -827,7 +827,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	struct object_id rev;
 	int flag, writeout_error = 0;
 	memset(&old, 0, sizeof(old));
-	old.path = path_to_free = resolve_refdup("HEAD", 0, rev.hash, &flag);
+	old.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old.path)
 		old.commit = lookup_commit_reference_gently(&rev, 1);
 	if (!(flag & REF_ISSYMREF))
diff --git a/builtin/clone.c b/builtin/clone.c
index 5cd1b02d53..695bdd7046 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -715,7 +715,7 @@ static int checkout(int submodule_progress)
 	if (option_no_checkout)
 		return 0;
 
-	head = resolve_refdup("HEAD", RESOLVE_REF_READING, oid.hash, NULL);
+	head = resolve_refdup("HEAD", RESOLVE_REF_READING, &oid, NULL);
 	if (!head) {
 		warning(_("remote HEAD refers to nonexistent ref, "
 			  "unable to checkout.\n"));
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e99b5ddbf9..b69f7d3be2 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -603,7 +603,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 
 	/* get current branch */
 	current_branch = current_branch_to_free =
-		resolve_refdup("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL);
+		resolve_refdup("HEAD", RESOLVE_REF_READING, &head_oid, NULL);
 	if (!current_branch)
 		die("No current branch");
 	if (starts_with(current_branch, "refs/heads/"))
diff --git a/builtin/merge.c b/builtin/merge.c
index 99d4b873f0..99d2df965f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1142,7 +1142,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch = branch_to_free = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
+	branch = branch_to_free = resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (branch)
 		skip_prefix(branch, "refs/heads/", &branch);
 	if (!branch || is_null_oid(&head_oid))
diff --git a/builtin/notes.c b/builtin/notes.c
index 8276af419b..12afdf1907 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -724,7 +724,7 @@ static int merge_commit(struct notes_merge_options *o)
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
 
 	o->local_ref = local_ref_to_free =
-		resolve_refdup("NOTES_MERGE_REF", 0, oid.hash, NULL);
+		resolve_refdup("NOTES_MERGE_REF", 0, &oid, NULL);
 	if (!o->local_ref)
 		die(_("failed to resolve NOTES_MERGE_REF"));
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 84547d6fba..0237be4975 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -705,8 +705,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			static const char *fake_av[2];
 
 			fake_av[0] = resolve_refdup("HEAD",
-						    RESOLVE_REF_READING,
-						    oid.hash, NULL);
+						    RESOLVE_REF_READING, &oid,
+						    NULL);
 			fake_av[1] = NULL;
 			av = fake_av;
 			ac = 1;
@@ -775,7 +775,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	}
 
 	head = resolve_refdup("HEAD", RESOLVE_REF_READING,
-			      head_oid.hash, NULL);
+			      &head_oid, NULL);
 
 	if (with_current_branch && head) {
 		int has_head = 0;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 06ed02f994..5946a7ca93 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1144,7 +1144,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	argv++;
 	argc--;
 	/* Get the submodule's head ref and determine if it is detached */
-	head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
+	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
 	if (!strcmp(head, "HEAD"))
diff --git a/refs.c b/refs.c
index db4988ab3c..3bca4c273b 100644
--- a/refs.c
+++ b/refs.c
@@ -194,21 +194,21 @@ int ref_resolves_to_object(const char *refname,
 
 char *refs_resolve_refdup(struct ref_store *refs,
 			  const char *refname, int resolve_flags,
-			  unsigned char *sha1, int *flags)
+			  struct object_id *oid, int *flags)
 {
 	const char *result;
 
 	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-					 sha1, flags);
+					 oid->hash, flags);
 	return xstrdup_or_null(result);
 }
 
 char *resolve_refdup(const char *refname, int resolve_flags,
-		     unsigned char *sha1, int *flags)
+		     struct object_id *oid, int *flags)
 {
 	return refs_resolve_refdup(get_main_ref_store(),
 				   refname, resolve_flags,
-				   sha1, flags);
+				   oid, flags);
 }
 
 /* The argument to filter_refs */
diff --git a/refs.h b/refs.h
index 1fee56d132..8dd39eab72 100644
--- a/refs.h
+++ b/refs.h
@@ -69,9 +69,9 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 
 char *refs_resolve_refdup(struct ref_store *refs,
 			  const char *refname, int resolve_flags,
-			  unsigned char *sha1, int *flags);
+			  struct object_id *oid, int *flags);
 char *resolve_refdup(const char *refname, int resolve_flags,
-		     unsigned char *sha1, int *flags);
+		     struct object_id *oid, int *flags);
 
 int refs_read_ref_full(struct ref_store *refs, const char *refname,
 		       int resolve_flags, unsigned char *sha1, int *flags);
diff --git a/submodule.c b/submodule.c
index 63e7094e16..3b7be4cafe 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1016,7 +1016,7 @@ int push_unpushed_submodules(struct oid_array *commits,
 		char *head;
 		struct object_id head_oid;
 
-		head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
+		head = resolve_refdup("HEAD", 0, &head_oid, NULL);
 		if (!head)
 			die(_("Failed to resolve HEAD as a valid ref."));
 
-- 
2.15.0.rc0.271.g36b669edcc

