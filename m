From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v17 08/14] ref-filter: add support for %(contents:lines=X)
Date: Fri, 11 Sep 2015 20:34:16 +0530
Message-ID: <1441983856-540-1-git-send-email-Karthik.188@gmail.com>
References: <1441900110-4015-9-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 17:04:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaPs7-0000on-53
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 17:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbbIKPEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 11:04:10 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34616 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbbIKPEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 11:04:09 -0400
Received: by padhy16 with SMTP id hy16so77294431pad.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WKek7uk85UH+DbPPoHX4HUfbWml0BqbSchO0PoQspa0=;
        b=qhnm6AQM6K5yzD1b93B99qg7uGoMCvCfekj3sol7u6fgr+8weEx2Sa508fAxgbndxT
         UAhO3ngeRnyN7QAmZsUkRwHGDv2R1tXBxp/p23yRpiDu2KQKAXaAI/vXIneH2Asq86IC
         +RwDYL9nj0GlzNlYQ1dHIQl+VFmEYp1Ahv3c54lcOaN/ZxTK9afusZt5SErHpUQAf4/8
         QZMImzkMDfdt/et3N2VewAlF/BZXwXX0qrYNvKogb0L4Vd7+HuD6gxzUWdQLn/gMcTzb
         2vh56Wdq+DRrF9bTz8pgloNjMl0lXuwzx/Zhgw61TxRsU41jByX6TzPc2ALUfTq2nJbe
         7vaw==
X-Received: by 10.68.68.134 with SMTP id w6mr24682477pbt.61.1441983848444;
        Fri, 11 Sep 2015 08:04:08 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id oa5sm909302pbb.41.2015.09.11.08.04.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Sep 2015 08:04:07 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441900110-4015-9-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277663>

In 'tag.c' we can print N lines from the annotation of the tag using
the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
modify it to support appending of N lines from the annotation of tags
to the given strbuf.

Implement %(contents:lines=X) where X lines of the given object are
obtained.

While we're at it, remove unused "contents:<suboption>" atoms from
the `valid_atom` array.

Add documentation and test for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 ++-
 builtin/tag.c                      |  4 +++
 ref-filter.c                       | 47 +++++++++++++++++++++++++++++++---
 ref-filter.h                       |  3 ++-
 t/t6302-for-each-ref-filter.sh     | 52 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 3a271bf..324ad2c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -150,7 +150,8 @@ The complete message in a commit and tag object is `contents`.
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
index f046d82..32aab37 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -45,9 +45,6 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
-	{ "contents:subject" },
-	{ "contents:body" },
-	{ "contents:signature" },
 	{ "upstream" },
 	{ "push" },
 	{ "symref" },
@@ -65,6 +62,11 @@ struct align {
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
@@ -81,6 +83,7 @@ struct atom_value {
 	const char *s;
 	union {
 		struct align align;
+		struct contents contents;
 	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
@@ -643,6 +646,30 @@ static void find_subpos(const char *buf, unsigned long sz,
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
@@ -653,6 +680,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i];
 		struct atom_value *v = &val[i];
+		const char *valp = NULL;
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
@@ -662,7 +690,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 		    strcmp(name, "contents") &&
 		    strcmp(name, "contents:subject") &&
 		    strcmp(name, "contents:body") &&
-		    strcmp(name, "contents:signature"))
+		    strcmp(name, "contents:signature") &&
+		    !starts_with(name, "contents:lines="))
 			continue;
 		if (!subpos)
 			find_subpos(buf, sz,
@@ -682,6 +711,16 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
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
index f596035..bab1f28 100755
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
