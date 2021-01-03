Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E932C433E0
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5779F20784
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbhACVTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 16:19:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45752 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727453AbhACVTs (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jan 2021 16:19:48 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6D9DD60812;
        Sun,  3 Jan 2021 21:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1609708746;
        bh=3P8kUieolsojzjyIY6yQJ6r3SrSHAwoHPzE832QP8G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yf7iIrWoWl3qof2kw30na6KD74FosXDN7+cLhSgr/K/4A4EOF7leXFcFTNwXusXTO
         MAWjy9NSqALEUbQgalIRfxVhHVlZ2mP/EwIeWmCU8tJC4hJKphXi41bWsGoz7Z5L15
         fXAkItlRVcpKrtyy62J6kL5wlgwmuW3TmQcH6Pe9kE8SLbiA8cKAxnj033pZCd9orR
         7aD9elzHG1oqreUbnLsQFjzFWYgzLCVi5JKlCZ81HnwkSdG3NNnQN8h0iF+SuJRHKL
         Dk1ppdNtfahhff5H+zCMIhz4A0Irkk6iKHgNXPACrd9DznKWp3TcU+JBpI9gv+JP/m
         XwlwxMLXUh1WkA+JBbMXVb3HV4LGuBUPW5Jckxx/lE7KoiCWBpQAtMdBpdPy+hGlQ1
         /bWRWhAbnUr825RTheML9c+HSHLOBRqzpzRMbI1fS1f7oTM4Tw1FN1YQG0Fq4von94
         bd8J6YnAw9rIE8bOmHXnyOJUvePVxW46KVrTy0cecW3KUuZlMTe
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/5] mailmap: switch to opaque struct
Date:   Sun,  3 Jan 2021 21:18:46 +0000
Message-Id: <20210103211849.2691287-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently a mailmap is a simple sorted string list.  However, we'll soon
want to add additional data to our mailmap, and in order to do so
effectively, we'll need a struct of our own.  To do that, let's create a
struct mailmap and use that everywhere we're creating a mailmap.

Note that we no longer explicitly initialize our mailmaps, since
read_mailmap will do that for us.  We also don't need to explicitly set
the flag to strdup strings, since we've passed that argument when we
initialize the string list.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/blame.c         |  2 +-
 builtin/check-mailmap.c |  4 ++--
 builtin/commit.c        |  2 +-
 mailmap.c               | 20 +++++++++++++-------
 mailmap.h               | 14 +++++++++-----
 pretty.c                |  2 +-
 pretty.h                |  2 +-
 revision.c              |  2 +-
 revision.h              |  3 ++-
 shortlog.h              |  3 ++-
 10 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6f7e32411a..d48dbbd005 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -60,7 +60,7 @@ static int mark_ignored_lines;
 static struct date_mode blame_date_mode = { DATE_ISO8601 };
 static size_t blame_date_width;
 
-static struct string_list mailmap = STRING_LIST_INIT_NODUP;
+static struct mailmap mailmap;
 
 #ifndef DEBUG_BLAME
 #define DEBUG_BLAME 0
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index cdce144f3b..ad155e9092 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -15,7 +15,7 @@ static const struct option check_mailmap_options[] = {
 	OPT_END()
 };
 
-static void check_mailmap(struct string_list *mailmap, const char *contact)
+static void check_mailmap(struct mailmap *mailmap, const char *contact)
 {
 	const char *name, *mail;
 	size_t namelen, maillen;
@@ -39,7 +39,7 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
 int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct string_list mailmap = STRING_LIST_INIT_NODUP;
+	struct mailmap mailmap;
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, check_mailmap_options,
diff --git a/builtin/commit.c b/builtin/commit.c
index 505fe60956..2d69847c49 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1027,7 +1027,7 @@ static const char *find_author_by_nickname(const char *name)
 	struct rev_info revs;
 	struct commit *commit;
 	struct strbuf buf = STRBUF_INIT;
-	struct string_list mailmap = STRING_LIST_INIT_NODUP;
+	struct mailmap mailmap;
 	const char *av[20];
 	int ac = 0;
 
diff --git a/mailmap.c b/mailmap.c
index c9a538f4e2..d3287b409a 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -237,11 +237,14 @@ static int read_mailmap_blob(struct string_list *map,
 	return 0;
 }
 
-int read_mailmap(struct string_list *map, char **repo_abbrev)
+int read_mailmap(struct mailmap *mailmap, char **repo_abbrev)
 {
 	int err = 0;
+	struct string_list *map;
+
+	map = mailmap->mailmap = malloc(sizeof(*mailmap->mailmap));
+	string_list_init(map, 1);
 
-	map->strdup_strings = 1;
 	map->cmp = namemap_cmp;
 
 	if (!git_mailmap_blob && is_bare_repository())
@@ -254,11 +257,14 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 	return err;
 }
 
-void clear_mailmap(struct string_list *map)
+void clear_mailmap(struct mailmap *mailmap)
 {
+	struct string_list *map = mailmap->mailmap;
 	debug_mm("mailmap: clearing %d entries...\n", map->nr);
 	map->strdup_strings = 1;
 	string_list_clear_func(map, free_mailmap_entry);
+	string_list_clear(map, 1);
+	free(map);
 	debug_mm("mailmap: cleared\n");
 }
 
@@ -313,7 +319,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
 	return NULL;
 }
 
