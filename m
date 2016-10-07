Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C02720986
	for <e@80x24.org>; Fri,  7 Oct 2016 15:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756763AbcJGPHZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 11:07:25 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:54818 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756431AbcJGPHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 11:07:15 -0400
Received: from [84.131.252.35] (helo=localhost)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bsWjv-0006Bl-O3; Fri, 07 Oct 2016 17:07:11 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jens.Lehmann@web.de, Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH v2 3/3] batch check whether submodule needs pushing into one call
Date:   Fri,  7 Oct 2016 17:06:36 +0200
Message-Id: <67d4c48dc0129f20041c88d27a49c7a21188c882.1475851621.git.hvoigt@hvoigt.net>
X-Mailer: git-send-email 2.10.1.637.g09b28c5
In-Reply-To: <cover.1475851621.git.hvoigt@hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1475851621.git.hvoigt@hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net>
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
 submodule.c | 63 +++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5044afc2f8..a05c2a34b1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -529,27 +529,49 @@ static int append_hash_to_argv(const unsigned char sha1[20], void *data)
 	return 0;
 }
 
-static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
+static int check_has_hash(const unsigned char sha1[20], void *data)
 {
-	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
+	int *has_hash = (int *) data;
+
+	if (!lookup_commit_reference(sha1))
+		*has_hash = 0;
+
+	return 0;
+}
+
+static int submodule_has_hashes(const char *path, struct sha1_array *hashes)
+{
+	int has_hash = 1;
+
+	if (add_submodule_odb(path))
+		return 0;
+
+	sha1_array_for_each_unique(hashes, check_has_hash, &has_hash);
+	return has_hash;
+}
+
+static int submodule_needs_pushing(const char *path, struct sha1_array *hashes)
+{
+	if (!submodule_has_hashes(path, hashes))
 		return 0;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
-		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
 		struct strbuf buf = STRBUF_INIT;
 		int needs_pushing = 0;
 
-		argv[1] = sha1_to_hex(sha1);
-		cp.argv = argv;
+		argv_array_push(&cp.args, "rev-list");
+		sha1_array_for_each_unique(hashes, append_hash_to_argv, &cp.args);
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
+			die("Could not run 'git rev-list <hashes> --not --remotes -n 1' command in submodule %s",
+					path);
 		if (strbuf_read(&buf, cp.out, 41))
 			needs_pushing = 1;
 		finish_command(&cp);
@@ -604,21 +626,6 @@ static void find_unpushed_submodule_commits(struct commit *commit,
 	diff_tree_combined_merge(commit, 1, &rev);
 }
 
-struct collect_submodule_from_sha1s_data {
-	char *submodule_path;
-	struct string_list *needs_pushing;
-};
-
-static void collect_submodules_from_sha1s(const unsigned char sha1[20],
-		void *data)
-{
-	struct collect_submodule_from_sha1s_data *me =
-		(struct collect_submodule_from_sha1s_data *) data;
-
-	if (submodule_needs_pushing(me->submodule_path, sha1))
-		string_list_insert(me->needs_pushing, me->submodule_path);
-}
-
 static void free_submodules_sha1s(struct string_list *submodules)
 {
 	int i;
@@ -658,13 +665,11 @@ int find_unpushed_submodules(struct sha1_array *hashes,
 	argv_array_clear(&argv);
 
 	for (i = 0; i < submodules.nr; i++) {
-		struct string_list_item *item = &submodules.items[i];
-		struct collect_submodule_from_sha1s_data data;
-		data.submodule_path = item->string;
-		data.needs_pushing = needs_pushing;
-		sha1_array_for_each_unique((struct sha1_array *) item->util,
-				collect_submodules_from_sha1s,
-				&data);
+		struct string_list_item *submodule = &submodules.items[i];
+		struct sha1_array *hashes = (struct sha1_array *) submodule->util;
+
+		if (submodule_needs_pushing(submodule->string, hashes))
+			string_list_insert(needs_pushing, submodule->string);
 	}
 	free_submodules_sha1s(&submodules);
 
-- 
2.10.1.637.g09b28c5

