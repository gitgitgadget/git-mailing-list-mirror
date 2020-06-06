Return-Path: <SRS0=8AI5=7T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1E0C433DF
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 00:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151B8206FA
	for <git@archiver.kernel.org>; Sat,  6 Jun 2020 00:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sxvrA0y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgFFAXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 20:23:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39066 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728275AbgFFAXu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jun 2020 20:23:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1318160756;
        Sat,  6 Jun 2020 00:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591402999;
        bh=XZI0tI/rZU/+CqUbAAwGLMA4Mqt7BNLlZEWOJRqHbgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=sxvrA0y5ppVOZ1ZYw0fhKpH2WKt6Ei5UPqt5MwWZofuLUIsEHJxBS3F4tSvCqbdis
         rSd9eYqHqqCvRuCmiUeqLi+KmIxnB/Iq3ScwRHk6pOCDOJYaFSJtxwqhPLFVaZHhXv
         uXmsCJW+p4vpssRAXSRVzzYZO5DSp6k7690bBTuZk2KBrBVZ45WQhGK7swWNxdQeKp
         ZpQW27duUWDWAWqGv2XCekRjDabCYV31wk3+hPifr950mbS2o/6xC6cpGPwDJf29xv
         MKEDxTs9uQl8vSl2Ok4OZnDBg2QSVZJ3DPxhES/48RhhDJlCMaea3Y8hf+R8iE+GFC
         vhAQIfjhFacim1bJzqfQR4x6TAFXcQbzLVHs+/bRK0xrrTibRLzvENGQFUig9h1VCN
         rYb22qx/lnyLYa96QOWvMzqxzjz3CfDweWMFIOHPyp+/8LckJTpEB7WOs9gsBJHfHz
         FbVj+6iXWdeLrYEcctnMdqSoO1FlpXtYQi9C0zDJSIMhmmrt9MV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Billes Tibor <tbilles@gmx.com>
Subject: [PATCH] fast-import: fix incomplete conversion with multiple mark files
Date:   Sat,  6 Jun 2020 00:22:39 +0000
Message-Id: <20200606002241.1578150-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com>
References: <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When ddddf8d7e2 ("fast-import: permit reading multiple marks files",
2020-02-22) converted fast-import to handle multiple marks files in
preparation for submodule support, the conversion was incomplete.  With
a large number of marks, we would actually modify the marks variable
even though we had passed in a different variable to operate on.  In
addition, we didn't consider the fact that the code can replace the mark
set passed in, so when we did so we happened to leak quite a bit of
memory, since we never reused the structure we created, instead
reallocating a new one each time.

It doesn't appear from some testing that we actually produce incorrect
results in this case, only that we leak a substantial amount of memory.
To make things work properly and avoid leaking, pass a pointer to
pointer to struct mark_set, which allows us to modify the set of marks
when the number of marks is large.

With this patch, importing a dump of git.git with a set of exported
marks goes from taking in excess of 15 GiB of memory (and being killed
by the Linux OOM killer) to using a maximum of 1.4 GiB of memory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fast-import.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 0dfa14dc8c..ed87d6e380 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -150,7 +150,7 @@ struct recent_command {
 	char *buf;
 };
 
-typedef void (*mark_set_inserter_t)(struct mark_set *s, struct object_id *oid, uintmax_t mark);
+typedef void (*mark_set_inserter_t)(struct mark_set **s, struct object_id *oid, uintmax_t mark);
 typedef void (*each_mark_fn_t)(uintmax_t mark, void *obj, void *cbp);
 
 /* Configured limits on output */
@@ -534,13 +534,15 @@ static char *pool_strdup(const char *s)
 	return r;
 }
 
-static void insert_mark(struct mark_set *s, uintmax_t idnum, struct object_entry *oe)
+static void insert_mark(struct mark_set **sp, uintmax_t idnum, struct object_entry *oe)
 {
+	struct mark_set *s = *sp;
+
 	while ((idnum >> s->shift) >= 1024) {
 		s = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
-		s->shift = marks->shift + 10;
-		s->data.sets[0] = marks;
-		marks = s;
+		s->shift = (*sp)->shift + 10;
+		s->data.sets[0] = (*sp);
+		(*sp) = s;
 	}
 	while (s->shift) {
 		uintmax_t i = idnum >> s->shift;
@@ -958,7 +960,7 @@ static int store_object(
 
 	e = insert_object(&oid);
 	if (mark)
-		insert_mark(marks, mark, e);
+		insert_mark(&marks, mark, e);
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
@@ -1156,7 +1158,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	e = insert_object(&oid);
 
 	if (mark)
-		insert_mark(marks, mark, e);
+		insert_mark(&marks, mark, e);
 
 	if (e->idx.offset) {
 		duplicate_count_by_type[OBJ_BLOB]++;
@@ -1731,7 +1733,7 @@ static void dump_marks(void)
 	}
 }
 
-static void insert_object_entry(struct mark_set *s, struct object_id *oid, uintmax_t mark)
+static void insert_object_entry(struct mark_set **s, struct object_id *oid, uintmax_t mark)
 {
 	struct object_entry *e;
 	e = find_object(oid);
@@ -1748,12 +1750,12 @@ static void insert_object_entry(struct mark_set *s, struct object_id *oid, uintm
 	insert_mark(s, mark, e);
 }
 
-static void insert_oid_entry(struct mark_set *s, struct object_id *oid, uintmax_t mark)
+static void insert_oid_entry(struct mark_set **s, struct object_id *oid, uintmax_t mark)
 {
 	insert_mark(s, mark, xmemdupz(oid, sizeof(*oid)));
 }
 
-static void read_mark_file(struct mark_set *s, FILE *f, mark_set_inserter_t inserter)
+static void read_mark_file(struct mark_set **s, FILE *f, mark_set_inserter_t inserter)
 {
 	char line[512];
 	while (fgets(line, sizeof(line), f)) {
@@ -1786,7 +1788,7 @@ static void read_marks(void)
 		goto done; /* Marks file does not exist */
 	else
 		die_errno("cannot read '%s'", import_marks_file);
-	read_mark_file(marks, f, insert_object_entry);
+	read_mark_file(&marks, f, insert_object_entry);
 	fclose(f);
 done:
 	import_marks_file_done = 1;
@@ -3242,7 +3244,7 @@ static void parse_alias(void)
 		die(_("Expected 'to' command, got %s"), command_buf.buf);
 	e = find_object(&b.oid);
 	assert(e);
-	insert_mark(marks, next_mark, e);
+	insert_mark(&marks, next_mark, e);
 }
 
 static char* make_fast_import_path(const char *path)
@@ -3340,7 +3342,7 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	fp = fopen(f, "r");
 	if (!fp)
 		die_errno("cannot read '%s'", f);
-	read_mark_file(ms, fp, insert_oid_entry);
+	read_mark_file(&ms, fp, insert_oid_entry);
 	fclose(fp);
 }
 
