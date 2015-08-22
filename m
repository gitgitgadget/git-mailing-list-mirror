From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Sat, 22 Aug 2015 09:09:36 +0530
Message-ID: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 05:39:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSzeo-00027O-QG
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 05:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbbHVDjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 23:39:45 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35069 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbbHVDjo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 23:39:44 -0400
Received: by pacdd16 with SMTP id dd16so56489051pac.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RlHTb9CXDhTfj65Dw37sg0VJsnNveUcCWs4G/ZkKRok=;
        b=w14HLp4sYECAEuRNM4NiLh2NfXfq66hJjVLAQL3OuBLw6odHdiy1+tqrrt4STcmIFQ
         Mgbkl61vQH2lD5xLa2O/vlq3EjotZTbtaG1mGRdxtviOpk0v1iR3BYnulNf0XtmlM99a
         GA5Fi+fPNWe/hul7q1TaP17e6N/Bk723ABl5LXfRsQPNxOFYCqo5PfsEIaqHA/KlBclW
         ySp6GsBy2VQDVqsIjv+rvs8JpgPfqwB3CzANMUiM9aJDG8htzydvaCg7/rhzDQkb7cxd
         3uISOWtqhLdCHDzduoTDN2GLtVN/Cpx1xaP0sBOPcb9M70NhbUNX+yZr3H+zFwD1wTlI
         QkHg==
X-Received: by 10.67.30.232 with SMTP id kh8mr23839845pad.36.1440214783908;
        Fri, 21 Aug 2015 20:39:43 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id e4sm9393515pdd.45.2015.08.21.20.39.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 20:39:42 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276363>

Part of my GSoC project to port tag.c to use ref-filter APIs. This is
a follow up to porting for-each-ref to use ref-filter APIs.

Version 12 can be found here:
thread.gmane.org/gmane.comp.version-control.git/276133

Changes since v12:
* %(align)...%(end) now quote formats everything in between the atoms
even if they are string literals. 
* Changet the structure of ref_formatting_state to hold ref_formatting_stack
as the stack and quote_value, this ensures that we do not need to copy the 
quote_value to each element of the stack.
* While checking for %(align) atom, use strbuf_split_str().
* In tag.c support usage of --format with -n<num>.

Karthik Nayak (12):
  ref-filter: move `struct atom_value` to ref-filter.c
  ref-filter: introduce ref_formatting_state and ref_formatting_stack
  utf8: add function to align a string into given strbuf
  ref-filter: implement an `align` atom
  ref-filter: add option to filter out tags, branches and remotes
  ref-filter: support printing N lines from tag annotation
  ref-filter: add support to sort by version
  ref-filter: add option to match literal pattern
  tag.c: use 'ref-filter' data structures
  tag.c: use 'ref-filter' APIs
  tag.c: implement '--format' option
  tag.c: implement '--merged' and '--no-merged' options

 Documentation/git-for-each-ref.txt |  12 ++
 Documentation/git-tag.txt          |  27 ++-
 builtin/for-each-ref.c             |   3 +-
 builtin/tag.c                      | 365 +++++++------------------------------
 ref-filter.c                       | 350 +++++++++++++++++++++++++++++++----
 ref-filter.h                       |  32 +++-
 refs.c                             |   9 +
 refs.h                             |   1 +
 t/t6302-for-each-ref-filter.sh     | 105 +++++++++++
 t/t7004-tag.sh                     |  47 ++++-
 utf8.c                             |  21 +++
 utf8.h                             |  15 ++
 12 files changed, 626 insertions(+), 361 deletions(-)


Interdiff:

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 1997657..06d468e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -133,7 +133,8 @@ align::
 	`<position>` is either left, right or middle and `<width>` is
 	the total length of the content with alignment. If the
 	contents length is more than the width then no alignment is
-	performed.
+	performed. If used with '--quote' everything in between %(align:..)
+	and %(end) is quoted.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index c2785d9..3803bf7 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -161,22 +161,15 @@ This option is only applicable when listing tags without annotation lines.
 
 <format>::
 	A string that interpolates `%(fieldname)` from the object
