Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26821F600
	for <e@80x24.org>; Thu, 20 Jul 2017 17:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965349AbdGTRpt (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 13:45:49 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33197 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965980AbdGTRkm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 13:40:42 -0400
Received: by mail-pf0-f173.google.com with SMTP id s70so14751856pfs.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S0S8Z3cMpw9IxPkORTK5Ly7k21njRmfy4QS4YbCZH4k=;
        b=YiJDV0n44e4bf8wHN2d+LM/EABnhatDKZMvhvvqZsa8AcmADNt2qjq8E1eqnWeifMZ
         BM1wDU6kXJ42nZ7HHvnGSIaExF04TNxn6xb4DWb0JCZPYtPLnyKMguGnwwC9SAtTrsMi
         pKSyfN7gBUE3YMfA8oO80ztct6PCLlDvWrER2XSX13h7A0yGdHwJ6/BIEslzNUyh+xll
         Mc/H6Nyeu9h0HbuifgDETXYNJvBg689rHgs4qMoeIyJpwF12f3BQMNgzbjKqIaOcP2YC
         Tqkhzbe8S2ku4aIdCnGZdXY6TQIeV6m44PO2rX5qUMEdyYHWRaTNckkDgdFt8UVSBV5j
         aUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S0S8Z3cMpw9IxPkORTK5Ly7k21njRmfy4QS4YbCZH4k=;
        b=n2OXNqd381OD9iACqnfX/7lJeCUY5K3b6wHOGDPql0nnEpKxoMWaIuVIbvFtFABqcl
         3JYWExGXq5JTN5r5MGcEetb5Ti6jyH0GmKvI2mexjD/oxDjR6kG+GUJK+nx9An5kgJqZ
         4GuNzEUCe8iHGsq3qwZz7dt5WHUhwiRaNrJqtIQx1ouffYlTScNhSmMTugTl4urOSZe5
         /TZNIxcbCctNTz3mbjLc6v2BMpLHp758w8/LkeZjXc50mUCtbLlk3/1DfrserE5jq8MS
         L9moaXOFxMK9GVaAe5iI+FNTnQGvo13FWVrg7XAxR+qFFlnChcpA3tm9La9EEU/Yck+P
         e5Xw==
X-Gm-Message-State: AIVw112lI0Wrg277xfDFvqadtixyA4t0oDFChIoG3VjkeX0MNJXJphly
        rwMog7liaiJzUG2OGfC+Lg==
X-Received: by 10.84.195.131 with SMTP id j3mr5025833pld.147.1500572441329;
        Thu, 20 Jul 2017 10:40:41 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t186sm5641692pgc.28.2017.07.20.10.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jul 2017 10:40:40 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 1/1] submodule--helper: teach push-check to handle HEAD
Date:   Thu, 20 Jul 2017 10:40:37 -0700
Message-Id: <20170720174037.45305-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.284.gd933b75aa4-goog
In-Reply-To: <20170623200427.26803-1-bmwill@google.com>
References: <20170623200427.26803-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 06bf4ad1d (push: propagate remote and refspec with
--recurse-submodules) push was taught how to propagate a refspec down to
submodules when the '--recurse-submodules' flag is given.  The only refspecs
that are allowed to be propagated are ones which name a ref which exists
in both the superproject and the submodule, with the caveat that 'HEAD'
was disallowed.

This patch teaches push-check (the submodule helper which determines if
a refspec can be propagated to a submodule) to permit propagating 'HEAD'
if and only if the superproject and the submodule both have the same
named branch checked out and the submodule is not in a detached head
state.

Signed-off-by: Brandon Williams <bmwill@google.com>
---

Changes in V2:
 * fixed a few style issues
 * shifted argv/argc to prevent more damage to the code than is necessary.

 builtin/submodule--helper.c    | 49 ++++++++++++++++++++++++++++++++++--------
 submodule.c                    | 18 +++++++++++++---
 t/t5531-deep-submodule-push.sh | 25 ++++++++++++++++++++-
 3 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6abdad329..0939e3912 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1108,9 +1108,28 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 static int push_check(int argc, const char **argv, const char *prefix)
 {
 	struct remote *remote;
+	const char *superproject_head;
+	char *head;
+	int detached_head = 0;
+	struct object_id head_oid;
 
-	if (argc < 2)
-		die("submodule--helper push-check requires at least 1 argument");
+	if (argc < 3)
+		die("submodule--helper push-check requires at least 2 arguments");
+
+	/*
+	 * superproject's resolved head ref.
+	 * if HEAD then the superproject is in a detached head state, otherwise
+	 * it will be the resolved head ref.
+	 */
+	superproject_head = argv[1];
+	argv++;
+	argc--;
+	/* Get the submodule's head ref and determine if it is detached */
+	head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
+	if (!head)
+		die(_("Failed to resolve HEAD as a valid ref."));
+	if (!strcmp(head, "HEAD"))
+		detached_head = 1;
 
 	/*
 	 * The remote must be configured.
@@ -1133,18 +1152,30 @@ static int push_check(int argc, const char **argv, const char *prefix)
 			if (rs->pattern || rs->matching)
 				continue;
 
-			/*
-			 * LHS must match a single ref
-			 * NEEDSWORK: add logic to special case 'HEAD' once
-			 * working with submodules in a detached head state
-			 * ceases to be the norm.
-			 */
-			if (count_refspec_match(rs->src, local_refs, NULL) != 1)
+			/* LHS must match a single ref */
+			switch (count_refspec_match(rs->src, local_refs, NULL)) {
+			case 1:
+				break;
+			case 0:
+				/*
+				 * If LHS matches 'HEAD' then we need to ensure
+				 * that it matches the same named branch
+				 * checked out in the superproject.
+				 */
+				if (!strcmp(rs->src, "HEAD")) {
+					if (!detached_head &&
+					    !strcmp(head, superproject_head))
+						break;
+					die("HEAD does not match the named branch in the superproject");
+				}
+			default:
 				die("src refspec '%s' must name a ref",
 				    rs->src);
+			}
 		}
 		free_refspec(refspec_nr, refspec);
 	}