-int map_user(struct string_list *map,
+int map_user(struct mailmap *map,
 	     const char **email, size_t *emaillen,
 	     const char **name, size_t *namelen)
 {
@@ -324,7 +330,7 @@ int map_user(struct string_list *map,
 		 (int)*namelen, debug_str(*name),
 		 (int)*emaillen, debug_str(*email));
 
-	item = lookup_prefix(map, *email, *emaillen);
+	item = lookup_prefix(map->mailmap, *email, *emaillen);
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
 		if (me->namemap.nr) {
@@ -362,7 +368,7 @@ int map_user(struct string_list *map,
 	return 0;
 }
 
-int mailmap_entries(struct string_list *map)
+int mailmap_entries(struct mailmap *map)
 {
-	return map->nr;
+	return map->mailmap->nr;
 }
diff --git a/mailmap.h b/mailmap.h
index ff57b05a15..4cdce3b064 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -1,13 +1,17 @@
 #ifndef MAILMAP_H
 #define MAILMAP_H
 
-struct string_list;
+#include "string-list.h"
 
-int read_mailmap(struct string_list *map, char **repo_abbrev);
-void clear_mailmap(struct string_list *map);
-int mailmap_entries(struct string_list *map);
+struct mailmap {
+	struct string_list *mailmap;
+};
 
-int map_user(struct string_list *map,
+int read_mailmap(struct mailmap *map, char **repo_abbrev);
+void clear_mailmap(struct mailmap *map);
+int mailmap_entries(struct mailmap *map);
+
+int map_user(struct mailmap *map,
 			 const char **email, size_t *emaillen, const char **name, size_t *namelen);
 
 #endif
diff --git a/pretty.c b/pretty.c
index 43a0039870..0dc2c98e4a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -676,7 +676,7 @@ const char *repo_logmsg_reencode(struct repository *r,
 static int mailmap_name(const char **email, size_t *email_len,
 			const char **name, size_t *name_len)
 {
-	static struct string_list *mail_map;
+	static struct mailmap *mail_map;
 	if (!mail_map) {
 		mail_map = xcalloc(1, sizeof(*mail_map));
 		read_mailmap(mail_map, NULL);
diff --git a/pretty.h b/pretty.h
index 7ce6c0b437..15735a4c51 100644
--- a/pretty.h
+++ b/pretty.h
@@ -40,7 +40,7 @@ struct pretty_print_context {
 	struct reflog_walk_info *reflog_info;
 	struct rev_info *rev;
 	const char *output_encoding;
-	struct string_list *mailmap;
+	struct mailmap *mailmap;
 	int color;
 	struct ident_split *from_ident;
 	unsigned encode_email_headers:1;
diff --git a/revision.c b/revision.c
index 9dff845bed..848f43d88b 100644
--- a/revision.c
+++ b/revision.c
@@ -3659,7 +3659,7 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	return 0;
 }
 
-static int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
+static int commit_rewrite_person(struct strbuf *buf, const char *what, struct mailmap *mailmap)
 {
 	char *person, *endp;
 	size_t len, namelen, maillen;
diff --git a/revision.h b/revision.h
index 086ff10280..06bc127e90 100644
--- a/revision.h
+++ b/revision.h
@@ -7,6 +7,7 @@
 #include "notes.h"
 #include "pretty.h"
 #include "diff.h"
+#include "mailmap.h"
 #include "commit-slab-decl.h"
 
 /**
@@ -241,7 +242,7 @@ struct rev_info {
 	int		patch_name_max;
 	int		no_inline;
 	int		show_log_size;
-	struct string_list *mailmap;
+	struct mailmap *mailmap;
 
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
diff --git a/shortlog.h b/shortlog.h
index 64be879b24..9ebf7bbb9c 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -2,6 +2,7 @@
 #define SHORTLOG_H
 
 #include "string-list.h"
+#include "mailmap.h"
 
 struct commit;
 
@@ -25,7 +26,7 @@ struct shortlog {
 
 	char *common_repo_prefix;
 	int email;
-	struct string_list mailmap;
+	struct mailmap mailmap;
 	FILE *file;
 };
 
