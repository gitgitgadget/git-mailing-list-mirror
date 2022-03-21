Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7619C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiCUHgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344963AbiCUHfu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2635517A8B
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so13649826pjp.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNUGGInsboEmmZD6stgtnlSrPjoKjE8Hw9/tjipXSeA=;
        b=ICGEP1fRI9dZY+yv+HrEeqXJczo84nZiiz/LqKnjdXhc/ITMbqyJnQX3U879zi4xED
         QoqnXDmwF3RkSzQQBKV4biCI2Dv5UnGA8crcCn9El1xVlGUyf+pnW8SDntsEghcPC1Km
         TZuZ5EBFyEFeUtbcasKoK6UmFXgx6YoLK+3ZDYP3e+X8weRWnu8A8ZwBZ4YeOv13zI0S
         +ESiLRrvbmfL5I9iH9kDSXuplTZlDFKJfkBYTfwQwAwLfvywvs0z1JVZTizEsRKRgr6Q
         fTXBJhoccKOHFDeDF1jbXsIXpFjlM0Vo2YiRIZGLhoXq1Lz72uivCpXyB0Kk/7SyE6j9
         cAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNUGGInsboEmmZD6stgtnlSrPjoKjE8Hw9/tjipXSeA=;
        b=TkalnU/XoGcFZhCiybEaHOlRJUJZkHSMgOwpUHRb+nPNiSWVB3x2Ouu+mWtVQ7rbN9
         f6jqxO5wqn+5c6NAtRZ+gSipeRtRxPnGH51elz8TOgBrwPtlkTODi2bag3Lz1nzJxXK4
         EWdFKDxIsUCuoI2kxSQtUkgvVEXE4sSPW/hCB+o89rFjpgCYRzhk2va+eOB2bu+Av4Iu
         cxEfzJlT1rfmVVp8KUKK8xUvXimBsfrz2Uw55NP/9Mj4Bsy85x6NkeS9KMQ0bd1gCheU
         71IoxT2Nio3Wn8aaWvzhGvRJCCSd7dIgTq6dd7yumQ2VPN5EwhIubtAs+3432QU8NMUr
         dwzg==
X-Gm-Message-State: AOAM531QETQMG7Cra2Dq1c0IHguDbUkW26I9nhepq3PSc0HX89dYir2q
        nAuWopRPLjIp90TA7xVSedidmW+4KNwsmw==
X-Google-Smtp-Source: ABdhPJxULgz7IQ5ifl8gEUM3ZTAjFpHhMtH76FmcOfnzQaNehg9eUf377a40rrVX6AD/ZID5cG+FNQ==
X-Received: by 2002:a17:90b:1bc8:b0:1c7:443:3ffb with SMTP id oa8-20020a17090b1bc800b001c704433ffbmr5682375pjb.84.1647848065577;
        Mon, 21 Mar 2022 00:34:25 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.34.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:34:25 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 16/16] ls-tree: split up "fast path" callbacks
Date:   Mon, 21 Mar 2022 15:33:30 +0800
Message-Id: <010e3c0eceac0a936a447a6df7ba8c9abb7c77b2.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Make the various if/else in the callbacks for the "fast path" a lot
easier to read by just using common functions for the parts that are
common, and have per-format callbacks for those parts that are
different.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 198 +++++++++++++++++++++++++++++-----------------
 1 file changed, 124 insertions(+), 74 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 3e756b5eee..52ae71efaa 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -173,108 +173,157 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 	return recurse;
 }
 
