From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 00/13] port tag.c to use ref-filter APIs
Date: Sun,  9 Aug 2015 19:41:33 +0530
Message-ID: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 16:12:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZORKY-0006cq-P7
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 16:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbbHIOLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 10:11:46 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33978 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbbHIOLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 10:11:44 -0400
Received: by pdbfa8 with SMTP id fa8so21832094pdb.1
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=PryWXXgnK+npXNYKKhTtU7lScl+pGohHFILR3nuJ348=;
        b=AB/8dUEnUfQ10tpfGG2LPbQMTG8d5EfDFveN7Qf5UiwaHajI5EsPYrSKkiqGjhxkmO
         4PoSyA9qJsfMMxFO3s4fBDclt4syQxWxRP8MrskuBDgBlqNAHSYU/9LVsmqZM2V3Mu1S
         i9leMr/qRfkGP2ZNr4pmJerSiZHA4QnOr4z9X6Z2ZrTXW2gNL5wJQVMRtdZ0uO8aQ1yo
         Q5e/qDLFQu+6qY8ULecw5ByZcTmRoUir1E3gED6Ldjj36G64x5HRUaf69+VjWT6nJiBj
         a1rL/3vsIxz2YrFnJcfGwkpBMJ7utdrXXyEg+5dFCh69jZzQvwl2jeqbL4hl5aCjP31l
         e/GQ==
X-Received: by 10.70.14.36 with SMTP id m4mr34918442pdc.117.1439129503845;
        Sun, 09 Aug 2015 07:11:43 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id la4sm72920pbc.76.2015.08.09.07.11.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Aug 2015 07:11:43 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275537>

This is part of my GSoC project to unify git tag -l, git branch -l,
git for-each-ref.  This patch series is continued from: Git (next)
https://github.com/git/git/commit/bf5418f49ff0cebc6e5ce04ad1417e1a47c81b61

This series consists of porting tag.c over to using the ref-filter APIs

Version 8 can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/275252

Changes in this version: 
* use fwrite instead of looping over single characters and printing them.
* use strbuf_reset() at places instead of strbuf_release().
* make ref_formatting_state hold a strbuf, rather than a pointer to one.
* change a few function names to denote changes made to their implementations.
* move alignment to utf8, and use an enum for align_type.
* rename some variables to give better meanings.
* combine skip_prefix and starts_with in populate_value().
* fix utf8 checking.
* more small changes in the interdiff.

Thanks to everyone for their suggestions, especially Eric.

Karthik Nayak (13):
  ref-filter: move `struct atom_value` to ref-filter.c
  ref-filter: print output to strbuf for formatting
  ref-filter: introduce ref_formatting_state
  utf8: add function to align a string into given strbuf
  ref-filter: implement an `align` atom
  ref-filter: add option to filter only tags
  ref-filter: support printing N lines from tag annotation
  ref-filter: add support to sort by version
  ref-filter: add option to match literal pattern
  tag.c: use 'ref-filter' data structures
  tag.c: use 'ref-filter' APIs
  tag.c: implement '--format' option
  tag.c: implement '--merged' and '--no-merged' options

 Documentation/git-for-each-ref.txt |  12 ++
 Documentation/git-tag.txt          |  34 +++-
 builtin/for-each-ref.c             |   3 +-
 builtin/tag.c                      | 367 +++++++------------------------------
 ref-filter.c                       | 243 +++++++++++++++++++++---
 ref-filter.h                       |  22 ++-
 refs.c                             |   5 +
 refs.h                             |   1 +
 t/t6302-for-each-ref-filter.sh     |  84 +++++++++
 t/t7004-tag.sh                     |  51 +++++-
 utf8.c                             |  22 +++
 utf8.h                             |  13 ++
 12 files changed, 500 insertions(+), 357 deletions(-)

The interdiff between v9 and v10:

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6b6eb93..a795d5f 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -128,12 +128,13 @@ color::
 	are described in `color.branch.*`.
 
 align::
