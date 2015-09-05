From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v16 08/14] ref-filter: add support for %(contents:lines=X)
Date: Sun,  6 Sep 2015 00:22:09 +0530
Message-ID: <1441479135-5285-9-git-send-email-Karthik.188@gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 20:52:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYIa4-0002Ha-Ss
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 20:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbbIESwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 14:52:50 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34614 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbbIESw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 14:52:27 -0400
Received: by padhy16 with SMTP id hy16so52763147pad.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6T//TmGZ4qt0sGhnhaujTvzj4SvEXiViRDoQv+IhhU0=;
        b=oiLQgg307U5k9wLMJgNjdhjWtdEc2zbfLyem0QJHOnDhnocCwHCAThapesadRmqj6y
         /UpTl4tKyLG6Ci8WhosVTVOwEOPNbGXbTgn28RyP8w2UuvOJIHyFMjP3Yvc5MlOMNy9l
         Z5qMkb6VoN9KuMYkNm6j6+Q4Kp9OWW/N91K/OwLhocTCMWZpoBhzS5dUzvAQ5u+6V+dD
         zwJAjEVxxzl5AziQ46MW0LdJNAsIHlOCzwvmt72lCGw9dGRpYrNeDQ2gaPdqIvAe+2Si
         7JrHxkF3DRgRiC85cBGjhlqFYApfO1FAdo+bXt82E/hJsBVDXtboEepu4O8X6yBpIoZe
         SawQ==
X-Received: by 10.66.227.98 with SMTP id rz2mr24244867pac.16.1441479147246;
        Sat, 05 Sep 2015 11:52:27 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ch3sm6583639pbb.18.2015.09.05.11.52.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Sep 2015 11:52:26 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277402>

In 'tag.c' we can print N lines from the annotation of the tag using
the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
modify it to support appending of N lines from the annotation of tags
to the given strbuf.

Implement %(contents:lines=X) where X lines of the given object are
obtained.

Add documentation and test for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 ++-
 builtin/tag.c                      |  4 +++
 ref-filter.c                       | 45 ++++++++++++++++++++++++++++++++-
 ref-filter.h                       |  3 ++-
 t/t6302-for-each-ref-filter.sh     | 52 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index b23412d..99d108a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -149,7 +149,8 @@ The complete message in a commit and tag object is `contents`.
 Its first line is `contents:subject`, where subject is the concatenation
 of all lines of the commit message up to the first blank line.  The next
 line is 'contents:body', where body is all of the lines after the first
-blank line.  Finally, the optional GPG signature is `contents:signature`.
+blank line.  The optional GPG signature is `contents:signature`.  The
+first `N` lines of the message is obtained using `contents:lines=N`.
 
 For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
diff --git a/builtin/tag.c b/builtin/tag.c
index 471d6b1..b0bc1c5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -185,6 +185,10 @@ static enum contains_result contains(struct commit *candidate,
 	return contains_test(candidate, want);
 }
 
+/*
+ * Currently modified and used in ref-filter as append_lines(), will
+ * eventually be removed as we port tag.c to use ref-filter APIs.
+ */
 static void show_tag_lines(const struct object_id *oid, int lines)
 {
 	int i;
diff --git a/ref-filter.c b/ref-filter.c
index c7a8cf0..4435ec8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -56,6 +56,7 @@ static struct {
 	{ "color" },
 	{ "align" },
 	{ "end" },
+	{ "contents:lines" },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -65,6 +66,11 @@ struct align {
 	unsigned int width;
 };
 
+struct contents {
+	unsigned int lines;
+	struct object_id oid;
+};
+
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
@@ -81,6 +87,7 @@ struct atom_value {
 	const char *s;
 	union {
 		struct align align;
+		struct contents contents;
 	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
@@ -643,6 +650,30 @@ static void find_subpos(const char *buf, unsigned long sz,
 	*nonsiglen = *sig - buf;
 }
 
+/*
+ * If 'lines' is greater than 0, append that many lines from the given
+ * 'buf' of length 'size' to the given strbuf.
+ */
+static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
+{
+	int i;
+	const char *sp, *eol;
+	size_t len;
+
+	sp = buf;
+
+	for (i = 0; i < lines && sp < buf + size; i++) {
+		if (i)
+			strbuf_addstr(out, "\n    ");
+		eol = memchr(sp, '\n', size - (sp - buf));
+		len = eol ? eol - sp : size - (sp - buf);
+		strbuf_add(out, sp, len);
+		if (!eol)
+			break;
+		sp = eol + 1;
+	}
+}
+
 /* See grab_values */
 static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
 {
@@ -653,6 +684,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i];
 		struct atom_value *v = &val[i];
+		const char *valp = NULL;
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
@@ -662,7 +694,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 		    strcmp(name, "contents") &&
 		    strcmp(name, "contents:subject") &&
 		    strcmp(name, "contents:body") &&
-		    strcmp(name, "contents:signature"))
+		    strcmp(name, "contents:signature") &&
+		    !starts_with(name, "contents:lines="))
 			continue;
 		if (!subpos)
 			find_subpos(buf, sz,
@@ -682,6 +715,16 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			v->s = xmemdupz(sigpos, siglen);
 		else if (!strcmp(name, "contents"))
 			v->s = xstrdup(subpos);
+		else if (skip_prefix(name, "contents:lines=", &valp)) {
+			struct strbuf s = STRBUF_INIT;
+			const char *contents_end = bodylen + bodypos - siglen;
+
+			if (strtoul_ui(valp, 10, &v->u.contents.lines))
+				die(_("positive value expected contents:lines=%s"), valp);
+			/*  Size is the length of the message after removing the signature */
+			append_lines(&s, subpos, contents_end - subpos, v->u.contents.lines);
+			v->s = strbuf_detach(&s, NULL);
+		}
 	}
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 0913ba9..ab76b22 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -59,7 +59,8 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1;
-	unsigned int kind;
+	unsigned int kind,
+		lines;
 };
 
 struct ref_filter_cbdata {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index d0c0139..428d139 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -167,4 +167,56 @@ test_expect_success 'nested alignment with quote formatting' "
 	test_cmp expect actual
 "
 
+test_expect_success 'check `%(contents:lines=1)`' '
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
+	git for-each-ref --format="%(refname:short) |%(contents:lines=1)" >actual &&
+	test_cmp expect actual
+'
+
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
 test_done
-- 
2.5.1
