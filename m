From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v16 00/14] port tag.c to use ref-filter APIs
Date: Sun,  6 Sep 2015 00:22:01 +0530
Message-ID: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 20:52:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYIZk-0001yq-0O
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 20:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbbIESwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 14:52:10 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33530 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbbIESwH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 14:52:07 -0400
Received: by pacex6 with SMTP id ex6so55052037pac.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CdOerZaJAUKOgwvUEF2cRkRDtBMzIoWVFnzfkz1iBZU=;
        b=h0tQjJ9Z53v89ZXpXLnfFYfeZYgObCaFa6pO3eulokwGHcNPFs1W+xc65glVHJwD1c
         04KfUipkl20T6aC79Fv/CQorUaltN46mfJOrh9RzTrCyMMegIQa2nus/W+s9ryi+VVLu
         /oddk/Rl5EOJh/nBc+NJSjZYyE9kzeUQoPiR32MkEVy4jiNYMyeyrwYnpgwtVUcM3HsA
         qE0Y40R2u2hQCwMkzzQxiRQ1UVTo6S+AjLmFnqILpiWODwvKbTdiTMWk/GinULKUJS45
         0KnQQfaZJjPNMj6RA7ooVWHUBYh3ZIcjhUC+IDkrGJJLzozi4Kuzk1MS9O6cGMhVvIiw
         oxCw==
X-Received: by 10.66.141.231 with SMTP id rr7mr24182960pab.11.1441479127059;
        Sat, 05 Sep 2015 11:52:07 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ch3sm6583639pbb.18.2015.09.05.11.52.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Sep 2015 11:52:06 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277394>

Version 15 can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/277012

Changes in this version:
* Grammatical changes.
* rename cb_data to at_end_data.
* rename align_handler() to end_align_handler() and move it
next to align_atom_handler().
* introduce match_atom_name() for checking atom names.

Karthik Nayak (14):
  ref-filter: move `struct atom_value` to ref-filter.c
  ref-filter: introduce ref_formatting_state and ref_formatting_stack
  utf8: add function to align a string into given strbuf
  ref-filter: introduce handler function for each atom
  ref-filter: introduce match_atom_name()
  ref-filter: implement an `align` atom
  ref-filter: add option to filter out tags, branches and remotes
  ref-filter: add support for %(contents:lines=X)
  ref-filter: add support to sort by version
  ref-filter: add option to match literal pattern
  tag.c: use 'ref-filter' data structures
  tag.c: use 'ref-filter' APIs
  tag.c: implement '--format' option
  tag.c: implement '--merged' and '--no-merged' options

 Documentation/git-for-each-ref.txt |  16 +-
 Documentation/git-tag.txt          |  27 ++-
 builtin/for-each-ref.c             |   1 +
 builtin/tag.c                      | 368 ++++++--------------------------
 ref-filter.c                       | 415 ++++++++++++++++++++++++++++++++-----
 ref-filter.h                       |  25 ++-
 refs.c                             |   9 +
 refs.h                             |   1 +
 t/t6302-for-each-ref-filter.sh     | 174 ++++++++++++++++
 t/t7004-tag.sh                     |  47 ++++-
 utf8.c                             |  21 ++
 utf8.h                             |  15 ++
 12 files changed, 743 insertions(+), 376 deletions(-)

Interdiff:

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d039f40..c5154bb 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -128,13 +128,14 @@ color::
 	are described in `color.branch.*`.
 
 align::
-	Left-, middle-, or right-align the content between %(align:..)
+	Left-, middle-, or right-align the content between %(align:...)
 	and %(end). Followed by `:<width>,<position>`, where the
 	`<position>` is either left, right or middle and `<width>` is
 	the total length of the content with alignment. If the
 	contents length is more than the width then no alignment is
 	performed. If used with '--quote' everything in between
-	%(align:..)  and %(end) is quoted.
+	%(align:...) and %(end) is quoted, but if nested then only the
+	topmost level performs quoting.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/builtin/tag.c b/builtin/tag.c
index 9fa1400..f55dfda 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -43,8 +43,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 
 	if (!format) {
 		if (filter->lines)
-			format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
-						   filter->lines);
+			format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) "
+						   "%%(contents:lines=%d)", filter->lines);
 		else
 			format = "%(refname:short)";
 	}
diff --git a/ref-filter.c b/ref-filter.c
index b37d57a..e3024d3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -77,7 +77,7 @@ struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
 	void (*at_end)(struct ref_formatting_stack *stack);
-	void *cb_data;
+	void *at_end_data;
 };
 
 struct ref_formatting_state {
@@ -185,16 +185,6 @@ static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
 	}
 }
 
