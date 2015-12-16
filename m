From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 00/11] ref-filter: use parsing functions
Date: Wed, 16 Dec 2015 20:59:51 +0530
Message-ID: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 16:29:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9E1R-00019r-7Q
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbbLPP3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:29:40 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36413 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbLPP3j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 10:29:39 -0500
Received: by mail-pf0-f170.google.com with SMTP id o64so13666298pfb.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 07:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1GDimmWeTJ3McZ0onqdxKsHjLUBLhqbl+JiAOat1f2Y=;
        b=0p9+qkfKIXtwN/Ju6SabFnvTC5QTo5mvIoFB4TENDsdYjM81meLFIhboModdJ/3coB
         aF5RQe+BuyVtfpgclJu/IB/fBh9FeEP0Dz8YQnnsM9FUrNyxrDdcTA4iIDvXACfzstlI
         HvoUGVV0koJ+N+eVVdVbCQ4HewYZf6H6qSqkQJiE+kSRxshY+6Epp3y2NFvQSXoqVRB+
         82bEX8NrbPNKP2XiHY2vBU9dv96zz1m4vkiCEyiV/BNS5l2f8kX5DN1jVRZtpggv0uVf
         EP/xYnwPbjt5gVEKRFDhZ/0arxpIxznr5X0IUZP9uGD7GnwOWQCJ/EeJOpTBX6wcIWcV
         Bgnw==
X-Received: by 10.98.7.210 with SMTP id 79mr6253266pfh.98.1450279778816;
        Wed, 16 Dec 2015 07:29:38 -0800 (PST)
Received: from ashley.localdomain ([106.51.233.145])
        by smtp.gmail.com with ESMTPSA id x12sm5620612pfi.95.2015.12.16.07.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Dec 2015 07:29:38 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282563>

This series cleans up populate_value() in ref-filter, by moving out
the parsing part of atoms to separate parsing functions. This ensures
that parsing is only done once and also improves the modularity of the
code.
The previous version can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/281180

Changes in this version:
1. Re-ordered the patch series and split patches.
2. Used 'enums' rather than 'structs' in 'used_atom' structure.
3. Made all functions static to remove global scope (Thanks to Ramsay Jones).
4. Added "subject" and "body" atom under contents_atom_parser.
5. Changes in error messages, function names and variable names.
6. Changes in comments and documentation.
7. Added extensive test cases for the %(align) atom.

