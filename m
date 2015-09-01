From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v15 00/13] port builtin/tag.c to use ref-filter APIs.
Date: Tue,  1 Sep 2015 23:56:21 +0530
Message-ID: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 20:26:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqGT-00073k-MP
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbbIAS0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:26:33 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36227 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130AbbIAS0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:26:31 -0400
Received: by pacwi10 with SMTP id wi10so3648877pac.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Wtiurim5PB/Kpb8xsR8PVa8n65DFIrjix0ha075qNw8=;
        b=GV52BCSzJZEd2ifh80s+k9oH+ynEcfwB3sjbn6tX6ZnBnYFqgLIV6NIIGZd8X0i2hG
         W7HC6tkJQNmMG9/ftoXKNUlTO3EihwHugy3d6y5qVOIivtFUMQri9Kdsa2BwzM2m4EpT
         rsxz1uCCObc3MP+9JJuRRpqFteAhoxB9Lpacp6MolikdDi7wwEKfN2dn5YdsBI6ALSeT
         yYE3KSIc764nVT5BgRZMGoAs3F62gKXFp1mIpP/ovrjpz3zITS84hq6hDTctki9qNPQe
         5DEMYzxDJrpZd98DVWOLTCU4eXqxRLqVsyJimImYwXnXZsWa1pJ84c1lBcsbYh1IBLN/
         vJCw==
X-Received: by 10.67.23.232 with SMTP id id8mr16416116pad.138.1441131990442;
        Tue, 01 Sep 2015 11:26:30 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uk6sm19091682pac.27.2015.09.01.11.26.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Sep 2015 11:26:29 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277012>

The previous iteration of this series is found here:
http://article.gmane.org/gmane.comp.version-control.git/276779

Changes in this version:
* Make %(contents:lines=X) use existing ref-filter code rather
than reply completely on the code borrowed from tag.c.
* Make struct align and struct contents static variables inside
atom_value and put them inside an union.
* Since there was some redundant code movement, I moved most of
the code to the top. (Caused a noisy interdiff but should be more
benifital in the long run).
* Move the error checking of `align` into the block for processing
the align atom.
* Remove introduction of format_ref_array_item(), probably re-introduce
it if/when required.
* More tests added for %(contents:lines=X) and made them cleaner to read.
* Only the second element of the stack performs quoting at the end, all
elements after it perform no quoting themselves and rely on the quoting
performed by element two.

Karthik Nayak (13):
  ref-filter: move `struct atom_value` to ref-filter.c
  ref-filter: introduce ref_formatting_state and ref_formatting_stack
  utf8: add function to align a string into given strbuf
  ref-filter: introduce handler function for each atom
  ref-filter: implement an `align` atom
  ref-filter: add option to filter out tags, branches and remotes
  ref-filter: add support for %(contents:lines=X)
  ref-filter: add support to sort by version
  ref-filter: add option to match literal pattern
  tag.c: use 'ref-filter' data structures
  tag.c: use 'ref-filter' APIs
  tag.c: implement '--format' option
  tag.c: implement '--merged' and '--no-merged' options

 Documentation/git-for-each-ref.txt |  15 +-
 Documentation/git-tag.txt          |  27 ++-
 builtin/for-each-ref.c             |   1 +
 builtin/tag.c                      | 368 +++++++----------------------------
 ref-filter.c                       | 382 ++++++++++++++++++++++++++++++++-----
 ref-filter.h                       |  25 ++-
 refs.c                             |   9 +
 refs.h                             |   1 +
 t/t6302-for-each-ref-filter.sh     | 173 +++++++++++++++++
 t/t7004-tag.sh                     |  47 ++++-
 utf8.c                             |  21 ++
 utf8.h                             |  15 ++
 12 files changed, 710 insertions(+), 374 deletions(-)

Interdiff between v14 and v15:

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 1b48b95..d039f40 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -133,8 +133,8 @@ align::
 	`<position>` is either left, right or middle and `<width>` is
 	the total length of the content with alignment. If the
 	contents length is more than the width then no alignment is
