Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9625520282
	for <e@80x24.org>; Fri, 23 Jun 2017 20:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754872AbdFWUEd (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:04:33 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34669 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754814AbdFWUEc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:04:32 -0400
Received: by mail-pf0-f171.google.com with SMTP id s66so27883428pfs.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vkkcw+822Hb85CcUjjqLZ/Hz7oyJXRi0OzVnXZ9mfZM=;
        b=OmKwCo7UTb+yJNCvGHEYe6lXwFmBVc8qFpOn109RG+ucPLqXNMWvccV1CZxoLz/bcO
         yUTpXKaRVFE6XNeeM4mI54nDTT7NZ/SEmO1aDf3PAcU8NbNqknMnipKfS0/v/ZHHvW0q
         Z7mMOwpHb/WcCNGQgqsy6CBZQ5mZFfcUAX1PRemzM0g+PAVFZuhEYuE4eA0v/kvK96it
         yCejROPH/bnNJYIeCJHgMkDypiM8nH91cTq2+MK7gzZ9fkSnueTbt9GMUMebnJHdWZVU
         A33ZAc8Dp6bryRFMsdNmLZRVChOJNFlAUi9NHzLlROVASJ1PXw2VRmfaetxjNSq3dcU2
         pk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vkkcw+822Hb85CcUjjqLZ/Hz7oyJXRi0OzVnXZ9mfZM=;
        b=OSjkh0Iq2fp3fXKPLmOaeYDJFkPRorYXXpi1dIKp+jFvtEPdeLuBv4f8OHTqCiZJPo
         EfPWVuJyBrknwwPIlQX9rbg/7Bs3KUpzgnrz0B3ZkOa5xxlbH2n3zywz5N+gKwg4T7Er
         UvcDSTkDPROe4VzPN07UK51h1052yOHHUC4OnJAKNjx9D1bokymdWARug/iDNVULFX2r
         M5dfOZ3NU57e4ISTkeut+Kn0h1q6e9qHgNnKqUbTDoI03xaiuCZXmJ1iEe6KeqEmO/xV
         5hGBcbOy0rGzgE6jh213BGabA/scpnkXYkvO/y4UOLS+DOS1Aj7IOVfofPaoMtuCEhbg
         pnXA==
X-Gm-Message-State: AKS2vOyDr6MCu28GwRYz+MfYcFm0LakdGuSJHt4TPwkH8fE3QhqxA4LW
        ZhSporBB8HVaqoLUjQCYNw==
X-Received: by 10.84.224.11 with SMTP id r11mr503534plj.267.1498248271324;
        Fri, 23 Jun 2017 13:04:31 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 197sm10750012pga.58.2017.06.23.13.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 13:04:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH] submodule--helper: teach push-check to handle HEAD
Date:   Fri, 23 Jun 2017 13:04:27 -0700
Message-Id: <20170623200427.26803-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
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
 builtin/submodule--helper.c    | 57 +++++++++++++++++++++++++++++++-----------
 submodule.c                    | 18 ++++++++++---
 t/t5531-deep-submodule-push.sh | 25 +++++++++++++++++-
 3 files changed, 82 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1b4d2b346..fd5020036 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1107,24 +1107,41 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
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
+		die("submodule--helper push-check requires at least 2 argument");
+
+	/*
+	 * superproject's resolved head ref.
+	 * if HEAD then the superproject is in a detached head state, otherwise
+	 * it will be the resolved head ref.
+	 */
+	superproject_head = argv[1];
+	/* Get the submodule's head ref and determine if it is detached */
+	head = resolve_refdup("HEAD", 0, head_oid.hash, NULL);
+	if (!head)
+		die(_("Failed to resolve HEAD as a valid ref."));
+	if (!strcmp(head, "HEAD"))
+		detached_head = 1;
 
 	/*
 	 * The remote must be configured.
 	 * This is to avoid pushing to the exact same URL as the parent.
 	 */
-	remote = pushremote_get(argv[1]);
+	remote = pushremote_get(argv[2]);
 	if (!remote || remote->origin == REMOTE_UNCONFIGURED)
-		die("remote '%s' not configured", argv[1]);
+		die("remote '%s' not configured", argv[2]);
 
 	/* Check the refspec */
-	if (argc > 2) {
-		int i, refspec_nr = argc - 2;
+	if (argc > 3) {
+		int i, refspec_nr = argc - 3;
 		struct ref *local_refs = get_local_heads();
 		struct refspec *refspec = parse_push_refspec(refspec_nr,
-							     argv + 2);
+							     argv + 3);
 
 		for (i = 0; i < refspec_nr; i++) {
 			struct refspec *rs = refspec + i;
@@ -1132,18 +1149,30 @@ static int push_check(int argc, const char **argv, const char *prefix)
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
+			switch(count_refspec_match(rs->src, local_refs, NULL)) {
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
index 1b8a3b575..920b49328 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1003,7 +1003,8 @@ static int push_submodule(const char *path,
  * Perform a check in the submodule to see if the remote and refspec work.
  * Die if the submodule can't be pushed.
  */
-static void submodule_push_check(const char *path, const struct remote *remote,
+static void submodule_push_check(const char *path, const char *head,
+				 const struct remote *remote,
 				 const char **refspec, int refspec_nr)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1011,6 +1012,7 @@ static void submodule_push_check(const char *path, const struct remote *remote,
 
 	argv_array_push(&cp.args, "submodule--helper");
 	argv_array_push(&cp.args, "push-check");
+	argv_array_push(&cp.args, head);
 	argv_array_push(&cp.args, remote->name);
 
 	for (i = 0; i < refspec_nr; i++)
@@ -1049,10 +1051,20 @@ int push_unpushed_submodules(struct oid_array *commits,
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
2.13.1.704.gde00cce3c-goog