-static void align_handler(struct ref_formatting_stack *stack)
-{
-	struct align *align = (struct align *)stack->cb_data;
-	struct strbuf s = STRBUF_INIT;
-
-	strbuf_utf8_align(&s, align->position, align->width, stack->output.buf);
-	strbuf_swap(&stack->output, &s);
-	strbuf_release(&s);
-}
-
 static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
 {
 	/*
@@ -230,14 +220,24 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
 	*stack = prev;
 }
 
+static void end_align_handler(struct ref_formatting_stack *stack)
+{
+	struct align *align = (struct align *)stack->at_end_data;
+	struct strbuf s = STRBUF_INIT;
+
+	strbuf_utf8_align(&s, align->position, align->width, stack->output.buf);
+	strbuf_swap(&stack->output, &s);
+	strbuf_release(&s);
+}
+
 static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
 	struct ref_formatting_stack *new;
 
 	push_stack_element(&state->stack);
 	new = state->stack;
-	new->at_end = align_handler;
-	new->cb_data = &atomv->u.align;
+	new->at_end = end_align_handler;
+	new->at_end_data = &atomv->u.align;
 }
 
 static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
@@ -246,12 +246,13 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	struct strbuf s = STRBUF_INIT;
 
 	if (!current->at_end)
-		die(_("format: `end` atom used without a supporting atom"));
+		die(_("format: %%(end) atom used without corresponding atom"));
 	current->at_end(current);
 
 	/*
 	 * Perform quote formatting when the stack element is that of
-	 * a modifier atom and right above the first stack element.
+	 * a supporting atom. If nested then perform quote formatting
+	 * only on the topmost supporting atom.
 	 */
 	if (!state->stack->prev->prev) {
 		quote_formatting(&s, current->output.buf, state->quote_style);
@@ -261,6 +262,22 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	pop_stack_element(&state->stack);
 }
 
+static int match_atom_name(const char *name, const char *atom_name, const char **val)
+{
+	const char *body;
+
+	if (!skip_prefix(name, atom_name, &body))
+		return 0; /* doesn't even begin with "atom_name" */
+	if (!body[0] || !body[1]) {
+		*val = NULL; /* %(atom_name) and no customization */
+		return 1;
+	}
+	if (body[0] != ':')
+		return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
+	*val = body + 1; /* "atomname:val" */
+	return 1;
+}
+
 /*
  * In a format string, find the next occurrence of %(atom).
  */
@@ -645,9 +662,6 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 	const char *sp, *eol;
 	size_t len;
 
-	if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
-		size += 2;
-
 	sp = buf;
 
 	for (i = 0; i < lines && sp < buf + size; i++) {
@@ -705,9 +719,12 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			v->s = xstrdup(subpos);
 		else if (skip_prefix(name, "contents:lines=", &valp)) {
 			struct strbuf s = STRBUF_INIT;
+			const char *contents_end = bodylen + bodypos - siglen;
+
 			if (strtoul_ui(valp, 10, &v->u.contents.lines))
-				die(_("positive width expected contents:lines=%s"), valp);
-			append_lines(&s, subpos, sublen + bodylen - siglen, v->u.contents.lines);
+				die(_("positive value expected contents:lines=%s"), valp);
+			/*  Size is the length of the message after removing the signature */
+			append_lines(&s, subpos, contents_end - subpos, v->u.contents.lines);
 			v->s = strbuf_detach(&s, NULL);
 		}
 	}
@@ -830,10 +847,12 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_push(branch, NULL);
 			if (!refname)
 				continue;
-		} else if (starts_with(name, "color:")) {
+		} else if (match_atom_name(name, "color", &valp)) {
 			char color[COLOR_MAXLEN] = "";
 
-			if (color_parse(name + 6, color) < 0)
+			if (!valp)
+				die(_("expected format: %%(color:<color>)"));
+			if (color_parse(valp, color) < 0)
 				die(_("unable to parse format"));
 			v->s = xstrdup(color);
 			continue;
@@ -863,24 +882,32 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
-		} else if (skip_prefix(name, "align", &valp)) {
+		} else if (match_atom_name(name, "align", &valp)) {
 			struct align *align = &v->u.align;
 			struct strbuf **s;
 
-			if (valp[0] != ':')
-				die(_("format: usage %%(align:<width>,<position>)"));
-			else
-				valp++;
+			if (!valp)
+				die(_("expected format: %%(align:<width>, <position>)"));
 
+			/*
+			 * TODO: Implement a function similar to strbuf_split_str()
+			 * which would strip the terminator at the end.
+			 */
 			s = strbuf_split_str(valp, ',', 0);
 
 			/* If the position is given trim the ',' from the first strbuf */
 			if (s[1])
 				strbuf_setlen(s[0], s[0]->len - 1);
+			if (s[2])
+				die(_("align:<width>,<position> followed by garbage: %s"), s[2]->buf);
 
 			if (strtoul_ui(s[0]->buf, 10, &align->width))
 				die(_("positive width expected align:%s"), s[0]->buf);
 
+			/*
+			 * TODO: Implement a more general check, so that the values
+			 * do not always have to be in a specific order.
+			 */
 			if (!s[1])
 				align->position = ALIGN_LEFT;
 			else if (!strcmp(s[1]->buf, "left"))
@@ -1294,11 +1321,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
-	/*
-	 * Get the current ref kind. If we're filtering tags, remotes or local branches
-	 * only then the current ref-kind is nothing but filter->kind and filter_ref_kind()
-	 * will only return that value.
-	 */
+	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
 	kind = filter_ref_kind(filter, refname);
 	if (!(kind & filter->kind))
 		return 0;
@@ -1424,6 +1447,12 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	if (!filter->kind)
 		die("filter_refs: invalid type");
 	else {
+		/*
+		 * For common cases where we need only branches or remotes or tags,
+		 * we only iterate through those refs. If a mix of refs is needed,
+		 * we iterate over all refs and filter out required refs with the help
+		 * of filter_ref_kind().
+		 */
 		if (filter->kind == FILTER_REFS_BRANCHES)
 			ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata, broken);
 		else if (filter->kind == FILTER_REFS_REMOTES)
@@ -1561,7 +1590,7 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		append_atom(&resetv, &state);
 	}
 	if (state.stack->prev)
