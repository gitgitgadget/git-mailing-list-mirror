Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 097D41F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbeBLIJj (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:09:39 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:58618
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932984AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=BdENrxWuGruYkcXRN84o+ApE4oUCe2n6xKnSitwMvBs=;
        b=TDMgqiiFdojvmBHsEUADgoavMtOP5t9s+85tzGmStXlMf6f8R8ohv+BRsJusQ9Ej
        u99DTmg2Y6H2FTmpnvL6bTsvkdRWVpi3HCbVOdTWNZKCWzc38ixqQNWTRW4qg6AccqV
        52xBuOr142Oxy/nKqdWHY62O8d1Ljrdcdh3M8CIo=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f4373-5a54682e-c1b8-4408-9476-bea5551b992c-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 18/23] cat-file: reuse printing logic from ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reuse code from ref-filter to print resulting message.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 51 ++++-----------------------------------------------
 ref-filter.c       | 21 +++++++++++++++++++--
 2 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 273b4038e3893..21007995c5ac6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -176,45 +176,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	return 0;
 }
 
-static int is_atom(const char *atom, const char *s, int slen)
-{
-	int alen = strlen(atom);
-	return alen == slen && !memcmp(atom, s, alen);
-}
-
-static void expand_atom(struct strbuf *sb, const char *atom, int len,
-			 struct ref_array_item *item)
-{
-	if (is_atom("objectname", atom, len))
-		strbuf_addstr(sb, oid_to_hex(&item->oid));
-	else if (is_atom("objecttype", atom, len))
-		strbuf_addstr(sb, typename(item->type));
-	else if (is_atom("objectsize", atom, len))
-		strbuf_addf(sb, "%lu", item->size);
-	else if (is_atom("objectsize:disk", atom, len))
-		strbuf_addf(sb, "%"PRIuMAX, (uintmax_t)item->disk_size);
-	else if (is_atom("rest", atom, len)) {
-		if (item->rest)
-			strbuf_addstr(sb, item->rest);
-	} else if (is_atom("deltabase", atom, len))
-		strbuf_addstr(sb, oid_to_hex(item->delta_base_oid));
-}
-
-static size_t expand_format(struct strbuf *sb, const char *start, void *data)
-{
-	const char *end;
-	struct ref_array_item *item = data;
-
-	if (*start != '(')
-		return 0;
-	end = strchr(start + 1, ')');
-	if (!end)
-		die("format element '%s' does not end in ')'", start);
-
-	expand_atom(sb, start + 1, end - start - 1, item);
-	return end - start + 1;
-}
-
 static void batch_write(struct batch_options *opt, const void *data, int len)
 {
 	if (opt->buffer_output) {
@@ -282,23 +243,19 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 static void batch_object_write(const char *obj_name, struct batch_options *opt,
 			       struct expand_data *data)
 {
-	struct strbuf buf = STRBUF_INIT;
 	struct ref_array_item item = {0};
 
 	item.oid = data->oid;
 	item.rest = data->rest;
 	item.objectname = obj_name;
 
-	if (populate_value(&item))
+	if (show_ref_array_item(&item, &opt->format))
 		return;
-
-	data->type = item.type;
-	strbuf_expand(&buf, opt->format.format, expand_format, &item);
-	strbuf_addch(&buf, '\n');
-	batch_write(opt, buf.buf, buf.len);
-	strbuf_release(&buf);
+	if (!opt->buffer_output)
+		fflush(stdout);
 
 	if (opt->print_contents) {
+		data->type = item.type;
 		print_object_or_die(opt, data);
 		batch_write(opt, "\n", 1);
 	}
diff --git a/ref-filter.c b/ref-filter.c
index ee311d51ff81c..eb53b0babdb83 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1465,7 +1465,21 @@ int populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (starts_with(name, "refname"))
+		if (cat_file_info.is_cat_file) {
+			if (starts_with(name, "objectname"))
+				v->s = oid_to_hex(&ref->oid);
+			else if (starts_with(name, "objecttype"))
+				v->s = typename(ref->type);
+			else if (starts_with(name, "objectsize")) {
+				v->s = xstrfmt("%lu", ref->size);
+			} else if (starts_with(name, "objectsize:disk")) {
+				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)ref->disk_size);
+			} else if (starts_with(name, "rest"))
+				v->s = ref->rest;
+			else if (starts_with(name, "deltabase"))
+				v->s = xstrdup(oid_to_hex(ref->delta_base_oid));
+			continue;
+		} else if (starts_with(name, "refname"))
 			refname = get_refname(atom, ref);
 		else if (starts_with(name, "symref"))
 			refname = get_symref(atom, ref);
@@ -2207,6 +2221,7 @@ int format_ref_array_item(struct ref_array_item *info,
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	int retval = 0;
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
@@ -2223,6 +2238,8 @@ int format_ref_array_item(struct ref_array_item *info,
 			return -1;
 		atomv->handler(atomv, &state);
 	}
+	if (cat_file_info.is_cat_file && strlen(format->format) == 0)
+		retval = check_and_fill_for_cat(info);
 	if (*cp) {
 		sp = cp + strlen(cp);
 		append_literal(cp, sp, &state);
@@ -2236,7 +2253,7 @@ int format_ref_array_item(struct ref_array_item *info,
 		die(_("format: %%(end) atom missing"));
 	strbuf_addbuf(final_buf, &state.stack->output);
 	pop_stack_element(&state.stack);
-	return 0;
+	return retval;
 }
 
 int show_ref_array_item(struct ref_array_item *info,

--
https://github.com/git/git/pull/452
