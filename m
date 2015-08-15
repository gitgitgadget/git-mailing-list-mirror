From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v11 00/13] port tag.c to use ref-filter APIs
Date: Sat, 15 Aug 2015 23:30:30 +0530
Message-ID: <1439661643-16094-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 20:00:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQflG-0001Hw-RX
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 20:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbbHOSAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 14:00:40 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36179 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbbHOSAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 14:00:39 -0400
Received: by pdbmi9 with SMTP id mi9so609405pdb.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bbHcK1xLubxKjVesWkQeSBQDkXksQOiSWg/uHZxFem8=;
        b=k9SiBvWwWlJ69ciBII7LN7/UQ401ILres8JRYAGDoWd/M3DadhMCyqPpPQRabQvInQ
         fXo8irjck6NCY+8RTvaVyhGyVUFXY+/sq7B+cYVdAWrkqMnrwnqyKcqITvATjrL/XTo/
         ir8HMXafdAOvCrCnWDhIG8Vv0+p0tU/dm/LQHBAGhSTRpME1GPvBMnASejaNWMZrz5+q
         GdWdPg/xCXU0PdhDyO6piV9DrDyHIQ2uHSj1p/Byiq8fogiPd5jcFrc9KoBJZ1Hu1NJo
         npA+WitlXpPBt+dxAOUFeZ/j+RP4FGeW18Mu95vXuSa6A0ssEWcjcoXSPwDda+sknNPZ
         2Sbg==
X-Received: by 10.70.54.230 with SMTP id m6mr43478664pdp.156.1439661638551;
        Sat, 15 Aug 2015 11:00:38 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pe3sm9424144pdb.55.2015.08.15.11.00.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Aug 2015 11:00:37 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275997>

Karthik Nayak (13):
  ref-filter: move `struct atom_value` to ref-filter.c
  ref-filter: print output to strbuf for formatting
  ref-filter: introduce ref_formatting_state
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

Changes since v10:
* Improve documentation.
* Change the syntax used for the align atom and make left alignment
  default whenever the position is not mentioned.
* Instead of checking for modifier atoms, we have handler functions
  for each atom and each state can have a attend function which is
  called when the state is popped.
* Nested alignment is now possible.
* Change the way filter_refs() works and now we assign each ref its
  kind so further filtering if needed can be done.
* Rename some functions to have more meaningful names.
* strbuf_utf8_align() now works with empty strings and also been
  refactored to reduced the no of calls to strlen().

 Documentation/git-for-each-ref.txt |  11 ++
 Documentation/git-tag.txt          |  34 +++-
 builtin/for-each-ref.c             |   3 +-
 builtin/tag.c                      | 367 +++++++------------------------------
 ref-filter.c                       | 309 +++++++++++++++++++++++++++----
 ref-filter.h                       |  33 +++-
 refs.c                             |   7 +
 refs.h                             |   1 +
 t/t6302-for-each-ref-filter.sh     |  84 +++++++++
 t/t7004-tag.sh                     |  51 +++++-
 utf8.c                             |  21 +++
 utf8.h                             |  15 ++
 12 files changed, 573 insertions(+), 363 deletions(-)

InterDiff :

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index a795d5f..3099631 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -128,13 +128,12 @@ color::
 	are described in `color.branch.*`.
 
 align::
-	Implement an `align` atom which left-, middle-, or
-	right-aligns the content between %(align:..)  and
-	%(end). Followed by `:<position>,<width>`, where the
+	left-, middle-, or right-align the content between %(align:..)
+	and %(end). Followed by `:<position>,<width>`, where the
 	`<position>` is either left, right or middle and `<width>` is
 	the total length of the content with alignment. If the
 	contents length is more than the width then no alignment is
-	performed. Currently nested alignment is not supported.
+	performed.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/builtin/tag.c b/builtin/tag.c
index 22efbba..781d3e5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -41,7 +41,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 		filter->lines = 0;
 
 	if (filter->lines)
-		format = "%(align:left,16)%(refname:short)%(end)";
+		format = "%(align:16,left)%(refname:short)%(end)";
 	else if (!format)
 		format = "%(refname:short)";
 
diff --git a/ref-filter.c b/ref-filter.c
index d22bf66..a6086b2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -65,12 +65,19 @@ struct align {
 	unsigned int width;
 };
 
