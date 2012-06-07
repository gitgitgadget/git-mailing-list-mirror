From: Javier.Roucher-Iglesias@ensimag.imag.fr
Subject: [PATCH/RFC] credentials helpers+remote helpers
Date: Thu,  7 Jun 2012 16:35:43 +0200
Message-ID: <1339079743-31068-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Cc: Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 16:36:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scdoe-0002ll-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 16:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760902Ab2FGOf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 10:35:57 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:61720 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab2FGOfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 10:35:55 -0400
Received: by wibhj8 with SMTP id hj8so302319wib.1
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=HvAFNnefdqT9RgHjDNaGUV7y4kq+jpVaT/h7XzkVNNA=;
        b=cjLhWgoIEqH14qon0YuyK9OEB+ECKfon1tK23M7KRo3ZvGfUasayha+v1qRdcuj1TB
         HGFRQ3FntJvUDb88F8rhU9VNj07ef/wtKnlel/75bZOeq1Bt02sXJASZ54G35CsXtxzn
         WrcHu5+DToD8DdxQV0m8ObfBelTD1rvek5d8I/Sh9rfvaLGIrrfKWcw1xpEoNcYnADVE
         M6xOBOXHrOy0o3tiHN/NYU2iimXoF/q4owT9B5eync2ar23CXvpylltIIzL3WmIpqgq9
         jDO0Lem5q7UW0FOMvcDwKrWQlDkoSvocA046yplgT6wzGkHHUx+ZqTolgE65hTAOVsIM
         EWcw==
Received: by 10.216.206.159 with SMTP id l31mr1812294weo.2.1339079752179;
        Thu, 07 Jun 2012 07:35:52 -0700 (PDT)
Received: from SuperNova.grenet.fr (etu-189-10.vpn-inp.grenoble-inp.fr. [147.171.189.10])
        by mx.google.com with ESMTPS id et10sm1434080wib.2.2012.06.07.07.35.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 07:35:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc0.5.ge0c9cc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199410>

From: Javier Roucher <jroucher@gmail.com>


Add "git credential" plumbing command

The credential API is in C, and not available to scripting languages.
Expose the functionalities of the API by wrapping them into a new
plumbing command "git credentials".

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 .gitignore                       |  1 +
 Documentation/git-credential.txt | 70 ++++++++++++++++++++++++++++++++++++++++
 Makefile                         |  1 +
 builtin.h                        |  1 +
 builtin/credential.c             | 40 +++++++++++++++++++++++
 git.c                            |  1 +
 6 files changed, 114 insertions(+)
 create mode 100644 Documentation/git-credential.txt
 create mode 100644 builtin/credential.c

diff --git a/.gitignore b/.gitignore
index bf66648..7d1d86e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -31,6 +31,7 @@
 /git-commit-tree
 /git-config
 /git-count-objects
+/git-credential
 /git-credential-cache
 /git-credential-cache--daemon
 /git-credential-store
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
new file mode 100644
index 0000000..a6e1d0a
--- /dev/null
+++ b/Documentation/git-credential.txt
@@ -0,0 +1,70 @@
+git-credential(7)
+=================
+
+NAME
+----
+git-credential - Providing and storing user credentials to git
+
+SYNOPSIS
+--------
+------------------
+git credential [fill|approve|reject]
+
+------------------
+
+DESCRIPTION
+-----------
+
+Git-credential permits to save username, password, host, path and protocol.
+When you invoke git-credential, you can ask for a password, using the command
+'git credential fill'.
+Providing them by STDIN: 
+
+		username=admin\n 
+		protocol=[http|https]\n
+		host=localhost\n
+		path=/dir\n\n
+
+-If git-credential system, have the password already stored
+git-credential will answer by STDOUT:
+	
+		username=admin\n
+		password=*****\n
+
+-If it is not stored, git-credential will ask you to enter 
+the password:
+		
+		> Password for '[http|https]admin@localhost':
+
+Then if password is correct, you can store using command
+'git crendential approve' providing the structure, by STDIN.
+
+		username=admin\n 
+		password=*****\n
+		protocol=[http|https]\n
+		host=localhost\n
+		path=/dir\n\n
+
+If the password is refused, you can delete using command
+'git credential reject' providing the same structure.
+
+
+REQUESTING CREDENTIALS
+----------------------
+
+1. The 'git credential fill' makes the structure:
+		username=foo
+		password=****
+		protocol=[http|https]
+		localhost=url
+		path=/direction
+
+   with this structure it will be able to save your
+   credentials, and if the credential is allready stored,
+   it will fill the password.
+
+2. Then 'git credential approve' to store them.
+
+3. Otherwise, if the credential is not correct you can do
+  'git credential reject' to delete the credential.
+-------------------------------------------
diff --git a/Makefile b/Makefile
index 4592f1f..3f53da8 100644
--- a/Makefile
+++ b/Makefile
@@ -827,6 +827,7 @@ BUILTIN_OBJS += builtin/commit-tree.o
 BUILTIN_OBJS += builtin/commit.o
 BUILTIN_OBJS += builtin/config.o
 BUILTIN_OBJS += builtin/count-objects.o
+BUILTIN_OBJS += builtin/credential.o
 BUILTIN_OBJS += builtin/describe.o
 BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
diff --git a/builtin.h b/builtin.h
index 338f540..48feddc 100644
--- a/builtin.h
+++ b/builtin.h
@@ -66,6 +66,7 @@ extern int cmd_commit(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_credential(int argc, const char **argv, const char *prefix);
 extern int cmd_describe(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
diff --git a/builtin/credential.c b/builtin/credential.c
new file mode 100644
index 0000000..89f976b
--- /dev/null
+++ b/builtin/credential.c
@@ -0,0 +1,40 @@
+#include <stdio.h>
+#include "cache.h"
+#include "credential.h"
+#include "string-list.h"
+
+static const char usage_msg[] =
+"credential <fill|approve|reject> [helper...]";
+
+void cmd_credential (int argc, char **argv, const char *prefix){
+	const char *op;
+	struct credential c = CREDENTIAL_INIT;
+	int i;
+
+	op = argv[1];
+	if (!op)
+		usage(usage_msg);
+
+	for (i = 2; i < argc; i++)
+		string_list_append(&c.helpers, argv[i]);
+
+	if (credential_read(&c, stdin) < 0)
+		die("unable to read credential from stdin");
+
+	if (!strcmp(op, "fill")) {
+		credential_fill(&c);
+		if (c.username)
+			printf("username=%s\n", c.username);
+		if (c.password)
+			printf("password=%s\n", c.password);
+	}
+	else if (!strcmp(op, "approve")) {
+		credential_approve(&c);
+	}
+	else if (!strcmp(op, "reject")) {
+		credential_reject(&c);
+	}
+	else
+		usage(usage_msg);
+}
+
diff --git a/git.c b/git.c
index d232de9..211f01f 100644
--- a/git.c
+++ b/git.c
@@ -353,6 +353,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
+		{ "credential", cmd_credential, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
 		{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
-- 
1.7.11.rc0.5.ge0c9cc0.dirty
