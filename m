From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] git: expand user path in --git-dir
Date: Mon, 24 Sep 2012 14:57:20 +0200
Message-ID: <fdeaa78c0a520ce80e6d2cb09978dab348104eaf.1348491039.git.git@drmicha.warpmail.net>
References: <5060588D.3080202@drmicha.warpmail.net>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 14:57:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG8E8-0003qP-NT
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 14:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab2IXM5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 08:57:23 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32984 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753127Ab2IXM5W (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 08:57:22 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4BA35204F3;
	Mon, 24 Sep 2012 08:57:22 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 24 Sep 2012 08:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=XJVgs5/aU4KCx8mFTsiWtle7r
	ps=; b=UjQ9hiX6UNvsTS8vxf90QaLPfesQYaOPeVsFyio3VpB63V3orbTOFuVfK
	ZuV16rNWGrGcA8dL2n+y2A5agDXbdQRcoEM7yJC7WQ3XX9YRP/Zo/EpX5aokEwyg
	sOXQG9y8PgOlod+j/jXMYzUmLVJk3CH50GX49iOHr9TbJAKC70=
X-Sasl-enc: kOCJSyiWfkW8p/uy8YKthCJnCyb+skGmYsQY+ALbfqlx 1348491441
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E31FC4827C4;
	Mon, 24 Sep 2012 08:57:21 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.580.gb9ed689
In-Reply-To: <5060588D.3080202@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206265>

Currently, all paths in the config file are subject to tilde expansion
for user paths while the argument to --git-dir is not expanded, and
neither are paths in the environment such as GIT_DIR. From the user
perspective, though, the two commands

GIT_DIR=~user/foo git command
git --git-dir=~user/foo command

currently behave differently because in the first case the shell would
perform tilde expansion, but not in the second. Also, one may argue that
specifying '--git-dir=' is like specifying a config variable (which
cannot exist for this purpose).

Thus, make arguments to '--git-dir' undergo tilde expansion.
---
So, here's a simple patch implementing tilde expansion for --git-dir. It passes
all tests. It's done doing the expansion on the setting side.

Alternatively, one might do it on the getting side, i.e. when reading GIT_DIR,
so that paths passed directly through the environment undergo tilde expansion
as well. We don't do this for any environment variable yet, so I didn't go
that far.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 8788b32..35e8011 100644
--- a/git.c
+++ b/git.c
@@ -64,6 +64,22 @@ static void commit_pager_choice(void) {
 	}
 }
 
+static int expand_path_setenv(const char *name, const char *value, int overwrite)
+{
+	int ret;
+	const char *expanded;
+
+	if (!value)
+		return setenv(name, value, overwrite);
+
+	expanded = expand_user_path(value);
+	if (!expanded)
+		die("Failed to expand user dir in: '%s'", value);
+	ret = setenv(name, expanded, overwrite);
+	free((void *)expanded);
+	return ret;
+}
+
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	const char **orig_argv = *argv;
@@ -117,13 +133,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				fprintf(stderr, "No directory given for --git-dir.\n" );
 				usage(git_usage_string);
 			}
-			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
+			expand_path_setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
 			if (envchanged)
 				*envchanged = 1;
 			(*argv)++;
 			(*argc)--;
 		} else if (!prefixcmp(cmd, "--git-dir=")) {
-			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
+			expand_path_setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--namespace")) {
-- 
1.7.12.1.580.gb9ed689
