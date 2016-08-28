Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4A21F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756157AbcH1X2O (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:14 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41006 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756166AbcH1X2E (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1F5BA280AD;
        Sun, 28 Aug 2016 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426883;
        bh=v4EVAhgOCdctnfLHnwV8AAXIqXbSG9mLfqUjXICAiXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4og/uMU7UCcOT81lBo80zurgu2g46bRue+HG+MdZzuKBiWZ/4cFzyPfrbn4qRfUH
         4LQphPzwYFdEk2qv+pbQIzgH4THDRWbGfZyw6wqicuTrsAAqEK6ER2zp9SJOHrF49k
         Z3TcjtGAkAGTxuWEK/4kpT5XdAmZfpqUo90+DqliQnXYdjCHT8k+qEK3AAtG2lyaQ+
         SzmWXeSs4Tw2A9g+I6cXqDCG1lw65G94j+hSccY1EHf671z14diQPa5VjaWxux8PA5
         1p42YMODj8W5bMAP2prObi1+ARVzJNI+4VWIMxxz/8TPGlbrP1idlLo8td7bRFpQ5P
         yBlDAuC2wHvqFGvD8bw0Is314hrqA0264vZSQyP8yqc74z8uExGTDxsjSZn3syTj2B
         MTVQ7vepL9RMJ2s030VIdyXZFPMXJXyUzPvMMejKdQUfVKHUAdlpxpy7AfNrrEWcAD
         2rysyAYfM2PinNO4TBZ9Zame/aG+NwcYlwAbcYWKQmBPggC6GbD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 07/20] builtin: convert textconv_object to use struct object_id
Date:   Sun, 28 Aug 2016 23:27:44 +0000
Message-Id: <20160828232757.373278-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since all of its callers have been updated, make textconv_object take a
struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin.h          |  2 +-
 builtin/blame.c    | 12 ++++++------
 builtin/cat-file.c |  2 +-
 builtin/log.c      |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin.h b/builtin.h
index 6b95006a..b9122bc5 100644
--- a/builtin.h
+++ b/builtin.h
@@ -25,7 +25,7 @@ struct fmt_merge_msg_opts {
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 struct fmt_merge_msg_opts *);
 
-extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, int sha1_valid, char **buf, unsigned long *buf_size);
+extern int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, unsigned long *buf_size);
 
 extern int is_builtin(const char *s);
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 3852d189..527b66a4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -154,8 +154,8 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
  */
 int textconv_object(const char *path,
 		    unsigned mode,
-		    const unsigned char *sha1,
-		    int sha1_valid,
+		    const struct object_id *oid,
+		    int oid_valid,
 		    char **buf,
 		    unsigned long *buf_size)
 {
@@ -163,7 +163,7 @@ int textconv_object(const char *path,
 	struct userdiff_driver *textconv;
 
 	df = alloc_filespec(path);
-	fill_filespec(df, sha1, sha1_valid, mode);
+	fill_filespec(df, oid->hash, oid_valid, mode);
 	textconv = get_textconv(df);
 	if (!textconv) {
 		free_filespec(df);
@@ -188,7 +188,7 @@ static void fill_origin_blob(struct diff_options *opt,
 
 		num_read_blob++;
 		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
-		    textconv_object(o->path, o->mode, o->blob_oid.hash, 1, &file->ptr, &file_size))
+		    textconv_object(o->path, o->mode, &o->blob_oid, 1, &file->ptr, &file_size))
 			;
 		else
 			file->ptr = read_sha1_file(o->blob_oid.hash, &type,
@@ -2365,7 +2365,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
-			    textconv_object(read_from, mode, null_sha1, 0, &buf_ptr, &buf_len))
+			    textconv_object(read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
 				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
 				die_errno("cannot open or read '%s'", read_from);
@@ -2792,7 +2792,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			die("no such path %s in %s", path, final_commit_name);
 
 		if (DIFF_OPT_TST(&sb.revs->diffopt, ALLOW_TEXTCONV) &&
-		    textconv_object(path, o->mode, o->blob_oid.hash, 1, (char **) &sb.final_buf,
+		    textconv_object(path, o->mode, &o->blob_oid, 1, (char **) &sb.final_buf,
 				    &sb.final_buf_size))
 			;
 		else
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8b773787..7b2e0537 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -66,7 +66,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			die("git cat-file --textconv %s: <object> must be <sha1:path>",
 			    obj_name);
 
-		if (textconv_object(obj_context.path, obj_context.mode, oid.hash, 1, &buf, &size))
+		if (textconv_object(obj_context.path, obj_context.mode, &oid, 1, &buf, &size))
 			break;
 
 	case 'p':
diff --git a/builtin/log.c b/builtin/log.c
index 226212c9..48b9db51 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -479,7 +479,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	if (get_sha1_with_context(obj_name, 0, oidc.hash, &obj_context))
 		die(_("Not a valid object name %s"), obj_name);
 	if (!obj_context.path[0] ||
-	    !textconv_object(obj_context.path, obj_context.mode, oidc.hash, 1, &buf, &size))
+	    !textconv_object(obj_context.path, obj_context.mode, &oidc, 1, &buf, &size))
 		return stream_blob_to_fd(1, oid->hash, NULL, 0);
 
 	if (!buf)
