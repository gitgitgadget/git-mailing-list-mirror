From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] core.whitespace: documentation updates.
Date: Thu, 06 Dec 2007 01:04:56 -0800
Message-ID: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
References: <7v8x4os223.fsf@gitster.siamese.dyndns.org>
	<7v4pfcs20b.fsf@gitster.siamese.dyndns.org>
	<7v7ik7quc6.fsf_-_@gitster.siamese.dyndns.org>
	<20071124202257.GC12864@fieldses.org>
	<7v3auvqq09.fsf@gitster.siamese.dyndns.org>
	<20071125215819.GD23820@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 10:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Cfr-0007Lr-Me
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 10:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbXLFJFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 04:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbXLFJFJ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 04:05:09 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33488 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbXLFJFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 04:05:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B589F2EF;
	Thu,  6 Dec 2007 04:05:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B9CB9C73A;
	Thu,  6 Dec 2007 04:05:19 -0500 (EST)
In-Reply-To: <20071125215819.GD23820@fieldses.org> (J. Bruce Fields's message
	of "Sun, 25 Nov 2007 21:58:19 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67272>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Sat, Nov 24, 2007 at 01:42:46PM -0800, Junio C Hamano wrote:
>> "J. Bruce Fields" <bfields@fieldses.org> writes:
>> 
>> > I'd still prefer this to be a gitattributes thing rather than a config
>> > variable[1].  Last time I raised this you said something to the effect
>> > of "I think you're right, let's fix that before it's merged."  Would you
>> > like me to work on that?
>> 
>> Ah, I forgot about that, and you are right.  Go wild.
>
> OK, I will go wild, but... very slowly.

How wild are you these days ;-)?  I know December is a busy time for
everybody, and I ended up doing this myself while I was writing up the
API documentation for gitattributes.

-- >8 --
[PATCH] Use gitattributes to define per-path whitespace rule

The `core.whitespace` configuration variable allows you to define what
`diff` and `apply` should consider whitespace errors for all paths in
the project (See gitlink:git-config[1]).  This attribute gives you finer
control per path.

For example, if you have these in the .gitattributes:

    frotz   whitespace
    nitfol  -whitespace
    xyzzy   whitespace=-trailing

all types of whitespace problems known to git are noticed in path 'frotz'
(i.e. diff shows them in diff.whitespace color, and apply warns about
them), no whitespace problem is noticed in path 'nitfol', and the
default types of whitespace problems except "trailing whitespace" are
noticed for path 'xyzzy'.  A project with mixed Python and C might want
to have:

    *.c    whitespace
    *.py   whitespace=-indent-with-non-tab

in its toplevel .gitattributes file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitattributes.txt |   31 +++++++++++++
 Makefile                        |    2 +-
 builtin-apply.c                 |   36 +++++++++------
 cache.h                         |    4 +-
 config.c                        |   50 +--------------------
 diff.c                          |   19 +++++---
 environment.c                   |    2 +-
 t/t4019-diff-wserror.sh         |   47 +++++++++++++++++++
 t/t4124-apply-ws-rule.sh        |   20 ++++++++-
 ws.c                            |   96 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 233 insertions(+), 74 deletions(-)
 create mode 100644 ws.c

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 20cf8ff..c4bcbb9 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -360,6 +360,37 @@ When left unspecified, the driver itself is used for both
 internal merge and the final merge.
 
 
+Checking whitespace errors
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+`whitespace`
+^^^^^^^^^^^^
+
+The `core.whitespace` configuration variable allows you to define what
+`diff` and `apply` should consider whitespace errors for all paths in
+the project (See gitlink:git-config[1]).  This attribute gives you finer
+control per path.
+
+Set::
+
+	Notice all types of potential whitespace errors known to git.
+
+Unset::
+
+	Do not notice anything as error.
+
+Unspecified::
+
+	Use the value of `core.whitespace` configuration variable to
+	decide what to notice as error.
+
+String::
+
+	Specify a comma separate list of common whitespace problems to
+	notice in the same format as `core.whitespace` configuration
+	variable.
+
+
 EXAMPLE
 -------
 
