From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Tue,  1 Sep 2015 23:56:28 +0530
Message-ID: <1441131994-13508-8-git-send-email-Karthik.188@gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 20:26:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqGo-0007I8-PA
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbbIAS0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:26:51 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35823 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298AbbIAS0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:26:49 -0400
Received: by pacfv12 with SMTP id fv12so3694162pac.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yGeGS4giZV5cIX6caSG+e6XKUCPhpb0ikOLe8cZr0pI=;
        b=XEoBVwmVoNWTdOJHWjqpNEB5QxpUITMWQR5dvAVG1He6dcDhYAzEgivdA5pPhXAHx5
         rM+3nY1kYfiFRonkgtf/ZZ7KwHNE66w2kJnk0nTYdXJ+AmRDKtt75GFEt6W9SB9oiB5z
         L+lQ7pQY8e/WRqpQd96Xo0m5bYQLzIgXQMcgAvi5u/Rq0rUXvn8OayxPCb4jQIMK3nEj
         lPFBP8QBKewbMdtpiNG/flb5FkVhVu2C5lR6dmut/+zdIXjUkvxnTVechW8dEANbfzjq
         rhhuuWHUyNDaQtDTsbYY8bg33wdr7mWU+TCdagS/UK9zb9OA6RaqPwrqlsU7BL5XIaQ8
         c3XA==
X-Received: by 10.68.193.169 with SMTP id hp9mr49673651pbc.39.1441132009042;
        Tue, 01 Sep 2015 11:26:49 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id uk6sm19091682pac.27.2015.09.01.11.26.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Sep 2015 11:26:48 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277018>

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
 ref-filter.c                       | 53 +++++++++++++++++++++++++++++++++++---
 ref-filter.h                       |  3 ++-
 t/t6302-for-each-ref-filter.sh     | 52 +++++++++++++++++++++++++++++++++++++
 5 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index cac3128..98eb027 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -148,7 +148,8 @@ The complete message in a commit and tag object is `contents`.
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
index 430c80b..0e58fee 100644
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
@@ -79,7 +85,10 @@ struct ref_formatting_state {
 
 struct atom_value {
 	const char *s;
-	struct align align;
+	union {
+		struct align align;
+		struct contents contents;
+	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
@@ -226,7 +235,7 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	push_stack_element(&state->stack);
 	new = state->stack;
 	new->at_end = align_handler;
-	new->cb_data = &atomv->align;
+	new->cb_data = &atomv->u.align;
 }
 
 static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
@@ -624,6 +633,33 @@ static void find_subpos(const char *buf, unsigned long sz,
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
+	if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
+		size += 2;
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
@@ -634,6 +670,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i];
 		struct atom_value *v = &val[i];
+		const char *valp = NULL;
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
@@ -643,7 +680,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 		    strcmp(name, "contents") &&
 		    strcmp(name, "contents:subject") &&
 		    strcmp(name, "contents:body") &&
-		    strcmp(name, "contents:signature"))
+		    strcmp(name, "contents:signature") &&
+		    !starts_with(name, "contents:lines="))
 			continue;
 		if (!subpos)
 			find_subpos(buf, sz,
@@ -663,6 +701,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			v->s = xmemdupz(sigpos, siglen);
 		else if (!strcmp(name, "contents"))
 			v->s = xstrdup(subpos);
+		else if (skip_prefix(name, "contents:lines=", &valp)) {
+			struct strbuf s = STRBUF_INIT;
+			if (strtoul_ui(valp, 10, &v->u.contents.lines))
+				die(_("positive width expected contents:lines=%s"), valp);
+			append_lines(&s, subpos, sublen + bodylen - siglen, v->u.contents.lines);
+			v->s = strbuf_detach(&s, NULL);
+		}
 	}
 }
 
@@ -817,7 +862,7 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = " ";
 			continue;
 		} else if (skip_prefix(name, "align", &valp)) {
-			struct align *align = &v->align;
+			struct align *align = &v->u.align;
 			struct strbuf **s;
 
 			if (valp[0] != ':')
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
index cef7a41..75da32f 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -166,4 +166,56 @@ test_expect_success 'nested alignment' '
 	test_cmp expect actual
 '
 
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
2.5.0
