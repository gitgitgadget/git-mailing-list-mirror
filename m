From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v14 00/13] Port tag.c to use ref-filter.c
Date: Sat, 29 Aug 2015 19:42:04 +0530
Message-ID: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 16:12:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVgri-0003Ts-5j
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 16:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbbH2OMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 10:12:13 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34892 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbbH2OMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 10:12:12 -0400
Received: by pacdd16 with SMTP id dd16so91062110pac.2
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qMe5OH16sg9/eFAPIwJ8QK3SnFCvPa6oi/Fkqcl9MKI=;
        b=sCsyH5hKCrnV0HFnprEznRx7utPCZovSB3Rc0TPxDHPXqis/uLICBsAEH0rLqpvw+E
         ZJe3VRgJA26/WNMJlyxMFor604H2b+kOIPwm340TT6K/3EUreTjGGwF8qM8bKdSBgpbT
         PkbfgQIvSn3DyFKTzKq30VrYt3dsWlzXIWZnKu5jn2tumLaarjjwHtxGmXOQbxzZ9D1h
         WQwFvzQKFmLND4MVRdsOKuEuYCoUwYQ4QLMwTQ+wYSFwNzPEEEct4vkY4g3vfyGE3Rt5
         +H96He8ra9zLx0cfCrTrWdoqB89GD1IBvt2HNtoDQ+nHIVYa+fuDTEd+eRayxnl5d4TA
         RO6w==
X-Received: by 10.66.141.141 with SMTP id ro13mr23933474pab.68.1440857531427;
        Sat, 29 Aug 2015 07:12:11 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id hy5sm8876807pac.22.2015.08.29.07.12.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Aug 2015 07:12:10 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276779>

This is part of porting tag.c to ref-filter APIs.
Version 13 can be found:
thread.gmane.org/gmane.comp.version-control.git/276363

Changes in this version:
* Introduce format_ref_array_item() and make show_ref_array_item() a
wrapper around the same.
* Introduce %(contents:lines=X) which gets the first X lines from a
given object.
* Change code in 05/13 to make the code neater and consistent.
* %(align) without arguments fails now.
* Add test for nested alignment.
* We perform quoting on each layer of nested alignment. 

Karthik Nayak (13):
  ref-filter: move `struct atom_value` to ref-filter.c
  ref-filter: introduce ref_formatting_state and ref_formatting_stack
  utf8: add function to align a string into given strbuf
  ref-filter: implement an `align` atom
  ref-filter: add option to filter out tags, branches and remotes
  ref-filter: introduce format_ref_array_item()
  ref-filter: add support for %(contents:lines=X)
  ref-filter: add support to sort by version
  ref-filter: add option to match literal pattern
  tag.c: use 'ref-filter' data structures
  tag.c: use 'ref-filter' APIs
  tag.c: implement '--format' option
  tag.c: implement '--merged' and '--no-merged' options

 Documentation/git-for-each-ref.txt |  13 ++
 Documentation/git-tag.txt          |  27 ++-
 builtin/for-each-ref.c             |   1 +
 builtin/tag.c                      | 368 ++++++--------------------------
 ref-filter.c                       | 418 ++++++++++++++++++++++++++++++++-----
 ref-filter.h                       |  32 ++-
 refs.c                             |   9 +
 refs.h                             |   1 +
 t/t6302-for-each-ref-filter.sh     | 137 ++++++++++++
 t/t7004-tag.sh                     |  47 ++++-
 utf8.c                             |  21 ++
 utf8.h                             |  15 ++
 12 files changed, 712 insertions(+), 377 deletions(-)

Interdiff between version 13 and version 14

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 06d468e..1b48b95 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -149,6 +149,7 @@ Its first line is `contents:subject`, where subject is the concatenation
 of all lines of the commit message up to the first blank line.  The next
 line is 'contents:body', where body is all of the lines after the first
 blank line.  Finally, the optional GPG signature is `contents:signature`.
+The first `N` lines of the object is obtained using `contents:lines=N`.
 
 For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3ad6a64..4e9f6c2 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -75,7 +75,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
 	for (i = 0; i < maxcount; i++)
-		show_ref_array_item(array.items[i], format, quote_style, 0);
+		show_ref_array_item(array.items[i], format, quote_style);
 	ref_array_clear(&array);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index bbbcaed..9fa1400 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -33,6 +33,7 @@ static unsigned int colopts;
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
 	struct ref_array array;
