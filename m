Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2E62042F
	for <e@80x24.org>; Wed, 16 Nov 2016 15:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934004AbcKPPMO (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 10:12:14 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:53283 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753680AbcKPPMD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 10:12:03 -0500
Received: from [84.46.92.130] (helo=localhost)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c71sW-0004Mr-5M; Wed, 16 Nov 2016 16:12:00 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jens.Lehmann@web.de, Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH v4 2/4] serialize collection of refs that contain submodule changes
Date:   Wed, 16 Nov 2016 16:11:05 +0100
Message-Id: <3bb9abb760ac8bed0e980aa98a1767740104b2d9.1479308877.git.hvoigt@hvoigt.net>
X-Mailer: git-send-email 2.10.1.386.gc503e45
In-Reply-To: <cover.1479308877.git.hvoigt@hvoigt.net>
References: <cover.1479308877.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1479308877.git.hvoigt@hvoigt.net>
References: <cover.1479308877.git.hvoigt@hvoigt.net>
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are iterating over each pushed ref and want to check whether it
contains changes to submodules. Instead of immediately checking each ref
lets first collect them and then do the check for all of them in one
revision walk.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c | 35 ++++++++++++++++++++---------------
 submodule.h |  5 +++--
 transport.c | 29 +++++++++++++++++++++--------
 3 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/submodule.c b/submodule.c
index b2908fe..12ac1ea 100644
--- a/submodule.c
+++ b/submodule.c
@@ -500,6 +500,13 @@ static int has_remote(const char *refname, const struct object_id *oid,
 	return 1;
 }
 
+static int append_sha1_to_argv(const unsigned char sha1[20], void *data)
+{
+	struct argv_array *argv = data;
+	argv_array_push(argv, sha1_to_hex(sha1));
+	return 0;
+}
+
 static int submodule_needs_pushing(const char *path, const unsigned char sha1[20])
 {
 	if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
@@ -599,25 +606,24 @@ static void free_submodules_sha1s(struct string_list *submodules)
 	string_list_clear(submodules, 1);
 }
 
-int find_unpushed_submodules(unsigned char new_sha1[20],
+int find_unpushed_submodules(struct sha1_array *commits,
 		const char *remotes_name, struct string_list *needs_pushing)
 {
 	struct rev_info rev;
 	struct commit *commit;
-	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
-	int argc = ARRAY_SIZE(argv) - 1;
-	char *sha1_copy;
 	struct string_list submodules = STRING_LIST_INIT_DUP;
 	struct string_list_item *submodule;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	struct strbuf remotes_arg = STRBUF_INIT;
-
-	strbuf_addf(&remotes_arg, "--remotes=%s", remotes_name);
 	init_revisions(&rev, NULL);
-	sha1_copy = xstrdup(sha1_to_hex(new_sha1));
-	argv[1] = sha1_copy;
-	argv[3] = remotes_arg.buf;
-	setup_revisions(argc, argv, &rev, NULL);
+
+	/* argv.argv[0] will be ignored by setup_revisions */
+	argv_array_push(&argv, "find_unpushed_submodules");
+	sha1_array_for_each_unique(commits, append_sha1_to_argv, &argv);
+	argv_array_push(&argv, "--not");
+	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
+
+	setup_revisions(argv.argc, argv.argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
 
@@ -625,8 +631,7 @@ int find_unpushed_submodules(unsigned char new_sha1[20],
 		find_unpushed_submodule_commits(commit, &submodules);
 
 	reset_revision_walk();
-	free(sha1_copy);
-	strbuf_release(&remotes_arg);
+	argv_array_clear(&argv);
 
 	for_each_string_list_item(submodule, &submodules) {
 		struct collect_submodule_from_sha1s_data data;
@@ -663,12 +668,12 @@ static int push_submodule(const char *path)
 	return 1;
 }
 
-int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name)
+int push_unpushed_submodules(struct sha1_array *commits, const char *remotes_name)
 {
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
-	if (!find_unpushed_submodules(new_sha1, remotes_name, &needs_pushing))
+	if (!find_unpushed_submodules(commits, remotes_name, &needs_pushing))
 		return 1;
 
 	for (i = 0; i < needs_pushing.nr; i++) {
diff --git a/submodule.h b/submodule.h
index d9e197a..9454806 100644
--- a/submodule.h
+++ b/submodule.h
@@ -3,6 +3,7 @@
 
 struct diff_options;
 struct argv_array;
+struct sha1_array;
 
 enum {
 	RECURSE_SUBMODULES_CHECK = -4,
@@ -62,9 +63,9 @@ int submodule_uses_gitfile(const char *path);
 int ok_to_remove_submodule(const char *path);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20], int search);
-int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
+int find_unpushed_submodules(struct sha1_array *commits, const char *remotes_name,
 		struct string_list *needs_pushing);
-int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
+int push_unpushed_submodules(struct sha1_array *commits, const char *remotes_name);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 int parallel_submodules(void);
 
diff --git a/transport.c b/transport.c
index d57e8de..f482869 100644
--- a/transport.c
+++ b/transport.c
@@ -949,23 +949,36 @@ int transport_push(struct transport *transport,
 
 		if ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
+			struct sha1_array commits = SHA1_ARRAY_INIT;
+
 			for (; ref; ref = ref->next)
-				if (!is_null_oid(&ref->new_oid) &&
-				    !push_unpushed_submodules(ref->new_oid.hash,
-					    transport->remote->name))
-				    die ("Failed to push all needed submodules!");
+				if (!is_null_oid(&ref->new_oid))
+					sha1_array_append(&commits, ref->new_oid.hash);
+
+			if (!push_unpushed_submodules(&commits, transport->remote->name)) {
+				sha1_array_clear(&commits);
+				die("Failed to push all needed submodules!");
+			}
+			sha1_array_clear(&commits);
 		}
 
 		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 			      TRANSPORT_RECURSE_SUBMODULES_CHECK)) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
+			struct sha1_array commits = SHA1_ARRAY_INIT;
 
 			for (; ref; ref = ref->next)
-				if (!is_null_oid(&ref->new_oid) &&
-				    find_unpushed_submodules(ref->new_oid.hash,
-					    transport->remote->name, &needs_pushing))
-					die_with_unpushed_submodules(&needs_pushing);
+				if (!is_null_oid(&ref->new_oid))
+					sha1_array_append(&commits, ref->new_oid.hash);
+
+			if (find_unpushed_submodules(&commits, transport->remote->name,
+						&needs_pushing)) {
+				sha1_array_clear(&commits);
+				die_with_unpushed_submodules(&needs_pushing);
+			}
+			string_list_clear(&needs_pushing, 0);
+			sha1_array_clear(&commits);
 		}
 
 		push_ret = transport->push_refs(transport, remote_refs, flags);
-- 
2.10.1.386.gc503e45