-	pointed at by a ref being shown.  If `fieldname` is prefixed
-	with an asterisk (`*`) and the ref points at a tag object, the
-	value for the field in the object tag refers is used.  When
-	unspecified, defaults to `%(refname:short)`.  It also
-	interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
-	interpolates to character with hex code `xx`; for example
-	`%00` interpolates to `\0` (NUL), `%09` to `\t` (TAB) and
-	`%0a` to `\n` (LF).  The fields are same as those in `git
-	for-each-ref`.
+	pointed at by a ref being shown.  The format is the same as
+	that of linkgit:git-for-each-ref[1].  When unspecified,
+	defaults to `%(refname:short)`.
 
 --[no-]merged [<commit>]::
 	Only list tags whose tips are reachable, or not reachable
 	if '--no-merged' is used, from the specified commit ('HEAD'
 	if not specified).
 
-
 CONFIGURATION
 -------------
 By default, 'git tag' in sign-with-default mode (-s) will use your
diff --git a/ref-filter.c b/ref-filter.c
index 665221b..f8b8fb7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -65,18 +65,24 @@ struct align {
 	unsigned int width;
 };
 
-struct ref_formatting_state {
-	struct ref_formatting_state *prev;
+#define REF_FORMATTING_STATE_INIT  { 0, NULL }
+
+struct ref_formatting_stack {
+	struct ref_formatting_stack *prev;
 	struct strbuf output;
-	void (*at_end)(struct ref_formatting_state *state);
+	void (*at_end)(struct ref_formatting_stack *stack);
 	void *cb_data;
+};
+
+struct ref_formatting_state {
 	int quote_style;
+	struct ref_formatting_stack *stack;
 };
 
 struct atom_value {
 	const char *s;
 	struct align *align;
-	void (*handler)(struct atom_value *atomv, struct ref_formatting_state **state);
+	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
 
@@ -149,19 +155,19 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	return at;
 }
 
-static void push_new_state(struct ref_formatting_state **stack)
+static void push_new_stack_element(struct ref_formatting_stack **stack)
 {
-	struct ref_formatting_state *s = xcalloc(1, sizeof(struct ref_formatting_state));
+	struct ref_formatting_stack *s = xcalloc(1, sizeof(struct ref_formatting_stack));
 
 	strbuf_init(&s->output, 0);
 	s->prev = *stack;
 	*stack = s;
 }
 
-static void pop_state(struct ref_formatting_state **stack)
+static void pop_stack_element(struct ref_formatting_stack **stack)
 {
-	struct ref_formatting_state *current = *stack;
-	struct ref_formatting_state *prev = current->prev;
+	struct ref_formatting_stack *current = *stack;
+	struct ref_formatting_stack *prev = current->prev;
 
 	if (prev)
 		strbuf_addbuf(&prev->output, &current->output);
@@ -640,34 +646,49 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static void align_handler(struct ref_formatting_state *state)
+static void align_handler(struct ref_formatting_stack *stack)
 {
-	struct align *align = (struct align *)state->cb_data;
+	struct align *align = (struct align *)stack->cb_data;
 	struct strbuf s = STRBUF_INIT;
 
-	strbuf_utf8_align(&s, align->position, align->width, state->output.buf);
-	strbuf_reset(&state->output);
-	strbuf_addbuf(&state->output, &s);
+	strbuf_utf8_align(&s, align->position, align->width, stack->output.buf);
+	strbuf_swap(&stack->output, &s);
+	strbuf_release(&s);
 	free(align);
 }
 
-static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
+static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
-	struct ref_formatting_state *new;
+	struct ref_formatting_stack *new;
 
-	push_new_state(state);
-	new = *state;
+	push_new_stack_element(&state->stack);
+	new = state->stack;
 	new->at_end = align_handler;
 	new->cb_data = atomv->align;
 }
 
-static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
+static void perform_quote_formatting(struct strbuf *s, const char *str, int quote_style);
+
+static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
-	struct ref_formatting_state *current = *state;
+	struct ref_formatting_stack *current = state->stack;
+	struct strbuf s = STRBUF_INIT;
+
 	if (!current->at_end)
 		die(_("format: `end` atom used without a supporting atom"));
 	current->at_end(current);
-	pop_state(state);
+	/*
+	 * Whenever we have more than one stack element that means we
+	 * are using a certain modifier atom. In that case we need to
+	 * perform quote formatting.
+	 */
+	if (!state->stack->prev->prev) {
+		perform_quote_formatting(&s, current->output.buf, state->quote_style);
+		strbuf_reset(&current->output);
+		strbuf_addbuf(&current->output, &s);
+	}
+	strbuf_release(&s);
+	pop_stack_element(&state->stack);
 }
 
 /*
@@ -766,25 +787,26 @@ static void populate_value(struct ref_array_item *ref)
 			continue;
 		} else if (skip_prefix(name, "align:", &valp)) {
 			struct align *align = xmalloc(sizeof(struct align));
-			char *ep = strchr(valp, ',');
+			struct strbuf **s = strbuf_split_str(valp, ',', 0);
 
-			if (ep)
-				*ep = '\0';
+			/* If the position is given trim the ',' from the first strbuf */
+			if (s[1])
+				strbuf_remove(s[0], s[0]->len - 1, 1);
 
