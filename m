From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 07/13] ref-filter: support printing N lines from tag annotation
Date: Sun,  9 Aug 2015 19:41:40 +0530
Message-ID: <1439129506-9989-8-git-send-email-Karthik.188@gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 16:12:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZORLC-00077G-Iw
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 16:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933065AbbHIOMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 10:12:43 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35609 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbbHIOME (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 10:12:04 -0400
Received: by pacgr6 with SMTP id gr6so8153218pac.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rL8n4DS+9qG+hQoKke+INDwWgecFtzWjdNM9/b68B9M=;
        b=Kkp/sUbbEGOPTEnybgqSXrYzRHYZrgE7KJY6U465Jy2+ONgyj6wZ/ybspoBMr6LIKy
         7wS6mqs6hX5KsNd/HdPzOmLGhY9MSargxVWUOb1REFTBMbciEu8wKzzFVwBWMPP7/WYY
         qdgMt2g4v+JZx6OSvoDGIsSMHtor4UJGT88Zo4z++3J+IFvyLq6hVfclVm2y3VFgtCZC
         tp9DRX6G71d5HqXSLrbP+/WBBNeQgm1WL1UWOidrsD5UaU9L6reLoa25An4SX01L+aRM
         lp9/vNJlHt7NDvqhNbB5bmjegRHbBHDmRrosIqoBAiez4xwwoyBXD7FfmMlKEhNgyUH2
         j/FQ==
X-Received: by 10.68.133.68 with SMTP id pa4mr35680367pbb.71.1439129523128;
        Sun, 09 Aug 2015 07:12:03 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id la4sm72920pbc.76.2015.08.09.07.12.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Aug 2015 07:12:02 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275546>

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
 ref-filter.c           | 55 ++++++++++++++++++++++++++++++++++++++++++++++++--
 ref-filter.h           |  9 +++++++--
 4 files changed, 65 insertions(+), 5 deletions(-)

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
index fb5d74e..2042962 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1327,7 +1327,51 @@ static void perform_state_formatting(struct ref_formatting_state *state, struct
 	strbuf_reset(&state->output);
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
 	struct strbuf final_buf = STRBUF_INIT;
@@ -1373,10 +1417,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 		format_quote_value(&resetv, &state);
 		perform_state_formatting(&state, &final_buf);
 	}
+
 	fwrite(final_buf.buf, 1, final_buf.len, stdout);
-	putchar('\n');
 	strbuf_release(&final_buf);
 	strbuf_release(&state.output);
+
+	if (lines > 0) {
+		struct object_id oid;
+		hashcpy(oid.hash, info->objectname);
+		show_tag_lines(&oid, lines);
+	}
+	putchar('\n');
 }
 
 /*  If no sorting option is given, use refname to sort as default */
diff --git a/ref-filter.h b/ref-filter.h
index 1886baa..72e21bb 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -53,6 +53,7 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1;
+	unsigned int lines;
 };
 
 struct ref_filter_cbdata {
@@ -84,8 +85,12 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
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
