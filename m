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
	by dcvr.yhbt.net (Postfix) with ESMTP id EFF281F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeAZToe (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:44:34 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:43858
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752027AbeAZTnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Jan 2018 14:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1516995820;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=PldimuUY/XJm5y/GO5iEgmvShlR6igTT6PCNOILvwKs=;
        b=R6BRrotPvkhZTWokV1dR363VqSMxt+IcffNIyaZCiGPY+FA2w0NlYs4tbHJzrMei
        YHQQBoaDAZMPGOlzj67C2hneUpOskRCdxCKoN9ljlXB9ciTLM4A04k0UZ88Wldp2Uhu
        EUCo/wxjxv7Q2OlESBZGKvLIRi5UTNNs7X5qLYlQ=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016133ff3ad8-abf99952-4df0-42a4-9ae9-06f602e84f3b-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 02/24] ref-filter: add return value to some functions
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

Add return flag to format_ref_array_item, show_ref_array_item,
get_ref_array_info and populate_value for further using.
Need it to handle situations when item is broken but we can not invoke
die() because we are in batch mode and all items need to be processed.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 ref-filter.c | 21 +++++++++++++--------
 ref-filter.h |  4 ++--
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 37337b57aacf4..7030d35c84a81 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1405,7 +1405,7 @@ static void need_object(struct ref_array_item *ref) {
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct ref_array_item *ref)
+static int populate_value(struct ref_array_item *ref)
 {
 	int i;
 
@@ -1526,20 +1526,22 @@ static void populate_value(struct ref_array_item *ref)
 			break;
 		}
 	}
-	return;
+	return 0;
 }
 
 /*
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
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
@@ -2124,7 +2126,7 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
-void format_ref_array_item(struct ref_array_item *info,
+int format_ref_array_item(struct ref_array_item *info,
 			   const struct ref_format *format,
 			   struct strbuf *final_buf)
 {
@@ -2158,17 +2160,20 @@ void format_ref_array_item(struct ref_array_item *info,
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
 	fwrite(final_buf.buf, 1, final_buf.len, stdout);
 	strbuf_release(&final_buf);
-	putchar('\n');
+	if (!retval)
+		putchar('\n');
+	return retval;
 }
 
 void pretty_print_ref(const char *name, const unsigned char *sha1,
diff --git a/ref-filter.h b/ref-filter.h
index 0d98342b34319..ff416b733b4b1 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -110,11 +110,11 @@ int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
 /*  Based on the given format and quote_style, fill the strbuf */
-void format_ref_array_item(struct ref_array_item *info,
+int format_ref_array_item(struct ref_array_item *info,
 			   const struct ref_format *format,
 			   struct strbuf *final_buf);
 /*  Print the ref using the given format and quote_style */
-void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
+int show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
 /*  Parse a single sort specifier and add it to the list */
 void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
 /*  Callback function for parsing the sort option */

--
https://github.com/git/git/pull/452
