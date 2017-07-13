Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F96A202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbdGMPBW (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:01:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:39104 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751200AbdGMPBV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:01:21 -0400
Received: (qmail 24102 invoked by uid 109); 13 Jul 2017 15:01:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:01:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32109 invoked by uid 111); 13 Jul 2017 15:01:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:01:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:01:18 -0400
Date:   Thu, 13 Jul 2017 11:01:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/15] ref-filter: abstract ref format into its own struct
Message-ID: <20170713150118.eof3xgu4zujmo6u6@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref-filter module provides routines for formatting a ref
for output. The fundamental interface for the format is a
"const char *" containing the format, and any additional
options need to be passed to each invocation of
show_ref_array_item.

Instead, let's make a ref_format struct that holds the
format, along with any associated format options. That will
make some enhancements easier in the future:

  1. new formatting options can be added without disrupting
     existing callers

  2. some state can be carried in the struct rather than as
     global variables

For now this just has the text format itself along with the
quote_style option, but we'll add more fields in future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
A few of the spots are a bit ugly. E.g., when the format is optional you
might have to check whether format->format is NULL. It's possible that
it would be nicer if we abstracted this into a more opaque object with
accessors. But I didn't want to go overboard.

 builtin/branch.c       | 14 +++++++-------
 builtin/for-each-ref.c | 22 ++++++++++++----------
 builtin/tag.c          | 30 ++++++++++++++++--------------
 builtin/verify-tag.c   | 12 ++++++------
 ref-filter.c           | 22 ++++++++++++----------
 ref-filter.h           | 22 +++++++++++++++++-----
 6 files changed, 70 insertions(+), 52 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e756a5667..036fdc929 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -383,7 +383,7 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	return strbuf_detach(&fmt, NULL);
 }
 
-static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
+static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting, struct ref_format *format)
 {
 	int i;
 	struct ref_array array;
@@ -407,8 +407,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
-	if (!format)
-		format = to_free = build_format(filter, maxwidth, remote_prefix);
+	if (!format->format)
+		format->format = to_free = build_format(filter, maxwidth, remote_prefix);
 
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));
@@ -416,7 +416,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
-		format_ref_array_item(array.items[i], format, 0, &out);
+		format_ref_array_item(array.items[i], format, &out);
 		if (column_active(colopts)) {
 			assert(!filter->verbose && "--column and --verbose are incompatible");
 			 /* format to a string_list to let print_columns() do its job */
@@ -551,7 +551,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	struct ref_filter filter;
 	int icase = 0;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
-	const char *format = NULL;
+	struct ref_format format = REF_FORMAT_INIT;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -595,7 +595,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			N_("print only branches of the object"), 0, parse_opt_object_name
 		},
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
-		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
+		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT_END(),
 	};
 
@@ -669,7 +669,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!sorting)
 			sorting = ref_default_sorting();
 		sorting->ignore_case = icase;
