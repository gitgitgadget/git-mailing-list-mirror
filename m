From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v14 07/13] ref-filter: add support for %(contents:lines=X)
Date: Sat, 29 Aug 2015 19:42:11 +0530
Message-ID: <1440857537-13968-8-git-send-email-Karthik.188@gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 16:12:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVgs2-0003nt-U4
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 16:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbbH2OMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 10:12:33 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35080 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbH2OMb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 10:12:31 -0400
Received: by pacdd16 with SMTP id dd16so91066759pac.2
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PsiPVigajPwhD3C+q9OWzqQSdKj9wmbP9b8swmm/kBk=;
        b=SYyhFmU2GqsTnCqEnVfnnO0t61TJO1mUCEj9ZnpTxf5sj0S09EQ3a8ZTLuJrqX+L/W
         eIDjMDgZFjEgIQIL5hNK6UcKMwXqZvSGek6wYAqvXcqy6LJjHW5t0NIgbr7noQZLaH9Z
         c71newMYLjTmeY4SPObyt7xZF1kQbdD4U1iXdRE2s4QoZZLeBn9VsVCbgrIKEhpNENjX
         4Uq9pZ+Q6dnh2wAxpMGLNtgocqU66k2lM2ERr1e81n/uuoNLjtKeodSXoo87g2xtQ/QI
         NCaluB5H5E+ZLAZAcY8kXJI7XOtv3LyoOS68XJ6CamgzK2mszMKlYfn2857NP7AlLRLE
         WkMA==
X-Received: by 10.68.189.161 with SMTP id gj1mr23968194pbc.4.1440857550085;
        Sat, 29 Aug 2015 07:12:30 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id hy5sm8876807pac.22.2015.08.29.07.12.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Aug 2015 07:12:29 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276782>

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
 Documentation/git-for-each-ref.txt |  1 +
 builtin/tag.c                      |  4 ++
 ref-filter.c                       | 75 +++++++++++++++++++++++++++++++++++++-
 ref-filter.h                       |  3 +-
 t/t6302-for-each-ref-filter.sh     | 16 ++++++++
 5 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 943975d..7ca1fe4 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -149,6 +149,7 @@ Its first line is `contents:subject`, where subject is the concatenation
 of all lines of the commit message up to the first blank line.  The next
 line is 'contents:body', where body is all of the lines after the first
 blank line.  Finally, the optional GPG signature is `contents:signature`.
+The first `N` lines of the object is obtained using `contents:lines=N`.
 
 For sorting purposes, fields with numeric values sort in numeric
 order (`objectsize`, `authordate`, `committerdate`, `taggerdate`).
diff --git a/builtin/tag.c b/builtin/tag.c
index 471d6b1..0fc7557 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -185,6 +185,10 @@ static enum contains_result contains(struct commit *candidate,
 	return contains_test(candidate, want);
 }
 
+/*
+ * Currently duplicated in ref-filter, will eventually be removed as
+ * we port tag.c to use ref-filter APIs.
+ */
 static void show_tag_lines(const struct object_id *oid, int lines)
 {
 	int i;
diff --git a/ref-filter.c b/ref-filter.c
index 1e6754a..ece7a23 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -56,6 +56,7 @@ static struct {
 	{ "color" },
 	{ "align" },
 	{ "end" },
+	{ "contents:lines" },
 };
 
 struct align {
@@ -63,6 +64,11 @@ struct align {
 	unsigned int width;
 };
 
+struct contents {
+	unsigned int lines;
+	struct object_id oid;
+};
+
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
 
 struct ref_formatting_stack {
@@ -80,6 +86,7 @@ struct ref_formatting_state {
 struct atom_value {
 	const char *s;
 	struct align *align;
+	struct contents *contents;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
 };
@@ -569,6 +576,61 @@ static void find_subpos(const char *buf, unsigned long sz,
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
@@ -579,6 +641,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i];
 		struct atom_value *v = &val[i];
+		const char *valp = NULL;
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
@@ -588,7 +651,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 		    strcmp(name, "contents") &&
 		    strcmp(name, "contents:subject") &&
 		    strcmp(name, "contents:body") &&
-		    strcmp(name, "contents:signature"))
+		    strcmp(name, "contents:signature") &&
+		    !starts_with(name, "contents:lines="))
 			continue;
 		if (!subpos)
 			find_subpos(buf, sz,
@@ -608,6 +672,15 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
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
 
diff --git a/ref-filter.h b/ref-filter.h
index 082bee5..3759424 100644
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
index cef7a41..0277498 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -166,4 +166,20 @@ test_expect_success 'nested alignment' '
 	test_cmp expect actual
 '
 
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
 test_done
-- 
2.5.0
