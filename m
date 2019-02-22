Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4DC20248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfBVQFt (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:05:49 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:41308
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727145AbfBVQFs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=nI4xNrV9odkN5qeCI6Lq6X6D7q9HrKyjucidS8bLDqI=;
        b=P+C5TNInw+8aMUv5hlX5k9WXZ9Rx8A5E2RLM7/BeB3yOjq4NBfvcXybwk8GMrrro
        JAPz1RMepQQow/YXl4JhwwJNXyPF/vvrdFNRT4rol12Ub460WrALe4k3AgVfMuenUon
        ioL4TGj/u+lUwqTPkvkEHXDBXHPGi/+ikXRpHhrw=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a72-81347643-bf78-47fe-8cee-d22ce2a18db0-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 18/20] cat-file: get rid of expand_data
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up cat-file after moving all formatting logic
to ref-filter.
We do not need to use struct expand_data anymore.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 43 +++++++++++++++++++++++--------------------
 ref-filter.c       | 11 ++++++++++-
 ref-filter.h       | 12 ------------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 6fa100d1bea72..ee7557e1e0975 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -28,8 +28,6 @@ struct batch_options {
 };
 
 static const char *force_path;
-/* global rest will be deleted at the end of this patch */
-static const char *rest;
 
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			int unknown_type)
@@ -170,16 +168,19 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 static void batch_object_write(const char *obj_name,
 			       struct strbuf *scratch,
 			       struct batch_options *opt,
-			       struct expand_data *data)
+			       struct ref_array_item *item)
 {
 	struct strbuf err = STRBUF_INIT;
-	struct ref_array_item item = { data->oid };
-	item.request_rest = rest;
-	item.check_obj = 1;
+	/*
+	 * TODO: get rid of memory leak. The best way is to reuse ref_array
+	 * in batch_objects and then call ref_array_clear.
+	 */
+	item->value = 0;
+	item->check_obj = 1;
 	strbuf_reset(scratch);
 
-	if (format_ref_array_item(&item, &opt->format, scratch, &err)) {
-		printf("%s missing\n", obj_name ? obj_name : oid_to_hex(&item.oid));
+	if (format_ref_array_item(item, &opt->format, scratch, &err)) {
+		printf("%s missing\n", obj_name ? obj_name : oid_to_hex(&item->oid));
 		fflush(stdout);
 		return;
 	}
@@ -189,7 +190,7 @@ static void batch_object_write(const char *obj_name,
 	strbuf_release(&err);
 
 	if (opt->print_contents) {
-		print_raw_object_or_die(&item, opt->cmdmode, opt->buffer_output);
+		print_raw_object_or_die(item, opt->cmdmode, opt->buffer_output);
 		write_or_die(1, "\n", 1);
 	}
 }
@@ -197,14 +198,14 @@ static void batch_object_write(const char *obj_name,
 static void batch_one_object(const char *obj_name,
 			     struct strbuf *scratch,
 			     struct batch_options *opt,
-			     struct expand_data *data)
+			     struct ref_array_item *item)
 {
 	struct object_context ctx;
 	int flags = opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
 	enum get_oid_result result;
 
 	result = get_oid_with_context(the_repository, obj_name,
-				      flags, &data->oid, &ctx);
+				      flags, &item->oid, &ctx);
 	if (result != FOUND) {
 		switch (result) {
 		case MISSING_OBJECT:
@@ -242,12 +243,12 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
-	batch_object_write(obj_name, scratch, opt, data);
+	batch_object_write(obj_name, scratch, opt, item);
 }
 
 struct object_cb_data {
 	struct batch_options *opt;
-	struct expand_data *expand;
+	struct ref_array_item *item;
 	struct oidset *seen;
 	struct strbuf *scratch;
 };
@@ -255,8 +256,8 @@ struct object_cb_data {
 static int batch_object_cb(const struct object_id *oid, void *vdata)
 {
 	struct object_cb_data *data = vdata;
-	oidcpy(&data->expand->oid, oid);
-	batch_object_write(NULL, data->scratch, data->opt, data->expand);
+	oidcpy(&data->item->oid, oid);
+	batch_object_write(NULL, data->scratch, data->opt, data->item);
 	return 0;
 }
 
@@ -306,20 +307,20 @@ static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
-	struct expand_data data;
 	int save_warning;
 	int retval = 0;
 	int is_rest = strstr(opt->format.format, "%(rest)") != NULL || opt->cmdmode;
-	memset(&data, 0, sizeof(data));
 
 	if (opt->all_objects) {
 		struct object_cb_data cb;
+		struct ref_array_item item;
+		memset(&item, 0, sizeof(item));
 
 		if (repository_format_partial_clone)
 			warning("This repository has extensions.partialClone set. Some objects may not be loaded.");
 
 		cb.opt = opt;
-		cb.expand = &data;
+		cb.item = &item;
 		cb.scratch = &output;
 
 		if (opt->unordered) {
@@ -358,6 +359,8 @@ static int batch_objects(struct batch_options *opt)
 	warn_on_object_refname_ambiguity = 0;
 
 	while (strbuf_getline(&input, stdin) != EOF) {
+		struct ref_array_item item;
+		memset(&item, 0, sizeof(item));
 		if (is_rest) {
 			/*
 			 * Split at first whitespace, tying off the beginning
@@ -369,10 +372,10 @@ static int batch_objects(struct batch_options *opt)
 				while (*p && strchr(" \t", *p))
 					*p++ = '\0';
 			}
-			rest = p;
+			item.request_rest = p;
 		}
 
-		batch_one_object(input.buf, &output, opt, &data);
+		batch_one_object(input.buf, &output, opt, &item);
 	}
 
 	strbuf_release(&input);
diff --git a/ref-filter.c b/ref-filter.c
index 45d163246e3f3..3f9bd2fc6a76a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -65,7 +65,16 @@ struct refname_atom {
 	int lstrip, rstrip;
 };
 
-static struct expand_data oi, oi_deref;
+static struct expand_data {
+	struct object_id oid;
+	enum object_type type;
+	unsigned long size;
+	off_t disk_size;
+	struct object_id delta_base_oid;
+	void *content;
+
+	struct object_info info;
+} oi, oi_deref;
 
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
diff --git a/ref-filter.h b/ref-filter.h
index e8cd97a49632c..237eed9818949 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -5,7 +5,6 @@
 #include "refs.h"
 #include "commit.h"
 #include "parse-options.h"
-#include "object-store.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -75,17 +74,6 @@ struct ref_filter {
 		verbose;
 };
 
-struct expand_data {
-	struct object_id oid;
-	enum object_type type;
-	unsigned long size;
-	off_t disk_size;
-	struct object_id delta_base_oid;
-	void *content;
-
-	struct object_info info;
-};
-
 struct ref_format {
 	/*
 	 * Set these to define the format; make sure you call

--
https://github.com/git/git/pull/568