Thanks to Eric and Junio for suggestions on v1.
TODO: Implement an enum to denote current atom in used_atom,
so as to get rid of repetitive checks performed.
(http://article.gmane.org/gmane.comp.version-control.git/282320).

Karthik Nayak (11):
  strbuf: introduce strbuf_split_str_without_term()
  ref-filter: use strbuf_split_str_omit_term()
  ref-filter: introduce struct used_atom
  ref-fitler: bump match_atom() name to the top
  ref-filter: skip deref specifier in match_atom_name()
  ref-filter: introduce color_atom_parser()
  ref-filter: introduce align_atom_parser()
  ref-filter: introduce prefixes for the align atom
  ref-filter: introduce remote_ref_atom_parser()
  ref-filter: introduce contents_atom_parser()
  ref-filter: introduce objectname_atom_parser()

 Documentation/git-for-each-ref.txt |  20 +-
 ref-filter.c                       | 441 ++++++++++++++++++++++---------------
 strbuf.c                           |   7 +-
 strbuf.h                           |  25 ++-
 t/t6302-for-each-ref-filter.sh     | 162 ++++++++++++++
 5 files changed, 462 insertions(+), 193 deletions(-)

Interdiff:

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 56ffdc1..9af0f53 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -133,8 +133,10 @@ align::
 	`width=<width>` and `position=<position>` in any order
 	separated by a comma, where the `<position>` is either left,
 	right or middle, default being left and `<width>` is the total
-	length of the content with alignment. The prefix for the
-	arguments is not mandatory. If the contents length is more
+	length of the content with alignment. For brevity, the
+	"width=" and/or "position=" prefixes may be omitted, and bare
+	<width> and <position> used instead.  For instance,
+	`%(align:<width>,<position>)`. If the contents length is more
 	than the width then no alignment is performed. If used with
 	'--quote' everything in between %(align:...) and %(end) is
 	quoted, but if nested then only the topmost level performs
diff --git a/ref-filter.c b/ref-filter.c
index 3bd3e45..a8fd178 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -37,23 +37,13 @@ static struct used_atom {
 	union {
 		const char *color;
 		struct align align;
+		enum { RR_SHORTEN, RR_TRACK, RR_TRACKSHORT, RR_NORMAL }
+			remote_ref;
 		struct {
-			unsigned int shorten : 1,
-				track : 1,
-				trackshort : 1;
-		} remote_ref;
-		struct {
-			unsigned int subject : 1,
-				body : 1,
-				signature : 1,
-				all : 1,
-				lines : 1,
-				no_lines;
+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
+			unsigned int no_lines;
 		} contents;
-		struct {
-			unsigned int shorten : 1,
-				full : 1;
-		} objectname;
+		enum { O_FULL, O_SHORT } objectname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -79,81 +69,89 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
 	return 1;
 }
 
-void color_atom_parser(struct used_atom *atom)
+static void color_atom_parser(struct used_atom *atom)
 {
 	match_atom_name(atom->str, "color", &atom->u.color);
 	if (!atom->u.color)
 		die(_("expected format: %%(color:<color>)"));
 }
 
-void remote_ref_atom_parser(struct used_atom *atom)
+static void remote_ref_atom_parser(struct used_atom *atom)
 {
 	const char *buf;
 
 	buf = strchr(atom->str, ':');
+	atom->u.remote_ref = RR_NORMAL;
 	if (!buf)
 		return;
 	buf++;
 	if (!strcmp(buf, "short"))
-		atom->u.remote_ref.shorten = 1;
+		atom->u.remote_ref = RR_SHORTEN;
 	else if (!strcmp(buf, "track"))
-		atom->u.remote_ref.track = 1;
+		atom->u.remote_ref = RR_TRACK;
 	else if (!strcmp(buf, "trackshort"))
-		atom->u.remote_ref.trackshort = 1;
+		atom->u.remote_ref = RR_TRACKSHORT;
 	else
-		die(_("improper format entered align:%s"), buf);
+		die(_("unrecognized format: %%(%s)"), atom->str);
 }
 
-void contents_atom_parser(struct used_atom *atom)
+static void contents_atom_parser(struct used_atom *atom)
 {
 	const char * buf;
 
 	if (match_atom_name(atom->str, "contents", &buf))
-		atom->u.contents.all = 1;
-
+		atom->u.contents.option = C_BARE;
+	else if (match_atom_name(atom->str, "subject", &buf)) {
+		atom->u.contents.option = C_SUB;
+		return;
+	} else if (match_atom_name(atom->str, "body", &buf)) {
+		atom->u.contents.option = C_BODY_DEP;
+		return;
+	}
 	if (!buf)
 		return;
+
 	if (!strcmp(buf, "body"))
-		atom->u.contents.body = 1;
+		atom->u.contents.option = C_BODY;
 	else if (!strcmp(buf, "signature"))
-		atom->u.contents.signature = 1;
+		atom->u.contents.option = C_SIG;
 	else if (!strcmp(buf, "subject"))
-		atom->u.contents.subject = 1;
+		atom->u.contents.option = C_SUB;
 	else if (skip_prefix(buf, "lines=", &buf)) {
-		atom->u.contents.lines = 1;
+		atom->u.contents.option = C_LINES;
 		if (strtoul_ui(buf, 10, &atom->u.contents.no_lines))
 			die(_("positive value expected contents:lines=%s"), buf);
 	} else
-		die(_("improper format entered contents:%s"), buf);
+		die(_("unrecognized %%(contents) argument: %s"), buf);
 }
 
-void objectname_atom_parser(struct used_atom *atom)
+static void objectname_atom_parser(struct used_atom *atom)
 {
 	const char * buf;
 
 	if (match_atom_name(atom->str, "objectname", &buf))
-		atom->u.objectname.full = 1;
-
+		atom->u.objectname = O_FULL;
 	if (!buf)
 		return;
+
 	if (!strcmp(buf, "short"))
-		atom->u.objectname.shorten = 1;
+		atom->u.objectname = O_SHORT;
 	else
-		die(_("improper format entered objectname:%s"), buf);
+		die(_("unrecognized %%(objectname) argument: %s"), buf);
 }
 
-static align_type get_align_position(const char *type)
+static align_type parse_align_position(const char *s)
 {
-	if (!strcmp(type, "right"))
+	if (!strcmp(s, "right"))
 		return ALIGN_RIGHT;
-	else if (!strcmp(type, "middle"))
+	else if (!strcmp(s, "middle"))
 		return ALIGN_MIDDLE;
-	else if (!strcmp(type, "left"))
+	else if (!strcmp(s, "left"))
 		return ALIGN_LEFT;
 	return -1;
 }
 
-void align_atom_parser(struct used_atom *atom)
+static void align_atom_parser(struct used_atom *atom)
 {
 	struct align *align = &atom->u.align;
 	const char *buf = NULL;
@@ -163,31 +161,28 @@ void align_atom_parser(struct used_atom *atom)
 	match_atom_name(atom->str, "align", &buf);
 	if (!buf)
 		die(_("expected format: %%(align:<width>,<position>)"));
-	s = to_free = strbuf_split_str_without_term(buf, ',', 0);
+	s = to_free = strbuf_split_str_omit_term(buf, ',', 0);
 
-	/*  By default align to ALGIN_LEFT */
 	align->position = ALIGN_LEFT;
 
 	while (*s) {
 		int position;
 		buf = s[0]->buf;
 
-		position = get_align_position(buf);
-
 		if (skip_prefix(buf, "position=", &buf)) {
-			position = get_align_position(buf);
+			position = parse_align_position(buf);
 			if (position == -1)
-				die(_("improper format entered align:%s"), s[0]->buf);
+				die(_("unrecognized position:%s"), buf);
 			align->position = position;
 		} else if (skip_prefix(buf, "width=", &buf)) {
 			if (strtoul_ui(buf, 10, (unsigned int *)&width))
-				die(_("improper format entered align:%s"), s[0]->buf);
+				die(_("unrecognized width:%s"), buf);
 		} else if (!strtoul_ui(buf, 10, (unsigned int *)&width))
-				;
-		else if (position != -1)
+			;
+		else if ((position = parse_align_position(buf)) != -1)
 			align->position = position;
 		else
-			die(_("improper format entered align:%s"), s[0]->buf);
+			die(_("unrecognized %%(align) argument: %s"), s[0]->buf);
 		s++;
 	}
 
@@ -226,8 +221,8 @@ static struct {
 	{ "taggerdate", FIELD_TIME },
 	{ "creator" },
 	{ "creatordate", FIELD_TIME },
-	{ "subject" },
-	{ "body" },
+	{ "subject", FIELD_STR, contents_atom_parser },
+	{ "body", FIELD_STR, contents_atom_parser },
 	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
@@ -485,10 +480,10 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
 			   struct atom_value *v, struct used_atom *atom)
 {
 	if (starts_with(name, "objectname")) {
-		if (atom->u.objectname.shorten) {
+		if (atom->u.objectname == O_SHORT) {
 			v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			return 1;
-		} else if (atom->u.objectname.full) {
+		} else if (atom->u.objectname == O_FULL) {
 			v->s = xstrdup(sha1_to_hex(sha1));
 			return 1;
 		}
@@ -815,7 +810,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			name++;
 		if (strcmp(name, "subject") &&
 		    strcmp(name, "body") &&
-		    !atom->u.contents.all)
+		    !starts_with(name, "contents"))
 			continue;
 		if (!subpos)
 			find_subpos(buf, sz,
@@ -823,24 +818,22 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 				    &bodypos, &bodylen, &nonsiglen,
 				    &sigpos, &siglen);
 
-		if (!strcmp(name, "subject"))
-			v->s = copy_subject(subpos, sublen);
-		else if (atom->u.contents.subject)
+		if (atom->u.contents.option == C_SUB)
 			v->s = copy_subject(subpos, sublen);
-		else if (!strcmp(name, "body"))
+		else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
-		else if (atom->u.contents.body)
+		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
-		else if (atom->u.contents.signature)
+		else if (atom->u.contents.option == C_SIG)
 			v->s = xmemdupz(sigpos, siglen);
-		else if (atom->u.contents.lines) {
+		else if (atom->u.contents.option == C_LINES) {
 			struct strbuf s = STRBUF_INIT;
 			const char *contents_end = bodylen + bodypos - siglen;
 
 			/*  Size is the length of the message after removing the signature */
 			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.no_lines);
 			v->s = strbuf_detach(&s, NULL);
-		} else /*  For %(contents) without modifiers */
+		} else if (atom->u.contents.option == C_BARE)
 			v->s = xstrdup(subpos);
 	}
 }
@@ -903,9 +896,9 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 				    struct branch *branch, const char **s)
 {
 	int num_ours, num_theirs;
-	if (atom->u.remote_ref.shorten)
+	if (atom->u.remote_ref == RR_SHORTEN)
 		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
-	else if (atom->u.remote_ref.track) {
+	else if (atom->u.remote_ref == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
 				       &num_theirs, NULL))
 			return;
@@ -918,7 +911,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		else
 			*s = xstrfmt("[ahead %d, behind %d]",
 				     num_ours, num_theirs);
-	} else if (atom->u.remote_ref.trackshort) {
+	} else if (atom->u.remote_ref == RR_TRACKSHORT) {
 		if (stat_tracking_info(branch, &num_ours,
 				       &num_theirs, NULL))
 			return;
@@ -931,7 +924,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 			*s = ">";
 		else
 			*s = "<>";
-	} else
+	} else if (atom->u.remote_ref == RR_NORMAL)
 		*s = refname;
 }
 