-struct atom_value{
+struct ref_formatting_state {
+	struct strbuf output;
+	struct ref_formatting_state *prev;
+	void (*attend)(struct ref_formatting_state *state);
+	void *cb_data;
+	int quote_style;
+};
+
+struct atom_value {
 	const char *s;
 	struct align *align;
+	void (*handler)(struct atom_value *atomv, struct ref_formatting_state **state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
-	unsigned int modifier_atom : 1,
-		end : 1;
 };
 
 /*
@@ -142,6 +149,26 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	return at;
 }
 
+static struct ref_formatting_state *push_new_state(struct ref_formatting_state **state)
+{
+	struct ref_formatting_state *new = xcalloc(1, sizeof(struct ref_formatting_state));
+	struct ref_formatting_state *old = *state;
+
+	*state = new;
+	new->prev = old;
+	return new;
+}
+
+static void pop_state(struct ref_formatting_state **state)
+{
+	struct ref_formatting_state *current = *state;
+	struct ref_formatting_state *prev = current->prev;
+
+	strbuf_release(&current->output);
+	free(current);
+	*state = prev;
+}
+
 /*
  * In a format string, find the next occurrence of %(atom).
  */
@@ -612,6 +639,34 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
+static void align_handler(struct ref_formatting_state *state)
+{
+	struct strbuf aligned = STRBUF_INIT;
+	struct ref_formatting_state *return_to = state->prev;
+	struct align *align = (struct align *)state->cb_data;
+
+	strbuf_utf8_align(&aligned, align->position, align->width, state->output.buf);
+	strbuf_addbuf(&return_to->output, &aligned);
+	strbuf_release(&aligned);
+}
+
+static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
+{
+	struct ref_formatting_state *new = push_new_state(state);
+	strbuf_init(&new->output, 0);
+	new->attend = align_handler;
+	new->cb_data = atomv->align;
+}
+
+static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
+{
+	struct ref_formatting_state *current = *state;
+	if (!current->attend)
+		die(_("format: `end` atom used without a supporting atom"));
+	current->attend(current);
+	pop_state(state);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -708,23 +763,31 @@ static void populate_value(struct ref_array_item *ref)
 			continue;
 		} else if (skip_prefix(name, "align:", &valp)) {
 			struct align *align = xmalloc(sizeof(struct align));
+			char *ep = strchr(valp, ',');
+
+			if (ep)
+				*ep = '\0';
+
+			if (strtoul_ui(valp, 10, &align->width))
+				die(_("positive width expected align:%s"), valp);
 
-			if (skip_prefix(valp, "left,", &valp))
+			if (!ep || starts_with(ep + 1, "left"))
 				align->position = ALIGN_LEFT;
-			else if (skip_prefix(valp, "right,", &valp))
+			else if (starts_with(ep + 1, "right"))
 				align->position = ALIGN_RIGHT;
-			else if (skip_prefix(valp, "middle,", &valp))
+			else if (starts_with(ep + 1, "middle"))
 				align->position = ALIGN_MIDDLE;
 			else
-				die(_("improper format entered align:%s"), valp);
-			if (strtoul_ui(valp, 10, &align->width))
-				die(_("positive width expected align:%s"), valp);
+				die(_("improper format entered align:%s"), ep + 1);
+
+			if (ep)
+				*ep = ',';
+
 			v->align = align;
-			v->modifier_atom = 1;
+			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
-			v->end = 1;
-			v->modifier_atom = 1;
+			v->handler = end_atom_handler;
 			continue;
 		} else
 			continue;
@@ -979,7 +1042,8 @@ static int match_pattern(const char **patterns, const char *refname)
 	 */
 	(void)(skip_prefix(refname, "refs/tags/", &refname) ||
 	       skip_prefix(refname, "refs/heads/", &refname) ||
-	       skip_prefix(refname, "refs/remotes/", &refname));
+	       skip_prefix(refname, "refs/remotes/", &refname) ||
+	       skip_prefix(refname, "refs/", &refname));
 
 	for (; *patterns; patterns++) {
 		if (!wildmatch(*patterns, refname, 0, NULL))
@@ -1070,6 +1134,36 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 	return ref;
 }
 
+static int filter_ref_kind(struct ref_filter *filter, const char *refname)
+{
+	unsigned int i;
+
+	static struct {
+		const char *prefix;
+		unsigned int kind;
+	} ref_kind[] = {
+		{ "refs/heads/" , FILTER_REFS_BRANCHES },
+		{ "refs/remotes/" , FILTER_REFS_REMOTES },
+		{ "refs/tags/", FILTER_REFS_TAGS}
+	};
+
+	if (filter->kind == FILTER_REFS_BRANCHES)
+		return FILTER_REFS_BRANCHES;
+	else if (filter->kind == FILTER_REFS_REMOTES)
+		return FILTER_REFS_REMOTES;
+	else if (filter->kind == FILTER_REFS_TAGS)
+		return FILTER_REFS_TAGS;
+	else if (!strcmp(refname, "HEAD"))
+		return FILTER_REFS_DETACHED_HEAD;
+
+	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
+		if (starts_with(refname, ref_kind[i].prefix))
+			return ref_kind[i].kind;
+	}
+
+	return FILTER_REFS_OTHERS;
+}
+
 /*
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
@@ -1080,6 +1174,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	struct ref_filter *filter = ref_cbdata->filter;
 	struct ref_array_item *ref;
 	struct commit *commit = NULL;
+	unsigned int kind;
 
 	if (flag & REF_BAD_NAME) {
 		warning("ignoring ref with broken name %s", refname);
@@ -1091,6 +1186,10 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
+	kind = filter_ref_kind(filter, refname);
+	if (!(kind & filter->kind))
+		return 0;
+
 	if (!filter_pattern_match(filter, refname))
 		return 0;
 
@@ -1122,6 +1221,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
 	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
+	ref->kind = kind;
 	return 0;
 }
 
@@ -1198,18 +1298,29 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 {
 	struct ref_filter_cbdata ref_cbdata;
 	int ret = 0;
+	unsigned int broken = 0;
 
 	ref_cbdata.array = array;
 	ref_cbdata.filter = filter;
 
 	/*  Simple per-ref filtering */
