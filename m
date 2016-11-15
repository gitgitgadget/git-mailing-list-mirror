Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22B82042F
	for <e@80x24.org>; Tue, 15 Nov 2016 14:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbcKOO5X (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 09:57:23 -0500
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:55449 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753253AbcKOO5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 09:57:18 -0500
Received: from [84.46.92.130] (helo=localhost)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c6fAg-0007ZJ-RP; Tue, 15 Nov 2016 15:57:14 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH v3 1/4] serialize collection of changed submodules
Date:   Tue, 15 Nov 2016 15:56:14 +0100
Message-Id: <67e11474d4fd8ada2652809cf14f6c4d96be55ff.1479221071.git.hvoigt@hvoigt.net>
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

To check whether a submodule needs to be pushed we need to collect all
changed submodules. Lets collect them first and then execute the
possibly expensive test whether certain revisions are already pushed
only once per submodule.

There is further potential for optimization since we can assemble one
command and only issued that instead of one call for each remote ref in
the submodule.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6f7d883..b91585e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -532,19 +532,34 @@ static int submodule_needs_pushing(const char *path, const unsigned char sha1[20
 	return 0;
 }
 
+static struct sha1_array *submodule_commits(struct string_list *submodules,
+					    const char *path)
+{
+	struct string_list_item *item;
+
+	item = string_list_insert(submodules, path);
+	if (item->util)
+		return (struct sha1_array *) item->util;
+
+	/* NEEDSWORK: should we have sha1_array_init()? */
+	item->util = xcalloc(1, sizeof(struct sha1_array));
+	return (struct sha1_array *) item->util;
+}
+
 static void collect_submodules_from_diff(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
 {
 	int i;
-	struct string_list *needs_pushing = data;
+	struct string_list *submodules = data;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
+		struct sha1_array *commits;
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
-		if (submodule_needs_pushing(p->two->path, p->two->oid.hash))
-			string_list_insert(needs_pushing, p->two->path);
+		commits = submodule_commits(submodules, p->two->path);
+		sha1_array_append(commits, p->two->oid.hash);
 	}
 }
 
@@ -560,6 +575,31 @@ static void find_unpushed_submodule_commits(struct commit *commit,
 	diff_tree_combined_merge(commit, 1, &rev);
 }
 
+struct collect_submodule_from_sha1s_data {
+	char *submodule_path;
+	struct string_list *needs_pushing;
+};
+
+static int collect_submodules_from_sha1s(const unsigned char sha1[20],
+		void *data)
+{
+	struct collect_submodule_from_sha1s_data *me =
+		(struct collect_submodule_from_sha1s_data *) data;
+
+	if (submodule_needs_pushing(me->submodule_path, sha1))
+		string_list_insert(me->needs_pushing, me->submodule_path);
+
+	return 0;
+}
+
+static void free_submodules_sha1s(struct string_list *submodules)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, submodules)
+		sha1_array_clear((struct sha1_array *) item->util);
+	string_list_clear(submodules, 1);
+}
+
 int find_unpushed_submodules(unsigned char new_sha1[20],
 		const char *remotes_name, struct string_list *needs_pushing)
 {
@@ -568,6 +608,8 @@ int find_unpushed_submodules(unsigned char new_sha1[20],
 	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
 	int argc = ARRAY_SIZE(argv) - 1;
 	char *sha1_copy;
+	struct string_list submodules = STRING_LIST_INIT_DUP;
+	struct string_list_item *submodule;
 
 	struct strbuf remotes_arg = STRBUF_INIT;
 
@@ -581,12 +623,22 @@ int find_unpushed_submodules(unsigned char new_sha1[20],
 		die("revision walk setup failed");
 
 	while ((commit = get_revision(&rev)) != NULL)
-		find_unpushed_submodule_commits(commit, needs_pushing);
+		find_unpushed_submodule_commits(commit, &submodules);
 
 	reset_revision_walk();
 	free(sha1_copy);
 	strbuf_release(&remotes_arg);
 
+	for_each_string_list_item(submodule, &submodules) {
+		struct collect_submodule_from_sha1s_data data;
+		data.submodule_path = submodule->string;
+		data.needs_pushing = needs_pushing;
+		sha1_array_for_each_unique((struct sha1_array *) submodule->util,
+				collect_submodules_from_sha1s,
+				&data);
+	}
+	free_submodules_sha1s(&submodules);
+
 	return needs_pushing->nr;
 }
 
-- 
2.10.1.386.gc503e45

