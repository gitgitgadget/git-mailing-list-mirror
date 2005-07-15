From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 3/6] Add git-var a tool for reading interesting git
 variables.
Date: Thu, 14 Jul 2005 18:55:09 -0600
Message-ID: <m1k6jsyjki.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 02:55:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtEUL-0002Ry-Fb
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 02:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbVGOAz1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 20:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbVGOAz1
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 20:55:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14781 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263066AbVGOAzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 20:55:25 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F0t9js020799;
	Thu, 14 Jul 2005 18:55:09 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F0t93A020798;
	Thu, 14 Jul 2005 18:55:09 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Sharing code between shell scripts and C is a challenge.
The program git-var allows us to have a set of named values
that a shell script can interrogate and a normal C program
can simply call the functions that compute them.    Allowing
sharing when computing plain test values.

---

 Documentation/git-var.txt |   60 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/git.txt     |    3 ++
 Makefile                  |    3 +-
 var.c                     |   65 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-var.txt
 create mode 100644 var.c

2c929de1b5444fadda13becb6df3d852277e6e27
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-var.txt
@@ -0,0 +1,60 @@
+git-var(1)
+==================
+v0.1, July 2005
+
+NAME
+----
+git-var - Print the git users identity
+
+
+SYNOPSIS
+--------
+git-var [ -l | <variable> ]
+
+DESCRIPTION
+-----------
+Prints a git logical variable.
+
+-l causes the logical variables to be listed.
+
+EXAMPLE
+--------
+$git-var GIT_AUTHOR_IDENT
+
+Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
+
+
+VARIABLES
+----------
+GIT_AUTHOR_IDENT
+    The author of a piece of code.
+
+GIT_COMMITTER_IDENT
+    The person who put a piece of code into git.
+
+Diagnostics
+-----------
+You don't exist. Go away!::
+    The passwd(5) gecos field couldn't be read
+Your parents must have hated you!::
+    The password(5) gecos field is longer than a giant static buffer.
+Your sysadmin must have hate you!::
+    The password(5) name field is longer than a giant static buffer.
+
+See Also
+--------
+link:git-commit-tree.html[git-commit-tree]
+link:git-tag-script.html[git-tag-script]
+
+Author
+------
+Written by Eric Biederman <ebiederm@xmission.com>
+
+Documentation
+--------------
+Documentation by Eric Biederman and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -111,6 +111,9 @@ link:git-tar-tree.html[git-tar-tree]::
 link:git-unpack-file.html[git-unpack-file]::
 	Creates a temporary file with a blob's contents
 
+link:git-var.html[git-var]::
+	Displays a git logical variable
+
 link:git-verify-pack.html[git-verify-pack]::
 	Validates packed GIT archive files
 
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -48,7 +48,7 @@ PROG=   git-update-cache git-diff-files 
 	git-diff-stages git-rev-parse git-patch-id git-pack-objects \
 	git-unpack-objects git-verify-pack git-receive-pack git-send-pack \
 	git-prune-packed git-fetch-pack git-upload-pack git-clone-pack \
-	git-show-index git-daemon
+	git-show-index git-daemon git-var
 
 all: $(PROG)
 
@@ -148,6 +148,7 @@ git-receive-pack: receive-pack.c
 git-send-pack: send-pack.c
 git-prune-packed: prune-packed.c
 git-fetch-pack: fetch-pack.c
+git-var: var.c
 
 git-http-pull: LIBS += -lcurl
 git-rev-list: LIBS += -lssl
diff --git a/var.c b/var.c
new file mode 100644
--- /dev/null
+++ b/var.c
@@ -0,0 +1,65 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Eric Biederman, 2005
+ */
+#include "cache.h"
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+
+static char *var_usage = "git-var [-l | <variable>]";
+
+struct git_var {
+	const char *name;
+	char *(*read)(void);
+};
+static struct git_var git_vars[] = {
+	{ "GIT_COMMITTER_IDENT", git_committer_info },
+	{ "GIT_AUTHOR_IDENT",   git_author_info },
+	{ "", NULL },
+};
+
+static void list_vars(void)
+{
+	struct git_var *ptr;
+	for(ptr = git_vars; ptr->read; ptr++) {
+		printf("%s=%s\n", ptr->name, ptr->read());
+	}
+}
+
+static const char *read_var(const char *var)
+{
+	struct git_var *ptr;
+	const char *val;
+	val = NULL;
+	for(ptr = git_vars; ptr->read; ptr++) {
+		if (strcmp(var, ptr->name) == 0) {
+			val = ptr->read();
+			break;
+		}
+	}
+	return val;
+}
+
+int main(int argc, char **argv)
+{
+	const char *val;
+	if (argc != 2) {
+		usage(var_usage);
+	}
+	setup_ident();
+	val = NULL;
+
+	if (strcmp(argv[1], "-l") == 0) {
+		list_vars();
+		return 0;
+	}
+	val = read_var(argv[1]);
+	if (!val)
+		usage(var_usage);
+	
+	printf("%s\n", val);
+	
+	return 0;
+}
