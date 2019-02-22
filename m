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
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B0920248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfBVQFt (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:05:49 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:44892
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbfBVQFs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=F6iVVCro+xUkL54cvQwGTe37xwISJ+94frnoqk+q+nw=;
        b=DhCYc/dhi0LpCOWwVi0fttUlSbowflI/9pLyFLULs8g9v7/UirJCJl6zBM0EoM6x
        IBGcfRGZkxrVcid1nqc+9U2nNuvp5gRWS2gyUyJ5oar8L2icYt65EzxuumeN7nR5Pjp
        xNG300C2yWdVaeZjS0ibMii/BeJegp1f2S1EBN58=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a72-d28a8c0c-7594-4330-8c1c-e497622a8fd9-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 17/20] cat-file: reuse ref-filter formatting logic
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start using general ref-filter formatting logic in cat-file.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 111 ++++++++-------------------------------------
 ref-filter.c       |  39 +++++++++++-----
 ref-filter.h       |   4 +-
 3 files changed, 49 insertions(+), 105 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 6c0cbf71f0f0c..6fa100d1bea72 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -28,9 +28,7 @@ struct batch_options {
 };
 
 static const char *force_path;
-/* Next 3 vars will be deleted at the end of this patch */
-static int mark_query;
-static int skip_object_info;
+/* global rest will be deleted at the end of this patch */
 static const char *rest;
 
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
@@ -169,84 +167,29 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	return 0;
 }
 