+	free(head);
 
 	return 0;
 }
diff --git a/submodule.c b/submodule.c
index 6531c5d60..36f45f5a5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1015,7 +1015,8 @@ static int push_submodule(const char *path,
  * Perform a check in the submodule to see if the remote and refspec work.
  * Die if the submodule can't be pushed.
  */
-static void submodule_push_check(const char *path, const struct remote *remote,
+static void submodule_push_check(const char *path, const char *head,
+				 const struct remote *remote,
 				 const char **refspec, int refspec_nr)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1023,6 +1024,7 @@ static void submodule_push_check(const char *path, const struct remote *remote,
 
 	argv_array_push(&cp.args, "submodule--helper");
 	argv_array_push(&cp.args, "push-check");
+	argv_array_push(&cp.args, head);
 	argv_array_push(&cp.args, remote->name);
 
 	for (i = 0; i < refspec_nr; i++)
@@ -1061,10 +1063,20 @@ int push_unpushed_submodules(struct oid_array *commits,
 	 * won't be propagated due to the remote being unconfigured (e.g. a URL
 	 * instead of a remote name).
 	 */
-	if (remote->origin != REMOTE_UNCONFIGURED)
+	if (remote->origin != REMOTE_UNCONFIGURED) {
+		char *head;
+		struct object_id head_oid;
+
+		head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
+		if (!head)
+			die(_("Failed to resolve HEAD as a valid ref."));
+
 		for (i = 0; i < needs_pushing.nr; i++)
 			submodule_push_check(needs_pushing.items[i].string,
-					     remote, refspec, refspec_nr);
+					     head, remote,
+					     refspec, refspec_nr);
+		free(head);
+	}
 
 	/* Actually push the submodules */
 	for (i = 0; i < needs_pushing.nr; i++) {
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index beff65b8a..0f84a5314 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -533,7 +533,8 @@ test_expect_success 'push propagating refspec to a submodule' '
 	# Fails when refspec includes an object id
 	test_must_fail git -C work push --recurse-submodules=on-demand origin \
 		"$(git -C work rev-parse branch2):refs/heads/branch2" &&
-	# Fails when refspec includes 'HEAD' as it is unsupported at this time
+	# Fails when refspec includes HEAD and parent and submodule do not
+	# have the same named branch checked out
 	test_must_fail git -C work push --recurse-submodules=on-demand origin \
 		HEAD:refs/heads/branch2 &&
 
@@ -548,4 +549,26 @@ test_expect_success 'push propagating refspec to a submodule' '
 	test_cmp expected_pub actual_pub
 '
 
+test_expect_success 'push propagating HEAD refspec to a submodule' '
+	git -C work/gar/bage checkout branch2 &&
+	> work/gar/bage/junk12 &&
+	git -C work/gar/bage add junk12 &&
+	git -C work/gar/bage commit -m "Twelfth junk" &&
+
+	git -C work checkout branch2 &&
+	git -C work add gar/bage &&
+	git -C work commit -m "updating gar/bage in branch2" &&
+
+	# Passes since the superproject and submodules HEAD are both on branch2
+	git -C work push --recurse-submodules=on-demand origin \
+		HEAD:refs/heads/branch2 &&
+
+	git -C submodule.git rev-parse branch2 >actual_submodule &&
+	git -C pub.git rev-parse branch2 >actual_pub &&
+	git -C work/gar/bage rev-parse branch2 >expected_submodule &&
+	git -C work rev-parse branch2 >expected_pub &&
+	test_cmp expected_submodule actual_submodule &&
+	test_cmp expected_pub actual_pub
+'
+
 test_done
-- 
2.14.0.rc0.284.gd933b75aa4-goog

