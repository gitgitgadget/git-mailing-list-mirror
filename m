Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ABE220248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfBVQGC (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:06:02 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:35510
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726970AbfBVQFr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Feb 2019 11:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1550851545;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=YRWWylAc8B99LB3bksVdp5y3LQjYyIMVDE69r4rkBog=;
        b=SJAvTXcLxOgAYTiXIMBHZb6ZNqE1xi+1WqSd5OLZUGJeb5FMT9DqVDb08vu7kvTA
        QkkgTpTD6BAq+3QSdFV27S69Z2hZHuDPDTUXwpsEZXG4AI9epaOkDBJfTxY8ce5sUMe
        v0hf3mNTNK2tkdFjsCBXlltMScyFbDWBMfc84SUs=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016915f49a5f-d96e159b-149d-40f9-9789-d0859dc7e2e9-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC 11/20] cat-file: move filter_object to diff.c
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Feb 2019 16:05:45 +0000
X-SES-Outgoing: 2019.02.22-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move function filter_object to diff.c, like it is done with
function textconv_object.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 builtin/cat-file.c | 23 -----------------------
 diff.c             | 23 +++++++++++++++++++++++
 diff.h             |  4 ++++
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index cd9a4447c8da9..41f333b73d851 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
@@ -34,28 +33,6 @@ static int mark_query;
 static int skip_object_info;
 static const char *rest;
 
-static int filter_object(const char *path, unsigned mode,
-			 const struct object_id *oid,
-			 char **buf, unsigned long *size)
-{
-	enum object_type type;
-
-	*buf = read_object_file(oid, &type, size);
-	if (!*buf)
-		return error(_("cannot read object %s '%s'"),
-			     oid_to_hex(oid), path);
-	if ((type == OBJ_BLOB) && S_ISREG(mode)) {
-		struct strbuf strbuf = STRBUF_INIT;
-		if (convert_to_working_tree(&the_index, path, *buf, *size, &strbuf)) {
-			free(*buf);
-			*size = strbuf.len;
-			*buf = strbuf_detach(&strbuf, NULL);
-		}
-	}
-
-	return 0;
-}
-
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			int unknown_type)
 {
diff --git a/diff.c b/diff.c
index 5306c48652db5..fe7160c86755d 100644
--- a/diff.c
+++ b/diff.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
+#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "tempfile.h"
@@ -6524,6 +6525,28 @@ int textconv_object(struct repository *r,
 	return 1;
 }
 
+int filter_object(const char *path, unsigned mode,
+		  const struct object_id *oid,
+		  char **buf, unsigned long *size)
+{
+	enum object_type type;
+
+	*buf = read_object_file(oid, &type, size);
+	if (!*buf)
+		return error(_("cannot read object %s '%s'"),
+			     oid_to_hex(oid), path);
+	if ((type == OBJ_BLOB) && S_ISREG(mode)) {
+		struct strbuf strbuf = STRBUF_INIT;
+		if (convert_to_working_tree(&the_index, path, *buf, *size, &strbuf)) {
+			free(*buf);
+			*size = strbuf.len;
+			*buf = strbuf_detach(&strbuf, NULL);
+		}
+	}
+
+	return 0;
+}
+
 void setup_diff_pager(struct diff_options *opt)
 {
 	/*
diff --git a/diff.h b/diff.h
index b512d0477ac3a..c3709e611870a 100644
--- a/diff.h
+++ b/diff.h
@@ -476,6 +476,10 @@ int textconv_object(struct repository *repo,
 		    const struct object_id *oid, int oid_valid,
 		    char **buf, unsigned long *buf_size);
 
+int filter_object(const char *path, unsigned mode,
+		  const struct object_id *oid,
+		  char **buf, unsigned long *size);
+
 int parse_rename_score(const char **cp_p);
 
 long parse_algorithm_value(const char *value);

--
https://github.com/git/git/pull/568
