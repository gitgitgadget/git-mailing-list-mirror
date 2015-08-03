From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 05/11] ref-filter: support printing N lines from tag annotation
Date: Mon,  3 Aug 2015 22:24:15 +0530
Message-ID: <1438620861-25219-5-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 18:54:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMJ0c-0000PH-P1
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 18:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbbHCQye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 12:54:34 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33692 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbbHCQyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 12:54:33 -0400
Received: by padck2 with SMTP id ck2so94066256pad.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Y0erZJxXv1U3E/wSfyh1kmRrHS+KYPuEZma9h9yJZo=;
        b=kYShT3UwOQ5PoL4ObkU+mAXoBHwWFkg9TpdX8V/8EdXEji8v4VqixSJ5HdT3K+cd1U
         sGPCS6bS6gpfTkCLQa+eUbWP2xeQ0dT/5pgCYvVuYzjix2PYbCl+tVc+SIsnrqmeY7pt
         aIkE07himZnEWAHk1MoaWlyvTh5kHwb2ZAar8+CQeDSuzyewsptt6Rqz35DjulmLbujB
         pGgUdREv9sl3vBsrhL/rtzc+TvnSvU4f7SjUkJAY+5XBY+xKYv872+3uRlBtKn5N4hnY
         XH9QVMzmh6Lu93TWviaZ9L4A0cd2wKXVGVRKtFcY07xjBbf6drv2Q/W1O0A2c9sLogDo
         91HA==
X-Received: by 10.68.224.71 with SMTP id ra7mr25747540pbc.69.1438620872643;
        Mon, 03 Aug 2015 09:54:32 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id gk5sm18164153pac.21.2015.08.03.09.54.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Aug 2015 09:54:32 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275179>

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
index 01c9097..9f3806a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1318,7 +1318,51 @@ static void apply_formatting_state(struct ref_formatting_state *state, struct st
 
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
@@ -1363,8 +1407,14 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 
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
index 8d4e348..16cffab 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -71,6 +71,7 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1;
+	unsigned int lines;
 };
 
 struct ref_filter_cbdata {
@@ -102,8 +103,12 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
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
