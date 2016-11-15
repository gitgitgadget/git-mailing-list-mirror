Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A5542021E
	for <e@80x24.org>; Tue, 15 Nov 2016 14:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbcKOO5U (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 09:57:20 -0500
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:33650 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbcKOO5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 09:57:18 -0500
Received: from [84.46.92.130] (helo=localhost)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c6fAh-0007dO-UD; Tue, 15 Nov 2016 15:57:16 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH v3 3/4] batch check whether submodule needs pushing into one call
Date:   Tue, 15 Nov 2016 15:56:16 +0100
Message-Id: <0f1aaa07e151f6be87eb61b434f8c9448f8dad75.1479221071.git.hvoigt@hvoigt.net>
X-Mailer: git-send-email 2.10.1.386.gc503e45
In-Reply-To: <cover.1479221071.git.hvoigt@hvoigt.net>
References: <cover.1479221071.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1479221071.git.hvoigt@hvoigt.net>
References: <cover.1479221071.git.hvoigt@hvoigt.net>
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We run a command for each sha1 change in a submodule. This is
unnecessary since we can simply batch all sha1's we want to check into
one command. Lets do it so we can speedup the check when many submodule
changes are in need of checking.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c | 63 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/submodule.c b/submodule.c
index 769d666..e1196fd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -507,27 +507,49 @@ static int append_sha1_to_argv(const unsigned char sha1[20], void *data)
 	return 0;
 }
 
-static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
+static int check_has_commit(const unsigned char sha1[20], void *data)
 {
-	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
+	int *has_commit = (int *) data;
+
+	if (!lookup_commit_reference(sha1))
+		*has_commit = 0;
+
+	return 0;
+}
+
+static int submodule_has_commits(const char *path, struct sha1_array *commits)
+{
+	int has_commit = 1;
+
+	if (add_submodule_odb(path))
+		return 0;
+
+	sha1_array_for_each_unique(commits, check_has_commit, &has_commit);
+	return has_commit;
+}
+
+static int submodule_needs_pushing(const char *path, struct sha1_array *commits)
+{
+	if (!submodule_has_commits(path, commits))
 		return 0;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
-		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
 		struct strbuf buf = STRBUF_INIT;
 		int needs_pushing = 0;
 
-		argv[1] = sha1_to_hex(sha1);
-		cp.argv = argv;
+		argv_array_push(&cp.args, "rev-list");
+		sha1_array_for_each_unique(commits, append_sha1_to_argv, &cp.args);
+		argv_array_pushl(&cp.args, "--not", "--remotes", "-n", "1" , NULL);
+
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
 		cp.out = -1;
 		cp.dir = path;
 		if (start_command(&cp))
-			die("Could not run 'git rev-list %s --not --remotes -n 1' command in submodule %s",
-				sha1_to_hex(sha1), path);
+			die("Could not run 'git rev-list <commits> --not --remotes -n 1' command in submodule %s",
+					path);
 		if (strbuf_read(&buf, cp.out, 41))
 			needs_pushing = 1;
 		finish_command(&cp);
@@ -582,23 +604,6 @@ static void find_unpushed_submodule_commits(struct commit *commit,
 	diff_tree_combined_merge(commit, 1, &rev);
 }
 
-struct collect_submodule_from_sha1s_data {
-	char *submodule_path;
-	struct string_list *needs_pushing;
-};
-
-static int collect_submodules_from_sha1s(const unsigned char sha1[20],
-		void *data)
-{
-	struct collect_submodule_from_sha1s_data *me =
-		(struct collect_submodule_from_sha1s_data *) data;
-
-	if (submodule_needs_pushing(me->submodule_path, sha1))
-		string_list_insert(me->needs_pushing, me->submodule_path);
-
-	return 0;
-}
-
 static void free_submodules_sha1s(struct string_list *submodules)
 {
 	struct string_list_item *item;
@@ -635,12 +640,10 @@ int find_unpushed_submodules(struct sha1_array *commits,
 	argv_array_clear(&argv);
 
 	for_each_string_list_item(submodule, &submodules) {
-		struct collect_submodule_from_sha1s_data data;
-		data.submodule_path = submodule->string;
-		data.needs_pushing = needs_pushing;
-		sha1_array_for_each_unique((struct sha1_array *) submodule->util,
-				collect_submodules_from_sha1s,
-				&data);
+		struct sha1_array *commits = (struct sha1_array *) submodule->util;
+
+		if (submodule_needs_pushing(submodule->string, commits))
+			string_list_insert(needs_pushing, submodule->string);
 	}
 	free_submodules_sha1s(&submodules);
 
-- 
2.10.1.386.gc503e45

