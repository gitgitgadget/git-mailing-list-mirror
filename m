From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v11 07/13] ref-filter: support printing N lines from tag annotation
Date: Sat, 15 Aug 2015 23:30:37 +0530
Message-ID: <1439661643-16094-8-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 20:01:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQflZ-0001a1-67
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 20:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbbHOSA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 14:00:58 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33747 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbbHOSA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 14:00:57 -0400
Received: by pabyb7 with SMTP id yb7so79256497pab.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2xMm7AAc+yxurL0DbwpVJnWxwiKrqP/ewjPS4ra4WwA=;
        b=gMwu7K+U1cvqJXz0NZp+Y/KdZXe+LsW0gDLTu6BJVZWM2iNZ9TRrrdCViLGmr7395d
         k3gls2l2S4y3J3aJ9nRcGTo6PZfOde3GrSSS8LZ1kY11JhaE4W0oc45fMpmCC8aSbcYl
         pHWkutDhm9otKdjcLKcv+xH62gRfgRF+aABBSwuBcLyH6aDdBKeadMzGm0G45Gg5eBJG
         PEVVGocV8fCzhegvA6B4fNejz3J+AylLx6z81GwDHXYn+PwUBMfMosUBXXU+vOvUQjc/
         8RpAyhK/o7qL8KMjKlg6Hm7yZr8zmvQbW0+OicvJkqGz9j+ae7U3otGr99NK9Q2JQlSZ
         jdjA==
X-Received: by 10.68.134.169 with SMTP id pl9mr101301445pbb.164.1439661656514;
        Sat, 15 Aug 2015 11:00:56 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pe3sm9424144pdb.55.2015.08.15.11.00.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Aug 2015 11:00:55 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276000>

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
 ref-filter.c           | 52 +++++++++++++++++++++++++++++++++++++++++++++++++-
 ref-filter.h           | 11 ++++++++---
 4 files changed, 64 insertions(+), 5 deletions(-)

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
index abcd235..2f302b4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1398,7 +1398,51 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
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
 	struct strbuf *final_buf;
@@ -1434,6 +1478,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 	final_buf = &state->output;
 	fwrite(final_buf->buf, 1, final_buf->len, stdout);
 	pop_state(&state);
+
+	if (lines > 0) {
+		struct object_id oid;
+		hashcpy(oid.hash, info->objectname);
+		show_tag_lines(&oid, lines);
+	}
 	putchar('\n');
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 64fedd3..0f2048d 100644
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
@@ -91,8 +92,12 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
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
2.5.0