-static int is_atom(const char *atom, const char *s, int slen)
-{
-	int alen = strlen(atom);
-	return alen == slen && !memcmp(atom, s, alen);
-}
-
-static void expand_atom(struct strbuf *sb, const char *atom, int len,
-			void *vdata)
-{
-	struct expand_data *data = vdata;
-
-	if (is_atom("objectname", atom, len)) {
-		if (!mark_query)
-			strbuf_addstr(sb, oid_to_hex(&data->oid));
-	} else if (is_atom("objecttype", atom, len)) {
-		if (mark_query)
-			data->info.typep = &data->type;
-		else
-			strbuf_addstr(sb, type_name(data->type));
-	} else if (is_atom("objectsize", atom, len)) {
-		if (mark_query)
-			data->info.sizep = &data->size;
-		else
-			strbuf_addf(sb, "%"PRIuMAX , (uintmax_t)data->size);
-	} else if (is_atom("objectsize:disk", atom, len)) {
-		if (mark_query)
-			data->info.disk_sizep = &data->disk_size;
-		else
-			strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)data->disk_size);
-	} else if (is_atom("rest", atom, len)) {
-		if (rest)
-			strbuf_addstr(sb, rest);
-	} else if (is_atom("deltabase", atom, len)) {
-		if (mark_query)
-			data->info.delta_base_sha1 = data->delta_base_oid.hash;
-		else
-			strbuf_addstr(sb,
-				      oid_to_hex(&data->delta_base_oid));
-	} else
-		die("unknown format element: %.*s", len, atom);
-}
-
-static size_t expand_format(struct strbuf *sb, const char *start, void *data)
-{
-	const char *end;
-
-	if (*start != '(')
-		return 0;
-	end = strchr(start + 1, ')');
-	if (!end)
-		die("format element '%s' does not end in ')'", start);
-
-	expand_atom(sb, start + 1, end - start - 1, data);
-
-	return end - start + 1;
-}
-
 static void batch_object_write(const char *obj_name,
 			       struct strbuf *scratch,
 			       struct batch_options *opt,
 			       struct expand_data *data)
 {
-	if (!skip_object_info &&
-	    oid_object_info_extended(the_repository, &data->oid, &data->info,
-				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
-		printf("%s missing\n",
-		       obj_name ? obj_name : oid_to_hex(&data->oid));
+	struct strbuf err = STRBUF_INIT;
+	struct ref_array_item item = { data->oid };
+	item.request_rest = rest;
+	item.check_obj = 1;
+	strbuf_reset(scratch);
+
+	if (format_ref_array_item(&item, &opt->format, scratch, &err)) {
+		printf("%s missing\n", obj_name ? obj_name : oid_to_hex(&item.oid));
 		fflush(stdout);
 		return;
 	}
 
-	strbuf_reset(scratch);
-	strbuf_expand(scratch, opt->format.format, expand_format, data);
 	strbuf_addch(scratch, '\n');
 	write_or_die(1, scratch->buf, scratch->len);
+	strbuf_release(&err);
 
 	if (opt->print_contents) {
-		print_object_or_die(data, opt->cmdmode, opt->buffer_output, rest);
+		print_raw_object_or_die(&item, opt->cmdmode, opt->buffer_output);
 		write_or_die(1, "\n", 1);
 	}
 }
@@ -367,30 +310,7 @@ static int batch_objects(struct batch_options *opt)
 	int save_warning;
 	int retval = 0;
 	int is_rest = strstr(opt->format.format, "%(rest)") != NULL || opt->cmdmode;
-
-	/*
-	 * Expand once with our special mark_query flag, which will prime the
-	 * object_info to be handed to oid_object_info_extended for each
-	 * object.
-	 */
 	memset(&data, 0, sizeof(data));
-	mark_query = 1;
-	strbuf_expand(&output, opt->format.format, expand_format, &data);
-	mark_query = 0;
-	strbuf_release(&output);
-
-	if (opt->all_objects) {
-		struct object_info empty = OBJECT_INFO_INIT;
-		if (!memcmp(&data.info, &empty, sizeof(empty)))
-			skip_object_info = 1;
-	}
-
-	/*
-	 * If we are printing out the object, then always fill in the type,
-	 * since we will want to decide whether or not to stream.
-	 */
-	if (opt->print_contents)
-		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
 		struct object_cb_data cb;
@@ -581,6 +501,15 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	if (!batch.format.format)
 		batch.format.format = "%(objectname) %(objecttype) %(objectsize)";
+	if (batch.print_contents) {
+		const char *contents = "%(raw)";
+		char *format = (char *)calloc(strlen(batch.format.format) + strlen(contents) + 1, 1);
+		memcpy(format, batch.format.format, strlen(batch.format.format));
+		memcpy(format + strlen(format), contents, strlen(contents));
+		batch.format.format = format;
+	}
+	if (verify_ref_format(&batch.format))
+		usage_with_options(cat_file_usage, options);
 
 	if (batch.enabled)
 		return batch_objects(&batch);
diff --git a/ref-filter.c b/ref-filter.c
index bb963a4110fb2..45d163246e3f3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2231,6 +2231,7 @@ int format_ref_array_item(struct ref_array_item *info,
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	struct object_info empty = OBJECT_INFO_INIT;
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
@@ -2253,6 +2254,11 @@ int format_ref_array_item(struct ref_array_item *info,
 		sp = cp + strlen(cp);
 		append_literal(cp, sp, &state);
 	}
+	if (info->check_obj &&
+	    oid_object_info_extended(the_repository, &info->oid, &empty,
+				     OBJECT_INFO_LOOKUP_REPLACE))
+		return strbuf_addf_ret(error_buf, -1, _("%s missing\n"),
+				       oid_to_hex(&info->oid));
 	if (format->need_color_reset_at_eol) {
 		struct atom_value resetv;
 		resetv.s = GIT_COLOR_RESET;
@@ -2381,23 +2387,32 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-void print_object_or_die(struct expand_data *data, int cmdmode,
-			 int buffered, const char *rest)
+/*
+ * TODO: add support of %(*raw). Need to switch between oi and oi_deref for that.
+ * TODO: split logic and printing (as it is done in format_ref_array_item and
+ * show_ref_array_item).
+ * TODO: rewrite print_object_or_die so that it will reuse result of general
+ * oid_object_info_extended call.
+ * TODO: embed this function into general ref_filter flow, make it static.
+ * That will allow other ref-filter users to print raw file
+ * (now only cat_file can use it).
+ */
+void print_raw_object_or_die(struct ref_array_item *item, int cmdmode, int buffered)
 {
-	const struct object_id *oid = &data->oid;
+	const struct object_id *oid = &oi.oid;
 	unsigned long size;
 	char *contents;
 
-	assert(data->info.typep);
+	assert(oi.info.typep);
 
-	if (data->type != OBJ_BLOB) {
+	if (oi.type != OBJ_BLOB) {
 		enum object_type type;
 		contents = read_object_file(oid, &type, &size);
 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
-		if (type != data->type)
+		if (type != oi.type)
 			die("object %s changed type!?", oid_to_hex(oid));
-		if (data->info.sizep && size != data->size)
+		if (oi.info.sizep && size != oi.size)
 			die("object %s changed size!?", oid_to_hex(oid));
 
 		write_or_die(1, contents, size);
@@ -2413,19 +2428,19 @@ void print_object_or_die(struct expand_data *data, int cmdmode,
 		return;
 	}
 
-	if (!rest)
+	if (!item->request_rest)
 		die("missing path for '%s'", oid_to_hex(oid));
 
 	if (cmdmode == 'w') {
-		if (filter_object(rest, 0100644, oid, &contents, &size))
-			die("could not convert '%s' %s", oid_to_hex(oid), rest);
+		if (filter_object(item->request_rest, 0100644, oid, &contents, &size))
+			die("could not convert '%s' %s", oid_to_hex(oid), item->request_rest);
 	} else if (cmdmode == 'c') {
 		enum object_type type;
-		if (!textconv_object(the_repository, rest, 0100644, oid, 1,
+		if (!textconv_object(the_repository, item->request_rest, 0100644, oid, 1,
 				     &contents, &size))
 			contents = read_object_file(oid, &type, &size);
 		if (!contents)
-			die("could not convert '%s' %s", oid_to_hex(oid), rest);
+			die("could not convert '%s' %s", oid_to_hex(oid), item->request_rest);
 	} else
 		BUG("invalid cmdmode: %c", cmdmode);
 	write_or_die(1, contents, size);
diff --git a/ref-filter.h b/ref-filter.h
index 3422f39e64b5b..e8cd97a49632c 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -42,6 +42,7 @@ struct ref_array_item {
 	struct commit *commit;
 	struct atom_value *value;
 	const char *request_rest;
+	int check_obj;
 	char refname[FLEX_ARRAY];
 };
 
@@ -157,7 +158,6 @@ struct ref_array_item *ref_array_push(struct ref_array *array,
 				      const char *refname,
 				      const struct object_id *oid);
 
-void print_object_or_die(struct expand_data *data, int cmdmode,
-			 int buffered, const char *rest);
+void print_raw_object_or_die(struct ref_array_item *item, int cmdmode, int buffered);
 
 #endif /*  REF_FILTER_H  */

--
https://github.com/git/git/pull/568