-	Align any string with or without %(atom) before the %(end)
-	atom to the right, left or middle. Followed by
-	`:<type>,<paddinglength>`, where the `<type>` is either left,
-	right or middle and `<paddinglength>` is the total length of
-	the padding to be performed. If the string length is more than
-	the padding length then no padding is performed.
+	Implement an `align` atom which left-, middle-, or
+	right-aligns the content between %(align:..)  and
+	%(end). Followed by `:<position>,<width>`, where the
+	`<position>` is either left, right or middle and `<width>` is
+	the total length of the content with alignment. If the
+	contents length is more than the width then no alignment is
+	performed. Currently nested alignment is not supported.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/builtin/tag.c b/builtin/tag.c
index 529b29f..22efbba 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -41,7 +41,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 		filter->lines = 0;
 
 	if (filter->lines)
-		format = "%(align:left,16)%(refname:short)";
+		format = "%(align:left,16)%(refname:short)%(end)";
 	else if (!format)
 		format = "%(refname:short)";
 
diff --git a/ref-filter.c b/ref-filter.c
index de84dd4..d22bf66 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -60,6 +60,19 @@ static struct {
 	{ "end" },
 };
 
+struct align {
+	align_type position;
+	unsigned int width;
+};
+
+struct atom_value{
+	const char *s;
+	struct align *align;
+	unsigned long ul; /* used for sorting when not FIELD_STR */
+	unsigned int modifier_atom : 1,
+		end : 1;
+};
+
 /*
  * An atom is a valid field atom listed above, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -625,8 +638,9 @@ static void populate_value(struct ref_array_item *ref)
 		const char *name = used_atom[i];
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
-		const char *refname = NULL;
+		const char *refname;
 		const char *formatp;
+		const char *valp;
 		struct branch *branch = NULL;
 
 		if (*name == '*') {
@@ -692,26 +706,23 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
-		} else if (starts_with(name, "align:")) {
-			const char *valp = NULL;
+		} else if (skip_prefix(name, "align:", &valp)) {
 			struct align *align = xmalloc(sizeof(struct align));
 
-			skip_prefix(name, "align:", &valp);
-
 			if (skip_prefix(valp, "left,", &valp))
-				align->align_type = ALIGN_LEFT;
+				align->position = ALIGN_LEFT;
 			else if (skip_prefix(valp, "right,", &valp))
-				align->align_type = ALIGN_RIGHT;
+				align->position = ALIGN_RIGHT;
 			else if (skip_prefix(valp, "middle,", &valp))
-				align->align_type = ALIGN_MIDDLE;
+				align->position = ALIGN_MIDDLE;
 			else
-				die(_("align: improper format"));
-			if (strtoul_ui(valp, 10, &align->align_value))
-				die(_("align: positive value expected"));
+				die(_("improper format entered align:%s"), valp);
+			if (strtoul_ui(valp, 10, &align->width))
+				die(_("positive width expected align:%s"), valp);
 			v->align = align;
 			v->modifier_atom = 1;
 			continue;
-		} else if (starts_with(name, "end")) {
+		} else if (!strcmp(name, "end")) {
 			v->end = 1;
 			v->modifier_atom = 1;
 			continue;
@@ -1253,23 +1264,31 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void print_value(struct atom_value *v, struct ref_formatting_state *state)
+
+struct ref_formatting_state {
+	struct strbuf output;
+	struct align *align;
+	int quote_style;
+	unsigned int end : 1;
+};
+
+static void format_quote_value(struct atom_value *v, struct ref_formatting_state *state)
 {
 	switch (state->quote_style) {
 	case QUOTE_NONE:
-		strbuf_addstr(state->output, v->s);
+		strbuf_addstr(&state->output, v->s);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(state->output, v->s);
+		sq_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(state->output, v->s);
+		perl_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(state->output, v->s);
+		python_quote_buf(&state->output, v->s);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(state->output, v->s);
+		tcl_quote_buf(&state->output, v->s);
 		break;
 	}
 }
@@ -1292,7 +1311,7 @@ static int hex2(const char *cp)
 		return -1;
 }
 
-static void emit(const char *cp, const char *ep, struct ref_formatting_state *state)
+static void append_non_atom(const char *cp, const char *ep, struct ref_formatting_state *state)
 {
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp == '%') {
@@ -1301,18 +1320,18 @@ static void emit(const char *cp, const char *ep, struct ref_formatting_state *st
 			else {
 				int ch = hex2(cp + 1);
 				if (0 <= ch) {
-					strbuf_addch(state->output, ch);
+					strbuf_addch(&state->output, ch);
 					cp += 3;
 					continue;
 				}
 			}
 		}
-		strbuf_addch(state->output, *cp);
+		strbuf_addch(&state->output, *cp);
 		cp++;
 	}
 }
 
-static void process_formatting_state(struct atom_value *atomv, struct ref_formatting_state *state)
+static void set_formatting_state(struct atom_value *atomv, struct ref_formatting_state *state)
 {
 	if (atomv->align) {
 		state->align = atomv->align;
@@ -1322,42 +1341,25 @@ static void process_formatting_state(struct atom_value *atomv, struct ref_format
 		state->end = 1;
 }
 
-static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *final)
+static int align_ref_strbuf(struct ref_formatting_state *state, struct strbuf *final)
 {
 	if (state->align && state->end) {
-		struct strbuf *value = state->output;
-		int len = 0, buf_len = value->len;
 		struct align *align = state->align;
-
-		if (!value->buf)
-			return;
-		if (!is_utf8(value->buf)) {
-			len = value->len - utf8_strwidth(value->buf);
-			buf_len -= len;
-		}
-
-		if (align->align_value < buf_len) {
-			state->align = NULL;
-			strbuf_addbuf(final, value);
-			strbuf_release(value);
-			return;
-		}
-
-		if (align->align_type == ALIGN_LEFT)
-			strbuf_addf(final, "%-*s", len + align->align_value, value->buf);
-		else if (align->align_type == ALIGN_MIDDLE) {
-			int right = (align->align_value - buf_len)/2;
-			strbuf_addf(final, "%*s%-*s", align->align_value - right + len,
-				    value->buf, right, "");
-		} else if (align->align_type == ALIGN_RIGHT)
-			strbuf_addf(final, "%*s", align->align_value, value->buf);
-		strbuf_release(value);
+		strbuf_utf8_align(final, align->position, align->width, state->output.buf);
+		strbuf_reset(&state->output);
 		state->align = NULL;
-		return;
+		return 1;
 	} else if (state->align)
+		return 1;
+	return 0;
+}
+
+static void perform_state_formatting(struct ref_formatting_state *state, struct strbuf *final)
+{
+	if (align_ref_strbuf(state, final))
 		return;
-	strbuf_addbuf(final, state->output);
-	strbuf_release(state->output);
+	strbuf_addbuf(final, &state->output);
+	strbuf_reset(&state->output);
 }
 
 /*
@@ -1407,41 +1409,38 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
 			 int quote_style, unsigned int lines)
 {
 	const char *cp, *sp, *ep;
-	struct strbuf value = STRBUF_INIT;
 	struct strbuf final_buf = STRBUF_INIT;
 	struct ref_formatting_state state;
-	int i;
 
-	memset(&state, 0, sizeof(state));
 	state.quote_style = quote_style;
-	state.output = &value;
+	strbuf_init(&state.output, 0);
+	state.align = NULL;
+	state.end = 0;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
-		struct atom_value *atomv = NULL;
+		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
 		if (cp < sp) {
-			emit(cp, sp, &state);
-			apply_formatting_state(&state, &final_buf);
+			append_non_atom(cp, sp, &state);
+			perform_state_formatting(&state, &final_buf);
 		}
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
 		if (atomv->modifier_atom)
-			process_formatting_state(atomv, &state);
+			set_formatting_state(atomv, &state);
 		else {
-			print_value(atomv, &state);
-			apply_formatting_state(&state, &final_buf);
-		}
-		if (atomv->end) {
-			print_value(atomv, &state);
-			apply_formatting_state(&state, &final_buf);
+			format_quote_value(atomv, &state);
+			perform_state_formatting(&state, &final_buf);
 		}
+		if (atomv->end)
+			perform_state_formatting(&state, &final_buf);
 	}
 	if (state.align)
 		die(_("format: align used without an `end` atom"));
 	if (*cp) {
 		sp = cp + strlen(cp);
-		emit(cp, sp, &state);
-		apply_formatting_state(&state, &final_buf);
+		append_non_atom(cp, sp, &state);
+		perform_state_formatting(&state, &final_buf);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1450,13 +1449,13 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		print_value(&resetv, &state);
-		apply_formatting_state(&state, &final_buf);
+		format_quote_value(&resetv, &state);
+		perform_state_formatting(&state, &final_buf);
 	}
 
-	for (i = 0; i < final_buf.len; i++)
-		printf("%c", final_buf.buf[i]);
+	fwrite(final_buf.buf, 1, final_buf.len, stdout);
 	strbuf_release(&final_buf);
+	strbuf_release(&state.output);
 
 	if (lines > 0) {
 		struct object_id oid;
diff --git a/ref-filter.h b/ref-filter.h
index 5be3e35..75bf989 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "parse-options.h"
+#include "utf8.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -17,29 +18,7 @@
 #define FILTER_REFS_ALL 0x2
 #define FILTER_REFS_TAGS 0x4
 
-#define ALIGN_LEFT 0x01
-#define ALIGN_RIGHT 0x02
-#define ALIGN_MIDDLE 0x04
-
-struct ref_formatting_state {
-	int quote_style;
-	struct strbuf *output;
-	struct align *align;
-	unsigned int end : 1;
-};
-
-struct align {
-	unsigned int align_type,
-		align_value;
-};
-
-struct atom_value {
-	const char *s;
-	struct align *align;
-	unsigned long ul; /* used for sorting when not FIELD_STR */
-	unsigned int modifier_atom : 1,
-		end : 1;
-};
+struct atom_value;
 
 struct ref_sorting {
 	struct ref_sorting *next;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 272a7e4..ce455d9 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -103,7 +103,7 @@ test_expect_success 'middle alignment' '
 	|  refname is refs/heads/side  |refs/heads/side
 	|   refname is refs/odd/spot   |refs/odd/spot
 	|refname is refs/tags/double-tag|refs/tags/double-tag
-	|   refname is refs/tags/four  |refs/tags/four
+	|  refname is refs/tags/four   |refs/tags/four
 	|   refname is refs/tags/one   |refs/tags/one
 	|refname is refs/tags/signed-tag|refs/tags/signed-tag
 	|  refname is refs/tags/three  |refs/tags/three
diff --git a/utf8.c b/utf8.c
index 28e6d76..bcbc621 100644
--- a/utf8.c
+++ b/utf8.c
@@ -644,3 +644,25 @@ int skip_utf8_bom(char **text, size_t len)
 	*text += strlen(utf8_bom);
 	return 1;
 }
