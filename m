Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E751F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeAZToF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:44:05 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:43862
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752065AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=dLsTyVO1pGM8Qm1nuluUvske2+WGSef/H1XKg9eRdR8=;
        b=avmfSwJD7eRdi5MGUG5vD0U8SUtzcFulBkZOqKunwQ2+bmY9xg+eEP7Of/z/FnUe
        WH3mygYaEQyxshVWL9v9pfpA4ADSeP9NtUNHAx1badzD6MLGDMrrGxfFQzrG1K0CNRN
        amBKnT3xPBrB2l/kXoIEPu1myqBhkQhBdj9pAZlQ=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3b3f-26fceb2a-c1ef-447b-9013-caccccc052f9-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 17/24] cat-file: reuse printing logic from ref-filter
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jan 2018 19:43:40 +0000
X-SES-Outgoing: 2018.01.26-54.240.7.12
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
 builtin/cat-file.c | 52 +++++-----------------------------------------------
 ref-filter.c       | 30 +++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 50 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bd803856537b8..26b35bef4ba02 100644
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
-		strbuf_addstr(sb, oid_to_hex(&item->objectname));
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
@@ -282,22 +243,19 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 static void batch_object_write(const char *obj_name, struct batch_options *opt,
 			       struct expand_data *data)
 {
-	struct strbuf buf = STRBUF_INIT;
 	struct ref_array_item item = {0};
 
 	item.objectname = data->oid;
 	item.rest = data->rest;
 	item.start_of_request = obj_name;
 
-	if (populate_value(&item)) return;
-	data->type = item.type;
-
-	strbuf_expand(&buf, opt->format.format, expand_format, &item);
-	strbuf_addch(&buf, '\n');
-	batch_write(opt, buf.buf, buf.len);
-	strbuf_release(&buf);
+	if (show_ref_array_item(&item, &opt->format))
+		return;
+	if (!opt->buffer_output)
+		fflush(stdout);
 
 	if (opt->print_contents) {
+		data->type = item.type;
 		print_object_or_die(opt, data);
 		batch_write(opt, "\n", 1);
 	}
diff --git a/ref-filter.c b/ref-filter.c
index 906a5344949f7..bfbc7c83fdd47 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1522,7 +1522,21 @@ int populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (starts_with(name, "refname"))
+		if (is_cat) {
+			if (starts_with(name, "objectname"))
+				v->s = oid_to_hex(&ref->objectname);
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
@@ -2219,6 +2233,7 @@ int format_ref_array_item(struct ref_array_item *info,
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
+	int retval = 0;
 
 	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
@@ -2229,13 +2244,22 @@ int format_ref_array_item(struct ref_array_item *info,
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			append_literal(cp, sp, &state);
-		get_ref_atom_value(info,
+		if (is_cat) {
+			if(get_ref_atom_value(info,
+				parse_ref_filter_atom(format, valid_cat_file_atom,
+					ARRAY_SIZE(valid_cat_file_atom), sp + 2, ep),
+					&atomv))
+				return -1;
+		} else
+			get_ref_atom_value(info,
 				   parse_ref_filter_atom(format, valid_atom,
 							 ARRAY_SIZE(valid_atom),
 							 sp + 2, ep),
 				   &atomv);
 		atomv->handler(atomv, &state);
 	}
+	if (is_cat && strlen(format->format) == 0)
+		retval = check_and_fill_for_cat(info);
 	if (*cp) {
 		sp = cp + strlen(cp);
 		append_literal(cp, sp, &state);
@@ -2249,7 +2273,7 @@ int format_ref_array_item(struct ref_array_item *info,
 		die(_("format: %%(end) atom missing"));
 	strbuf_addbuf(final_buf, &state.stack->output);
 	pop_stack_element(&state.stack);
-	return 0;
+	return retval;
 }
 
 int show_ref_array_item(struct ref_array_item *info,

--
https://github.com/git/git/pull/452