-	performed. If used with '--quote' everything in between %(align:..)
-	and %(end) is quoted.
+	performed. If used with '--quote' everything in between
+	%(align:..)  and %(end) is quoted.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
@@ -148,8 +148,8 @@ The complete message in a commit and tag object is `contents`.
 Its first line is `contents:subject`, where subject is the concatenation
 of all lines of the commit message up to the first blank line.  The next
 line is 'contents:body', where body is all of the lines after the first
-blank line.  Finally, the optional GPG signature is `contents:signature`.
-The first `N` lines of the object is obtained using `contents:lines=N`.
+blank line.  The optional GPG signature is `contents:signature`.  The
+first `N` lines of the message is obtained using `contents:lines=N`.
 
 For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
diff --git a/ref-filter.c b/ref-filter.c
index f268cd7..b37d57a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -61,6 +61,8 @@ static struct {
 	{ "contents:lines" },
 };
 
+#define REF_FORMATTING_STATE_INIT  { 0, NULL }
+
 struct align {
 	align_type position;
 	unsigned int width;
@@ -71,8 +73,6 @@ struct contents {
 	struct object_id oid;
 };
 
-#define REF_FORMATTING_STATE_INIT  { 0, NULL }
-
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
@@ -87,8 +87,10 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
-	struct align *align;
-	struct contents *contents;
+	union {
+		struct align align;
+		struct contents contents;
+	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
@@ -183,6 +185,30 @@ static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
 	}
 }
 
+static void align_handler(struct ref_formatting_stack *stack)
+{
+	struct align *align = (struct align *)stack->cb_data;
+	struct strbuf s = STRBUF_INIT;
+
+	strbuf_utf8_align(&s, align->position, align->width, stack->output.buf);
+	strbuf_swap(&stack->output, &s);
+	strbuf_release(&s);
+}
+
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
+
 static void push_stack_element(struct ref_formatting_stack **stack)
 {
 	struct ref_formatting_stack *s = xcalloc(1, sizeof(struct ref_formatting_stack));
@@ -204,6 +230,37 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
 	*stack = prev;
 }
 
+static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *new;
+
+	push_stack_element(&state->stack);
+	new = state->stack;
+	new->at_end = align_handler;
+	new->cb_data = &atomv->u.align;
+}
+
+static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *current = state->stack;
+	struct strbuf s = STRBUF_INIT;
+
+	if (!current->at_end)
+		die(_("format: `end` atom used without a supporting atom"));
+	current->at_end(current);
+
+	/*
+	 * Perform quote formatting when the stack element is that of
+	 * a modifier atom and right above the first stack element.
+	 */
+	if (!state->stack->prev->prev) {
+		quote_formatting(&s, current->output.buf, state->quote_style);
+		strbuf_swap(&current->output, &s);
+	}
+	strbuf_release(&s);
+	pop_stack_element(&state->stack);
+}
+
 /*
  * In a format string, find the next occurrence of %(atom).
  */
@@ -580,34 +637,20 @@ static void find_subpos(const char *buf, unsigned long sz,
 
 /*
  * If 'lines' is greater than 0, append that many lines from the given
- * object_id 'oid' to the given strbuf.
+ * 'buf' of length 'size' to the given strbuf.
  */
-static void append_tag_lines(struct strbuf *out, const struct object_id *oid, int lines)
+static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
 {
 	int i;
-	unsigned long size;
-	enum object_type type;
-	char *buf, *sp, *eol;
+	const char *sp, *eol;
 	size_t len;
 
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
+	if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
+		size += 2;
+
+	sp = buf;
+
+	for (i = 0; i < lines && sp < buf + size; i++) {
 		if (i)
 			strbuf_addstr(out, "\n    ");
 		eol = memchr(sp, '\n', size - (sp - buf));
@@ -617,20 +660,6 @@ static void append_tag_lines(struct strbuf *out, const struct object_id *oid, in
 			break;
 		sp = eol + 1;
 	}
-free_return:
-	free(buf);
-}
-
-static void contents_lines_handler(struct atom_value *atomv, struct ref_formatting_state *state)
-{
-	struct contents *contents = (struct contents *)atomv->contents;
-	struct strbuf s = STRBUF_INIT;
-
-	append_tag_lines(&s, &contents->oid, contents->lines);
-	quote_formatting(&state->stack->output, s.buf, state->quote_style);
-	strbuf_release(&s);
-
-	free(contents);
 }
 
 /* See grab_values */
@@ -675,13 +704,11 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 		else if (!strcmp(name, "contents"))
 			v->s = xstrdup(subpos);
 		else if (skip_prefix(name, "contents:lines=", &valp)) {
-			struct contents *contents = xmalloc(sizeof(struct contents));
-
-			if (strtoul_ui(valp, 10, &contents->lines))
-				die(_("positive width expected align:%s"), valp);
-			hashcpy(contents->oid.hash, obj->sha1);
-			v->handler = contents_lines_handler;
-			v->contents = contents;
+			struct strbuf s = STRBUF_INIT;
+			if (strtoul_ui(valp, 10, &v->u.contents.lines))
+				die(_("positive width expected contents:lines=%s"), valp);
+			append_lines(&s, subpos, sublen + bodylen - siglen, v->u.contents.lines);
+			v->s = strbuf_detach(&s, NULL);
 		}
 	}
 }