-	if (type & (FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN))
-		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
-	else if (type & FILTER_REFS_ALL)
-		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
-	else if (type & FILTER_REFS_TAGS)
-		ret = for_each_tag_ref_fullpath(ref_filter_handler, &ref_cbdata);
-	else if (type)
+	if (type & FILTER_REFS_INCLUDE_BROKEN) {
+		type -= FILTER_REFS_INCLUDE_BROKEN;
+		broken = 1;
+	}
+
+	filter->kind = type;
+	if (type == FILTER_REFS_BRANCHES)
+		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/heads/", broken, &ref_cbdata);
+	else if (type == FILTER_REFS_REMOTES)
+		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/remotes/", broken, &ref_cbdata);
+	else if (type == FILTER_REFS_TAGS)
+		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/tags/", broken, &ref_cbdata);
+	else if (type & FILTER_REFS_ALL) {
+		ret = for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);
+		if (type & FILTER_REFS_DETACHED_HEAD)
+			head_ref(ref_filter_handler, &ref_cbdata);
+	} else
 		die("filter_refs: invalid type");
 
 	/*  Filters that need revision walking */
@@ -1264,15 +1375,7 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
 }
 
-
-struct ref_formatting_state {
-	struct strbuf output;
-	struct align *align;
-	int quote_style;
-	unsigned int end : 1;
-};
-
-static void format_quote_value(struct atom_value *v, struct ref_formatting_state *state)
+static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
 {
 	switch (state->quote_style) {
 	case QUOTE_NONE:
@@ -1311,7 +1414,7 @@ static int hex2(const char *cp)
 		return -1;
 }
 
-static void append_non_atom(const char *cp, const char *ep, struct ref_formatting_state *state)
+static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
 {
 	while (*cp && (!ep || cp < ep)) {
 		if (*cp == '%') {
@@ -1331,37 +1434,6 @@ static void append_non_atom(const char *cp, const char *ep, struct ref_formattin
 	}
 }
 
-static void set_formatting_state(struct atom_value *atomv, struct ref_formatting_state *state)
-{
-	if (atomv->align) {
-		state->align = atomv->align;
-		atomv->align = NULL;
-	}
-	if (atomv->end)
-		state->end = 1;
-}
-
-static int align_ref_strbuf(struct ref_formatting_state *state, struct strbuf *final)
-{
-	if (state->align && state->end) {
-		struct align *align = state->align;
-		strbuf_utf8_align(final, align->position, align->width, state->output.buf);
-		strbuf_reset(&state->output);
-		state->align = NULL;
-		return 1;
-	} else if (state->align)
-		return 1;
-	return 0;
-}
-
-static void perform_state_formatting(struct ref_formatting_state *state, struct strbuf *final)
-{
-	if (align_ref_strbuf(state, final))
-		return;
-	strbuf_addbuf(final, &state->output);
-	strbuf_reset(&state->output);
-}
-
 /*
  * If 'lines' is greater than 0, print that many lines from the given
  * object_id 'oid'.
@@ -1409,38 +1481,26 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
 			 int quote_style, unsigned int lines)
 {
 	const char *cp, *sp, *ep;
-	struct strbuf final_buf = STRBUF_INIT;
-	struct ref_formatting_state state;
+	struct strbuf *final_buf;
+	struct ref_formatting_state *state = NULL;
 
-	state.quote_style = quote_style;
-	strbuf_init(&state.output, 0);
-	state.align = NULL;
-	state.end = 0;
+	state = push_new_state(&state);
+	state->quote_style = quote_style;
 
 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
 		struct atom_value *atomv;
 
 		ep = strchr(sp, ')');
-		if (cp < sp) {
-			append_non_atom(cp, sp, &state);
-			perform_state_formatting(&state, &final_buf);
-		}
+		if (cp < sp)
+			append_literal(cp, sp, state);
 		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
-		if (atomv->modifier_atom)
-			set_formatting_state(atomv, &state);
-		else {
-			format_quote_value(atomv, &state);
-			perform_state_formatting(&state, &final_buf);
-		}
-		if (atomv->end)
-			perform_state_formatting(&state, &final_buf);
+		if (atomv->handler)
+			atomv->handler(atomv, &state);
+		append_atom(atomv, state);
 	}
-	if (state.align)
-		die(_("format: align used without an `end` atom"));
 	if (*cp) {
 		sp = cp + strlen(cp);
-		append_non_atom(cp, sp, &state);
-		perform_state_formatting(&state, &final_buf);
+		append_literal(cp, sp, state);
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
@@ -1449,13 +1509,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format,
 		if (color_parse("reset", color) < 0)
 			die("BUG: couldn't parse 'reset' as a color");
 		resetv.s = color;
-		format_quote_value(&resetv, &state);
-		perform_state_formatting(&state, &final_buf);
+		append_atom(&resetv, state);
 	}
-
-	fwrite(final_buf.buf, 1, final_buf.len, stdout);
-	strbuf_release(&final_buf);
-	strbuf_release(&state.output);
+	final_buf = &state->output;
+	fwrite(final_buf->buf, 1, final_buf->len, stdout);
+	pop_state(&state);
 
 	if (lines > 0) {
 		struct object_id oid;
diff --git a/ref-filter.h b/ref-filter.h
index 75bf989..72fdf9e 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -14,9 +14,14 @@
 #define QUOTE_PYTHON 4
 #define QUOTE_TCL 8
 
-#define FILTER_REFS_INCLUDE_BROKEN 0x1
-#define FILTER_REFS_ALL 0x2
-#define FILTER_REFS_TAGS 0x4
+#define FILTER_REFS_INCLUDE_BROKEN 0x0001
+#define FILTER_REFS_TAGS           0x0002
+#define FILTER_REFS_BRANCHES       0x0004
+#define FILTER_REFS_REMOTES        0x0008
+#define FILTER_REFS_OTHERS         0x0010
+#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
+				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
+#define FILTER_REFS_DETACHED_HEAD  0x0020
 
 struct atom_value;
 
@@ -30,6 +35,7 @@ struct ref_sorting {
 struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
+	unsigned int kind;
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
@@ -55,7 +61,8 @@ struct ref_filter {
 
 	unsigned int with_commit_tag_algo : 1,
 		match_as_path : 1;
-	unsigned int lines;
+	unsigned int kind,
+		lines;
 };
 
 struct ref_filter_cbdata {
diff --git a/refs.c b/refs.c
index 0103a88..0f18c34 100644
--- a/refs.c
+++ b/refs.c
@@ -2114,11 +2114,6 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 	return for_each_ref_in("refs/tags/", fn, cb_data);
 }
 
-int for_each_tag_ref_fullpath(each_ref_fn fn, void *cb_data)
-{
-	return do_for_each_ref(&ref_cache, "refs/tags/", fn, 0, 0, cb_data);
-}
-
 int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return for_each_ref_in_submodule(submodule, "refs/tags/", fn, cb_data);
@@ -2150,6 +2145,13 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 			       strlen(git_replace_ref_base), 0, cb_data);
 }
 
+int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
+{
+	if (broken)
+		broken = DO_FOR_EACH_INCLUDE_BROKEN;
+	return do_for_each_ref(&ref_cache, type, fn, 0, broken, cb_data);
+}
+
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/refs.h b/refs.h
index 0956255..7f91a72 100644
--- a/refs.h
+++ b/refs.h
@@ -174,12 +174,12 @@ extern int head_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 extern int for_each_tag_ref(each_ref_fn fn, void *cb_data);
-extern int for_each_tag_ref_fullpath(each_ref_fn fn, void *cb_data);
 extern int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_replace_ref(each_ref_fn fn, void *cb_data);
 extern int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char *prefix, void *cb_data);
+extern int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data);
 
 extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index ce455d9..1c56879 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -93,7 +93,7 @@ test_expect_success 'left alignment' '
 	refname is refs/tags/three    |refs/tags/three
 	refname is refs/tags/two      |refs/tags/two
 	EOF
-	git for-each-ref --format="%(align:left,30)refname is %(refname)%(end)|%(refname)" >actual &&
+	git for-each-ref --format="%(align:30,left)refname is %(refname)%(end)|%(refname)" >actual &&
 	test_cmp expect actual
 '
 
@@ -109,7 +109,7 @@ test_expect_success 'middle alignment' '
 	|  refname is refs/tags/three  |refs/tags/three
 	|   refname is refs/tags/two   |refs/tags/two
 	EOF
-	git for-each-ref --format="|%(align:middle,30)refname is %(refname)%(end)|%(refname)" >actual &&
+	git for-each-ref --format="|%(align:30,middle)refname is %(refname)%(end)|%(refname)" >actual &&
 	test_cmp expect actual
 '
 
@@ -125,7 +125,7 @@ test_expect_success 'right alignment' '
 	|    refname is refs/tags/three|refs/tags/three
 	|      refname is refs/tags/two|refs/tags/two
 	EOF
-	git for-each-ref --format="|%(align:right,30)refname is %(refname)%(end)|%(refname)" >actual &&
+	git for-each-ref --format="|%(align:30,right)refname is %(refname)%(end)|%(refname)" >actual &&
 	test_cmp expect actual
 '
 
diff --git a/utf8.c b/utf8.c
index 65e55cc..0fb8e9d 100644
--- a/utf8.c
+++ b/utf8.c
@@ -648,21 +648,20 @@ int skip_utf8_bom(char **text, size_t len)
 void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
 		       const char *s)
 {
-	int display_len = utf8_strnwidth(s, strlen(s), 0);
-	int utf8_compenstation = strlen(s) - display_len;
+	int slen = strlen(s);
+	int display_len = utf8_strnwidth(s, slen, 0);
+	int utf8_compensation = slen - display_len;
 
-	if (!strlen(s))
-		return;
 	if (display_len >= width) {
 		strbuf_addstr(buf, s);
 		return;
 	}
 
 	if (position == ALIGN_LEFT)
-		strbuf_addf(buf, "%-*s", width + utf8_compenstation, s);
+		strbuf_addf(buf, "%-*s", width + utf8_compensation, s);
 	else if (position == ALIGN_MIDDLE) {
 		int left = (width - display_len)/2;
-		strbuf_addf(buf, "%*s%-*s", left, "", width - left + utf8_compenstation, s);
+		strbuf_addf(buf, "%*s%-*s", left, "", width - left + utf8_compensation, s);
 	} else if (position == ALIGN_RIGHT)
-		strbuf_addf(buf, "%*s", width + utf8_compenstation, s);
+		strbuf_addf(buf, "%*s", width + utf8_compensation, s);
 }
diff --git a/utf8.h b/utf8.h
index db8ca63..7930b44 100644
--- a/utf8.h
+++ b/utf8.h
@@ -62,8 +62,10 @@ typedef enum {
 } align_type;
 
 /*
- * Align the string given and store it into a strbuf as per the type
- * and width.
+ * Align the string given and store it into a strbuf as per the
+ * 'position' and 'width'. If the given string length is larger than
+ * 'width' than then the input string is not truncated and no
+ * alignment is done.
  */
 void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
 		       const char *s);

-- 
2.5.0
