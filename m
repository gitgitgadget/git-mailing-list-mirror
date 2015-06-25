From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 3/9] ref-filter: support printing N lines from tag annotation
Date: Thu, 25 Jun 2015 17:13:10 +0530
Message-ID: <1435232596-27466-3-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
 <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 13:43:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z85ZL-0006GR-OX
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 13:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbbFYLno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 07:43:44 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33564 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbFYLnm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 07:43:42 -0400
Received: by padev16 with SMTP id ev16so48609603pad.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OQxjTftOupYS/Kq4hwuMQ9Z1tyWomMtA8dLAw37Xqso=;
        b=rrKCE7Q+9+w6uDqZNnR6PgQd9txIkbN2+/ubEbvUdBPnPeQAalq7B8BGBVx2yKzb1d
         iKWuL/IkQR+CT7vnRbuWYyjsD6rgjZZw1dW1DDxCrA5KkHeNIzQ67RvB1184c+J+tUGT
         5y/eENVfO0YZuWVTCodVacmGfLADOKUtybl2FYWeIg3QV6ZYedLocXhHr31vxik+vB0R
         B5RhEqNyCY5/IPg7Abz4gCR8GuN2CyftyBmUy1tsUXIi3GMzycYbSAAMFc2TB7W4rPqr
         SEGE+D2rx7RY6jtwPFSBuK6vniP+PXJ67KZf04lf8yzZpfROkXAr8lTNMVwgBEn2otLj
         zs0w==
X-Received: by 10.68.131.225 with SMTP id op1mr20250778pbb.86.1435232621823;
        Thu, 25 Jun 2015 04:43:41 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id xn2sm11575446pbc.44.2015.06.25.04.43.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 04:43:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272660>

In 'tag.c' we can print N lines from the annotation of the tag
using the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter'
and modify 'ref-filter' to support printing of N lines from the
annotation of tags.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c |  2 +-
 builtin/tag.c          |  4 ++++
 ref-filter.c           | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 ref-filter.h           |  3 ++-
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 5868c48..c318e33 100644
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
index 767162e..9f300e0 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -180,6 +180,10 @@ static enum contains_result contains(struct commit *candidate,
 	return contains_test(candidate, want);
 }
 
+/*
+ * Currently dupplicated in ref-filter, will eventually be removed as
+ * we port tag.c to use ref-filter APIs.
+ */
 static void show_tag_lines(const struct object_id *oid, int lines)
 {
 	int i;
diff --git a/ref-filter.c b/ref-filter.c
index 97432d1..57a5cfb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1262,7 +1262,48 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+/* Print 'lines' no of lines of a given oid */
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
 
@@ -1288,6 +1329,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		resetv.s = color;
 		print_value(&resetv, quote_style);
 	}
+	if (lines > 0) {
+		struct object_id oid;
+		hashcpy(oid.hash, info->objectname);
+		show_tag_lines(&oid, lines);
+	}
 	putchar('\n');
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index dd28d17..6b6fb96 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -55,6 +55,7 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo: 1;
+	unsigned int lines;
 };
 
 struct ref_filter_cbdata {
@@ -87,7 +88,7 @@ int verify_ref_format(const char *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
 /*  Print the ref using the given format and quote_style */
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
+void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style, unsigned int lines);
 /*  Callback function for parsing the sort option */
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
-- 
2.4.4