-static int show_default(struct show_tree_data *data)
+static int show_tree_common(struct show_tree_data *data, int *recurse,
+			    const struct object_id *oid, struct strbuf *base,
+			    const char *pathname, unsigned mode)
 {
-	size_t baselen = data->base->len;
-
-	if (cmdmode == MODE_LONG) {
-		char size_text[24];
-		if (data->type == OBJ_BLOB) {
-			unsigned long size;
-			if (oid_object_info(the_repository, data->oid, &size) == OBJ_BAD)
-				xsnprintf(size_text, sizeof(size_text), "BAD");
-			else
-				xsnprintf(size_text, sizeof(size_text),
-					  "%" PRIuMAX, (uintmax_t)size);
-		} else {
-			xsnprintf(size_text, sizeof(size_text), "-");
-		}
-		printf("%06o %s %s %7s\t", data->mode, type_name(data->type),
-		find_unique_abbrev(data->oid, abbrev), size_text);
-	} else {
-		printf("%06o %s %s\t", data->mode, type_name(data->type),
-		find_unique_abbrev(data->oid, abbrev));
-	}
-	baselen = data->base->len;
-	strbuf_addstr(data->base, data->pathname);
-	write_name_quoted_relative(data->base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
-				   line_termination);
-	strbuf_setlen(data->base, baselen);
-	return 1;
-}
-
-static int show_tree(const struct object_id *oid, struct strbuf *base,
-		const char *pathname, unsigned mode, void *context)
-{
-	int recurse = 0;
-	size_t baselen;
 	enum object_type type = object_type(mode);
-	struct show_tree_data data = {
-		.mode = mode,
-		.type = type,
-		.oid = oid,
-		.pathname = pathname,
-		.base = base,
-	};
+	int ret = -1;
+
+	*recurse = 0;
+	data->mode = mode;
+	data->type = type;
+	data->oid = oid;
+	data->pathname = pathname;
+	data->base = base;
 
 	if (type == OBJ_BLOB) {
 		if (ls_options & LS_TREE_ONLY)
-			return 0;
+			ret = 0;
 	} else if (type == OBJ_TREE &&
 		   show_recursive(base->buf, base->len, pathname)) {
-		recurse = READ_TREE_RECURSIVE;
+		*recurse = READ_TREE_RECURSIVE;
 		if (!(ls_options & LS_SHOW_TREES))
-			return recurse;
+			ret = *recurse;
 	}
 
-	if (cmdmode == MODE_OBJECT_ONLY) {
-		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
-		return recurse;
-	}
+	return ret;
+}
 
-	if (cmdmode == MODE_NAME_ONLY) {
-		baselen = base->len;
-		strbuf_addstr(base, pathname);
-		write_name_quoted_relative(base->buf,
-					   chomp_prefix ? ls_tree_prefix : NULL,
-					   stdout, line_termination);
-		strbuf_setlen(base, baselen);
-		return recurse;
+static void show_tree_common_default_long(struct strbuf *base,
+					  const char *pathname,
+					  const size_t baselen)
+{
+	strbuf_addstr(base, pathname);
+	write_name_quoted_relative(base->buf,
+				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
+				   line_termination);
+	strbuf_setlen(base, baselen);
+}
+
+static int show_tree_default(const struct object_id *oid, struct strbuf *base,
+			     const char *pathname, unsigned mode,
+			     void *context)
+{
+	int early;
+	int recurse;
+	struct show_tree_data data = { 0 };
+
+	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	if (early >= 0)
+		return early;
+
+	printf("%06o %s %s\t", data.mode, type_name(data.type),
+	       find_unique_abbrev(data.oid, abbrev));
+	show_tree_common_default_long(base, pathname, data.base->len);
+	return recurse;
+}
+
+static int show_tree_long(const struct object_id *oid, struct strbuf *base,
+			  const char *pathname, unsigned mode, void *context)
+{
+	int early;
+	int recurse;
+	struct show_tree_data data = { 0 };
+	char size_text[24];
+
+	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	if (early >= 0)
+		return early;
+
+	if (data.type == OBJ_BLOB) {
+		unsigned long size;
+		if (oid_object_info(the_repository, data.oid, &size) == OBJ_BAD)
+			xsnprintf(size_text, sizeof(size_text), "BAD");
+		else
+			xsnprintf(size_text, sizeof(size_text),
+				  "%" PRIuMAX, (uintmax_t)size);
+	} else {
+		xsnprintf(size_text, sizeof(size_text), "-");
 	}
 
-	if (cmdmode == MODE_LONG ||
-	    (!ls_options || (ls_options & LS_RECURSIVE)
-	     || (ls_options & LS_SHOW_TREES)
-	     || (ls_options & LS_TREE_ONLY)))
-		show_default(&data);
+	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
+	       find_unique_abbrev(data.oid, abbrev), size_text);
+	show_tree_common_default_long(base, pathname, data.base->len);
+	return 1;
+}
 