-		die(_("format: `end` atom missing"));
+		die(_("format: %%(end) atom missing"));
 	final_buf = &state.stack->output;
 	fwrite(final_buf->buf, 1, final_buf->len, stdout);
 	pop_stack_element(&state.stack);
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index d95b781..4bc1055 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -81,6 +81,10 @@ test_expect_success 'filtering with --contains' '
 	test_cmp expect actual
 '
 
+test_expect_success '%(color) must fail' '
+	test_must_fail git for-each-ref --format="%(color)%(refname)"
+'
+
 test_expect_success 'left alignment' '
 	cat >expect <<-\EOF &&
 	refname is refs/heads/master  |refs/heads/master
@@ -129,42 +133,39 @@ test_expect_success 'right alignment' '
 	test_cmp expect actual
 '
 
-# Everything in between the %(align)...%(end) atom must be quoted, hence we test this by
-# introducing single quote's in %(align)...%(end), which must not be escaped.
-
-sq="'"
+# Individual atoms inside %(align:...) and %(end) must not be quoted.
 
-test_expect_success 'alignment with format quote' '
-	cat >expect <<-EOF &&
-	refname is ${sq}           ${sq}\\${sq}${sq}master${sq}\\${sq}${sq}           ${sq}|
-	refname is ${sq}            ${sq}\\${sq}${sq}side${sq}\\${sq}${sq}            ${sq}|
-	refname is ${sq}          ${sq}\\${sq}${sq}odd/spot${sq}\\${sq}${sq}          ${sq}|
-	refname is ${sq}         ${sq}\\${sq}${sq}double-tag${sq}\\${sq}${sq}         ${sq}|
-	refname is ${sq}            ${sq}\\${sq}${sq}four${sq}\\${sq}${sq}            ${sq}|
-	refname is ${sq}            ${sq}\\${sq}${sq}one${sq}\\${sq}${sq}             ${sq}|
-	refname is ${sq}         ${sq}\\${sq}${sq}signed-tag${sq}\\${sq}${sq}         ${sq}|
-	refname is ${sq}           ${sq}\\${sq}${sq}three${sq}\\${sq}${sq}            ${sq}|
-	refname is ${sq}            ${sq}\\${sq}${sq}two${sq}\\${sq}${sq}             ${sq}|
+test_expect_success 'alignment with format quote' "
+	cat >expect <<-\EOF &&
+	|'       master| A U Thor       '|
+	|'        side| A U Thor        '|
+	|'      odd/spot| A U Thor      '|
+	|'         double-tag|          '|
+	|'        four| A U Thor        '|
+	|'        one| A U Thor         '|
+	|'         signed-tag|          '|
+	|'       three| A U Thor        '|
+	|'        two| A U Thor         '|
 	EOF
-	git for-each-ref --shell --format="refname is %(align:30,middle)${sq}%(refname:short)${sq}%(end)|" >actual &&
+	git for-each-ref --shell --format='|%(align:30,middle)%(refname:short)| %(authorname)%(end)|' >actual &&
 	test_cmp expect actual
-'
+"
 
-test_expect_success 'nested alignment' '
+test_expect_success 'nested alignment with quote formatting' "
 	cat >expect <<-\EOF &&
-	|         master               |
-	|           side               |
-	|       odd/spot               |
-	|     double-tag               |
-	|           four               |
-	|            one               |
-	|     signed-tag               |
-	|          three               |
-	|            two               |
+	|'         master               '|
+	|'           side               '|
+	|'       odd/spot               '|
+	|'     double-tag               '|
+	|'           four               '|
+	|'            one               '|
+	|'     signed-tag               '|
+	|'          three               '|
+	|'            two               '|
 	EOF
-	git for-each-ref --format="|%(align:30,left)%(align:15,right)%(refname:short)%(end)%(end)|" >actual &&
+	git for-each-ref --shell --format='|%(align:30,left)%(align:15,right)%(refname:short)%(end)%(end)|' >actual &&
 	test_cmp expect actual
-'
+"
 
 test_expect_success 'check `%(contents:lines=1)`' '
 	cat >expect <<-\EOF &&

-- 
2.5.1
