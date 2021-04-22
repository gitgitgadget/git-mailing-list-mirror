Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CEAC43460
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 01:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBAD61424
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 01:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbhDVBIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 21:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbhDVBIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 21:08:05 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC7AC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 18:07:27 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:527b:9dff:fe2b:180a])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 6336D80591;
        Wed, 21 Apr 2021 21:07:26 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson " <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 1/3] fast-export, fast-import: make stylistic changes
Date:   Wed, 21 Apr 2021 19:06:57 -0600
Message-Id: <20210422010659.2498280-2-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422010659.2498280-1-lukeshu@lukeshu.com>
References: <20210422010659.2498280-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

In order to keep the diffs in the next two commits small easy-to-read,
go ahead and make some essentially stylistic changes to fast-export and
fast-import.  Rename some variables and struct members, move some code
arround, introduce new temporary variables for clarity.  That sort of
thing.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 builtin/fast-export.c | 19 ++++++++++++-------
 builtin/fast-import.c | 41 +++++++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 85a76e0ef8..e697f87172 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -767,13 +767,15 @@ static void handle_tail(struct object_array *commits, struct rev_info *revs,
 	}
 }
 
-static void handle_tag(const char *name, struct tag *tag)
+static void handle_tag(const char *refname, struct tag *tag)
 {
 	unsigned long size;
 	enum object_type type;
 	char *buf;
-	const char *tagger, *tagger_end, *message;
+	const char *message;
 	size_t message_size = 0;
+	const char *tagname;
+	const char *tagger, *tagger_end;
 	struct object *tagged;
 	int tagged_mark;
 	struct commit *p;
@@ -795,11 +797,13 @@ static void handle_tag(const char *name, struct tag *tag)
 	buf = read_object_file(&tag->object.oid, &type, &size);
 	if (!buf)
 		die("could not read tag %s", oid_to_hex(&tag->object.oid));
+
 	message = memmem(buf, size, "\n\n", 2);
 	if (message) {
 		message += 2;
 		message_size = strlen(message);
 	}
+
 	tagger = memmem(buf, message ? message - buf : size, "\ntagger ", 8);
 	if (!tagger) {
 		if (fake_missing_tagger)
@@ -816,7 +820,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	}
 
 	if (anonymize) {
-		name = anonymize_refname(name);
+		refname = anonymize_refname(refname);
 		if (message) {
 			static struct hashmap tags;
 			message = anonymize_str(&tags, anonymize_tag,
@@ -870,7 +874,7 @@ static void handle_tag(const char *name, struct tag *tag)
 				p = rewrite_commit((struct commit *)tagged);
 				if (!p) {
 					printf("reset %s\nfrom %s\n\n",
-					       name, oid_to_hex(&null_oid));
+					       refname, oid_to_hex(&null_oid));
 					free(buf);
 					return;
 				}
@@ -884,10 +888,11 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	if (tagged->type == OBJ_TAG) {
 		printf("reset %s\nfrom %s\n\n",
-		       name, oid_to_hex(&null_oid));
+		       refname, oid_to_hex(&null_oid));
 	}
-	skip_prefix(name, "refs/tags/", &name);
-	printf("tag %s\n", name);
+	tagname = refname;
+	skip_prefix(tagname, "refs/tags/", &tagname);
+	printf("tag %s\n", tagname);
 	if (mark_tags) {
 		mark_next_object(&tag->object);
 		printf("mark :%"PRIu32"\n", last_idnum);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3afa81cf9a..43287f929f 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -127,7 +127,7 @@ struct branch {
 
 struct tag {
 	struct tag *next_tag;
-	const char *name;
+	const char *refname;
 	unsigned int pack_id;
 	struct object_id oid;
 };
@@ -375,7 +375,7 @@ static void write_crash_report(const char *err)
 		for (tg = first_tag; tg; tg = tg->next_tag) {
 			fputs(oid_to_hex(&tg->oid), rpt);
 			fputc(' ', rpt);
-			fputs(tg->name, rpt);
+			fputs(tg->refname, rpt);
 			fputc('\n', rpt);
 		}
 	}
@@ -1654,7 +1654,6 @@ static void dump_tags(void)
 {
 	static const char *msg = "fast-import";
 	struct tag *t;
-	struct strbuf ref_name = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
 
@@ -1664,10 +1663,7 @@ static void dump_tags(void)
 		goto cleanup;
 	}
 	for (t = first_tag; t; t = t->next_tag) {
-		strbuf_reset(&ref_name);
-		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
-
-		if (ref_transaction_update(transaction, ref_name.buf,
+		if (ref_transaction_update(transaction, t->refname,
 					   &t->oid, NULL, 0, msg, &err)) {
 			failure |= error("%s", err.buf);
 			goto cleanup;
@@ -1678,7 +1674,6 @@ static void dump_tags(void)
 
  cleanup:
 	ref_transaction_free(transaction);
-	strbuf_release(&ref_name);
 	strbuf_release(&err);
 }
 
@@ -2783,6 +2778,8 @@ static void parse_new_commit(const char *arg)
 static void parse_new_tag(const char *arg)
 {
 	static struct strbuf msg = STRBUF_INIT;
+	static struct strbuf refname = STRBUF_INIT;
+	char *tagname;
 	const char *from;
 	char *tagger;
 	struct branch *s;
@@ -2792,17 +2789,15 @@ static void parse_new_tag(const char *arg)
 	enum object_type type;
 	const char *v;
 
-	t = mem_pool_alloc(&fi_mem_pool, sizeof(struct tag));
-	memset(t, 0, sizeof(struct tag));
-	t->name = mem_pool_strdup(&fi_mem_pool, arg);
-	if (last_tag)
-		last_tag->next_tag = t;
-	else
-		first_tag = t;
-	last_tag = t;
+	tagname = xstrdup(arg);
+
 	read_next_command();
 	parse_mark();
 
+	strbuf_reset(&refname);
+	strbuf_addstr(&refname, "refs/tags/");
+	strbuf_addstr(&refname, tagname);
+
 	/* from ... */
 	if (!skip_prefix(command_buf.buf, "from ", &from))
 		die("Expected from command, got %s", command_buf.buf);
@@ -2850,13 +2845,23 @@ static void parse_new_tag(const char *arg)
 		    "object %s\n"
 		    "type %s\n"
 		    "tag %s\n",
-		    oid_to_hex(&oid), type_name(type), t->name);
+		    oid_to_hex(&oid), type_name(type), tagname);
 	if (tagger)
 		strbuf_addf(&new_data,
 			    "tagger %s\n", tagger);
 	strbuf_addch(&new_data, '\n');
 	strbuf_addbuf(&new_data, &msg);
 	free(tagger);
+	free(tagname);
+
+	t = mem_pool_alloc(&fi_mem_pool, sizeof(struct tag));
+	memset(t, 0, sizeof(struct tag));
+	t->refname = mem_pool_strdup(&fi_mem_pool, refname.buf);
+	if (last_tag)
+		last_tag->next_tag = t;
+	else
+		first_tag = t;
+	last_tag = t;
 
 	if (store_object(OBJ_TAG, &new_data, NULL, &t->oid, next_mark))
 		t->pack_id = MAX_PACK_ID;
@@ -2895,7 +2900,7 @@ static void parse_reset_branch(const char *arg)
 		 */
 		struct tag *t, *prev = NULL;
 		for (t = first_tag; t; t = t->next_tag) {
-			if (!strcmp(t->name, tag_name))
+			if (!strcmp(t->refname, b->name))
 				break;
 			prev = t;
 		}
-- 
2.31.1