+	char *to_free = NULL;
 	int i;
 
 	memset(&array, 0, sizeof(array));
@@ -42,7 +43,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 
 	if (!format) {
 		if (filter->lines)
-			format = "%(align:16,left)%(refname:short)%(end)";
+			format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
+						   filter->lines);
 		else
 			format = "%(refname:short)";
 	}
@@ -52,8 +54,9 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++)
-		show_ref_array_item(array.items[i], format, QUOTE_NONE, filter->lines);
+		show_ref_array_item(array.items[i], format, 0);
 	ref_array_clear(&array);
+	free(to_free);
 
 	return 0;
 }
diff --git a/ref-filter.c b/ref-filter.c
index f8b8fb7..f268cd7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -58,6 +58,7 @@ static struct {
 	{ "color" },
 	{ "align" },
 	{ "end" },
+	{ "contents:lines" },
 };
 
 struct align {
@@ -65,6 +66,11 @@ struct align {
 	unsigned int width;
 };
 
+struct contents {
+	unsigned int lines;
+	struct object_id oid;
+};
+
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
 
 struct ref_formatting_stack {
@@ -82,6 +88,7 @@ struct ref_formatting_state {
 struct atom_value {
 	const char *s;
 	struct align *align;
+	struct contents *contents;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
@@ -155,7 +162,28 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	return at;
 }
 
-static void push_new_stack_element(struct ref_formatting_stack **stack)
+static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
+{
+	switch (quote_style) {
+	case QUOTE_NONE:
+		strbuf_addstr(s, str);
+		break;
+	case QUOTE_SHELL:
+		sq_quote_buf(s, str);
+		break;
+	case QUOTE_PERL:
+		perl_quote_buf(s, str);
+		break;
+	case QUOTE_PYTHON:
+		python_quote_buf(s, str);
+		break;
+	case QUOTE_TCL:
+		tcl_quote_buf(s, str);
+		break;
+	}
+}
+
+static void push_stack_element(struct ref_formatting_stack **stack)
 {
 	struct ref_formatting_stack *s = xcalloc(1, sizeof(struct ref_formatting_stack));
 
@@ -550,6 +578,61 @@ static void find_subpos(const char *buf, unsigned long sz,
 	*nonsiglen = *sig - buf;
 }
 
+/*
+ * If 'lines' is greater than 0, append that many lines from the given
+ * object_id 'oid' to the given strbuf.
+ */
+static void append_tag_lines(struct strbuf *out, const struct object_id *oid, int lines)
+{
+	int i;
+	unsigned long size;
+	enum object_type type;
+	char *buf, *sp, *eol;
+	size_t len;
+
+	buf = read_sha1_file(oid->hash, &type, &size);
+	if (!buf)
+		die_errno("unable to read object %s", oid_to_hex(oid));
+	if (type != OBJ_COMMIT && type != OBJ_TAG)
+		goto free_return;
+	if (!size)
+		die("an empty %s object %s?",
+		    typename(type), oid_to_hex(oid));
+
+	/* skip header */
+	sp = strstr(buf, "\n\n");
+	if (!sp)
+		goto free_return;
+
+	/* only take up to "lines" lines, and strip the signature from a tag */
+	if (type == OBJ_TAG)
+		size = parse_signature(buf, size);
+	for (i = 0, sp += 2; i < lines && sp < buf + size; i++) {
+		if (i)
+			strbuf_addstr(out, "\n    ");
+		eol = memchr(sp, '\n', size - (sp - buf));
+		len = eol ? eol - sp : size - (sp - buf);
+		strbuf_add(out, sp, len);
+		if (!eol)
+			break;
+		sp = eol + 1;
+	}
+free_return:
+	free(buf);
+}
+
+static void contents_lines_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct contents *contents = (struct contents *)atomv->contents;
+	struct strbuf s = STRBUF_INIT;
+
+	append_tag_lines(&s, &contents->oid, contents->lines);
+	quote_formatting(&state->stack->output, s.buf, state->quote_style);
+	strbuf_release(&s);
+
+	free(contents);
+}
+
 /* See grab_values */
 static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
 {
@@ -560,6 +643,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i];
 		struct atom_value *v = &val[i];
+		const char *valp = NULL;
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
@@ -569,7 +653,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 		    strcmp(name, "contents") &&
 		    strcmp(name, "contents:subject") &&
 		    strcmp(name, "contents:body") &&
-		    strcmp(name, "contents:signature"))
+		    strcmp(name, "contents:signature") &&
+		    !starts_with(name, "contents:lines="))
 			continue;
 		if (!subpos)
 			find_subpos(buf, sz,
@@ -589,6 +674,15 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			v->s = xmemdupz(sigpos, siglen);
 		else if (!strcmp(name, "contents"))
 			v->s = xstrdup(subpos);
+		else if (skip_prefix(name, "contents:lines=", &valp)) {
+			struct contents *contents = xmalloc(sizeof(struct contents));
+
+			if (strtoul_ui(valp, 10, &contents->lines))
+				die(_("positive width expected align:%s"), valp);
+			hashcpy(contents->oid.hash, obj->sha1);
+			v->handler = contents_lines_handler;
+			v->contents = contents;
+		}
 	}
 }
 
