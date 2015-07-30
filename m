From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 05/11] ref-filter: support printing N lines from tag annotation
Date: Thu, 30 Jul 2015 21:05:46 +0530
Message-ID: <1438270552-10333-5-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438270552-10333-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 17:36:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKpsO-00014u-Sb
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbbG3PgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:36:04 -0400
Received: from mail-pd0-f195.google.com ([209.85.192.195]:35404 "EHLO
	mail-pd0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbG3PgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:36:03 -0400
Received: by pdbnk16 with SMTP id nk16so2271121pdb.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yeyGLeR9uaFnQyXAJ2yR72xPjWPGMfW4Rt0SWpX1yvc=;
        b=DgIZBW/kUZsSPspQo9oru+JHZShG2u4fTYviL7z01YSPuTa6+U5TtRMZ5IksKnun3U
         Jr7Z486QEGgxZJQn7UTRgGDPbOfCWjPwu46pyF2ujVf3Kp/sS613Qb3jVZAYg7rv8fbG
         BfO0pyZjBRfttnE+HbP2atVwvStmu0pSAF4kCp1qvJeeBc3hM2pAVAkXqx16jKHIs27u
         BlAVp0JIXRi+ebDLB+7cjYSNcNyDyC1gW0mkG+12VZ+ujRKQA7tnbdJKDRc+CvMTJjZk
         6MeL+/rCHaPp12Ug3hqZU4BAI9x3Q9Sbu27o/WKVQUFQYjnmZiVXK4aFY030V9ylPYNa
         0+RA==
X-Received: by 10.70.6.161 with SMTP id c1mr106851222pda.76.1438270561962;
        Thu, 30 Jul 2015 08:36:01 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id oq10sm2790985pdb.75.2015.07.30.08.35.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 08:36:01 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438270552-10333-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274994>

From: Karthik Nayak <karthik.188@gmail.com>

In 'tag.c' we can print N lines from the annotation of the tag using
the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
modify 'ref-filter' to support printing of N lines from the annotation
of tags.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c |  2 +-
 builtin/tag.c          |  4 ++++
 ref-filter.c           | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
 ref-filter.h           |  9 +++++++--
 4 files changed, 62 insertions(+), 4 deletions(-)

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
index 510a1da..edb2c38 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1315,7 +1315,51 @@ static void store_formatting_state(struct ref_formatting_state *state,
 		state->pad_to_right = atomv->ul;
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
@@ -1348,6 +1392,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		resetv.s = color;
 		print_value(&resetv, &state);
 	}
+	if (lines > 0) {
+		struct object_id oid;
+		hashcpy(oid.hash, info->objectname);
+		show_tag_lines(&oid, lines);
+	}
 	putchar('\n');
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 2b8462a..4d94ebf 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -64,6 +64,7 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1;
+	unsigned int lines;
 };
 
 struct ref_filter_cbdata {
@@ -95,8 +96,12 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
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
-- 
2.4.6
