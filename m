Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE2620986
	for <e@80x24.org>; Fri,  7 Oct 2016 15:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756766AbcJGPHP (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 11:07:15 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.95]:54173 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756743AbcJGPHH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 11:07:07 -0400
Received: from [84.131.252.35] (helo=localhost)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bsWjh-0006dJ-3Y; Fri, 07 Oct 2016 17:06:57 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jens.Lehmann@web.de, Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH v2 1/3] serialize collection of changed submodules
Date:   Fri,  7 Oct 2016 17:06:34 +0200
Message-Id: <10cd5be93601bc52388100e80b6c6735a7cacfb4.1475851621.git.hvoigt@hvoigt.net>
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

To check whether a submodule needs to be pushed we need to collect all
changed submodules. Lets collect them first and then execute the
possibly expensive test whether certain revisions are already pushed
only once per submodule.

There is further potential for optimization since we can assemble one
command and only issued that instead of one call for each remote ref in
the submodule.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 2de06a3351..59c9d15905 100644
--- a/submodule.c
+++ b/submodule.c
@@ -554,19 +554,34 @@ static int submodule_needs_pushing(const char *path, const unsigned char sha1[20
 	return 0;
 }
 
+static struct sha1_array *get_sha1s_from_list(struct string_list *submodules,
+		const char *path)
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
+		struct sha1_array *hashes;
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
-		if (submodule_needs_pushing(p->two->path, p->two->oid.hash))
-			string_list_insert(needs_pushing, p->two->path);
+		hashes = get_sha1s_from_list(submodules, p->two->path);
+		sha1_array_append(hashes, p->two->oid.hash);
 	}
 }
 
@@ -582,14 +597,41 @@ static void find_unpushed_submodule_commits(struct commit *commit,
 	diff_tree_combined_merge(commit, 1, &rev);
 }
 
+struct collect_submodule_from_sha1s_data {
+	char *submodule_path;
+	struct string_list *needs_pushing;
+};
+
+static void collect_submodules_from_sha1s(const unsigned char sha1[20],
+		void *data)
+{
+	struct collect_submodule_from_sha1s_data *me =
+		(struct collect_submodule_from_sha1s_data *) data;
+
+	if (submodule_needs_pushing(me->submodule_path, sha1))
+		string_list_insert(me->needs_pushing, me->submodule_path);
+}
+
+static void free_submodules_sha1s(struct string_list *submodules)
+{
+	int i;
+	for (i = 0; i < submodules->nr; i++) {
+		struct string_list_item *item = &submodules->items[i];
+		struct sha1_array *hashes = (struct sha1_array *) item->util;
+		sha1_array_clear(hashes);
+	}
+	string_list_clear(submodules, 1);
+}
+
 int find_unpushed_submodules(unsigned char new_sha1[20],
 		const char *remotes_name, struct string_list *needs_pushing)
 {
 	struct rev_info rev;
 	struct commit *commit;
 	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
-	int argc = ARRAY_SIZE(argv) - 1;
+	int argc = ARRAY_SIZE(argv) - 1, i;
 	char *sha1_copy;
+	struct string_list submodules = STRING_LIST_INIT_DUP;
 
 	struct strbuf remotes_arg = STRBUF_INIT;
 
@@ -603,12 +645,23 @@ int find_unpushed_submodules(unsigned char new_sha1[20],
 		die("revision walk setup failed");
 
 	while ((commit = get_revision(&rev)) != NULL)
-		find_unpushed_submodule_commits(commit, needs_pushing);
+		find_unpushed_submodule_commits(commit, &submodules);
 
 	reset_revision_walk();
 	free(sha1_copy);
 	strbuf_release(&remotes_arg);
 
+	for (i = 0; i < submodules.nr; i++) {
+		struct string_list_item *item = &submodules.items[i];
+		struct collect_submodule_from_sha1s_data data;
+		data.submodule_path = item->string;
+		data.needs_pushing = needs_pushing;
+		sha1_array_for_each_unique((struct sha1_array *) item->util,
+				collect_submodules_from_sha1s,
+				&data);
+	}
+	free_submodules_sha1s(&submodules);
+
 	return needs_pushing->nr;
 }
 
-- 
2.10.1.637.g09b28c5