@@ -1003,11 +996,10 @@ static void populate_value(struct ref_array_item *ref)
 				continue;
 			fill_remote_ref_details(atom, refname, branch, &v->s);
 			continue;
-		} else if (starts_with(name, "color")) {
+		} else if (starts_with(name, "color:")) {
 			char color[COLOR_MAXLEN] = "";
-			const char *valp = atom->u.color;
 
-			if (color_parse(valp, color) < 0)
+			if (color_parse(atom->u.color, color) < 0)
 				die(_("unable to parse format"));
 			v->s = xstrdup(color);
 			continue;
diff --git a/strbuf.c b/strbuf.c
index d31336f..b62508e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -115,7 +115,7 @@ void strbuf_tolower(struct strbuf *sb)
 }
 
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
-				 int terminator, int max, int with_term)
+				 int terminator, int max, int omit_term)
 {
 	struct strbuf **ret = NULL;
 	size_t nr = 0, alloc = 0;
@@ -123,27 +123,19 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 
 	while (slen) {
 		int len = slen;
-		int term = with_term;
+		const char *end = NULL;
 		if (max <= 0 || nr + 1 < max) {
-			const char *end = memchr(str, terminator, slen);
+			end = memchr(str, terminator, slen);
 			if (end)
-				len = end - str + term;
-			else
-				/*  When no terminator present, we must add the last character */
-				term = 1;
+				len = end - str + 1;
 		}
 		t = xmalloc(sizeof(struct strbuf));
 		strbuf_init(t, len);
-		strbuf_add(t, str, len);
+		strbuf_add(t, str, len - !!end * !!omit_term);
 		ALLOC_GROW(ret, nr + 2, alloc);
 		ret[nr++] = t;
-		if (!term) {
-			str += len + 1;
-			slen -= len + 1;
-		} else {
-			str += len;
-			slen -= len;
-		}
+		str += len;
+		slen -= len;
 	}
 	ALLOC_GROW(ret, nr + 1, alloc); /* In case string was empty */
 	ret[nr] = NULL;
diff --git a/strbuf.h b/strbuf.h
index 63e1e69..a865a74 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -450,11 +450,12 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 /**
  * Split str (of length slen) at the specified terminator character.
  * Return a null-terminated array of pointers to strbuf objects
- * holding the substrings.  The substrings include the terminator,
- * except for the last substring, which might be unterminated if the
- * original string did not end with a terminator.  If max is positive,
- * then split the string into at most max substrings (with the last
- * substring containing everything following the (max-1)th terminator
+ * holding the substrings.  The substrings include the terminator if
+ * the value of omit_term is '0' else the terminator is excluded.  The
+ * last substring, might be unterminated if the original string did
+ * not end with a terminator.  If max is positive, then split the
+ * string into at most max substrings (with the last substring
+ * containing everything following the (max-1)th terminator
  * character).
  *
  * The most generic form is `strbuf_split_buf`, which takes an arbitrary
@@ -466,24 +467,24 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
  * string_list_split_in_place().
  */
 extern struct strbuf **strbuf_split_buf(const char *str, size_t slen,
-					int terminator, int max, int with_term);
+					int terminator, int max, int omit_term);
 