-			if (strtoul_ui(valp, 10, &align->width))
-				die(_("positive width expected align:%s"), valp);
+			if (strtoul_ui(s[0]->buf, 10, &align->width))
+				die(_("positive width expected align:%s"), s[0]->buf);
 
-			if (!ep || !strcmp(ep + 1, "left"))
+			/* If no position is given, default to ALIGN_LEFT */
+			if (!s[1] || !strcmp(s[1]->buf, "left"))
 				align->position = ALIGN_LEFT;
-			else if (!strcmp(ep + 1, "right"))
+			else if (!strcmp(s[1]->buf, "right"))
 				align->position = ALIGN_RIGHT;
-			else if (!strcmp(ep + 1, "middle"))
+			else if (!strcmp(s[1]->buf, "middle"))
 				align->position = ALIGN_MIDDLE;
 			else
-				die(_("improper format entered align:%s"), ep + 1);
+				die(_("improper format entered align:%s"), s[1]->buf);
 
-			if (ep)
-				*ep = ',';
+			strbuf_list_free(s);
 
 			v->align = align;
 			v->handler = align_atom_handler;
@@ -1378,27 +1400,33 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
+static void perform_quote_formatting(struct strbuf *s, const char *str, int quote_style)
 {
-	switch (state->quote_style) {
+	switch (quote_style) {
 	case QUOTE_NONE:
-		strbuf_addstr(&state->output, v->s);
+		strbuf_addstr(s, str);
 		break;
 	case QUOTE_SHELL:
-		sq_quote_buf(&state->output, v->s);
+		sq_quote_buf(s, str);
 		break;
 	case QUOTE_PERL:
-		perl_quote_buf(&state->output, v->s);
+		perl_quote_buf(s, str);
 		break;
 	case QUOTE_PYTHON:
-		python_quote_buf(&state->output, v->s);
+		python_quote_buf(s, str);
 		break;
 	case QUOTE_TCL:
-		tcl_quote_buf(&state->output, v->s);
+		tcl_quote_buf(s, str);
 		break;
 	}
 }
 
+static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
+{
+	struct strbuf *s = &state->stack->output;
+	perform_quote_formatting(s, v->s, state->quote_style);
+}
+
 static int hex1(char ch)
 {
 	if ('0' <= ch && ch <= '9')
@@ -1419,6 +1447,8 @@ static int hex2(const char *cp)
 
 static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
 {
+	struct strbuf *s = &state->stack->output;
+
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp == '%') {
 			if (cp[1] == '%')
@@ -1426,13 +1456,13 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 			else {
 				int ch = hex2(cp + 1);
 				if (0 <= ch) {
-					strbuf_addch(&state->output, ch);
+					strbuf_addch(s, ch);
 					cp += 3;
 					continue;
 				}
 			}
 		}
-		strbuf_addch(&state->output, *cp);
+		strbuf_addch(s, *cp);
 		cp++;
 	}
 }