diff --git a/Makefile b/Makefile
index 042f79e..ac6b079 100644
--- a/Makefile
+++ b/Makefile
@@ -312,7 +312,7 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
-	transport.o bundle.o walker.o parse-options.o
+	transport.o bundle.o walker.o parse-options.o ws.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-apply.c b/builtin-apply.c
index 57efcd5..ee3ef60 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -144,6 +144,7 @@ struct patch {
 	unsigned int old_mode, new_mode;
 	int is_new, is_delete;	/* -1 = unknown, 0 = false, 1 = true */
 	int rejected;
+	unsigned ws_rule;
 	unsigned long deflate_origlen;
 	int lines_added, lines_deleted;
 	int score;
@@ -898,7 +899,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 	return -1;
 }
 
-static void check_whitespace(const char *line, int len)
+static void check_whitespace(const char *line, int len, unsigned ws_rule)
 {
 	const char *err = "Adds trailing whitespace";
 	int seen_space = 0;
@@ -910,14 +911,14 @@ static void check_whitespace(const char *line, int len)
 	 * this function.  That is, an addition of an empty line would
 	 * check the '+' here.  Sneaky...
 	 */
-	if ((whitespace_rule & WS_TRAILING_SPACE) && isspace(line[len-2]))
+	if ((ws_rule & WS_TRAILING_SPACE) && isspace(line[len-2]))
 		goto error;
 
 	/*
 	 * Make sure that there is no space followed by a tab in
 	 * indentation.
 	 */
-	if (whitespace_rule & WS_SPACE_BEFORE_TAB) {
+	if (ws_rule & WS_SPACE_BEFORE_TAB) {
 		err = "Space in indent is followed by a tab";
 		for (i = 1; i < len; i++) {
 			if (line[i] == '\t') {
@@ -935,7 +936,7 @@ static void check_whitespace(const char *line, int len)
 	 * Make sure that the indentation does not contain more than
 	 * 8 spaces.
 	 */
-	if ((whitespace_rule & WS_INDENT_WITH_NON_TAB) &&
+	if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
 	    (8 < len) && !strncmp("+        ", line, 9)) {
 		err = "Indent more than 8 places with spaces";
 		goto error;
@@ -1001,7 +1002,7 @@ static int parse_fragment(char *line, unsigned long size,
 		case '-':
 			if (apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
-				check_whitespace(line, len);
+				check_whitespace(line, len, patch->ws_rule);
 			deleted++;
 			oldlines--;
 			trailing = 0;
@@ -1009,7 +1010,7 @@ static int parse_fragment(char *line, unsigned long size,
 		case '+':
 			if (!apply_in_reverse &&
 			    ws_error_action != nowarn_ws_error)
-				check_whitespace(line, len);
+				check_whitespace(line, len, patch->ws_rule);
 			added++;
 			newlines--;
 			trailing = 0;
@@ -1318,6 +1319,10 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 	if (offset < 0)
 		return offset;
 
+	patch->ws_rule = whitespace_rule(patch->new_name
+					 ? patch->new_name
+					 : patch->old_name);
+
 	patchsize = parse_single_patch(buffer + offset + hdrsize,
 				       size - offset - hdrsize, patch);
 
@@ -1568,7 +1573,8 @@ static void remove_last_line(const char **rbuf, int *rsize)
 	*rsize = offset + 1;
 }
 
-static int apply_line(char *output, const char *patch, int plen)
+static int apply_line(char *output, const char *patch, int plen,
+		      unsigned ws_rule)
 {
 	/*
 	 * plen is number of bytes to be copied from patch,
@@ -1593,7 +1599,7 @@ static int apply_line(char *output, const char *patch, int plen)
 	/*
 	 * Strip trailing whitespace
 	 */
-	if ((whitespace_rule & WS_TRAILING_SPACE) &&
+	if ((ws_rule & WS_TRAILING_SPACE) &&
 	    (1 < plen && isspace(patch[plen-1]))) {
 		if (patch[plen] == '\n')
 			add_nl_to_tail = 1;
@@ -1610,12 +1616,12 @@ static int apply_line(char *output, const char *patch, int plen)
 		char ch = patch[i];
 		if (ch == '\t') {
 			last_tab_in_indent = i;
-			if ((whitespace_rule & WS_SPACE_BEFORE_TAB) &&
+			if ((ws_rule & WS_SPACE_BEFORE_TAB) &&
 			    0 <= last_space_in_indent)
 			    need_fix_leading_space = 1;
 		} else if (ch == ' ') {
 			last_space_in_indent = i;
-			if ((whitespace_rule & WS_INDENT_WITH_NON_TAB) &&
+			if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
 			    last_tab_in_indent < 0 &&
 			    8 <= i)
 				need_fix_leading_space = 1;
@@ -1629,7 +1635,7 @@ static int apply_line(char *output, const char *patch, int plen)
 		int consecutive_spaces = 0;
 		int last = last_tab_in_indent + 1;
 
-		if (whitespace_rule & WS_INDENT_WITH_NON_TAB) {
+		if (ws_rule & WS_INDENT_WITH_NON_TAB) {
 			/* have "last" point at one past the indent */
 			if (last_tab_in_indent < last_space_in_indent)
 				last = last_space_in_indent + 1;
@@ -1671,7 +1677,7 @@ static int apply_line(char *output, const char *patch, int plen)
 }
 
 static int apply_one_fragment(struct strbuf *buf, struct fragment *frag,
-			      int inaccurate_eof)
+			      int inaccurate_eof, unsigned ws_rule)
 {
 	int match_beginning, match_end;
 	const char *patch = frag->patch;
@@ -1730,7 +1736,7 @@ static int apply_one_fragment(struct strbuf *buf, struct fragment *frag,
 		case '+':
 			if (first != '+' || !no_add) {
 				int added = apply_line(new + newsize, patch,
-						       plen);
+						       plen, ws_rule);
 				newsize += added;
 				if (first == '+' &&
 				    added == 1 && new[newsize-1] == '\n')
@@ -1953,12 +1959,14 @@ static int apply_fragments(struct strbuf *buf, struct patch *patch)
 {
 	struct fragment *frag = patch->fragments;
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
+	unsigned ws_rule = patch->ws_rule;
+	unsigned inaccurate_eof = patch->inaccurate_eof;
 
 	if (patch->is_binary)
 		return apply_binary(buf, patch);
 
 	while (frag) {
-		if (apply_one_fragment(buf, frag, patch->inaccurate_eof)) {
+		if (apply_one_fragment(buf, frag, inaccurate_eof, ws_rule)) {
 			error("patch failed: %s:%ld", name, frag->oldpos);
 			if (!apply_with_reject)
 				return -1;
diff --git a/cache.h b/cache.h
index 3f42827..9cc6268 100644
--- a/cache.h
+++ b/cache.h
@@ -610,6 +610,8 @@ void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, i
 #define WS_SPACE_BEFORE_TAB	02
 #define WS_INDENT_WITH_NON_TAB	04
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
-extern unsigned whitespace_rule;
+extern unsigned whitespace_rule_cfg;
+extern unsigned whitespace_rule(const char *);
+extern unsigned parse_whitespace_rule(const char *);
 
 #endif /* CACHE_H */
diff --git a/config.c b/config.c
index d5b9766..2500e0d 100644
--- a/config.c
+++ b/config.c
@@ -246,54 +246,6 @@ static unsigned long get_unit_factor(const char *end)
 	die("unknown unit: '%s'", end);
 }
 
-static struct whitespace_rule {
-	const char *rule_name;
-	unsigned rule_bits;
-} whitespace_rule_names[] = {
-	{ "trailing-space", WS_TRAILING_SPACE },
-	{ "space-before-tab", WS_SPACE_BEFORE_TAB },
-	{ "indent-with-non-tab", WS_INDENT_WITH_NON_TAB },
-};
-
-static unsigned parse_whitespace_rule(const char *string)
-{
-	unsigned rule = WS_DEFAULT_RULE;
-
-	while (string) {
-		int i;
-		size_t len;
-		const char *ep;
-		int negated = 0;
-
-		string = string + strspn(string, ", \t\n\r");
-		ep = strchr(string, ',');
-		if (!ep)
-			len = strlen(string);
-		else
-			len = ep - string;
-
-		if (*string == '-') {
-			negated = 1;
-			string++;
-			len--;
-		}
-		if (!len)
-			break;
-		for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++) {
-			if (strncmp(whitespace_rule_names[i].rule_name,
-				    string, len))
-				continue;
-			if (negated)
-				rule &= ~whitespace_rule_names[i].rule_bits;
-			else
-				rule |= whitespace_rule_names[i].rule_bits;
-			break;
-		}
-		string = ep;
-	}
-	return rule;
-}
-
 int git_parse_long(const char *value, long *ret)
 {
 	if (value && *value) {
@@ -480,7 +432,7 @@ int git_default_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.whitespace")) {
-		whitespace_rule = parse_whitespace_rule(value);
+		whitespace_rule_cfg = parse_whitespace_rule(value);
 		return 0;
 	}
 
diff --git a/diff.c b/diff.c
index 6bb902f..c3a1942 100644
--- a/diff.c
+++ b/diff.c
@@ -454,6 +454,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 struct emit_callback {
 	struct xdiff_emit_state xm;
 	int nparents, color_diff;
+	unsigned ws_rule;
 	const char **label_path;
 	struct diff_words_data *diff_words;
 	int *found_changesp;
@@ -493,8 +494,8 @@ static void emit_line(const char *set, const char *reset, const char *line, int
 }
 
 static void emit_line_with_ws(int nparents,
-		const char *set, const char *reset, const char *ws,
-		const char *line, int len)
+			      const char *set, const char *reset, const char *ws,
+			      const char *line, int len, unsigned ws_rule)
 {
 	int col0 = nparents;
 	int last_tab_in_indent = -1;
@@ -511,7 +512,7 @@ static void emit_line_with_ws(int nparents,
 	for (i = col0; i < len; i++) {
 		if (line[i] == '\t') {
 			last_tab_in_indent = i;
-			if ((whitespace_rule & WS_SPACE_BEFORE_TAB) &&
+			if ((ws_rule & WS_SPACE_BEFORE_TAB) &&
 			    0 <= last_space_in_indent)
 				need_highlight_leading_space = 1;
 		}
@@ -520,7 +521,7 @@ static void emit_line_with_ws(int nparents,
 		else
 			break;
 	}
-	if ((whitespace_rule & WS_INDENT_WITH_NON_TAB) &&
+	if ((ws_rule & WS_INDENT_WITH_NON_TAB) &&
 	    0 <= last_space_in_indent &&
 	    last_tab_in_indent < 0 &&
 	    8 <= (i - col0)) {
@@ -551,7 +552,7 @@ static void emit_line_with_ws(int nparents,
 	tail = len - 1;
 	if (line[tail] == '\n' && i < tail)
 		tail--;
-	if (whitespace_rule & WS_TRAILING_SPACE) {
+	if (ws_rule & WS_TRAILING_SPACE) {
 		while (i < tail) {
 			if (!isspace(line[tail]))
 				break;
@@ -578,7 +579,7 @@ static void emit_add_line(const char *reset, struct emit_callback *ecbdata, cons
 		emit_line(set, reset, line, len);
 	else
 		emit_line_with_ws(ecbdata->nparents, set, reset, ws,
-				line, len);
+				  line, len, ecbdata->ws_rule);
 }
 
 static void fn_out_consume(void *priv, char *line, unsigned long len)
@@ -994,6 +995,7 @@ struct checkdiff_t {
 	struct xdiff_emit_state xm;
 	const char *filename;
 	int lineno, color_diff;
+	unsigned ws_rule;
 };
 
 static void checkdiff_consume(void *priv, char *line, unsigned long len)
@@ -1029,7 +1031,8 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 			if (white_space_at_end)
 				printf("white space at end");
 			printf(":%s ", reset);
-			emit_line_with_ws(1, set, reset, ws, line, len);
+			emit_line_with_ws(1, set, reset, ws, line, len,
+					  data->ws_rule);
 		}
 
 		data->lineno++;
@@ -1330,6 +1333,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = o->color_diff;
 		ecbdata.found_changesp = &o->found_changes;
+		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
@@ -1423,6 +1427,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.filename = name_b ? name_b : name_a;
 	data.lineno = 0;
 	data.color_diff = o->color_diff;
+	data.ws_rule = whitespace_rule(data.filename);
 
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
diff --git a/environment.c b/environment.c
index 624dd96..2fbbc8e 100644
--- a/environment.c
+++ b/environment.c
@@ -35,7 +35,7 @@ int pager_in_use;
 int pager_use_color = 1;
 char *editor_program;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
-unsigned whitespace_rule = WS_DEFAULT_RULE;
+unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index dbc895b..67e080b 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -45,8 +45,24 @@ test_expect_success 'without -trail' '
 
 '
 
+test_expect_success 'without -trail (attribute)' '
+
+	git config --unset core.whitespace
+	echo "F whitespace=-trail" >.gitattributes
+	git diff --color >output
+	grep "$blue_grep" output >error
+	grep -v "$blue_grep" output >normal
+
+	grep Eight normal >/dev/null &&
+	grep HT error >/dev/null &&
+	grep With normal >/dev/null &&
+	grep No normal >/dev/null
+
+'
+
 test_expect_success 'without -space' '
 
+	rm -f .gitattributes
 	git config core.whitespace -space
 	git diff --color >output
 	grep "$blue_grep" output >error
@@ -59,8 +75,24 @@ test_expect_success 'without -space' '
 
 '
 
+test_expect_success 'without -space (attribute)' '
+
+	git config --unset core.whitespace
+	echo "F whitespace=-space" >.gitattributes
+	git diff --color >output
+	grep "$blue_grep" output >error
+	grep -v "$blue_grep" output >normal
+
+	grep Eight normal >/dev/null &&
+	grep HT normal >/dev/null &&
+	grep With error >/dev/null &&
+	grep No normal >/dev/null
+
+'
+
 test_expect_success 'with indent-non-tab only' '
 
+	rm -f .gitattributes
 	git config core.whitespace indent,-trailing,-space
 	git diff --color >output
 	grep "$blue_grep" output >error
@@ -73,4 +105,19 @@ test_expect_success 'with indent-non-tab only' '
 
 '
 
+test_expect_success 'with indent-non-tab only (attribute)' '
+
+	git config --unset core.whitespace
+	echo "F whitespace=indent,-trailing,-space" >.gitattributes
+	git diff --color >output
+	grep "$blue_grep" output >error
+	grep -v "$blue_grep" output >normal
+
+	grep Eight error >/dev/null &&
+	grep HT normal >/dev/null &&
+	grep With normal >/dev/null &&
+	grep No normal >/dev/null
+
+'
+
 test_done
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index f53ac46..85f3da2 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -112,6 +112,15 @@ test_expect_success 'whitespace=error-all, no rule' '
 
 '
 
+test_expect_success 'whitespace=error-all, no rule (attribute)' '
+
+	git config --unset core.whitespace &&
+	echo "target -whitespace" >.gitattributes &&
+	apply_patch --whitespace=error-all &&
+	diff file target
+
+'
+
 for t in - ''
 do
 	case "$t" in '') tt='!' ;; *) tt= ;; esac
@@ -121,11 +130,20 @@ do
 		for i in - ''
 		do
 			case "$i" in '') ti='#' ;; *) ti= ;; esac
-			rule=${t}trailing,${s}space,${i}indent &&
+			rule=${t}trailing,${s}space,${i}indent
+
+			rm -f .gitattributes
 			test_expect_success "rule=$rule" '
 				git config core.whitespace "$rule" &&
 				test_fix "$tt$ts$ti"
 			'
+
+			test_expect_success "rule=$rule (attributes)" '
+				git config --unset core.whitespace &&
+				echo "target whitespace=$rule" >.gitattributes &&
+				test_fix "$tt$ts$ti"
+			'
+
 		done
 	done
 done
diff --git a/ws.c b/ws.c
new file mode 100644
index 0000000..52c10ca
--- /dev/null
+++ b/ws.c
@@ -0,0 +1,96 @@
+/*
+ * Whitespace rules
+ *
+ * Copyright (c) 2007 Junio C Hamano
+ */
+
+#include "cache.h"
+#include "attr.h"
+
+static struct whitespace_rule {
+	const char *rule_name;
+	unsigned rule_bits;
+} whitespace_rule_names[] = {
+	{ "trailing-space", WS_TRAILING_SPACE },
+	{ "space-before-tab", WS_SPACE_BEFORE_TAB },
+	{ "indent-with-non-tab", WS_INDENT_WITH_NON_TAB },
+};
+
+unsigned parse_whitespace_rule(const char *string)
+{
+	unsigned rule = WS_DEFAULT_RULE;
+
+	while (string) {
+		int i;
+		size_t len;
+		const char *ep;
+		int negated = 0;
+
+		string = string + strspn(string, ", \t\n\r");
+		ep = strchr(string, ',');
+		if (!ep)
+			len = strlen(string);
+		else
+			len = ep - string;
+
+		if (*string == '-') {
+			negated = 1;
+			string++;
+			len--;
+		}
+		if (!len)
+			break;
+		for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++) {
+			if (strncmp(whitespace_rule_names[i].rule_name,
+				    string, len))
+				continue;
+			if (negated)
+				rule &= ~whitespace_rule_names[i].rule_bits;
+			else
+				rule |= whitespace_rule_names[i].rule_bits;
+			break;
+		}
+		string = ep;
+	}
+	return rule;
+}
+
+static void setup_whitespace_attr_check(struct git_attr_check *check)
+{
+	static struct git_attr *attr_whitespace;
+
+	if (!attr_whitespace)
+		attr_whitespace = git_attr("whitespace", 10);
+	check[0].attr = attr_whitespace;
+}
+
+unsigned whitespace_rule(const char *pathname)
+{
+	struct git_attr_check attr_whitespace_rule;
+
+	setup_whitespace_attr_check(&attr_whitespace_rule);
+	if (!git_checkattr(pathname, 1, &attr_whitespace_rule)) {
+		const char *value;
+
+		value = attr_whitespace_rule.value;
+		if (ATTR_TRUE(value)) {
+			/* true (whitespace) */
+			unsigned all_rule = 0;
+			int i;
+			for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++)
+				all_rule |= whitespace_rule_names[i].rule_bits;
+			return all_rule;
+		} else if (ATTR_FALSE(value)) {
+			/* false (-whitespace) */
+			return 0;
+		} else if (ATTR_UNSET(value)) {
+			/* reset to default (!whitespace) */
+			return whitespace_rule_cfg;
+		} else {
+			/* string */
+			return parse_whitespace_rule(value);
+		}
+	} else {
+		return whitespace_rule_cfg;
+	}
+}
-- 
1.5.3.7-2155-g4c25