-static inline struct strbuf **strbuf_split_str_without_term(const char *str,
+static inline struct strbuf **strbuf_split_str_omit_term(const char *str,
 							    int terminator, int max)
 {
-	return strbuf_split_buf(str, strlen(str), terminator, max, 0);
+	return strbuf_split_buf(str, strlen(str), terminator, max, 1);
 }
 
 static inline struct strbuf **strbuf_split_str(const char *str,
 					       int terminator, int max)
 {
-	return strbuf_split_buf(str, strlen(str), terminator, max, 1);
+	return strbuf_split_buf(str, strlen(str), terminator, max, 0);
 }
 
 static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
 						int terminator, int max)
 {
-	return strbuf_split_buf(sb->buf, sb->len, terminator, max, 1);
+	return strbuf_split_buf(sb->buf, sb->len, terminator, max, 0);
 }
 
 static inline struct strbuf **strbuf_split(const struct strbuf *sb,
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 688751e..bcb6771 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -97,7 +97,7 @@ test_expect_success 'left alignment is default' '
 	refname is refs/tags/three    |refs/tags/three
 	refname is refs/tags/two      |refs/tags/two
 	EOF
-	git for-each-ref --format="%(align:width=30)refname is %(refname)%(end)|%(refname)" >actual &&
+	git for-each-ref --format="%(align:30)refname is %(refname)%(end)|%(refname)" >actual &&
 	test_cmp expect actual
 '
 
@@ -113,7 +113,7 @@ test_expect_success 'middle alignment' '
 	|  refname is refs/tags/three  |refs/tags/three
 	|   refname is refs/tags/two   |refs/tags/two
 	EOF
-	git for-each-ref --format="|%(align:position=middle,30)refname is %(refname)%(end)|%(refname)" >actual &&
+	git for-each-ref --format="|%(align:middle,30)refname is %(refname)%(end)|%(refname)" >actual &&
 	test_cmp expect actual
 '
 
@@ -133,6 +133,168 @@ test_expect_success 'right alignment' '
 	test_cmp expect actual
 '
 
+test_expect_success 'alignment with "position" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:30,position=right)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with "position" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:position=right,30)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with "width" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:width=30,right)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with "width" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:right,width=30)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with "position" and "width" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:width=30,position=right)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with "position" and "width" prefix' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:position=right,width=30)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+# Last one wins (silently) when multiple arguments of the same type are given
+
+test_expect_success 'alignment with multiple "<width>" values' '
+	cat >expect <<-\EOF &&
+	|refname is refs/heads/master  |refs/heads/master
+	|refname is refs/heads/side    |refs/heads/side
+	|refname is refs/odd/spot      |refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|refname is refs/tags/four     |refs/tags/four
+	|refname is refs/tags/one      |refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|refname is refs/tags/three    |refs/tags/three
+	|refname is refs/tags/two      |refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:32,width=30)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with multiple "<width>" values' '
+	cat >expect <<-\EOF &&
+	|refname is refs/heads/master    |refs/heads/master
+	|refname is refs/heads/side      |refs/heads/side
+	|refname is refs/odd/spot        |refs/odd/spot
+	|refname is refs/tags/double-tag |refs/tags/double-tag
+	|refname is refs/tags/four       |refs/tags/four
+	|refname is refs/tags/one        |refs/tags/one
+	|refname is refs/tags/signed-tag |refs/tags/signed-tag
+	|refname is refs/tags/three      |refs/tags/three
+	|refname is refs/tags/two        |refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:width=30,32)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with multiple "<position>" values' '
+	cat >expect <<-\EOF &&
+	|  refname is refs/heads/master|refs/heads/master
+	|    refname is refs/heads/side|refs/heads/side
+	|      refname is refs/odd/spot|refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|     refname is refs/tags/four|refs/tags/four
+	|      refname is refs/tags/one|refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|    refname is refs/tags/three|refs/tags/three
+	|      refname is refs/tags/two|refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:width=30,position=middle,right)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alignment with multiple "<position>" values' '
+	cat >expect <<-\EOF &&
+	| refname is refs/heads/master |refs/heads/master
+	|  refname is refs/heads/side  |refs/heads/side
+	|   refname is refs/odd/spot   |refs/odd/spot
+	|refname is refs/tags/double-tag|refs/tags/double-tag
+	|  refname is refs/tags/four   |refs/tags/four
+	|   refname is refs/tags/one   |refs/tags/one
+	|refname is refs/tags/signed-tag|refs/tags/signed-tag
+	|  refname is refs/tags/three  |refs/tags/three
+	|   refname is refs/tags/two   |refs/tags/two
+	EOF
+	git for-each-ref --format="|%(align:30,right,position=middle)refname is %(refname)%(end)|%(refname)" >actual &&
+	test_cmp expect actual
+'
+
 # Individual atoms inside %(align:...) and %(end) must not be quoted.
 
 test_expect_success 'alignment with format quote' "

-- 
2.6.4
