Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4F7C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 04:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiAFEcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 23:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiAFEcF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 23:32:05 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAB1C06118A
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 20:32:05 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v25so1546181pge.2
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 20:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89Uz1mkv+gPqWm/Mc69dIJDLJ4vI4UWr7PalD/8OJQs=;
        b=iMI5V3485XP4l1CvUovoF/6pydXRvL6+svnGNMDh8XYwLDFCsniRtoBIoWxVUlXo7z
         DhXKyAR5V1PlGMCNcT8DWKj4BcpfXqf3x498od084CSkyyVRNglcS4wWZuqAhE0OqgYu
         rkriMaiuPe+2NYSg2IA35glo3TjBa8vgGJFvfOr4xvKhQanKxKHMn4jiXlENt4qqLOKH
         QdbNlZ1ed+dmjX7nFKdqf6eDPKwwsyHqFnGOmgHYSdPN5AZ9IUP0yEwaE2+Z4Lqfxhw1
         AwLpYNzIOLNnBPl/bLdZyoXYd5x27IUQoKYHAWqSlJ3pPvnVZDAL0uOUQdrRWNQ0y8Iv
         PWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89Uz1mkv+gPqWm/Mc69dIJDLJ4vI4UWr7PalD/8OJQs=;
        b=jLSLHR4A+ZuHNT6ZfDe1LJaeI0N7aiqJf65vCl7isDzjt8XosFzfYyHt+koAXaNoi1
         q9OEH2QnYhWzFgH74P/FzLRP1cP1J5IN2d8U2/278JBHZOaXq9Vzrf6YTzTiYNYr7O+F
         fVC6I5iannJ1L4L3nrMdCPAu5E2NYDCQ0M7QAY6pa/G5Cpuj70KiQgDTdYIk8GzQ/DmK
         eTMU61dVtglnqFLEJw17cd4Svnxs3FRcUS3Mcpnv5BsdMWXV5JOpM5tK7hfcUazO2j4w
         HySYfjszQUyIikYdqBErKckcZI0BkL3ZX/acY1NVJqvHjU85uPTmk/nKwAG/ljCOylKJ
         OYsA==
X-Gm-Message-State: AOAM531MnujhMLrWLVjh0BEWXj76ArktR/OdmQ0qChcJ42FIsatiJ0Qn
        5DSGFEUnbyEb4jkiJ+IIzhY=
X-Google-Smtp-Source: ABdhPJyBoNzsHb/nDSq9uaJHbTQJg5PoJ/KWfwR5YvphF9kSgEYtQy1DuOcpmsZ1UXFL4RnfcNFhaw==
X-Received: by 2002:a63:44a:: with SMTP id 71mr49906381pge.453.1641443524960;
        Wed, 05 Jan 2022 20:32:04 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id 13sm636491pfm.161.2022.01.05.20.32.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jan 2022 20:32:04 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes.Schindelin@gmx.de, Teng Long <dyronetengb@gmail.com>
Subject: [PATCH v9 5/9] ls-tree: optimize naming and handling of "return" in show_tree()
Date:   Thu,  6 Jan 2022 12:31:28 +0800
Message-Id: <75503c41a7e2f3fdbb59ce3568853049b55a2d3b.1641440700.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1794.g2ae0a9cb82
In-Reply-To: <cover.1641440700.git.dyroneteng@gmail.com>
References: <cover.1641440700.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable which "show_tree()" return is named "retval", a name that's
a little hard to understand. This commit tries to make the variable
and the related codes more clear in the context.

The change is based on three steps. The first is to rename "retval" to
a more meaningful name.

The second is that there are different "return" cases in "show_tree",
some places use "return retval;", some just directly use "return 0;",
this maybe cause some confusion when reading these "returns". For this
, we change all the "return" cases to the new uniform name.

The last is there are some nested "if" judgments surround the "returns",
this even make the codes here a little hard to understand. So we put
some logic in individual methods, "init_type()" and "init_recursive()".

After the steps, let us look at "show_tree()" again. It has a uniform
return variable name now, and first we init the "type" by "mode", then
call "init_recursive" to init the value of "recursive" which means
whether to go on reading recusively into the "tree". The codes here
become a little bit clearer, so we do not need to take a look at
"read_tree_at()" in "tree.c" to make sure the context of the return
value.

Signed-off-by: Teng Long <dyronetengb@gmail.com>
---
 builtin/ls-tree.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index eecc7482d5..7383dddf8c 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -61,25 +61,35 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
+static void init_type(unsigned mode, enum object_type *type)
+{
+	if (S_ISGITLINK(mode))
+		*type = OBJ_COMMIT;
+	else if (S_ISDIR(mode))
+		*type = OBJ_TREE;
+}
+
+static void init_recursive(struct strbuf *base, const char *pathname,
+				int *recursive)
+{
+	if (show_recursive(base->buf, base->len, pathname))
+		*recursive = READ_TREE_RECURSIVE;
+}
+
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
-	int retval = 0;
+	int recursive = 0;
 	size_t baselen;
 	enum object_type type = OBJ_BLOB;
 
-	if (S_ISGITLINK(mode)) {
-		type = OBJ_COMMIT;
-	} else if (S_ISDIR(mode)) {
-		if (show_recursive(base->buf, base->len, pathname)) {
-			retval = READ_TREE_RECURSIVE;
-			if (!(ls_options & LS_SHOW_TREES))
-				return retval;
-		}
-		type = OBJ_TREE;
-	}
-	else if (ls_options & LS_TREE_ONLY)
-		return 0;
+	init_type(mode, &type);
+	init_recursive(base, pathname, &recursive);
+
+	if (type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
+		return recursive;
+	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
+		return !READ_TREE_RECURSIVE;
 
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
@@ -109,7 +119,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 				   chomp_prefix ? ls_tree_prefix : NULL,
 				   stdout, line_termination);
 	strbuf_setlen(base, baselen);
-	return retval;
+	return recursive;
 }
 
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
-- 
2.33.0.rc1.1794.g2ae0a9cb82

