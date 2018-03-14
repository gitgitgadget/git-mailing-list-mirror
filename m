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
	by dcvr.yhbt.net (Postfix) with ESMTP id 25D2C1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 19:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeCNTEX (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 15:04:23 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:54056
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751478AbeCNTEV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Mar 2018 15:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1521054260;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=91lYevg2G8UdufJ+DeH/VYb1z0fe1VQrYAUW0/Gv/zA=;
        b=U7J+m7Ws1keRjv4NFEg+vLRr3ZLafQH//jCFPZv1vesumUvPstEwoIO4VQn6G+e/
        Wd7uQWzRWGa8kKLJ1k9yAuzQRL+31Mw+qNafAh/kqu5ZxF2SiLzt+kmwAd40at7V6lb
        e5vBseXb8q0sjkvMyn39tIF6cVwOgqMKdif9TF38=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016225e61c34-50ab78f0-6fb6-4ece-acfe-da253bdce616-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201621edc97a4-a4239b1e-86d2-4400-aaac-d81727710f4f-000000@eu-west-1.amazonses.com>
References: <010201621edc97a4-a4239b1e-86d2-4400-aaac-d81727710f4f-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 1/5] ref-filter: start adding strbufs with errors
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Mar 2018 19:04:20 +0000
X-SES-Outgoing: 2018.03.14-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a first step in removing any printing from
ref-filter formatting logic, so that it could be more general.
Everything would be the same for show_ref_array_item() users.
But, if you want to deal with errors by your own, you could invoke
format_ref_array_item(). It means that you need to print everything
(the result and errors) on your side.

This commit changes signature of format_ref_array_item() by adding
return value and strbuf parameter for errors, and adjusts
its callers. While at it, reduce the scope of the out-variable.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/branch.c |  7 +++++--
 ref-filter.c     | 17 ++++++++++++-----
 ref-filter.h     |  7 ++++---
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 8dcc2ed058be6..f86709ca42d5e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -391,7 +391,6 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	struct ref_array array;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
-	struct strbuf out = STRBUF_INIT;
 	char *to_free = NULL;
 
 	/*
@@ -419,7 +418,10 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
-		format_ref_array_item(array.items[i], format, &out);
+		struct strbuf out = STRBUF_INIT;
+		struct strbuf err = STRBUF_INIT;
+		if (format_ref_array_item(array.items[i], format, &out, &err))
+			die("%s", err.buf);
 		if (column_active(colopts)) {
 			assert(!filter->verbose && "--column and --verbose are incompatible");
 			 /* format to a string_list to let print_columns() do its job */
@@ -428,6 +430,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 			fwrite(out.buf, 1, out.len, stdout);
 			putchar('\n');
 		}
+		strbuf_release(&err);
 		strbuf_release(&out);
 	}
 
diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216aaa8..54fae00bdd410 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2118,9 +2118,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
-void format_ref_array_item(struct ref_array_item *info,
+int format_ref_array_item(struct ref_array_item *info,
 			   const struct ref_format *format,
-			   struct strbuf *final_buf)
+			   struct strbuf *final_buf,
+			   struct strbuf *error_buf)
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
@@ -2148,19 +2149,25 @@ void format_ref_array_item(struct ref_array_item *info,
 		resetv.s = GIT_COLOR_RESET;
 		append_atom(&resetv, &state);
 	}
-	if (state.stack->prev)
-		die(_("format: %%(end) atom missing"));
+	if (state.stack->prev) {
+		strbuf_addstr(error_buf, _("format: %(end) atom missing"));
+		return -1;
+	}
 	strbuf_addbuf(final_buf, &state.stack->output);
 	pop_stack_element(&state.stack);
+	return 0;
 }
 
 void show_ref_array_item(struct ref_array_item *info,
 			 const struct ref_format *format)
 {
 	struct strbuf final_buf = STRBUF_INIT;
+	struct strbuf error_buf = STRBUF_INIT;
 
-	format_ref_array_item(info, format, &final_buf);
+	if (format_ref_array_item(info, format, &final_buf, &error_buf))
+		die("%s", error_buf.buf);
 	fwrite(final_buf.buf, 1, final_buf.len, stdout);
+	strbuf_release(&error_buf);
 	strbuf_release(&final_buf);
 	putchar('\n');
 }
diff --git a/ref-filter.h b/ref-filter.h
index 0d98342b34319..e13f8e6f8721a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -110,9 +110,10 @@ int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
 /*  Based on the given format and quote_style, fill the strbuf */
-void format_ref_array_item(struct ref_array_item *info,
-			   const struct ref_format *format,
-			   struct strbuf *final_buf);
+int format_ref_array_item(struct ref_array_item *info,
+			  const struct ref_format *format,
+			  struct strbuf *final_buf,
+			  struct strbuf *error_buf);
 /*  Print the ref using the given format and quote_style */
 void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
 /*  Parse a single sort specifier and add it to the list */

--
https://github.com/git/git/pull/466
