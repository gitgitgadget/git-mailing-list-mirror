From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/12] attr: convert git_all_attrs() to use "struct git_attr_check"
Date: Mon, 16 May 2016 14:05:43 -0700
Message-ID: <20160516210545.6591-11-gitster@pobox.com>
References: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:06:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2PiY-0001Mt-1u
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbcEPVGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:06:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751266AbcEPVGM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:06:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 886E01C74F;
	Mon, 16 May 2016 17:06:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=YPuh
	cVLbUVNLrTfCaoBe3tjFdIc=; b=YAB3aWTWtn5yuIFIC+CxBTLjKh1uC61cTwPH
	tMOCvLS9Lwn2iFHV3iiXWwCIV7T+jaHW7l+lDumpCrYKyUF+dtAptHk38UjVv0M0
	mNsWqq+xOJ6YDlBtGLPgbZnVdJ6AgE9oJYFTRKbTjkYZhVqQKCYwTZV04bNdWyDs
	Ngn3lRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=J5fJlZ
	MKmTWwMza1ZpFDnoNHPrNbPycTymXk/VplZjWDYotOU2APz2AN9LKkcyu9PFKLqC
	7XJYpr/qfSe3Q2sadMSqWMhJ1RpyQ4CC+2WcDdw4m2Hp8+zRn+x3ZZ561F4KiEOs
	DLUT/wzb8gLDbcQjwWzzGhphgO1tD8f7ZQi4s=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 812491C74D;
	Mon, 16 May 2016 17:06:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D563D1C74B;
	Mon, 16 May 2016 17:06:10 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
X-Pobox-Relay-ID: 041E4036-1BAA-11E6-A891-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294794>

This updates the other two ways the attribute check is done via an
array of "struct git_attr_check_elem" elements.  These two niches
appear only in "git check-attr".

 * The caller does not know offhand what attributes it wants to ask
   about and cannot use git_attr_check_initl() to prepare the
   git_attr_check structure.

 * The caller may not know what attributes it wants to ask at all,
   and instead wants to learn everything that the given path has.

Such a caller can call git_attr_check_alloc() to allocate an empty
git_attr_check, and then call git_attr_check_append() to add
attribute names one by one.  A new attribute can be appended until
git_attr_check structure is "finalized", which happens when it is
used to ask for attributes for any path by calling git_check_attr()
or git_all_attrs().  A git_attr_check structure that is initialized
by git_attr_check_initl() is already finalized when it is returned.

I am not at all happy with the way git_all_attrs() API turned out to
be, but it is only to support one niche caller ("check-attr --all"),
so I'll stop here for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c               | 70 +++++++++++++++++++++++++++++++++++++---------------
 attr.h               | 16 +++++++-----
 builtin/check-attr.c | 54 ++++++++++++++++++----------------------
 3 files changed, 84 insertions(+), 56 deletions(-)

diff --git a/attr.c b/attr.c
index 285fc58..9c187bc 100644
--- a/attr.c
+++ b/attr.c
@@ -785,32 +785,21 @@ int git_check_attrs(const char *path, int num, struct git_attr_check_elem *check
 	return 0;
 }
 
-int git_all_attrs(const char *path, int *num, struct git_attr_check_elem **check)
+void git_all_attrs(const char *path, struct git_attr_check *check)
 {
-	int i, count, j;
+	int i;
 
+	git_attr_check_clear(check);
 	collect_some_attrs(path, 0, NULL);
 
-	/* Count the number of attributes that are set. */
-	count = 0;
-	for (i = 0; i < attr_nr; i++) {
-		const char *value = check_all_attr[i].value;
-		if (value != ATTR__UNSET && value != ATTR__UNKNOWN)
-			++count;
-	}
-	*num = count;
-	ALLOC_ARRAY(*check, count);
-	j = 0;
 	for (i = 0; i < attr_nr; i++) {
+		const char *name = check_all_attr[i].attr->name;
 		const char *value = check_all_attr[i].value;
-		if (value != ATTR__UNSET && value != ATTR__UNKNOWN) {
-			(*check)[j].attr = check_all_attr[i].attr;
-			(*check)[j].value = value;
-			++j;
-		}
+		if (value == ATTR__UNSET || value == ATTR__UNKNOWN)
+			continue;
+		git_attr_check_append(check, name);
+		check->check[check->check_nr - 1].value = value;
 	}
-
-	return 0;
 }
 
 void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
