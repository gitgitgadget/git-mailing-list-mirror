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
	by dcvr.yhbt.net (Postfix) with ESMTP id 535561F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbeBLIJl (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:09:41 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:51916
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932902AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=8AAc0ShAvJBnKFFoqUxZGfHDHtzzOBcxQZrZfpTXA3M=;
        b=CSrw9HXELJ+bqo8g3C6Y4PzdQDdNZDdRafhWZAI7cLuU/l/F3mwlocp2BqrBZxUZ
        UIXQBDy9IEi3yV9KoF76LOebEsKSNPIRgxT6Bg0BUvQ2/KGavDSpVyC7F/WM6szMSsZ
        oJk9lu2CJmu2g/UqIjxmvM3PYGRmxytaWXmNbWe0=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f4311-ab635cac-1d48-47ee-90e1-f178f134db1c-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 02/23] ref-filter: add return value to some functions
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add return flag to format_ref_array_item(), show_ref_array_item(),
get_ref_array_info() and populate_value() for further using.
Need it to handle situations when item is broken but we can not invoke
die() because we are in batch mode and all items need to be processed.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 37 ++++++++++++++++++++++++-------------
 ref-filter.h | 14 ++++++++++----
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index d04295e33448e..9ed5e66066a7a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1356,8 +1356,9 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 
 /*
  * Parse the object referred by ref, and grab needed value.
+ * Return 0 if everything was successful, -1 otherwise.
  */
-static void populate_value(struct ref_array_item *ref)
+static int populate_value(struct ref_array_item *ref)
 {
 	void *buf;
 	struct object *obj;
@@ -1482,7 +1483,7 @@ static void populate_value(struct ref_array_item *ref)
 		}
 	}
 	if (used_atom_cnt <= i)
-		return;
+		return 0;
 
 	buf = get_obj(&ref->objectname, &obj, &size, &eaten);
 	if (!buf)
@@ -1501,7 +1502,7 @@ static void populate_value(struct ref_array_item *ref)
 	 * object, we are done.
 	 */
 	if (!need_tagged || (obj->type != OBJ_TAG))
-		return;
+		return 0;
 
 	/*
 	 * If it is a tag object, see if we use a value that derefs
@@ -1525,19 +1526,24 @@ static void populate_value(struct ref_array_item *ref)
 	grab_values(ref->value, 1, obj, buf, size);
 	if (!eaten)
 		free(buf);
+
+	return 0;
 }
 
 /*
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
+ * Return 0 if everything was successful, -1 otherwise.
  */
-static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom_value **v)
+static int get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom_value **v)
 {
+	int retval = 0;
 	if (!ref->value) {
-		populate_value(ref);
+		retval = populate_value(ref);
 		fill_missing_values(ref->value);
 	}
 	*v = &ref->value[atom];
+	return retval;
 }
 
 /*
@@ -2122,7 +2128,7 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
-void format_ref_array_item(struct ref_array_item *info,
+int format_ref_array_item(struct ref_array_item *info,
 			   const struct ref_format *format,
 			   struct strbuf *final_buf)
 {
@@ -2138,9 +2144,10 @@ void format_ref_array_item(struct ref_array_item *info,
 		ep = strchr(sp, ')');
 		if (cp < sp)
 			append_literal(cp, sp, &state);
-		get_ref_atom_value(info,
-				   parse_ref_filter_atom(format, sp + 2, ep),
-				   &atomv);
+		if (get_ref_atom_value(info,
+				       parse_ref_filter_atom(format, sp + 2, ep),
+				       &atomv))
+			return -1;
 		atomv->handler(atomv, &state);
 	}
 	if (*cp) {
@@ -2156,17 +2163,21 @@ void format_ref_array_item(struct ref_array_item *info,
 		die(_("format: %%(end) atom missing"));
 	strbuf_addbuf(final_buf, &state.stack->output);
 	pop_stack_element(&state.stack);
+	return 0;
 }
 
-void show_ref_array_item(struct ref_array_item *info,
+int show_ref_array_item(struct ref_array_item *info,
 			 const struct ref_format *format)
 {
 	struct strbuf final_buf = STRBUF_INIT;
+	int retval = format_ref_array_item(info, format, &final_buf);
 
-	format_ref_array_item(info, format, &final_buf);
-	fwrite(final_buf.buf, 1, final_buf.len, stdout);
+	if (!retval) {
+		fwrite(final_buf.buf, 1, final_buf.len, stdout);
+		putchar('\n');
+	}
 	strbuf_release(&final_buf);
-	putchar('\n');
+	return retval;
 }
 
 void pretty_print_ref(const char *name, const unsigned char *sha1,
diff --git a/ref-filter.h b/ref-filter.h
index 0d98342b34319..b75c8ac45248e 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -109,12 +109,18 @@ void ref_array_clear(struct ref_array *array);
 int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
-/*  Based on the given format and quote_style, fill the strbuf */
-void format_ref_array_item(struct ref_array_item *info,
+/*
+ * Based on the given format and quote_style, fill the strbuf.
+ * Return 0 if everything was successful, -1 otherwise (and strbuf remains empty)
+ */
+int format_ref_array_item(struct ref_array_item *info,
 			   const struct ref_format *format,
 			   struct strbuf *final_buf);
-/*  Print the ref using the given format and quote_style */
-void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
+/*
+ * Print the ref using the given format and quote_style.
+ * Return 0 if everything was successful, -1 otherwise.
+ */
+int show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
 /*  Parse a single sort specifier and add it to the list */
 void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
 /*  Callback function for parsing the sort option */

--
https://github.com/git/git/pull/452