@@ -1485,25 +1515,34 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
 {
 	const char *cp, *sp, *ep;
 	struct strbuf *final_buf;
-	struct ref_formatting_state *state = NULL;
+	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 
-	push_new_state(&state);
-	state->quote_style = quote_style;
+	state.quote_style = quote_style;
+	push_new_stack_element(&state.stack);
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
 		if (cp < sp)
-			append_literal(cp, sp, state);
+			append_literal(cp, sp, &state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
+		/*
+		 * If the atom is a modifier atom, then call the handler function.
+		 * Else, if this is the first element on the stack, then we need to
+		 * format the atom as per the given quote. Else we just add the atom value
+		 * to the current stack element and handle quote formatting at the end.
+		 */
 		if (atomv->handler)
 			atomv->handler(atomv, &state);
-		append_atom(atomv, state);
+		else if (!state.stack->prev)
+			append_atom(atomv, &state);
+		else
+			strbuf_addstr(&state.stack->output, atomv->s);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
-		append_literal(cp, sp, state);
+		append_literal(cp, sp, &state);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1512,12 +1551,13 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		append_atom(&resetv, state);
+		append_atom(&resetv, &state);
 	}
-	final_buf = &state->output;
+	if (state.stack->prev)
+		die(_("format: `end` atom missing"));
+	final_buf = &state.stack->output;
 	fwrite(final_buf->buf, 1, final_buf->len, stdout);
-	pop_state(&state);
-
+	pop_stack_element(&state.stack);
 	if (lines > 0) {
 		struct object_id oid;
 		hashcpy(oid.hash, info->objectname);
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 1c56879..38c99c9 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -129,6 +129,27 @@ test_expect_success 'right alignment' '
 	test_cmp expect actual
 '
 
+# Everything in between the %(align)...%(end) atom must be quoted, hence we test this by
+# introducing single quote's in %(align)...%(end), which must not be escaped.
+
+sq="'"
+
+test_expect_success 'alignment with format quote' '
+	cat >expect <<-EOF &&
+	refname is ${sq}           ${sq}\\${sq}${sq}master${sq}\\${sq}${sq}           ${sq}|
+	refname is ${sq}            ${sq}\\${sq}${sq}side${sq}\\${sq}${sq}            ${sq}|
+	refname is ${sq}          ${sq}\\${sq}${sq}odd/spot${sq}\\${sq}${sq}          ${sq}|
+	refname is ${sq}         ${sq}\\${sq}${sq}double-tag${sq}\\${sq}${sq}         ${sq}|
+	refname is ${sq}            ${sq}\\${sq}${sq}four${sq}\\${sq}${sq}            ${sq}|
+	refname is ${sq}            ${sq}\\${sq}${sq}one${sq}\\${sq}${sq}             ${sq}|
+	refname is ${sq}         ${sq}\\${sq}${sq}signed-tag${sq}\\${sq}${sq}         ${sq}|
+	refname is ${sq}           ${sq}\\${sq}${sq}three${sq}\\${sq}${sq}            ${sq}|
+	refname is ${sq}            ${sq}\\${sq}${sq}two${sq}\\${sq}${sq}             ${sq}|
+	EOF
+	git for-each-ref --shell --format="refname is %(align:30,middle)${sq}%(refname:short)${sq}%(end)|" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup for version sort' '
 	test_commit foo1.3 &&
 	test_commit foo1.6 &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 335396e..3dd2f51 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1519,10 +1519,6 @@ EOF"
 	test_cmp expect actual
 '
 
-test_expect_success '--format cannot be used with -n' '
-	test_must_fail git tag -l -n4 --format="%(refname)"
-'
-
 test_expect_success '--format should list tags as per format given' '
 	cat >expect <<-\EOF &&
 	refname : refs/tags/foo1.10

diff --git a/builtin/tag.c b/builtin/tag.c
index 781d3e5..bbbcaed 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -23,7 +23,7 @@ static const char * const git_tag_usage[] = {
        N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
        N_("git tag -d <tagname>..."),
        N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
-               "\n\t\t[--[no-]merged [<commit>]] [<pattern>...]"),
+               "\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
        N_("git tag -v <tagname>..."),
        NULL
 };
@@ -40,10 +40,12 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
        if (filter->lines == -1)
                filter->lines = 0;
 
-       if (filter->lines)
-               format = "%(align:16,left)%(refname:short)%(end)";
-       else if (!format)
-               format = "%(refname:short)";
+       if (!format) {
+               if (filter->lines)
+                       format = "%(align:16,left)%(refname:short)%(end)";
+               else
+                       format = "%(refname:short)";
+       }
 
        verify_ref_format(format);
        filter_refs(&array, filter, FILTER_REFS_TAGS);
@@ -401,8 +403,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
                        copts.padding = 2;
                        run_column_filter(colopts, &copts);
                }
-               if (format && (filter.lines != -1))
-                       die(_("--format and -n are incompatible"));
                filter.name_patterns = argv;
                ret = list_tags(&filter, sorting, format);
                if (column_active(colopts))

-- 
2.5.0