-		print_ref_list(&filter, sorting, format);
+		print_ref_list(&filter, sorting, &format);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
 		return 0;
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 52be99cba..f47066b42 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -17,25 +17,25 @@ static char const * const for_each_ref_usage[] = {
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
-	int maxcount = 0, quote_style = 0, icase = 0;
+	int maxcount = 0, icase = 0;
 	struct ref_array array;
 	struct ref_filter filter;
+	struct ref_format format = REF_FORMAT_INIT;
 
 	struct option opts[] = {
-		OPT_BIT('s', "shell", &quote_style,
+		OPT_BIT('s', "shell", &format.quote_style,
 			N_("quote placeholders suitably for shells"), QUOTE_SHELL),
-		OPT_BIT('p', "perl",  &quote_style,
+		OPT_BIT('p', "perl",  &format.quote_style,
 			N_("quote placeholders suitably for perl"), QUOTE_PERL),
-		OPT_BIT(0 , "python", &quote_style,
+		OPT_BIT(0 , "python", &format.quote_style,
 			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
-		OPT_BIT(0 , "tcl",  &quote_style,
+		OPT_BIT(0 , "tcl",  &format.quote_style,
 			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
 
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
-		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
+		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			    N_("field name to sort on"), &parse_opt_ref_sorting),
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
@@ -52,16 +52,18 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	memset(&array, 0, sizeof(array));
 	memset(&filter, 0, sizeof(filter));
 
+	format.format = "%(objectname) %(objecttype)\t%(refname)";
+
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
 	if (maxcount < 0) {
 		error("invalid --count argument: `%d'", maxcount);
 		usage_with_options(for_each_ref_usage, opts);
 	}
-	if (HAS_MULTI_BITS(quote_style)) {
+	if (HAS_MULTI_BITS(format.quote_style)) {
 		error("more than one quoting style?");
 		usage_with_options(for_each_ref_usage, opts);
 	}
-	if (verify_ref_format(format))
+	if (verify_ref_format(&format))
 		usage_with_options(for_each_ref_usage, opts);
 
 	if (!sorting)
@@ -80,7 +82,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
 	for (i = 0; i < maxcount; i++)
-		show_ref_array_item(array.items[i], format, quote_style);
+		show_ref_array_item(array.items[i], &format);
 	ref_array_clear(&array);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index 216629fb2..207c9eb03 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -32,7 +32,8 @@ static const char * const git_tag_usage[] = {
 static unsigned int colopts;
 static int force_sign_annotate;
 
-static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
+static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
+		     struct ref_format *format)
 {
 	struct ref_array array;
 	char *to_free = NULL;
@@ -43,14 +44,14 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 	if (filter->lines == -1)
 		filter->lines = 0;
 
-	if (!format) {
+	if (!format->format) {
 		if (filter->lines) {
 			to_free = xstrfmt("%s %%(contents:lines=%d)",
 					  "%(align:15)%(refname:lstrip=2)%(end)",
 					  filter->lines);
-			format = to_free;
+			format->format = to_free;
 		} else
-			format = "%(refname:lstrip=2)";
+			format->format = "%(refname:lstrip=2)";
 	}
 
 	if (verify_ref_format(format))
@@ -60,7 +61,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++)
-		show_ref_array_item(array.items[i], format, 0);
+		show_ref_array_item(array.items[i], format);
 	ref_array_clear(&array);
 	free(to_free);
 
@@ -106,17 +107,17 @@ static int verify_tag(const char *name, const char *ref,
 		      const struct object_id *oid, const void *cb_data)
 {
 	int flags;
-	const char *fmt_pretty = cb_data;
+	const struct ref_format *format = cb_data;
 	flags = GPG_VERIFY_VERBOSE;
 
-	if (fmt_pretty)
+	if (format->format)
 		flags = GPG_VERIFY_OMIT_STATUS;
 
 	if (gpg_verify_tag(oid->hash, name, flags))
 		return -1;
 
-	if (fmt_pretty)
-		pretty_print_ref(name, oid->hash, fmt_pretty);
+	if (format->format)
+		pretty_print_ref(name, oid->hash, format);
 
 	return 0;
 }
@@ -393,7 +394,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
-	const char *format = NULL;
+	struct ref_format format = REF_FORMAT_INIT;
 	int icase = 0;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
@@ -432,7 +433,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			N_("print only tags of the object"), PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_object_name, (intptr_t) "HEAD"
 		},
-		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
+		OPT_STRING(  0 , "format", &format.format, N_("format"),
+			   N_("format to use for the output")),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_END()
 	};
@@ -484,7 +486,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			run_column_filter(colopts, &copts);
 		}
 		filter.name_patterns = argv;
-		ret = list_tags(&filter, sorting, format);
+		ret = list_tags(&filter, sorting, &format);
 		if (column_active(colopts))
 			stop_column_filter();
 		return ret;
@@ -502,9 +504,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag, NULL);
 	if (cmdmode == 'v') {
-		if (format && verify_ref_format(format))
+		if (format.format && verify_ref_format(&format))
 			usage_with_options(git_tag_usage, options);
-		return for_each_tag_name(argv, verify_tag, format);
+		return for_each_tag_name(argv, verify_tag, &format);
 	}
 
 	if (msg.given || msgfile) {
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index a10eca2b2..87d73e856 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -32,11 +32,11 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
-	char *fmt_pretty = NULL;
+	struct ref_format format = REF_FORMAT_INIT;
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
-		OPT_STRING(  0 , "format", &fmt_pretty, N_("format"), N_("format to use for the output")),
+		OPT_STRING(0, "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT_END()
 	};
 
@@ -50,8 +50,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	if (fmt_pretty) {
-		if (verify_ref_format(fmt_pretty))
+	if (format.format) {
+		if (verify_ref_format(&format))
 			usage_with_options(verify_tag_usage,
 					   verify_tag_options);
 		flags |= GPG_VERIFY_OMIT_STATUS;
@@ -70,8 +70,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (fmt_pretty)
-			pretty_print_ref(name, sha1, fmt_pretty);
+		if (format.format)
+			pretty_print_ref(name, sha1, &format);
 	}
 	return had_error;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 6da5be3ac..66d234bb1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -657,12 +657,12 @@ static const char *find_next(const char *cp)
  * Make sure the format string is well formed, and parse out
  * the used atoms.
  */
-int verify_ref_format(const char *format)
+int verify_ref_format(struct ref_format *format)
 {
 	const char *cp, *sp;
 
 	need_color_reset_at_eol = 0;
-	for (cp = format; *cp && (sp = find_next(cp)); ) {
+	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
 		const char *color, *ep = strchr(sp, ')');
 		int at;
 
@@ -2060,16 +2060,17 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
-void format_ref_array_item(struct ref_array_item *info, const char *format,
-			   int quote_style, struct strbuf *final_buf)
+void format_ref_array_item(struct ref_array_item *info,
+			   const struct ref_format *format,
+			   struct strbuf *final_buf)
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 
-	state.quote_style = quote_style;
+	state.quote_style = format->quote_style;
 	push_stack_element(&state.stack);
 
-	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
+	for (cp = format->format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
@@ -2093,23 +2094,24 @@ void format_ref_array_item(struct ref_array_item *info, const char *format,
 	pop_stack_element(&state.stack);
 }
 
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+void show_ref_array_item(struct ref_array_item *info,
+			 const struct ref_format *format)
 {
 	struct strbuf final_buf = STRBUF_INIT;
 
-	format_ref_array_item(info, format, quote_style, &final_buf);
+	format_ref_array_item(info, format, &final_buf);
 	fwrite(final_buf.buf, 1, final_buf.len, stdout);
 	strbuf_release(&final_buf);
 	putchar('\n');
 }
 
 void pretty_print_ref(const char *name, const unsigned char *sha1,
-		const char *format)
+		      const struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
 	ref_item = new_ref_array_item(name, sha1, 0);
 	ref_item->kind = ref_kind_from_refname(name);
-	show_ref_array_item(ref_item, format, 0);
+	show_ref_array_item(ref_item, format);
 	free_array_item(ref_item);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 6552024f0..2bb58879d 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -72,6 +72,17 @@ struct ref_filter {
 		verbose;
 };
 
+struct ref_format {
+	/*
+	 * Set these to define the format; make sure you call
+	 * verify_ref_format() afterwards to finalize.
+	 */
+	const char *format;
+	int quote_style;
+};
+
+#define REF_FORMAT_INIT { NULL, 0 }
+
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
 	{ OPTION_CALLBACK, 0, option, (filter), N_("commit"), (h), \
@@ -93,14 +104,15 @@ void ref_array_clear(struct ref_array *array);
 /*  Parse format string and sort specifiers */
 int parse_ref_filter_atom(const char *atom, const char *ep);
 /*  Used to verify if the given format is correct and to parse out the used atoms */
-int verify_ref_format(const char *format);
+int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
 /*  Based on the given format and quote_style, fill the strbuf */
-void format_ref_array_item(struct ref_array_item *info, const char *format,
-			   int quote_style, struct strbuf *final_buf);
+void format_ref_array_item(struct ref_array_item *info,
+			   const struct ref_format *format,
+			   struct strbuf *final_buf);
 /*  Print the ref using the given format and quote_style */
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
+void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
 /*  Callback function for parsing the sort option */
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
@@ -117,6 +129,6 @@ void setup_ref_filter_porcelain_msg(void);
  * name must be a fully qualified refname.
  */
 void pretty_print_ref(const char *name, const unsigned char *sha1,
-		const char *format);
+		      const struct ref_format *format);
 
 #endif /*  REF_FILTER_H  */
-- 
2.13.2.1157.gc6daca446