@@ -661,13 +755,25 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 {
 	struct ref_formatting_stack *new;
 
-	push_new_stack_element(&state->stack);
+	push_stack_element(&state->stack);
 	new = state->stack;
 	new->at_end = align_handler;
 	new->cb_data = atomv->align;
 }
 
-static void perform_quote_formatting(struct strbuf *s, const char *str, int quote_style);
+static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
+{
+	/*
+	 * Quote formatting is only done when the stack has a single
+	 * element. Otherwise quote formatting is done on the
+	 * element's entire output strbuf when the %(end) atom is
+	 * encountered.
+	 */
+	if (!state->stack->prev)
+		quote_formatting(&state->stack->output, v->s, state->quote_style);
+	else
+		strbuf_addstr(&state->stack->output, v->s);
+}
 
 static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
@@ -682,8 +788,8 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	 * are using a certain modifier atom. In that case we need to
 	 * perform quote formatting.
 	 */
-	if (!state->stack->prev->prev) {
-		perform_quote_formatting(&s, current->output.buf, state->quote_style);
+	if (state->stack->prev) {
+		quote_formatting(&s, current->output.buf, state->quote_style);
 		strbuf_reset(&current->output);
 		strbuf_addbuf(&current->output, &s);
 	}
@@ -722,6 +828,8 @@ static void populate_value(struct ref_array_item *ref)
 		const char *valp;
 		struct branch *branch = NULL;
 
+		v->handler = append_atom;
+
 		if (*name == '*') {
 			deref = 1;
 			name++;
@@ -785,7 +893,9 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
-		} else if (skip_prefix(name, "align:", &valp)) {
+		} else if (!strcmp(name, "align"))
+			die(_("format: incomplete use of the `align` atom"));
+		else if (skip_prefix(name, "align:", &valp)) {
 			struct align *align = xmalloc(sizeof(struct align));
 			struct strbuf **s = strbuf_split_str(valp, ',', 0);
 
@@ -1172,12 +1282,10 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 		{ "refs/tags/", FILTER_REFS_TAGS}
 	};
 
-	if (filter->kind == FILTER_REFS_BRANCHES)
-		return FILTER_REFS_BRANCHES;
-	else if (filter->kind == FILTER_REFS_REMOTES)
-		return FILTER_REFS_REMOTES;
-	else if (filter->kind == FILTER_REFS_TAGS)
-		return FILTER_REFS_TAGS;
+	if (filter->kind == FILTER_REFS_BRANCHES ||
+	    filter->kind == FILTER_REFS_REMOTES ||
+	    filter->kind == FILTER_REFS_TAGS)
+		return filter->kind;
 	else if (!strcmp(refname, "HEAD"))
 		return FILTER_REFS_DETACHED_HEAD;
 
@@ -1211,6 +1319,11 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
+	/*
+	 * Get the current ref kind. If we're filtering tags, remotes or local branches
+	 * only then the current ref-kind is nothing but filter->kind and filter_ref_kind()
+	 * will only return that value.
+	 */
 	kind = filter_ref_kind(filter, refname);
 	if (!(kind & filter->kind))
 		return 0;
@@ -1328,25 +1441,26 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	ref_cbdata.array = array;
 	ref_cbdata.filter = filter;
 
-	/*  Simple per-ref filtering */
-	if (type & FILTER_REFS_INCLUDE_BROKEN) {
-		type &= ~FILTER_REFS_INCLUDE_BROKEN;
+	if (type & FILTER_REFS_INCLUDE_BROKEN)
 		broken = 1;
-	}
+	filter->kind = type & FILTER_REFS_KIND_MASK;
 
-	filter->kind = type;
-	if (type == FILTER_REFS_BRANCHES)
-		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/heads/", broken, &ref_cbdata);
-	else if (type == FILTER_REFS_REMOTES)
-		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/remotes/", broken, &ref_cbdata);
-	else if (type == FILTER_REFS_TAGS)
-		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/tags/", broken, &ref_cbdata);
-	else if (type & FILTER_REFS_ALL) {
-		ret = for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);
-		if (type & FILTER_REFS_DETACHED_HEAD)
-			head_ref(ref_filter_handler, &ref_cbdata);
-	} else
+	/*  Simple per-ref filtering */
+	if (!filter->kind)
 		die("filter_refs: invalid type");
