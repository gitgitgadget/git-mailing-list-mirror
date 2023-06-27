Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3343EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjF0QUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjF0QTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:19:31 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869B83A8F
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:19:26 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B7F7C5B41F;
        Tue, 27 Jun 2023 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687882752;
        bh=NpeqmC3RKqSRtGreRdj5ZxBa84gc/g1K8DiTYURD0mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kCwg2I3go6K2oajifBoCXCELsh54YeMI/KIE/Y8JCpuN4SZxK3yiJOVFS4QsQxDV4
         kmg20ixf6e0y/O/PRYTkRfuXQ8bsPyC0AIutghVdKlRSVHBVVLf1lu9lPg3ubPD+87
         4upwPpMSyPGQ/YCFAAFsShh9dbVKJSfhXEA4q8kxkOzAy3ZSbnlKPR+9d9oN7BRzwd
         DShDJ5qwK/x6OzyXPz+nXWTIX8wNzp/6LDpKWoWVf/hfi6VB5Dm2K5tvf/yXw7g9Yr
         Wg1vScUA5Rey3JDP/OTaWbO3BTmH0nB2gCWPbaqSLF0Fe/kbgTvgH6kbs0Srb1wB0r
         iH41228y8gz9AEluRS/gV4fLe3MKGHunLaRSKVnD/qwKjkOlEshJcVyS0RlB0xtHXI
         OR3fHp0FgfKMt6KcMWlOlN0KpNK6QNF9NQh62jbK/nS1epk5IXSECJvy5NcszX9vHg
         oQl/vsxXDPmj5vsRnonVIXNroFDEhsLNBECslKLGB+4GHkmlkNt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 5/8] var: adjust memory allocation for strings
Date:   Tue, 27 Jun 2023 16:18:59 +0000
Message-ID: <20230627161902.754472-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230627161902.754472-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230627161902.754472-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

Right now, all of our values are constants whose allocation is managed
elsewhere.  However, in the future, we'll have some variables whose
memory we will need to free.  To keep things consistent, let's make each
of our functions allocate its own memory and make the caller responsible
for freeing it.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 builtin/var.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index 379564a399..d6f9f495c9 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -12,47 +12,57 @@
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
-static const char *editor(int ident_flag UNUSED)
+static char *committer(int ident_flag)
 {
-	return git_editor();
+	return xstrdup_or_null(git_committer_info(ident_flag));
 }
 
-static const char *sequence_editor(int ident_flag UNUSED)
+static char *author(int ident_flag)
 {
-	return git_sequence_editor();
+	return xstrdup_or_null(git_author_info(ident_flag));
 }
 
-static const char *pager(int ident_flag UNUSED)
+static char *editor(int ident_flag UNUSED)
+{
+	return xstrdup_or_null(git_editor());
+}
+
+static char *sequence_editor(int ident_flag UNUSED)
+{
+	return xstrdup_or_null(git_sequence_editor());
+}
+
+static char *pager(int ident_flag UNUSED)
 {
 	const char *pgm = git_pager(1);
 
 	if (!pgm)
 		pgm = "cat";
-	return pgm;
+	return xstrdup(pgm);
 }
 
-static const char *default_branch(int ident_flag UNUSED)
+static char *default_branch(int ident_flag UNUSED)
 {
-	return git_default_branch_name(1);
+	return xstrdup_or_null(git_default_branch_name(1));
 }
 
-static const char *shell_path(int ident_flag UNUSED)
+static char *shell_path(int ident_flag UNUSED)
 {
-	return SHELL_PATH;
+	return xstrdup(SHELL_PATH);
 }
 
 struct git_var {
 	const char *name;
-	const char *(*read)(int);
+	char *(*read)(int);
 };
 static struct git_var git_vars[] = {
 	{
 		.name = "GIT_COMMITTER_IDENT",
-		.read = git_committer_info,
+		.read = committer,
 	},
 	{
 		.name = "GIT_AUTHOR_IDENT",
-		.read = git_author_info,
+		.read = author,
 	},
 	{
 		.name = "GIT_EDITOR",
@@ -83,11 +93,13 @@ static struct git_var git_vars[] = {
 static void list_vars(void)
 {
 	struct git_var *ptr;
-	const char *val;
+	char *val;
 
 	for (ptr = git_vars; ptr->read; ptr++)
-		if ((val = ptr->read(0)))
+		if ((val = ptr->read(0))) {
 			printf("%s=%s\n", ptr->name, val);
+			free(val);
+		}
 }
 
 static const struct git_var *get_git_var(const char *var)
@@ -113,7 +125,7 @@ static int show_config(const char *var, const char *value, void *cb)
 int cmd_var(int argc, const char **argv, const char *prefix UNUSED)
 {
 	const struct git_var *git_var;
-	const char *val;
+	char *val;
 
 	if (argc != 2)
 		usage(var_usage);
@@ -134,6 +146,7 @@ int cmd_var(int argc, const char **argv, const char *prefix UNUSED)
 		return 1;
 
 	printf("%s\n", val);
+	free(val);
 
 	return 0;
 }