@@ -740,63 +767,6 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static void align_handler(struct ref_formatting_stack *stack)
-{
-	struct align *align = (struct align *)stack->cb_data;
-	struct strbuf s = STRBUF_INIT;
-
-	strbuf_utf8_align(&s, align->position, align->width, stack->output.buf);
-	strbuf_swap(&stack->output, &s);
-	strbuf_release(&s);
-	free(align);
-}
-
-static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
-{
-	struct ref_formatting_stack *new;
-
-	push_stack_element(&state->stack);
-	new = state->stack;
-	new->at_end = align_handler;
-	new->cb_data = atomv->align;
-}
-
-static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
-{
-	/*
-	 * Quote formatting is only done when the stack has a single
-	 * element. Otherwise quote formatting is done on the
-	 * element's entire output strbuf when the %(end) atom is
-	 * encountered.
-	 */
-	if (!state->stack->prev)
-		quote_formatting(&state->stack->output, v->s, state->quote_style);
-	else
-		strbuf_addstr(&state->stack->output, v->s);
-}
-
-static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
-{
-	struct ref_formatting_stack *current = state->stack;
-	struct strbuf s = STRBUF_INIT;
-
-	if (!current->at_end)
-		die(_("format: `end` atom used without a supporting atom"));
-	current->at_end(current);
-	/*
-	 * Whenever we have more than one stack element that means we
-	 * are using a certain modifier atom. In that case we need to
-	 * perform quote formatting.
-	 */
-	if (state->stack->prev) {
-		quote_formatting(&s, current->output.buf, state->quote_style);
-		strbuf_reset(&current->output);
-		strbuf_addbuf(&current->output, &s);
-	}
-	strbuf_release(&s);
-	pop_stack_element(&state->stack);
-}
-
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -893,21 +863,27 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
-		} else if (!strcmp(name, "align"))
-			die(_("format: incomplete use of the `align` atom"));
-		else if (skip_prefix(name, "align:", &valp)) {
-			struct align *align = xmalloc(sizeof(struct align));
-			struct strbuf **s = strbuf_split_str(valp, ',', 0);
+		} else if (skip_prefix(name, "align", &valp)) {
+			struct align *align = &v->u.align;
+			struct strbuf **s;
+
+			if (valp[0] != ':')
+				die(_("format: usage %%(align:<width>,<position>)"));
+			else
+				valp++;
+
+			s = strbuf_split_str(valp, ',', 0);
 
 			/* If the position is given trim the ',' from the first strbuf */
 			if (s[1])
-				strbuf_remove(s[0], s[0]->len - 1, 1);
+				strbuf_setlen(s[0], s[0]->len - 1);
 
 			if (strtoul_ui(s[0]->buf, 10, &align->width))
 				die(_("positive width expected align:%s"), s[0]->buf);
 
-			/* If no position is given, default to ALIGN_LEFT */
-			if (!s[1] || !strcmp(s[1]->buf, "left"))
+			if (!s[1])
+				align->position = ALIGN_LEFT;
+			else if (!strcmp(s[1]->buf, "left"))
 				align->position = ALIGN_LEFT;
 			else if (!strcmp(s[1]->buf, "right"))
 				align->position = ALIGN_RIGHT;
@@ -918,7 +894,6 @@ static void populate_value(struct ref_array_item *ref)
 
 			strbuf_list_free(s);
 
-			v->align = align;
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
@@ -1554,10 +1529,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
-void format_ref_array_item(struct strbuf *out, struct ref_array_item *info,
-			   const char *format, int quote_style)
+void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
+	struct strbuf *final_buf;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 
 	state.quote_style = quote_style;
@@ -1587,17 +1562,10 @@ void format_ref_array_item(struct strbuf *out, struct ref_array_item *info,
 	}
 	if (state.stack->prev)
 		die(_("format: `end` atom missing"));
-	strbuf_addbuf(out, &state.stack->output);
+	final_buf = &state.stack->output;
+	fwrite(final_buf->buf, 1, final_buf->len, stdout);
 	pop_stack_element(&state.stack);
-}
-
-void show_ref_array_item(struct ref_array_item *item, const char *format, unsigned int quote_style)
-{
-	struct strbuf out = STRBUF_INIT;
-	format_ref_array_item(&out, item, format, quote_style);
-	fwrite(out.buf, out.len, 1, stdout);
-	printf("\n");
-	strbuf_release(&out);
+	putchar('\n');
 }
 
 /*  If no sorting option is given, use refname to sort as default */
