From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Thu,  8 Oct 2015 14:47:55 +0530
Message-ID: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 11:18:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk7Kx-0007QD-Qm
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 11:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbbJHJSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 05:18:01 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35856 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbbJHJR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 05:17:57 -0400
Received: by pacik9 with SMTP id ik9so5815234pac.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=PsCkntB8DmKtpJqTtjftQV80knVAzlMxtwxS/HYv0Uc=;
        b=s88csW1/vhU1rGCqr/JYgju49deqGXdGMUTKQgM60v1kKuQa8PI9exKFqe5MP6oCJj
         WfQ17EUZxtML6x9dkFamSio6KRFS/vkKs3vlPQ1w+gOjwHd22MivoXIiQpeGBEj9S3i1
         /vQ224aZ3mxt2uLV6FItU970lHft15dCOJLIzs6xVEznj+qrBZOGzYt2Dgl9rPcxXC/H
         Y7paDZobSjkrlw4n0jBaefOLV9BkjL/+FGA6itPxaHvwd954PNU2SyNPt9dgSozzoOZT
         VHvgVDexFtYOIQIXrAatigInRIRx4La1p3T9w0v1z+M8k4qArlWp808C42djvF7JjZIO
         Fdcg==
X-Received: by 10.68.93.194 with SMTP id cw2mr6964714pbb.36.1444295876804;
        Thu, 08 Oct 2015 02:17:56 -0700 (PDT)
Received: from ashley.localdomain ([106.51.20.153])
        by smtp.gmail.com with ESMTPSA id sv9sm44171159pbc.44.2015.10.08.02.17.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Oct 2015 02:17:56 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279226>

This is part of unification of the commands 'git tag -l, git branch -l
and git for-each-ref'. This ports over branch.c to use ref-filter's
printing options. The previous version of the patch can be found at:
http://article.gmane.org/gmane.comp.version-control.git/278926

Karthik Nayak (10):
  ref-filter: implement %(if), %(then), and %(else) atoms
  ref-filter: implement %(if:equals=<string>) and
    %(if:notequals=<string>)
  ref-filter: add support for %(refname:dir) and %(refname:base)
  ref-filter: modify "%(objectname:short)" to take length
  ref-filter: adopt get_head_description() from branch.c
  ref-filter: introduce format_ref_array_item()
  ref-filter: make %(upstream:track) prints "[gone]" for invalid
    upstreams
  ref-filter: add support for %(upstream:track,nobracket)
  branch: use ref-filter printing APIs
  branch: implement '--format' option

 Documentation/git-branch.txt       |   7 +-
 Documentation/git-for-each-ref.txt |  63 +++++++-
 builtin/branch.c                   | 265 +++++++++-------------------------
 ref-filter.c                       | 285 +++++++++++++++++++++++++++++++++----
 ref-filter.h                       |   5 +
 t/t3203-branch-output.sh           |  11 ++
 t/t6040-tracking-info.sh           |   2 +-
 t/t6300-for-each-ref.sh            |  33 ++++-
 t/t6302-for-each-ref-filter.sh     | 132 +++++++++++++++++
 9 files changed, 573 insertions(+), 230 deletions(-)

Changes in this version:

1. Use %(refname:dir) and %(refname:base) instead of %(path) and
%(path:short).
2. Make it %(objectname:short=<len>) rather than %(objectname:short,<len>).
3. Add %(upstream:track,nobracket) which removes the brackets from tracking
information.
4. calc_maxwidth() now also considers head ref descriptions, this wasn't done
in the last patch and would cause detached head description to be not aligned with the other ref-names.
5. remove the if_atom field in if_then_else struct.
6. introduce better error checking for the %(if), %(then), %(else) atoms
as suggested by Matthieu (when used along with %(align) atom and so on).
7. refactor code and improve documentation.

Interdiff:

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 5097915..a38cbf6 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -92,7 +92,9 @@ refname::
 	The name of the ref (the part after $GIT_DIR/).
 	For a non-ambiguous short name of the ref append `:short`.
 	The option core.warnAmbiguousRefs is used to select the strict
-	abbreviation mode.
+	abbreviation mode. For the base directory of the ref (i.e. foo
+	in refs/foo/bar/boz) append `:base`. For the entire directory
+	path append `:dir`.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
@@ -102,9 +104,9 @@ objectsize::
 
 objectname::
 	The object name (aka SHA-1).