@@ -828,6 +817,7 @@ void git_attr_set_direction(enum git_attr_direction new, struct index_state *ist
 
 int git_check_attr(const char *path, struct git_attr_check *check)
 {
+	check->finalized = 1;
 	return git_check_attrs(path, check->check_nr, check->check);
 }
 
@@ -845,17 +835,57 @@ struct git_attr_check *git_attr_check_initl(const char *one, ...)
 	check = xcalloc(1,
 			sizeof(*check) + cnt * sizeof(*(check->check)));
 	check->check_nr = cnt;
+	check->finalized = 1;
 	check->check = (struct git_attr_check_elem *)(check + 1);
 
 	check->check[0].attr = git_attr(one);
 	va_start(params, one);
 	for (cnt = 1; cnt < check->check_nr; cnt++) {
+		struct git_attr *attr;
 		param = va_arg(params, const char *);
 		if (!param)
 			die("BUG: counted %d != ended at %d",
 			    check->check_nr, cnt);
-		check->check[cnt].attr = git_attr(param);
+		attr = git_attr(param);
+		if (!attr)
+			die("BUG: %s: not a valid attribute name", param);
+		check->check[cnt].attr = attr;
 	}
 	va_end(params);
 	return check;
 }
+
+struct git_attr_check *git_attr_check_alloc(void)
+{
+	return xcalloc(1, sizeof(struct git_attr_check));
+}
+
+void git_attr_check_append(struct git_attr_check *check, const char *name)
+{
+	struct git_attr *attr;
+
+	if (check->finalized)
+		die("BUG: append after git_attr_check structure is finalized");
+
+	attr = git_attr(name);
+	if (!attr)
+		die("%s: not a valid attribute name", name);
+	ALLOC_GROW(check->check, check->check_nr + 1, check->check_alloc);
+	check->check[check->check_nr++].attr = attr;
+}
+
+void git_attr_check_clear(struct git_attr_check *check)
+{
+	if ((void *)(check->check) == (void *)(check + 1))
+		die("BUG: clearing a statically initialized git_attr_check");
+	free(check->check);
+	check->check_nr = 0;
+	check->check_alloc = 0;
+	check->finalized = 0;
+}
+
+void git_attr_check_free(struct git_attr_check *check)
+{
+	git_attr_check_clear(check);
+	free(check);
+}
diff --git a/attr.h b/attr.h
index 3ed89e5..b5557ae 100644
--- a/attr.h
+++ b/attr.h
@@ -30,6 +30,7 @@ struct git_attr_check_elem {
 };
 
 struct git_attr_check {
+	int finalized;
 	int check_nr;
 	int check_alloc;
 	struct git_attr_check_elem *check;
@@ -38,6 +39,12 @@ struct git_attr_check {
 extern struct git_attr_check *git_attr_check_initl(const char *, ...);
 extern int git_check_attr(const char *path, struct git_attr_check *);
 
+extern struct git_attr_check *git_attr_check_alloc(void);
+extern void git_attr_check_append(struct git_attr_check *, const char *);
+
+extern void git_attr_check_clear(struct git_attr_check *);
+extern void git_attr_check_free(struct git_attr_check *);
+
 /*
  * Return the name of the attribute represented by the argument.  The
  * return value is a pointer to a null-delimited string that is part
@@ -48,13 +55,10 @@ char *git_attr_name(struct git_attr *);
 int git_check_attrs(const char *path, int, struct git_attr_check_elem *);
 
 /*
- * Retrieve all attributes that apply to the specified path.  *num
- * will be set to the number of attributes on the path; **check will
- * be set to point at a newly-allocated array of git_attr_check
- * objects describing the attributes and their values.  *check must be
- * free()ed by the caller.
+ * Retrieve all attributes that apply to the specified path.
+ * check holds the attributes and their values.
  */
-int git_all_attrs(const char *path, int *num, struct git_attr_check_elem **check);
+void git_all_attrs(const char *path, struct git_attr_check *check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 97e3837..700700f 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -24,12 +24,13 @@ static const struct option check_attr_options[] = {
 	OPT_END()
 };
 
-static void output_attr(int cnt, struct git_attr_check_elem *check,
-			const char *file)
+static void output_attr(struct git_attr_check *check, const char *file)
 {
 	int j;
+	int cnt = check->check_nr;
+
 	for (j = 0; j < cnt; j++) {
-		const char *value = check[j].value;
+		const char *value = check->check[j].value;
 
 		if (ATTR_TRUE(value))
 			value = "set";
@@ -42,36 +43,37 @@ static void output_attr(int cnt, struct git_attr_check_elem *check,
 			printf("%s%c" /* path */
 			       "%s%c" /* attrname */
 			       "%s%c" /* attrvalue */,
-			       file, 0, git_attr_name(check[j].attr), 0, value, 0);
+			       file, 0,
+			       git_attr_name(check->check[j].attr), 0, value, 0);
 		} else {
 			quote_c_style(file, NULL, stdout, 0);
-			printf(": %s: %s\n", git_attr_name(check[j].attr), value);
+			printf(": %s: %s\n",
+			       git_attr_name(check->check[j].attr), value);
 		}
-
 	}
 }
 
 static void check_attr(const char *prefix,
-		       int cnt, struct git_attr_check_elem *check,
+		       struct git_attr_check *check,
 		       const char *file)
 {
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 	if (check != NULL) {
-		if (git_check_attrs(full_path, cnt, check))
-			die("git_check_attrs died");
-		output_attr(cnt, check, file);
+		if (git_check_attr(full_path, check))
+			die("git_check_attr died");
+		output_attr(check, file);
 	} else {
-		if (git_all_attrs(full_path, &cnt, &check))
-			die("git_all_attrs died");
-		output_attr(cnt, check, file);
-		free(check);
+		check = git_attr_check_alloc();
+		git_all_attrs(full_path, check);
+		output_attr(check, file);
+		git_attr_check_free(check);
 	}
 	free(full_path);
 }
 
 static void check_attr_stdin_paths(const char *prefix,
-				   int cnt, struct git_attr_check_elem *check)
+				   struct git_attr_check *check)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -85,7 +87,7 @@ static void check_attr_stdin_paths(const char *prefix,
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		check_attr(prefix, cnt, check, buf.buf);
+		check_attr(prefix, check, buf.buf);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	strbuf_release(&buf);
@@ -100,7 +102,7 @@ static NORETURN void error_with_usage(const char *msg)
 
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
-	struct git_attr_check_elem *check;
+	struct git_attr_check *check;
 	int cnt, i, doubledash, filei;
 
 	if (!is_bare_repository())
@@ -163,24 +165,16 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	if (all_attrs) {
 		check = NULL;
 	} else {
-		check = xcalloc(cnt, sizeof(*check));
-		for (i = 0; i < cnt; i++) {
-			const char *name;
-			struct git_attr *a;
-			name = argv[i];
-			a = git_attr(name);
-			if (!a)
-				return error("%s: not a valid attribute name",
-					name);
-			check[i].attr = a;
-		}
+		check = git_attr_check_alloc();
+		for (i = 0; i < cnt; i++)
+			git_attr_check_append(check, argv[i]);
 	}
 
 	if (stdin_paths)
-		check_attr_stdin_paths(prefix, cnt, check);
+		check_attr_stdin_paths(prefix, check);
 	else {
 		for (i = filei; i < argc; i++)
-			check_attr(prefix, cnt, check, argv[i]);
+			check_attr(prefix, check, argv[i]);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	return 0;
-- 
2.8.2-748-gfb85f76
