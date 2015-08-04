From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 05/11] ref-filter: support printing N lines from tag annotation
Date: Tue,  4 Aug 2015 18:13:02 +0530
Message-ID: <1438692188-14367-5-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZSBMk9y1VGTVKSVsGMdYuPtjhPADciVUaEVwESRdSvWZg@mail.gmail.com>
 <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 14:43:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMbZ7-0004Ip-Fx
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 14:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236AbbHDMn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 08:43:27 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36738 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbbHDMnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 08:43:24 -0400
Received: by pacgq8 with SMTP id gq8so7799459pac.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aPEbzDZwtsRvAKf1Xvz+g4GuDXoBxd/X1scXfGGPFf4=;
        b=io8JuBR83Vw7rb/FtSW7Xd4lbncDEZuTzNkvT1LrcuC+WPWMS6NqDj9DcvXKM3m3Zw
         uTJhbR7ui5s7Xe4f0jGNZzqGfVgUtWGJupEIbxkc2PUsVux4DaSB5OwGDe5EpBVRP2Vc
         8qpntug5kHyPH8jwj8UdBOwumKDjyNzqXEiRUXU8PJCoyx1UL+0YJhv81C4yCGb96H42
         Z2bBf9spOMD99FI1/QAOhuBuKH1q+uSQdDD/L8Bs7ySzy+kj1yXDUjC1BWJq8gALSJQL
         Ex1BCS8q/fyZJFkiGEFZM/1/boCoMA5WcnTlh0rGJLgyYKQOP36lBLdJbYa18TGIkeW4
         1Pdw==
X-Received: by 10.66.222.161 with SMTP id qn1mr7660639pac.66.1438692204150;
        Tue, 04 Aug 2015 05:43:24 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id m2sm1359951pdr.64.2015.08.04.05.43.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 05:43:23 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438692188-14367-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275258>

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
 ref-filter.c           | 54 ++++++++++++++++++++++++++++++++++++++++++++++++--
 ref-filter.h           |  9 +++++++--
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
index 7c9c51d..1609b01 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1325,7 +1325,51 @@ static void apply_formatting_state(struct ref_formatting_state *state, struct st
 	strbuf_release(state->output);
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
 	struct strbuf value = STRBUF_INIT;
@@ -1377,8 +1421,14 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 
 	for (i = 0; i < final_buf.len; i++)
 		printf("%c", final_buf.buf[i]);
-	putchar('\n');
 	strbuf_release(&final_buf);
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
index 3412dce..2f571ed 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -74,6 +74,7 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1;
+	unsigned int lines;
 };
 
 struct ref_filter_cbdata {
@@ -105,8 +106,12 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
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