+
+void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
+		       const char *s)
+{
+	int display_len = utf8_strnwidth(s, strlen(s), 0);
+	int utf8_compenstation = strlen(s) - display_len;
+
+	if (!strlen(s))
+		return;
+	if (display_len >= width) {
+		strbuf_addstr(buf, s);
+		return;
+	}
+
+	if (position == ALIGN_LEFT)
+		strbuf_addf(buf, "%-*s", width + utf8_compenstation, s);
+	else if (position == ALIGN_MIDDLE) {
+		int left = (width - display_len)/2;
+		strbuf_addf(buf, "%*s%-*s", left, "", width - left + ut8_compenstation, s);
+	} else if (position == ALIGN_RIGHT)
+		strbuf_addf(buf, "%*s", width + utf8_compenstation, s);
+}
diff --git a/utf8.h b/utf8.h
index 5a9e94b..db8ca63 100644
--- a/utf8.h
+++ b/utf8.h
@@ -55,4 +55,17 @@ int mbs_chrlen(const char **text, size_t *remainder_p, const char *encoding);
  */
 int is_hfs_dotgit(const char *path);
 
+typedef enum {
+	ALIGN_LEFT,
+	ALIGN_MIDDLE,
+	ALIGN_RIGHT
+} align_type;
+
+/*
+ * Align the string given and store it into a strbuf as per the type
+ * and width.
+ */
+void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
+		       const char *s);
+
 #endif