-	For a non-ambiguous abbreviation of the object name append `:short`.
-	The length can be explicitly specified by appending either
-	`:short,<length>` or `:<length>,short`.  Minimum length is 4.
+	For a non-ambiguous abbreviation of the object name append
+	`:short`.  The length can be explicitly specified by appending
+	`:short=<length>`.  Minimum length being 4.
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
@@ -112,8 +114,10 @@ upstream::
 	`refname` above.  Additionally respects `:track` to show
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
-	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it.
+	or "=" (in sync).  Append `:track,nobracket` to show tracking
+	information without brackets (i.e "ahead N, behind M").  Has
+	no effect if the ref does not have tracking information
+	associated with it.
 
 push::
 	The name of a local ref which represents the `@{push}` location
@@ -143,14 +147,12 @@ if::
 	If there is an atom with value or string literal after the
 	%(if) then everything after the %(then) is printed, else if
 	the %(else) atom is used, then everything after %(else) is
-	printed. Append ":equals=<string>" or ":notequals=<string>" to
-	compare the value between the %(if:...) and %(then) atoms with the
-	given string.
-
-path::
-	The path of the given ref. For a shortened version listing
-	only the name of the directory the ref is under append
-	`:short`.
+	printed. We ignore space when evaluating the string before
+	%(then), this is useful when we use the %(HEAD) atom which
+	prints either "*" or " " and we want to apply the 'if'
+	condition only on the 'HEAD' ref. Append ":equals=<string>" or
+	":notequals=<string>" to compare the value between the
+	%(if:...) and %(then) atoms with the given string.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
@@ -191,8 +193,9 @@ opening atoms, replacement from every %(atom) is quoted when and only
 when it appears at the top-level (that is, when it appears outside
 %($open)...%(end)).
 
-When a scripting language specific quoting is in effect, everything
-between a top-level opening atom and its matching %(end) is evaluated
+When a scripting language specific quoting is in effect (i.e. one of
+`--shell`, `--perl`, `--python`, `--tcl` is used), everything between
+a top-level opening atom and its matching %(end) is evaluated
 according to the semantics of the opening atom and its result is
 quoted.
 
