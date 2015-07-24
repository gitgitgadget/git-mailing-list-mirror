From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 04/10] ref-filter: support printing N lines from tag annotation
Date: Sat, 25 Jul 2015 00:34:39 +0530
Message-ID: <1437764685-8633-5-git-send-email-Karthik.188@gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 21:05:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIiHw-0003eN-9I
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbbGXTFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:05:33 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33905 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbbGXTF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:05:26 -0400
Received: by pdbbh15 with SMTP id bh15so17615345pdb.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fgOwi04AU2f2a2hA7mBA7+dAYe21q1OnJ851Z7k3XHo=;
        b=LMmegdcsLZrSXcCj93HG2ZOrQkM6u8aOLzg1GsmsiMldzq4JAlWS/5VaMidEVVgcfN
         FLjGSVMcZPJQF+WVk6tcAeVdkawjDNc7RZOZKua+q6JFgU03QmvzNZXMlGJVIx4CKG1S
         bY+KZO80Zt16sB1Q1VXCbqaAmDzB+M12YwDYgSx9s74P0wP5FXWKk34ab32qLzaevQr/
         WVBc5lItJEtE76gV8zm0gaLlWvMNiXK/hdiIw8E5tpdA7KvDF5X0fRadCbiyrDQJN0qA
         VmLAKT45dib4lSAWYeTHD/DCloYY4rPreHfCFkhTiOKQrAkFWFqVltZt7slFljjlbras
         kAJg==
X-Received: by 10.70.87.195 with SMTP id ba3mr34581398pdb.154.1437764725521;
        Fri, 24 Jul 2015 12:05:25 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ns14sm15922915pdb.17.2015.07.24.12.05.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jul 2015 12:05:24 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274584>

From: Karthik Nayak <karthik.188@gmail.com>

In 'tag.c' we can print N lines from the annotation of the tag using
the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
modify 'ref-filter' to support printing of N lines from the annotation
of tags.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c                             |   2 +-
 builtin/tag.c                                      |   4 +
 ref-filter.c                                       |  51 ++++++++-
 ref-filter.h                                       |   9 +-
 ...ter-add-option-to-align-atoms-to-the-left.patch | 124 +++++++++++++++++++++
 5 files changed, 186 insertions(+), 4 deletions(-)
 create mode 100644 v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 40f343b..e4a4f8a 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -74,7 +74,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;
 	for (i = 0; i < maxcount; i++)
-		show_ref_array_item(array.items[i], format, quote_style);
+		show_ref_array_item(array.items[i], format, quote_style, 0);
 	ref_array_clear(&array);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index 071d001..10b11ce 100644
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
index 34e6603..08ecce5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1307,7 +1307,51 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+/*
+ * If 'lines' is greater than 0, print that many lines from the given
+ * object_id 'oid'.
+ */
+static void show_tag_lines(const struct object_id *oid, int lines)
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
+			printf("\n    ");
+		eol = memchr(sp, '\n', size - (sp - buf));
+		len = eol ? eol - sp : size - (sp - buf);
+		fwrite(sp, len, 1, stdout);
+		if (!eol)
+			break;
+		sp = eol + 1;
+	}
+free_return:
+	free(buf);
+}
+
+void show_ref_array_item(struct ref_array_item *info, const char *format,
+			 int quote_style, unsigned int lines)
 {
 	const char *cp, *sp, *ep;
 	struct ref_formatting_state state;
@@ -1339,6 +1383,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		state.color = xstrdup(color);
 		print_value(&state, &resetv);
 	}
