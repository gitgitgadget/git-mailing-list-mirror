From: Javier.Roucher-Iglesias@ensimag.imag.fr
Subject: [PATCH_v1] add 'git credential' plumbing command
Date: Sat,  9 Jun 2012 20:45:02 +0200
Message-ID: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Cc: Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 20:45:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdQf0-0008QO-T9
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 20:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab2FISpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jun 2012 14:45:12 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42645 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386Ab2FISpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2012 14:45:10 -0400
Received: by wgbdr13 with SMTP id dr13so1877177wgb.1
        for <git@vger.kernel.org>; Sat, 09 Jun 2012 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=HQIiwsqaCVQRES+H8SzeCssp4lsoCQNgyRYijWMrxPo=;
        b=Qoh2uMUtWT5OlaEQcSgRV4+5EtApa3YzDPKCHYLwxLMpHqezJTrnrzfSGk/UzaS8Ze
         IQ/+VPJkvAOLjFdfpzzkJZHlv6oJRWXcdNd2z5lZzQLhbRmV2zUN3nGc6Q/Q+RtwQAo1
         M9HsZuQHRsho+d5NNrtOoXx+Epkoqsc7azaZBBOsKbXQmrekLrckoI3k+0Stb2s/Pp+J
         Z+tSlNRJhdxqnyCTh9Z/DLzSD4ZMw7ozitEbhDrbyWvXKcw9Q4+DB4K1v1eev4tvhqsT
         uJ3568Lba7Wxg3Cz8dewZ6/BD/E45d6quEZ5TipPFt3t3DPFULR6nxOBqvOLr52OyQKo
         m6Mw==
Received: by 10.216.220.81 with SMTP id n59mr3589225wep.220.1339267509068;
        Sat, 09 Jun 2012 11:45:09 -0700 (PDT)
Received: from SuperNova.grenet.fr (etu-189-107.vpn-inp.grenoble-inp.fr. [147.171.189.107])
        by mx.google.com with ESMTPS id fm1sm11136253wib.10.2012.06.09.11.45.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Jun 2012 11:45:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc2.9.ge2c5c96.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199552>

From: Javier Roucher <jroucher@gmail.com>


The credential API is in C, and not available to scripting languages.
Expose the functionalities of the API by wrapping them into a new
plumbing command "git credentials".

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

---
 .gitignore                       |  1 +
 Documentation/git-credential.txt | 74 ++++++++++++++++++++++++++++++++++++++++
 Makefile                         |  1 +
 builtin.h                        |  1 +
 builtin/credential.c             | 40 ++++++++++++++++++++++
 git.c                            |  1 +
 6 files changed, 118 insertions(+)
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
index 0000000..ead23b5
--- /dev/null
+++ b/Documentation/git-credential.txt
@@ -0,0 +1,74 @@
+git-credential(7)
+=================
+
+NAME
+----
+git-credential - Providing and strore user credentials to git
+
+SYNOPSIS
+--------
+------------------
+git credential <fill|approve|reject>
+
+------------------
+
+DESCRIPTION
+-----------
+
+Git-credential permits to the user of the script to save:
+username, password, host, path and protocol. When the user of script
+invoke git-credential, the script can ask for a password, using the command
+'git credential fill'.
+Taking data from the standard input, the program treats each line as a
+separate data item, and the end of series of data item is signalled by a 
+blank line.
+
+		username=admin\n 
+		protocol=[http|https]\n
+		host=localhost\n
+		path=/dir\n\n
+
+-If git-credential system have the password already stored
+git-credential will answer with by STDOUT:
+	
+		username=admin
+		password=*****
+
+-If it is not stored, the user will be prompt for a password:
+		
+		> Password for '[http|https]admin@localhost':
+
+
+Then if the password is correct, (note: is not git credential
+how decides if password is correct or not. Is the external system
+that have to authenticate the user) it can be stored using command 
+'git crendential approve' by providing the structure, by STDIN.
+
+		username=admin
+		password=*****
+		protocol=[http|https]
+		host=localhost
+		path=/dir
+
+If the password is refused, it can be deleted using command
+'git credential reject' by providing the same structure.
+
+
+REQUESTING CREDENTIALS
+----------------------
+
+1. The 'git credential fill' makes the structure,
+with this structure it will be able to save your
+credentials, and if the credential is allready stored,
+it will fill the password.
+
+		username=foo
+		password=****
+		protocol=[http|https]
+		localhost=url
+		path=/direction
+
+2. Then 'git credential approve' to store them.
+
+3. Otherwise, if the credential is not correct you can do
+  'git credential reject' to delete the credential.
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
index 0000000..9f00885
--- /dev/null
+++ b/builtin/credential.c
@@ -0,0 +1,40 @@
+#include <stdio.h>
+#include "cache.h"
+#include "credential.h"
+#include "string-list.h"
+
+static const char usage_msg[] =
+"credential <fill|approve|reject>";
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
index d232de9..7cbd7d8 100644
--- a/git.c
+++ b/git.c
@@ -353,6 +353,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
+		{ "credential", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
 		{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
-- 
1.7.11.rc2.9.ge2c5c96.dirty
