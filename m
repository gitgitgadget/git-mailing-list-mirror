From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Built-in git-get-tar-commit-id (was: [PATCH/RFC] Retire SIMPLE_*** stuff.)
Date: Sat, 10 Jun 2006 16:13:41 +0200
Message-ID: <20060610141341.GA5787@lsrfire.ath.cx>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com> <7virnam435.fsf@assigned-by-dhcp.cox.net> <7v3bedn8ym.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 16:13:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp4Dh-000803-CS
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 16:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWFJONn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 10:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWFJONm
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 10:13:42 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:50896
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1030365AbWFJONm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 10:13:42 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 7EFBA12296; Sat, 10 Jun 2006 16:13:41 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bedn8ym.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21606>

By being an internal command git-get-commit-id can make use of
struct ustar_header and other stuff and stops wasting precious
disk space.

Note: I recycled one of the two "tar-tree" entries instead of
splitting that cleanup into a separate patch.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/Makefile b/Makefile
index 5226fa1..2a1e639 100644
--- a/Makefile
+++ b/Makefile
@@ -142,11 +142,11 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  git-cherry-pick git-status
 
 # The ones that do not have to link with lcrypto, lz nor xdiff.
 SIMPLE_PROGRAMS = \
-	git-get-tar-commit-id$X git-mailsplit$X \
+	git-mailsplit$X \
 	git-stripspace$X git-daemon$X
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
 	git-checkout-index$X git-clone-pack$X \
@@ -167,11 +167,11 @@ PROGRAMS = \
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
 	git-grep$X git-add$X git-rm$X git-rev-list$X \
 	git-check-ref-format$X git-rev-parse$X \
 	git-init-db$X git-tar-tree$X git-upload-tar$X git-format-patch$X \
-	git-ls-files$X git-ls-tree$X \
+	git-ls-files$X git-ls-tree$X git-get-tar-commit-id$X \
 	git-read-tree$X git-commit-tree$X \
 	git-apply$X git-show-branch$X git-diff-files$X \
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 7663b9b..58a8ccd 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -400,5 +400,30 @@ int cmd_tar_tree(int argc, const char **
 		usage(tar_tree_usage);
 	if (!strncmp("--remote=", argv[1], 9))
 		return remote_tar(argc, argv);
 	return generate_tar(argc, argv, envp);
 }
+
+/* ustar header + extended global header content */
+#define HEADERSIZE (2 * RECORDSIZE)
+
+int cmd_get_tar_commit_id(int argc, const char **argv, char **envp)
+{
+	char buffer[HEADERSIZE];
+	struct ustar_header *header = (struct ustar_header *)buffer;
+	char *content = buffer + RECORDSIZE;
+	ssize_t n;
+
+	n = xread(0, buffer, HEADERSIZE);
+	if (n < HEADERSIZE)
+		die("git-get-tar-commit-id: read error");
+	if (header->typeflag[0] != 'g')
+		return 1;
+	if (memcmp(content, "52 comment=", 11))
+		return 1;
+
+	n = xwrite(1, content + 11, 41);
+	if (n < 41)
+		die("git-get-tar-commit-id: write error");
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index ffa9340..b9f36be 100644
--- a/builtin.h
+++ b/builtin.h
@@ -30,10 +30,11 @@ extern int cmd_add(int argc, const char 
 extern int cmd_rev_list(int argc, const char **argv, char **envp);
 extern int cmd_check_ref_format(int argc, const char **argv, char **envp);
 extern int cmd_init_db(int argc, const char **argv, char **envp);
 extern int cmd_tar_tree(int argc, const char **argv, char **envp);
 extern int cmd_upload_tar(int argc, const char **argv, char **envp);
+extern int cmd_get_tar_commit_id(int argc, const char **argv, char **envp);
 extern int cmd_ls_files(int argc, const char **argv, char **envp);
 extern int cmd_ls_tree(int argc, const char **argv, char **envp);
 extern int cmd_read_tree(int argc, const char **argv, char **envp);
 extern int cmd_commit_tree(int argc, const char **argv, char **envp);
 extern int cmd_apply(int argc, const char **argv, char **envp);
diff --git a/get-tar-commit-id.c b/get-tar-commit-id.c
deleted file mode 100644
index 4166290..0000000
--- a/get-tar-commit-id.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2005 Rene Scharfe
- */
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-
-#define HEADERSIZE	1024
-
-int main(int argc, char **argv)
-{
-	char buffer[HEADERSIZE];
-	ssize_t n;
-
-	n = read(0, buffer, HEADERSIZE);
-	if (n < HEADERSIZE) {
-		fprintf(stderr, "read error\n");
-		return 3;
-	}
-	if (buffer[156] != 'g')
-		return 1;
-	if (memcmp(&buffer[512], "52 comment=", 11))
-		return 1;
-	n = write(1, &buffer[523], 41);
-	if (n < 41) {
-		fprintf(stderr, "write error\n");
-		return 2;
-	}
-	return 0;
-}
diff --git a/git.c b/git.c
index 6db8f2b..9469d44 100644
--- a/git.c
+++ b/git.c
@@ -161,11 +161,11 @@ static void handle_internal_command(int 
 		{ "grep", cmd_grep },
 		{ "rm", cmd_rm },
 		{ "add", cmd_add },
 		{ "rev-list", cmd_rev_list },
 		{ "init-db", cmd_init_db },
-		{ "tar-tree", cmd_tar_tree },
+		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "upload-tar", cmd_upload_tar },
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "ls-files", cmd_ls_files },
 		{ "ls-tree", cmd_ls_tree },
 		{ "tar-tree", cmd_tar_tree },