+	else {
+		if (filter->kind == FILTER_REFS_BRANCHES)
+			ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata, broken);
+		else if (filter->kind == FILTER_REFS_REMOTES)
+			ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata, broken);
+		else if (filter->kind == FILTER_REFS_TAGS)
+			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata, broken);
+		else if (filter->kind & FILTER_REFS_ALL)
+			ret = for_each_fullref_in("", ref_filter_handler, &ref_cbdata, broken);
+		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
+			head_ref(ref_filter_handler, &ref_cbdata);
+	}
+
 
 	/*  Filters that need revision walking */
 	if (filter->merge_commit)
@@ -1400,33 +1514,6 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-static void perform_quote_formatting(struct strbuf *s, const char *str, int quote_style)
-{
-	switch (quote_style) {
-	case QUOTE_NONE:
-		strbuf_addstr(s, str);
-		break;
-	case QUOTE_SHELL:
-		sq_quote_buf(s, str);
-		break;
-	case QUOTE_PERL:
-		perl_quote_buf(s, str);
-		break;
-	case QUOTE_PYTHON:
-		python_quote_buf(s, str);
-		break;
-	case QUOTE_TCL:
-		tcl_quote_buf(s, str);
-		break;
-	}
-}
-
-static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
-{
-	struct strbuf *s = &state->stack->output;
-	perform_quote_formatting(s, v->s, state->quote_style);
-}
-
 static int hex1(char ch)
 {
 	if ('0' <= ch && ch <= '9')
@@ -1467,58 +1554,14 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
-/*
- * If 'lines' is greater than 0, print that many lines from the given
- * object_id 'oid'.
- */
-static void show_tag_lines(const struct object_id *oid, int lines)
-{
-	int i;
-	unsigned long size;
-	enum object_type type;
-	char *buf, *sp, *eol;
-	size_t len;
-
-	buf = read_sha1_file(oid->hash, &type, &size);
-	if (!buf)
-		die_errno("unable to read object %s", oid_to_hex(oid));
-	if (type != OBJ_COMMIT && type != OBJ_TAG)
-		goto free_return;
-	if (!size)
-		die("an empty %s object %s?",
-		    typename(type), oid_to_hex(oid));
-
-	/* skip header */
-	sp = strstr(buf, "\n\n");
-	if (!sp)
-		goto free_return;
-
-	/* only take up to "lines" lines, and strip the signature from a tag */
-	if (type == OBJ_TAG)
-		size = parse_signature(buf, size);
-	for (i = 0, sp += 2; i < lines && sp < buf + size; i++) {
-		if (i)
-			printf("\n    ");
-		eol = memchr(sp, '\n', size - (sp - buf));
-		len = eol ? eol - sp : size - (sp - buf);
-		fwrite(sp, len, 1, stdout);
-		if (!eol)
-			break;
-		sp = eol + 1;
-	}
-free_return:
-	free(buf);
-}
-
-void show_ref_array_item(struct ref_array_item *info, const char *format,
-			 int quote_style, unsigned int lines)
+void format_ref_array_item(struct strbuf *out, struct ref_array_item *info,
+			   const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
-	struct strbuf *final_buf;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 
 	state.quote_style = quote_style;
-	push_new_stack_element(&state.stack);
+	push_stack_element(&state.stack);
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
@@ -1527,18 +1570,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
 		if (cp < sp)
 			append_literal(cp, sp, &state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		/*
-		 * If the atom is a modifier atom, then call the handler function.
-		 * Else, if this is the first element on the stack, then we need to
-		 * format the atom as per the given quote. Else we just add the atom value
-		 * to the current stack element and handle quote formatting at the end.
-		 */
-		if (atomv->handler)
-			atomv->handler(atomv, &state);
-		else if (!state.stack->prev)
-			append_atom(atomv, &state);
-		else
-			strbuf_addstr(&state.stack->output, atomv->s);
+		atomv->handler(atomv, &state);
 	}
 	if (*cp) {
 		sp = cp + strlen(cp);
@@ -1555,15 +1587,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
 	}
 	if (state.stack->prev)
 		die(_("format: `end` atom missing"));
-	final_buf = &state.stack->output;
-	fwrite(final_buf->buf, 1, final_buf->len, stdout);
+	strbuf_addbuf(out, &state.stack->output);
 	pop_stack_element(&state.stack);
-	if (lines > 0) {
-		struct object_id oid;
-		hashcpy(oid.hash, info->objectname);
-		show_tag_lines(&oid, lines);
-	}
-	putchar('\n');
+}
+
+void show_ref_array_item(struct ref_array_item *item, const char *format, unsigned int quote_style)
+{
+	struct strbuf out = STRBUF_INIT;
+	format_ref_array_item(&out, item, format, quote_style);
+	fwrite(out.buf, out.len, 1, stdout);
+	printf("\n");
+	strbuf_release(&out);
 }
 
 /*  If no sorting option is given, use refname to sort as default */
diff --git a/ref-filter.h b/ref-filter.h
index 8241066..179944c 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -21,6 +21,7 @@
 #define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
 				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
 #define FILTER_REFS_DETACHED_HEAD  0x0020
+#define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
 
 struct atom_value;
 
@@ -93,12 +94,11 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
 int verify_ref_format(const char *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
-/*
- * Print the ref using the given format and quote_style. If 'lines' > 0,
- * print that many lines of the the given ref.
- */
-void show_ref_array_item(struct ref_array_item *info, const char *format,
-			 int quote_style, unsigned int lines);
+/*  Format the ref as per given format and quote_style and store it into the strbuf */
+void format_ref_array_item(struct strbuf *out, struct ref_array_item *info,
+			   const char *format, int quote_style);
+/*  Wrapper around format_ref_array_item() which prints the given ref_array_item */
+void show_ref_array_item(struct ref_array_item *item, const char *format, unsigned int quote_style);
 /*  Callback function for parsing the sort option */
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
diff --git a/refs.c b/refs.c
index 3266617..a9469c2 100644
--- a/refs.c
+++ b/refs.c
@@ -2108,6 +2108,15 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
+int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
+{
+	unsigned int flag = 0;
+
+	if (broken)
+		flag = DO_FOR_EACH_INCLUDE_BROKEN;
+	return do_for_each_ref(&ref_cache, prefix, fn, 0, flag, cb_data);
+}
+
 int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn fn, void *cb_data)
 {
@@ -2150,15 +2159,6 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
-int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
-{
-	unsigned int flag = 0;
-
-	if (broken)
-		flag = DO_FOR_EACH_INCLUDE_BROKEN;
-	return do_for_each_ref(&ref_cache, type, fn, 0, flag, cb_data);
-}
-
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/refs.h b/refs.h
index 6e913ee..6d30c98 100644
--- a/refs.h
+++ b/refs.h
@@ -173,13 +173,13 @@ typedef int each_ref_fn(const char *refname,
 extern int head_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
+extern int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken);
 extern int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_replace_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char *prefix, void *cb_data);
-extern int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data);
 
 extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 38c99c9..8f18f86 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -150,6 +150,38 @@ test_expect_success 'alignment with format quote' '
 	test_cmp expect actual
 '
 
+test_expect_success 'nested alignment' '
+	cat >expect <<-\EOF &&
+	|         master               |
+	|           side               |
+	|       odd/spot               |
+	|     double-tag               |
+	|           four               |
+	|            one               |
+	|     signed-tag               |
+	|          three               |
+	|            two               |
+	EOF
+	git for-each-ref --format="|%(align:30,left)%(align:15,right)%(refname:short)%(end)%(end)|" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check `%(contents:lines=X)`' '
+	cat >expect <<-\EOF &&
+	master three
+	side four
+	odd/spot three
+	double-tag Annonated doubly
+	four four
+	one one
+	signed-tag A signed tag message
+	three three
+	two two
+	EOF
+	git for-each-ref --format="%(refname:short) %(contents:lines=1)" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup for version sort' '
 	test_commit foo1.3 &&
 	test_commit foo1.6 &&


-- 
2.5.0