+	if (lines > 0) {
+		struct object_id oid;
+		hashcpy(oid.hash, info->objectname);
+		show_tag_lines(&oid, lines);
+	}
 	putchar('\n');
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 729dece..1e2ee65 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -62,6 +62,7 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1;
+	unsigned int lines;
 };
 
 struct ref_filter_cbdata {
@@ -93,8 +94,12 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
 int verify_ref_format(const char *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
-/*  Print the ref using the given format and quote_style */
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
+/*
+ * Print the ref using the given format and quote_style. If 'lines' > 0,
+ * print that many lines of the the given ref.
+ */
+void show_ref_array_item(struct ref_array_item *info, const char *format,
+			 int quote_style, unsigned int lines);
 /*  Callback function for parsing the sort option */
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
diff --git a/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch b/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch
new file mode 100644
index 0000000..350acae
--- /dev/null
+++ b/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch
@@ -0,0 +1,124 @@
+From 3a07ca1f56f74ca54b7f3c30e3dfd9fe2fed1cc3 Mon Sep 17 00:00:00 2001
+From: Karthik Nayak <karthik.188@gmail.com>
+Date: Wed, 10 Jun 2015 17:19:55 +0530
+Subject: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
+
+Add a new atom "align" and support %(align:X) where X is a number.
+This will align the preceeding atom value to the left followed by
+spaces for a total length of X characters. If X is less than the item
+size, the entire atom value is printed.
+
+Helped-by: Duy Nguyen <pclouds@gmail.com>
+Mentored-by: Christian Couder <christian.couder@gmail.com>
+Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
+Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
+---
+ ref-filter.c | 41 +++++++++++++++++++++++++++++++++++++++--
+ ref-filter.h |  1 +
+ 2 files changed, 40 insertions(+), 2 deletions(-)
+
+diff --git a/ref-filter.c b/ref-filter.c
+index 7561727..93f59aa 100644
+--- a/ref-filter.c
++++ b/ref-filter.c
+@@ -10,6 +10,8 @@
+ #include "quote.h"
+ #include "ref-filter.h"
+ #include "revision.h"
++#include "utf8.h"
++#include "git-compat-util.h"
+ 
+ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
+ 
+@@ -53,6 +55,7 @@ static struct {
+ 	{ "flag" },
+ 	{ "HEAD" },
+ 	{ "color" },
++	{ "align" },
+ };
+ 
+ /*
+@@ -620,7 +623,7 @@ static void populate_value(struct ref_array_item *ref)
+ 		const char *name = used_atom[i];
+ 		struct atom_value *v = &ref->value[i];
+ 		int deref = 0;
+-		const char *refname;
++		const char *refname = NULL;
+ 		const char *formatp;
+ 		struct branch *branch = NULL;
+ 
+@@ -687,6 +690,17 @@ static void populate_value(struct ref_array_item *ref)
+ 			else
+ 				v->s = " ";
+ 			continue;
++		} else if (starts_with(name, "align:")) {
++			const char *valp = NULL;
++
++			skip_prefix(name, "align:", &valp);
++			if (!valp[0])
++				die(_("no value given with 'align:'"));
++			strtoul_ui(valp, 10, &ref->align_value);
++			if (ref->align_value < 1)
++				die(_("value should be greater than zero: align:%u"), ref->align_value);
++			v->s = "";
++			continue;
+ 		} else
+ 			continue;
+ 
+@@ -1254,17 +1268,40 @@ static void emit(const char *cp, const char *ep)
+ 	}
+ }
+ 
++static void assign_formating(struct ref_array_item *ref, int parsed_atom, struct atom_value *v)
++{
++	if (ref->align_value && !starts_with(used_atom[parsed_atom], "align")) {
++		unsigned int len = 0;
++
++		if (*v->s)
++			len = utf8_strwidth(v->s);
++		if (ref->align_value > len) {
++			struct strbuf buf = STRBUF_INIT;
++			if (*v->s)
++				strbuf_addstr(&buf, v->s);
++			if (*v->s && v->s[0] == '\0')
++				free((char *)v->s);
++			strbuf_addchars(&buf, ' ', ref->align_value - len);
++			v->s = strbuf_detach(&buf, NULL);
++		}
++		ref->align_value = 0;
++	}
++}
++
+ void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+ {
+ 	const char *cp, *sp, *ep;
+ 
+ 	for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
+ 		struct atom_value *atomv;
++		int parsed_atom;
+ 
+ 		ep = strchr(sp, ')');
+ 		if (cp < sp)
+ 			emit(cp, sp);
+-		get_ref_atom_value(info, parse_ref_filter_atom(sp + 2, ep), &atomv);
++		parsed_atom = parse_ref_filter_atom(sp + 2, ep);
++		get_ref_atom_value(info, parsed_atom, &atomv);
++		assign_formating(info, parsed_atom, atomv);
+ 		print_value(atomv, quote_style);
+ 	}
+ 	if (*cp) {
+diff --git a/ref-filter.h b/ref-filter.h
+index 6bf27d8..12ffbc5 100644
+--- a/ref-filter.h
++++ b/ref-filter.h
+@@ -30,6 +30,7 @@ struct ref_sorting {
+ struct ref_array_item {
+ 	unsigned char objectname[20];
+ 	int flag;
++	unsigned int align_value;
+ 	const char *symref;
+ 	struct commit *commit;
+ 	struct atom_value *value;
+-- 
+2.4.6
+
-- 
2.4.6
