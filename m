Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43E7020966
	for <e@80x24.org>; Wed,  5 Apr 2017 17:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755229AbdDERtL (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 13:49:11 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33020 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753749AbdDERre (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 13:47:34 -0400
Received: by mail-pf0-f179.google.com with SMTP id s16so10719356pfs.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i7KK7+OwX7OPVvPGHYUHp6LyDWf4kxOmQ39fVBkET5A=;
        b=p4XfGUBVTIPFkeDfj4Je/Cq3BK2Y6MqAEWKbET/8xBol0R9qRDmJ8adr3UtljMw8iz
         5eeOEWLr/2ibQiDKW7sQVOw/OouhddJKNOVveaJ1yajpXSQb7QVb/cvfeCfmKN/nj6Rd
         lHTyaGieLOaFqOwRmdbV7C6sUw5tcF/ajvG50MytzXMFV1eldE0OqpJMwSDypDY9PfYr
         vje+XO1LKKsofkCtzVM/Ay5iI92SoEYQLMd9HbxaPJlppXKxPRK/kiTM4EkN5HkV9afq
         5KHqPhZXE5jKfbF2sB8eVaU0k2kXzWEEAoop68UyhpasLrZyXyZBZ1wj/JpUO3yP8mrc
         t2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i7KK7+OwX7OPVvPGHYUHp6LyDWf4kxOmQ39fVBkET5A=;
        b=J7Q5b/ZiWjPTvks9jQ9qcFjE7Wg02hdYq/Lv695ALpz4drl4b7P50KVtiBMrOpYK1w
         IJhEtsKP2ln54thbAVTBEzJ3Vuz4Coodw+hf6zHgSGiyJmSMxTHaAA23VTIWJPYjs+IU
         dnbgo6hriEThA9BuD4blK26r1WLG6D0Oik5QuKmdaFqDd9gnkStN0+4qVaAeOyqrwAVB
         QhYU22Tqnog5soHjM4oLktbYFjVyFhYr9SB9SLxmLn0L/n+QPsilgB31G62qdljvW8FU
         4R0ZZT1t+iIVDF4roV4nNi17Y1FFY3DTWjyeSLRDzd+49fLbGs68M/XxHmtGu6BDnZmB
         Qobg==
X-Gm-Message-State: AFeK/H1GFb6+qm8gNHv9SPFN5KQH62OmH/Vj4vztps0s9vZvaNvmAFjc6YG2VzciGQbuvHIa
X-Received: by 10.99.155.17 with SMTP id r17mr31360534pgd.193.1491414453612;
        Wed, 05 Apr 2017 10:47:33 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id m69sm38726623pfc.33.2017.04.05.10.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 10:47:32 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com
Subject: [PATCH v3 5/5] push: propagate remote and refspec with --recurse-submodules
Date:   Wed,  5 Apr 2017 10:47:19 -0700
Message-Id: <20170405174719.1297-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
In-Reply-To: <20170405174719.1297-1-bmwill@google.com>
References: <20170331235623.166408-1-bmwill@google.com>
 <20170405174719.1297-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach "push --recurse-submodules" to propagate, if given a name as remote, the
provided remote and refspec recursively to the pushes performed in the
submodules. The push will therefore only succeed if all submodules have a
remote with such a name configured.

Note that "push --recurse-submodules" with a path or URL as remote will not
propagate the remote or refspec and instead use the default remote and refspec
configured in the submodule, preserving the current behavior.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c                    | 63 ++++++++++++++++++++++++++++++++++++++++--
 submodule.h                    |  4 ++-
 t/t5531-deep-submodule-push.sh | 52 ++++++++++++++++++++++++++++++++++
 transport.c                    |  3 +-
 4 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index de444be61..49ab132d0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -14,6 +14,7 @@
 #include "blob.h"
 #include "thread-utils.h"
 #include "quote.h"
+#include "remote.h"
 #include "worktree.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
@@ -783,6 +784,8 @@ int find_unpushed_submodules(struct sha1_array *commits,
 }
 
 static int push_submodule(const char *path,
+			  const struct remote *remote,
+			  const char **refspec, int refspec_nr,
 			  const struct string_list *push_options,
 			  int dry_run)
 {
@@ -801,6 +804,14 @@ static int push_submodule(const char *path,
 				argv_array_pushf(&cp.args, "--push-option=%s",
 						 item->string);
 		}
+
+		if (remote->origin != REMOTE_UNCONFIGURED) {
+			int i;
+			argv_array_push(&cp.args, remote->name);
+			for (i = 0; i < refspec_nr; i++)
+				argv_array_push(&cp.args, refspec[i]);
+		}
+
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
@@ -813,21 +824,67 @@ static int push_submodule(const char *path,
 	return 1;
 }
 
+/*
+ * Perform a check in the submodule to see if the remote and refspec work.
+ * Die if the submodule can't be pushed.
+ */
+static void submodule_push_check(const char *path, const struct remote *remote,
+				 const char **refspec, int refspec_nr)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	int i;
+
+	argv_array_push(&cp.args, "submodule--helper");
+	argv_array_push(&cp.args, "push-check");
+	argv_array_push(&cp.args, remote->name);
+
+	for (i = 0; i < refspec_nr; i++)
+		argv_array_push(&cp.args, refspec[i]);
+
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.no_stdout = 1;
+	cp.dir = path;
+
+	/*
+	 * Simply indicate if 'submodule--helper push-check' failed.
+	 * More detailed error information will be provided by the
+	 * child process.
+	 */
+	if (run_command(&cp))
+		die("process for submodule '%s' failed", path);
+}
+
 int push_unpushed_submodules(struct sha1_array *commits,
-			     const char *remotes_name,
+			     const struct remote *remote,
+			     const char **refspec, int refspec_nr,
 			     const struct string_list *push_options,
 			     int dry_run)
 {
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
-	if (!find_unpushed_submodules(commits, remotes_name, &needs_pushing))
+	if (!find_unpushed_submodules(commits, remote->name, &needs_pushing))
 		return 1;
 
+	/*
+	 * Verify that the remote and refspec can be propagated to all
+	 * submodules.  This check can be skipped if the remote and refspec
+	 * won't be propagated due to the remote being unconfigured (e.g. a URL
+	 * instead of a remote name).
+	 */
+	if (remote->origin != REMOTE_UNCONFIGURED)
+		for (i = 0; i < needs_pushing.nr; i++)
+			submodule_push_check(needs_pushing.items[i].string,
+					     remote, refspec, refspec_nr);
+
+	/* Actually push the submodules */
 	for (i = 0; i < needs_pushing.nr; i++) {
 		const char *path = needs_pushing.items[i].string;
 		fprintf(stderr, "Pushing submodule '%s'\n", path);
-		if (!push_submodule(path, push_options, dry_run)) {
+		if (!push_submodule(path, remote, refspec, refspec_nr,
+				    push_options, dry_run)) {
 			fprintf(stderr, "Unable to push submodule '%s'\n", path);
 			ret = 0;
 		}
diff --git a/submodule.h b/submodule.h
index 0e26430fd..127ff9be8 100644
--- a/submodule.h
+++ b/submodule.h
@@ -4,6 +4,7 @@
 struct diff_options;
 struct argv_array;
 struct sha1_array;
+struct remote;
 
 enum {
 	RECURSE_SUBMODULES_ONLY = -5,
@@ -91,7 +92,8 @@ extern int find_unpushed_submodules(struct sha1_array *commits,
 				    const char *remotes_name,
 				    struct string_list *needs_pushing);
 extern int push_unpushed_submodules(struct sha1_array *commits,
-				    const char *remotes_name,
+				    const struct remote *remote,
+				    const char **refspec, int refspec_nr,
 				    const struct string_list *push_options,
 				    int dry_run);
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index f55137f76..57ba32262 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -475,4 +475,56 @@ test_expect_success 'push only unpushed submodules recursively' '
 	test_cmp expected_pub actual_pub
 '
 
+test_expect_success 'push propagating the remotes name to a submodule' '
+	git -C work remote add origin ../pub.git &&
+	git -C work remote add pub ../pub.git &&
+
+	> work/gar/bage/junk10 &&
+	git -C work/gar/bage add junk10 &&
+	git -C work/gar/bage commit -m "Tenth junk" &&
+	git -C work add gar/bage &&
+	git -C work commit -m "Tenth junk added to gar/bage" &&
+
+	# Fails when submodule does not have a matching remote
+	test_must_fail git -C work push --recurse-submodules=on-demand pub master &&
+	# Succeeds when submodules has matching remote and refspec
+	git -C work push --recurse-submodules=on-demand origin master &&
+
+	git -C submodule.git rev-parse master >actual_submodule &&
+	git -C pub.git rev-parse master >actual_pub &&
+	git -C work/gar/bage rev-parse master >expected_submodule &&
+	git -C work rev-parse master >expected_pub &&
+	test_cmp expected_submodule actual_submodule &&
+	test_cmp expected_pub actual_pub
+'
+
+test_expect_success 'push propagating refspec to a submodule' '
+	> work/gar/bage/junk11 &&
+	git -C work/gar/bage add junk11 &&
+	git -C work/gar/bage commit -m "Eleventh junk" &&
+
+	git -C work checkout branch2 &&
+	git -C work add gar/bage &&
+	git -C work commit -m "updating gar/bage in branch2" &&
+
+	# Fails when submodule does not have a matching branch
+	test_must_fail git -C work push --recurse-submodules=on-demand origin branch2 &&
+	# Fails when refspec includes an object id
+	test_must_fail git -C work push --recurse-submodules=on-demand origin \
+		"$(git -C work rev-parse branch2):refs/heads/branch2" &&
+	# Fails when refspec includes 'HEAD' as it is unsupported at this time
+	test_must_fail git -C work push --recurse-submodules=on-demand origin \
+		HEAD:refs/heads/branch2 &&
+
+	git -C work/gar/bage branch branch2 master &&
+	git -C work push --recurse-submodules=on-demand origin branch2 &&
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
diff --git a/transport.c b/transport.c
index 64e60b635..a62e5118c 100644
--- a/transport.c
+++ b/transport.c
@@ -1030,7 +1030,8 @@ int transport_push(struct transport *transport,
 					sha1_array_append(&commits, ref->new_oid.hash);
 
 			if (!push_unpushed_submodules(&commits,
-						      transport->remote->name,
+						      transport->remote,
+						      refspec, refspec_nr,
 						      transport->push_options,
 						      pretend)) {
 				sha1_array_clear(&commits);
-- 
2.12.2.715.g7642488e1d-goog