+static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
+			       const char *pathname, unsigned mode, void *context)
+{
+	int early;
+	int recurse;
+	const size_t baselen = base->len;
+	struct show_tree_data data = { 0 };
+
+	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	if (early >= 0)
+		return early;
+
+	strbuf_addstr(base, pathname);
+	write_name_quoted_relative(base->buf,
+				   chomp_prefix ? ls_tree_prefix : NULL,
+				   stdout, line_termination);
+	strbuf_setlen(base, baselen);
+	return recurse;
+}
+
+static int show_tree_object(const struct object_id *oid, struct strbuf *base,
+			    const char *pathname, unsigned mode, void *context)
+{
+	int early;
+	int recurse;
+	struct show_tree_data data = { 0 };
+
+	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
+	if (early >= 0)
+		return early;
+
+	printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
 	return recurse;
 }
 
 struct ls_tree_cmdmode_to_fmt {
 	enum ls_tree_cmdmode mode;
 	const char *const fmt;
+	read_tree_fn_t fn;
 };
 
 static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
 	{
 		.mode = MODE_DEFAULT,
 		.fmt = "%(objectmode) %(objecttype) %(objectname)%x09%(path)",
+		.fn = show_tree_default,
 	},
 	{
 		.mode = MODE_LONG,
 		.fmt = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)",
+		.fn = show_tree_long,
 	},
 	{
 		.mode = MODE_NAME_ONLY, /* And MODE_NAME_STATUS */
 		.fmt = "%(path)",
+		.fn = show_tree_name_only,
 	},
 	{
 		.mode = MODE_OBJECT_ONLY,
 		.fmt = "%(objectname)",
+		.fn = show_tree_object
+	},
+	{
+		/* fallback */
+		.fn = show_tree_default,
 	},
-	{ 0 },
 };
 
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
@@ -283,7 +332,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	struct tree *tree;
 	int i, full_tree = 0;
 	unsigned int shown_fields = 0;
-	read_tree_fn_t fn = show_tree;
+	read_tree_fn_t fn = NULL;
 	const struct option ls_tree_options[] = {
 		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
@@ -312,6 +361,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
+	struct ls_tree_cmdmode_to_fmt *m2f = ls_tree_cmdmode_format;
 
 	git_config(git_default_config, NULL);
 	ls_tree_prefix = prefix;
@@ -367,18 +417,18 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	 * The generic show_tree_fmt() is slower than show_tree(), so
 	 * take the fast path if possible.
 	 */
-	if (format) {
-		struct ls_tree_cmdmode_to_fmt *m2f;
-
-		fn = show_tree_fmt;
-		for (m2f = ls_tree_cmdmode_format; m2f->fmt; m2f++) {
-			if (strcmp(format, m2f->fmt))
-				continue;
-
+	while (m2f++) {
+		if (!m2f->fmt) {
+			fn = format ? show_tree_fmt : show_tree_default;
+		} else if (format && !strcmp(format, m2f->fmt)) {
 			cmdmode = m2f->mode;
-			fn = show_tree;
-			break;
+			fn = m2f->fn;
+		} else if (!format && cmdmode == m2f->mode) {
+			fn = m2f->fn;
+		} else {
+			continue;
 		}
+		break;
 	}
 
 	return !!read_tree(the_repository, tree, &pathspec, fn, &shown_fields);
-- 
2.34.1.406.g2e0e55130e

