Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FF3EB64DD
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 19:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFZTBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjFZTA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 15:00:56 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A439D10D5
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 12:00:52 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 7E52F5B41C;
        Mon, 26 Jun 2023 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687806051;
        bh=c5LF6Yav/E/4nlZL6pGdaHUA04MoIi59swlSjaCKaUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=m4BXCLiiyg16//+2uQyUl2jDsJKne2/dE4j75h+6cibwhPMl7wd29GVe80jDzAJdy
         m/AxdpkNlcGgA8M6kFvd7SMUyUO+rRqOvl3eK29lP+XsecKTGJP5JhG4ms3EPHgBan
         Xe1stpdxMLZfnBrtdbfpgW0SI04TWT5Cj5W7VpycMApYCy4Kij6306UIrtehJlpBDO
         gYRKk+XRsbFjFK8rCEauz7MO7iUg9yC+qw48a7wtdDpkKhqzka+bRjxUO903lit877
         ofOedNFcq+5ELRVbGMmGZErFtk5SSTJ0JaXRDYonpiatoxxidi4BVfdV4GCOmw0v5d
         0in6X1JssgELpyUJHfG5VqaFAudZZ1cZSeJwQL8LUxMttaqzZecKJHMmNLhFUF9IG8
         p0GJPFGGHwJVr4Ea0EsbJKzmtYi65aTc1rGw8jCBhLKireL8nWpET1M/4irActa6yK
         qvpQpMdW2kFvMqyhR2kiy1/mnZWLImK98g3FhiMfVAMu7QX/WwW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 4/7] var: adjust memory allocation for strings
Date:   Mon, 26 Jun 2023 19:00:05 +0000
Message-ID: <20230626190008.644769-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230626190008.644769-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230626190008.644769-1-sandals@crustytoothpaste.net>
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
index bd2750b1bf..ce6a2231ca 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -12,47 +12,57 @@
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
-static const char *editor(int flag)
+static char *committer(int flag)
 {
-	return git_editor();
+	return xstrdup_or_null(git_committer_info(flag));
 }
 
-static const char *sequence_editor(int flag)
+static char *author(int flag)
 {
-	return git_sequence_editor();
+	return xstrdup_or_null(git_author_info(flag));
 }
 
-static const char *pager(int flag)
+static char *editor(int flag)
+{
+	return xstrdup_or_null(git_editor());
+}
+
+static char *sequence_editor(int flag)
+{
+	return xstrdup_or_null(git_sequence_editor());
+}
+
+static char *pager(int flag)
 {
 	const char *pgm = git_pager(1);
 
 	if (!pgm)
 		pgm = "cat";
-	return pgm;
+	return xstrdup(pgm);
 }
 
-static const char *default_branch(int flag)
+static char *default_branch(int flag)
 {
-	return git_default_branch_name(1);
+	return xstrdup_or_null(git_default_branch_name(1));
 }
 
-static const char *shell_path(int flag)
+static char *shell_path(int flag)
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