diff --git a/ref-filter.h b/ref-filter.h
index 179944c..a5cfa5e 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -94,11 +94,8 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
 int verify_ref_format(const char *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
-/*  Format the ref as per given format and quote_style and store it into the strbuf */
-void format_ref_array_item(struct strbuf *out, struct ref_array_item *info,
-			   const char *format, int quote_style);
-/*  Wrapper around format_ref_array_item() which prints the given ref_array_item */
-void show_ref_array_item(struct ref_array_item *item, const char *format, unsigned int quote_style);
+/*  Print the ref using the given format and quote_style */
+void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
 /*  Callback function for parsing the sort option */
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 8f18f86..d95b781 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -166,22 +166,58 @@ test_expect_success 'nested alignment' '
 	test_cmp expect actual
 '
 
-test_expect_success 'check `%(contents:lines=X)`' '
+test_expect_success 'check `%(contents:lines=1)`' '
 	cat >expect <<-\EOF &&
-	master three
-	side four
-	odd/spot three
-	double-tag Annonated doubly
-	four four
-	one one
-	signed-tag A signed tag message
-	three three
-	two two
-	EOF
-	git for-each-ref --format="%(refname:short) %(contents:lines=1)" >actual &&
+	master |three
+	side |four
+	odd/spot |three
+	double-tag |Annonated doubly
+	four |four
+	one |one
+	signed-tag |A signed tag message
+	three |three
+	two |two
+	EOF
+	git for-each-ref --format="%(refname:short) |%(contents:lines=1)" >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'check `%(contents:lines=0)`' '
+	cat >expect <<-\EOF &&
+	master |
+	side |
+	odd/spot |
+	double-tag |
+	four |
+	one |
+	signed-tag |
+	three |
+	two |
+	EOF
+	git for-each-ref --format="%(refname:short) |%(contents:lines=0)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check `%(contents:lines=99999)`' '
+	cat >expect <<-\EOF &&
+	master |three
+	side |four
+	odd/spot |three
+	double-tag |Annonated doubly
+	four |four
+	one |one
+	signed-tag |A signed tag message
+	three |three
+	two |two
+	EOF
+	git for-each-ref --format="%(refname:short) |%(contents:lines=99999)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '`%(contents:lines=-1)` should fail' '
+	test_must_fail git for-each-ref --format="%(refname:short) |%(contents:lines=-1)"
+'
+
 test_expect_success 'setup for version sort' '
 	test_commit foo1.3 &&
 	test_commit foo1.6 &&

-- 
2.5.0
