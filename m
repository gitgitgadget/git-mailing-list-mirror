From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 03/10] ref-filter: support printing N lines from tag annotation
Date: Thu,  9 Jul 2015 15:57:44 +0530
Message-ID: <1436437671-25600-3-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 12:29:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD953-0004Gy-Ec
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 12:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbbGIK2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 06:28:41 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36652 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbbGIK2D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 06:28:03 -0400
Received: by pdjr16 with SMTP id r16so1968824pdj.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u7CVKrtFP4neNfzyLT59cphL8cGBMmylt9ByqpSuI4Q=;
        b=Z7Y/cnlj+MnkIq2TcBcpcid/FP2fzDfFbSD++qxJR8A6inhw+0zfABye9GJfg83sVP
         sh/N+ka7giT/LVySufFGLSftHOgwqc3DlwB5nawGA5iTIlMUe/UedCVPfZgm/eXKLTUy
         2PhdHZ2O3P/FnTapmDir9fMmrrN6g8ihPbhPcJj7LOdbm2NPhzVAEN0USXWYbOb9HsiC
         HBopjuk8r706fDquRtylHCUWg18fya5Xvm8czQtGPZk2xu8PBZ9W6eKEQ+5QrDEfCMIB
         K78+8vpqK34IeLhO08H9+RV8L3iZ/ph73JByn2o2O5BLsSe53A8T/Bvw0KEg0IQeKtRK
         X94w==
X-Received: by 10.68.217.2 with SMTP id ou2mr30115349pbc.71.1436437682954;
        Thu, 09 Jul 2015 03:28:02 -0700 (PDT)
Received: from ashley.localdomain ([49.201.133.206])
        by smtp.gmail.com with ESMTPSA id b10sm5449836pdo.84.2015.07.09.03.28.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 03:28:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273738>

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
index 071d001..3b6a6cc 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -185,6 +185,10 @@ static enum contains_result contains(struct commit *candidate,
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
index e690177..1b088b1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1273,7 +1273,48 @@ static void emit(const char *cp, const char *ep)
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
 
@@ -1299,6 +1340,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
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
index 449ddb8..5247475 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -55,6 +55,7 @@ struct ref_filter {
 	struct commit *merge_commit;
 
 	unsigned int with_commit_tag_algo : 1;
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
2.4.5