@@ -282,6 +285,26 @@ eval=`git for-each-ref --shell --format="$fmt" \
 eval "$eval"
 ------------
 
+
+An example to show the usage of %(if)...%(then)...%(else)...%(end).
+This prefixes the current branch with a star.
+
+------------
+#!/bin/sh
+
+git for-each-ref --format="%(if)%(HEAD)%(then)* %(else)  %(end)%(refname:short)" refs/heads/
+------------
+
+
+An example to show the usage of %(if)...%(then)...%(end).
+This adds a red color to authorname, if present
+
+------------
+#!/bin/sh
+
+git for-each-ref --format="%(refname)%(if)%(authorname)%(then)%(color:red)%(end) %(authorname)"
+------------
+
 SEE ALSO
 --------
 linkgit:git-show-ref[1]
diff --git a/builtin/branch.c b/builtin/branch.c
index ae3ecfb..2356e72 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -282,7 +282,10 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 
 		skip_prefix(it->refname, "refs/heads/", &desc);
 		skip_prefix(it->refname, "refs/remotes/", &desc);
-		w = utf8_strwidth(desc);
+		if (it->kind == FILTER_REFS_DETACHED_HEAD)
+			w = strlen(get_head_description());
+		else
+			w = utf8_strwidth(desc);
 
 		if (it->kind == FILTER_REFS_REMOTES)
 			w += remote_bonus;
@@ -292,44 +295,41 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 	return max;
 }
 
-static char *get_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
+static char *build_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
 {
-	char *remote = NULL;
-	char *local = NULL;
-	char *final = NULL;
+	struct strbuf fmt = STRBUF_INIT;
+	struct strbuf local = STRBUF_INIT;
+	struct strbuf remote = STRBUF_INIT;
+
+	strbuf_addf(&fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)", branch_get_color(BRANCH_COLOR_CURRENT));
 
 	if (filter->verbose) {
-		if (filter->verbose > 1)
-			local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%%(refname:short)%%(end)%s"
-					" %%(objectname:short,7) %%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s] %%(end)"
-					"%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)",
-					branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET),
-					branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
+		strbuf_addf(&local, "%%(align:%d,left)%%(refname:short)%%(end)", maxwidth);
+		strbuf_addf(&local, "%s", branch_get_color(BRANCH_COLOR_RESET));
+		strbuf_addf(&local, " %%(objectname:short=7) ");
 
+		if (filter->verbose > 1)
+			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
+				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
+				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
 		else
-			local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%"
-					"%(refname:short)%%(end)%s %%(objectname:short,7) %%(if)%%(upstream:track)%"
-					"%(then)%%(upstream:track) %%(end)%%(contents:subject)",
-					branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET));
-
-		remote = xstrfmt("  %s%%(align:%d,left)%s%%(refname:short)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
-				 "%%(else) %%(objectname:short,7) %%(contents:subject)%%(end)",
-				 branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
-				 remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
-		final = xstrfmt("%%(if:notequals=remotes)%%(path:short)%%(then)%s%%(else)%s%%(end)", local, remote);
+			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
 
+		strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:short)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
+			    "%%(else) %%(objectname:short=7) %%(contents:subject)%%(end)",
+			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
+			    remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
 	} else {
-		local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(refname:short)%s",
-				branch_get_color(BRANCH_COLOR_CURRENT), branch_get_color(BRANCH_COLOR_RESET));
-		remote = xstrfmt("  %s%s%%(refname:short)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
-				 branch_get_color(BRANCH_COLOR_REMOTE), remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
-		final = xstrfmt("%%(if:notequals=remotes)%%(path:short)%%(then)%s%%(else)%s%%(end)", local, remote);
+		strbuf_addf(&local, "%%(refname:short)%s", branch_get_color(BRANCH_COLOR_RESET));
+		strbuf_addf(&remote, "%s%s%%(refname:short)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
+			    branch_get_color(BRANCH_COLOR_REMOTE), remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
 	}
 
-	free(local);
-	free(remote);
+	strbuf_addf(&fmt, "%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)", local.buf, remote.buf);
 
-	return final;
+	strbuf_release(&local);
+	strbuf_release(&remote);
+	return strbuf_detach(&fmt, NULL);
 }
 
 static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
@@ -357,7 +357,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
 	if (!format)
-		format = to_free = get_format(filter, maxwidth, remote_prefix);
+		format = to_free = build_format(filter, maxwidth, remote_prefix);
 	verify_ref_format(format);
 
 	/*
@@ -375,6 +375,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 		format_ref_array_item(array.items[i], format, 0, &out);
 		if (column_active(colopts)) {
 			assert(!filter->verbose && "--column and --verbose are incompatible");
+			 /* format to a string_list to let print_columns() do its job */
 			string_list_append(&output, out.buf);
 		} else {
 			fwrite(out.buf, 1, out.len, stdout);
diff --git a/ref-filter.c b/ref-filter.c
index 48b06e3..6044eb0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -59,7 +59,6 @@ static struct {
 	{ "if" },
 	{ "then" },
 	{ "else" },
-	{ "path" },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -77,8 +76,7 @@ struct contents {
 struct if_then_else {
 	const char *if_equals,
 		*not_equals;
-	unsigned int if_atom : 1,
-		then_atom : 1,
+	unsigned int then_atom : 1,
 		else_atom : 1,
 		condition_satisfied : 1;
 };
@@ -257,22 +255,27 @@ static void if_then_else_handler(struct ref_formatting_stack **stack)
 	struct ref_formatting_stack *prev = cur->prev;
 	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
 
-	/*
-	 * If the 'if' condition is satisfied, then if there exists an
-	 * 'else' atom drop the 'else' atom's state. Else we swap the
-	 * buffer of the 'else' atom with the previous state and drop
-	 * that state. If the condition is satisfied and no 'else' atom
-	 * exists, then just clear the buffer.
-	 */
-	if (if_then_else->condition_satisfied && if_then_else->else_atom) {
-		strbuf_reset(&cur->output);
-		pop_stack_element(&cur);
-	} else if (if_then_else->else_atom) {
-		strbuf_swap(&cur->output, &prev->output);
-		strbuf_reset(&cur->output);
-		pop_stack_element(&cur);
+	if (if_then_else->else_atom) {
+		/*
+		 * There is an %(else) atom: we need to drop one state from the
+		 * stack, either the %(else) branch if the condition is satisfied, or
+		 * the %(then) branch if it isn't.
+		 */
+		if (if_then_else->condition_satisfied) {
+			strbuf_reset(&cur->output);
+			pop_stack_element(&cur);
+		} else {
+			strbuf_swap(&cur->output, &prev->output);
+			strbuf_reset(&cur->output);
+			pop_stack_element(&cur);
+		}
 	} else if (!if_then_else->condition_satisfied)
+		/*
+		 * No %(else) atom: just drop the %(then) branch if the
+		 * condition is not satisfied.
+		 */
 		strbuf_reset(&cur->output);
+
 	*stack = cur;
 	free(if_then_else);
 }
@@ -283,7 +286,6 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
 	const char *valp;
 
-	if_then_else->if_atom = 1;
 	if (skip_prefix(atomv->s, "equals=", &valp))
 		if_then_else->if_equals = valp;
 	else if (skip_prefix(atomv->s, "notequals=", &valp))
@@ -297,7 +299,7 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 	new->at_end_data = if_then_else;
 }
 
-static int is_empty(const char * s){
+static int is_empty(const char *s){
 	while (*s != '\0') {
 		if (!isspace(*s))
 			return 0;
@@ -309,10 +311,14 @@ static int is_empty(const char * s){
 static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
 	struct ref_formatting_stack *cur = state->stack;
-	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
+	struct if_then_else *if_then_else = NULL;
 
+	if (cur->at_end == if_then_else_handler)
+		if_then_else = (struct if_then_else *)cur->at_end_data;
 	if (!if_then_else)
 		die(_("format: %%(then) atom used without an %%(if) atom"));
+	if (if_then_else->then_atom)
+		die(_("format: %%(then) atom used more than once"));
 	if_then_else->then_atom = 1;
 
 	/*
@@ -334,12 +340,16 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
 static void else_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
 	struct ref_formatting_stack *prev = state->stack;
-	struct if_then_else *if_then_else = (struct if_then_else *)state->stack->at_end_data;
+	struct if_then_else *if_then_else = NULL;
 
+	if (prev->at_end == if_then_else_handler)
+		if_then_else = (struct if_then_else *)prev->at_end_data;
 	if (!if_then_else)
 		die(_("format: %%(else) atom used without an %%(if) atom"));
 	if (!if_then_else->then_atom)
 		die(_("format: %%(else) atom used without a %%(then) atom"));
+	if (if_then_else->else_atom)
+		die(_("format: %%(else) atom used more than once"));
 	if_then_else->else_atom = 1;
 	push_stack_element(&state->stack);
 	state->stack->at_end_data = prev->at_end_data;
@@ -355,7 +365,7 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 		die(_("format: %%(end) atom used without corresponding atom"));
 	current->at_end(&state->stack);
 
-	/*  Stack may have been popped, hence reset the current pointer */
+	/*  Stack may have been popped within at_end(), hence reset the current pointer */
 	current = state->stack;
 
 	/*
@@ -458,33 +468,24 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
 	const char *p;
 
 	if (match_atom_name(name, "objectname", &p)) {
-		struct strbuf **s, **to_free;
-		int length = DEFAULT_ABBREV;
-
 		/*  No arguments given, copy the entire objectname */
 		if (!p) {
 			char *s = xmalloc(41);
 			strcpy(s, sha1_to_hex(sha1));
 			v->s = s;
 		} else {
-			s = to_free = strbuf_split_str(p, ',', 0);
-			while (*s) {
-				/*  Strip trailing comma */
-				if (s[1])
-					strbuf_setlen(s[0], s[0]->len - 1);
-				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&length))
-					;
-				/*  The `short` argument uses the default length */
-				else if (!strcmp("short", s[0]->buf))
-					;
-				else
-					die(_("format: unknown option entered with objectname:%s"), s[0]->buf);
-				s++;
-			}
+			unsigned int length = DEFAULT_ABBREV;
+
+			if (skip_prefix(p, "short", &p)) {
+				if (p[0] == '=')
+					if (strtoul_ui(p + 1, 10, &length))
+						die(_("positive length expected with objectname:%s"), p + 1);
+			} else
+				die(_("format: unknown option entered with objectname:%s"), p);
+
 			if (length < MINIMUM_ABBREV)
 				length = MINIMUM_ABBREV;
 			v->s = xstrdup(find_unique_abbrev(sha1, length));
-			free(to_free);
 		}
 		return 1;
 	}
@@ -916,7 +917,7 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static char *get_head_description(void)
+char *get_head_description(void)
 {
 	struct strbuf desc = STRBUF_INIT;
 	struct wt_status_state state;
@@ -1100,22 +1101,6 @@ static void populate_value(struct ref_array_item *ref)
 		} else if (!strcmp(name, "else")) {
 			v->handler = else_atom_handler;
 			continue;
-		} else if (match_atom_name(name, "path", &valp)) {
-			const char *sp, *ep;
-
-			if (ref->kind & FILTER_REFS_DETACHED_HEAD)
-				continue;
-
-			sp = strchr(ref->refname, '/');
-			ep = strchr(++sp, '/');
-
-			if (!valp)
-				sp = ref->refname;
-			else if (strcmp(valp, "short"))
-				die(_("format: invalid value given path:%s"), valp);
-
-			v->s = xstrndup(sp, ep - sp);
-			continue;
 		} else
 			continue;
 
@@ -1127,27 +1112,45 @@ static void populate_value(struct ref_array_item *ref)
 			if (!strcmp(formatp, "short"))
 				refname = shorten_unambiguous_ref(refname,
 						      warn_ambiguous_refs);
-			else if (!strcmp(formatp, "track") &&
+			else if (skip_prefix(formatp, "track", &valp) &&
+				 strcmp(formatp, "trackshort") &&
 				 (starts_with(name, "upstream") ||
 				  starts_with(name, "push"))) {
 				char buf[40];
+				unsigned int nobracket = 0;
+
+				if (!strcmp(valp, ",nobracket"))
+					nobracket = 1;
 
 				if (stat_tracking_info(branch, &num_ours,
 						       &num_theirs, NULL)) {
-					v->s = xstrdup("[gone]");
+					if (nobracket)
+						v->s = "gone";
+					else
+						v->s = "[gone]";
 					continue;
 				}
 
 				if (!num_ours && !num_theirs)
 					v->s = "";
 				else if (!num_ours) {
-					sprintf(buf, "[behind %d]", num_theirs);
+					if (nobracket)
+						sprintf(buf, "behind %d", num_theirs);
+					else
+						sprintf(buf, "[behind %d]", num_theirs);
 					v->s = xstrdup(buf);
 				} else if (!num_theirs) {
-					sprintf(buf, "[ahead %d]", num_ours);
+					if (nobracket)
+						sprintf(buf, "ahead %d", num_ours);
+					else
+						sprintf(buf, "[ahead %d]", num_ours);
 					v->s = xstrdup(buf);
 				} else {
-					sprintf(buf, "[ahead %d, behind %d]",
+					if (nobracket)
+						sprintf(buf, "ahead %d, behind %d",
+							num_ours, num_theirs);
+					else
+						sprintf(buf, "[ahead %d, behind %d]",
 						num_ours, num_theirs);
 					v->s = xstrdup(buf);
 				}
@@ -1170,6 +1173,29 @@ static void populate_value(struct ref_array_item *ref)
 				else
 					v->s = "<>";
 				continue;
+			} else if (!strcmp(formatp, "dir") &&
+				   (starts_with(name, "refname"))) {
+				const char *sp, *ep, *tmp;
+
+				sp = tmp = ref->refname;
+				/*  Obtain refs/foo/bar/ from refname refs/foo/bar/abc */
+				do {
+					ep = tmp;
+					tmp = strchr(ep + 1, '/');
+				} while (tmp);
+				v->s = xstrndup(sp, ep - sp);
+				continue;
+			} else if (!strcmp(formatp, "base") &&
+				   (starts_with(name, "refname"))) {
+				const char *sp, *ep;
+
+				if (skip_prefix(ref->refname, "refs/", &sp)) {
+					ep = strchr(sp, '/');
+					if (!ep)
+						continue;
+					v->s = xstrndup(sp, ep - sp);
+				}
+				continue;
 			} else
 				die("unknown %.*s format %s",
 				    (int)(formatp - name), name, formatp);
diff --git a/ref-filter.h b/ref-filter.h
index e0b26e8..0014b92 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -109,5 +109,7 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 struct ref_sorting *ref_default_sorting(void);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
+/*  Get the current HEAD's description */
+char *get_head_description(void);
 
 #endif /*  REF_FILTER_H  */
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index d110f26..97a0765 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -58,11 +58,11 @@ test_expect_success 'branch -v' '
 '
 
 cat >expect <<\EOF
-b1 [origin/master] [ahead 1, behind 1] d
-b2 [origin/master] [ahead 1, behind 1] d
-b3 [origin/master] [behind 1] b
-b4 [origin/master] [ahead 2] f
-b5 [brokenbase] [gone] g
+b1 [origin/master: ahead 1, behind 1] d
+b2 [origin/master: ahead 1, behind 1] d
+b3 [origin/master: behind 1] b
+b4 [origin/master: ahead 2] f
+b5 [brokenbase: gone] g
 b6 [origin/master] c
 EOF
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2a01645..7ab8bf8 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -344,6 +344,15 @@ test_expect_success 'Check upstream:track format' '
 '
 
 cat >expected <<EOF
+ahead 1
+EOF
+
+test_expect_success 'Check upstream:track,nobracket format' '
+	git for-each-ref --format="%(upstream:track,nobracket)" refs/heads >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
 >
 EOF
 
@@ -390,7 +399,7 @@ $(git rev-parse --short=1 HEAD)
 EOF
 
 test_expect_success 'Check objectname:short format when size is less than MINIMUM_ABBREV' '
-	git for-each-ref --format="%(objectname:short,1)" refs/heads >actual &&
+	git for-each-ref --format="%(objectname:short=1)" refs/heads >actual &&
 	test_cmp expected actual
 '
 
@@ -399,12 +408,12 @@ $(git rev-parse --short=10 HEAD)
 EOF
 
 test_expect_success 'Check objectname:short format' '
-	git for-each-ref --format="%(objectname:short,10)" refs/heads >actual &&
+	git for-each-ref --format="%(objectname:short=10)" refs/heads >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'Check objectname:short format for invalid input' '
-	test_must_fail git for-each-ref --format="%(objectname:short,-1)" refs/heads
+	test_must_fail git for-each-ref --format="%(objectname:short=-1)" refs/heads
 '
 
 test_expect_success 'Check for invalid refname format' '
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 5557657..19a5075 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -303,6 +303,25 @@ test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ignore spaces in %(if) atom usage' '
+	git for-each-ref --format="%(refname:short): %(if)%(HEAD)%(then)Head ref%(else)Not Head ref%(end)" >actual &&
+	cat >expect <<-\EOF &&
+	master: Head ref
+	side: Not Head ref
+	odd/spot: Not Head ref
+	double-tag: Not Head ref
+	foo1.10: Not Head ref
+	foo1.3: Not Head ref
+	foo1.6: Not Head ref
+	four: Not Head ref
+	one: Not Head ref
+	signed-tag: Not Head ref
+	three: Not Head ref
+	two: Not Head ref
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'check %(if:equals=<string>)' '
 	git for-each-ref --format="%(if:equals=master)%(refname:short)%(then)Found master%(else)Not master%(end)" refs/heads/ >actual &&
 	cat >expect <<-\EOF &&
@@ -312,7 +331,6 @@ test_expect_success 'check %(if:equals=<string>)' '
 	test_cmp expect actual
 '
 
-
 test_expect_success 'check %(if:notequals=<string>)' '
 	git for-each-ref --format="%(if:notequals=master)%(refname:short)%(then)Not master%(else)Found master%(end)" refs/heads/ >actual &&
 	cat >expect <<-\EOF &&
@@ -322,9 +340,16 @@ test_expect_success 'check %(if:notequals=<string>)' '
 	test_cmp expect actual
 '
 
-test_expect_success 'check %(path)' '
-	git for-each-ref --format="%(path)" >actual &&
+test_expect_success 'update refs for %(refname:dir) and %(refname:base)' '
+	git update-ref refs/foo HEAD &&
+	git update-ref refs/foodir/bar/boz HEAD
+'
+
+test_expect_success 'check %(refname:dir)' '
+	git for-each-ref --format="%(refname:dir)" >actual &&
 	cat >expect <<-\EOF &&
+	refs
+	refs/foodir/bar
 	refs/heads
 	refs/heads
 	refs/odd
@@ -341,9 +366,11 @@ test_expect_success 'check %(path)' '
 	test_cmp expect actual
 '
 
-test_expect_success 'check %(path:short)' '
-	git for-each-ref --format="%(path:short)" >actual &&
+test_expect_success 'check %(refname:base)' '
+	git for-each-ref --format="%(refname:base)" >actual &&
 	cat >expect <<-\EOF &&
+	
+	foodir
 	heads
 	heads
 	odd

--
2.6.0
