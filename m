From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] built-in tar-tree and remote tar-tree
Date: Thu, 18 May 2006 20:03:34 -0700
Message-ID: <7vodxulnqx.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060518192144.15912.qmail@web25913.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 19 05:03:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgvHB-0003hm-9H
	for gcvg-git@gmane.org; Fri, 19 May 2006 05:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWESDDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 23:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWESDDg
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 23:03:36 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26105 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932182AbWESDDg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 23:03:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060519030335.WQXX9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 23:03:35 -0400
To: git@vger.kernel.org
In-Reply-To: Junio C. Hamano's message of "(unknown date)"
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20318>

This makes tar-tree a built-in.  As an added bonus, you can now
say:

	git tar-tree --remote=remote-repository <ent> [<base>]

This does not work with git-daemon yet, but should work with
localhost and git over ssh transports.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * It comes up every once in a while that somebody says he wants
   a shallow clone, but when asked "what for?" it turns out that
   what is wanted is the ability to download a tarball for a
   specific revision for building that version, so here is one.

   If people think this is a useful thing, we would need to
   teach git-daemon about git-upload-tar, and perhaps we would
   also want to compress the tar image while it goes over the
   wire, which would be more work.

 Makefile                         |    8 +++--
 tar-tree.c => builtin-tar-tree.c |   62 +++++++++++++++++++++++++++++++++++-
 builtin-upload-tar.c             |   66 ++++++++++++++++++++++++++++++++++++++
 builtin.h                        |    2 +
 git.c                            |    2 +
 5 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 2149fb8..caf1e70 100644
--- a/Makefile
+++ b/Makefile
@@ -161,7 +161,7 @@ PROGRAMS = \
 	git-receive-pack$X git-rev-parse$X \
 	git-send-pack$X git-show-branch$X git-shell$X \
 	git-show-index$X git-ssh-fetch$X \
-	git-ssh-upload$X git-tar-tree$X git-unpack-file$X \
+	git-ssh-upload$X git-unpack-file$X \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X \
@@ -170,7 +170,8 @@ PROGRAMS = \
 
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
-	git-grep$X git-rev-list$X git-check-ref-format$X
+	git-grep$X git-rev-list$X git-check-ref-format$X \
+	git-tar-tree$X git-upload-tar$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -218,7 +219,8 @@ LIB_OBJS = \
 
 BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
-	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o
+	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
+	builtin-tar-tree.o builtin-upload-tar.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/tar-tree.c b/builtin-tar-tree.c
similarity index 86%
rename from tar-tree.c
rename to builtin-tar-tree.c
index 3308736..e97e0af 100644
--- a/tar-tree.c
+++ b/builtin-tar-tree.c
@@ -7,11 +7,14 @@ #include "tree-walk.h"
 #include "commit.h"
 #include "strbuf.h"
 #include "tar.h"
+#include "builtin.h"
+#include "pkt-line.h"
 
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
 
-static const char tar_tree_usage[] = "git-tar-tree <key> [basedir]";
+static const char tar_tree_usage[] =
+"git-tar-tree [--remote=<repo>] <ent> [basedir]";
 
 static char block[BLOCKSIZE];
 static unsigned long offset;
@@ -301,7 +304,7 @@ static void traverse_tree(struct tree_de
 	}
 }
 
-int main(int argc, char **argv)
+int generate_tar(int argc, const char **argv)
 {
 	unsigned char sha1[20], tree_sha1[20];
 	struct commit *commit;
@@ -348,3 +351,58 @@ int main(int argc, char **argv)
 	free(current_path.buf);
 	return 0;
 }
+
+static const char *exec = "git-upload-tar";
+
+static int remote_tar(int argc, const char **argv)
+{
+	int fd[2], ret, len;
+	pid_t pid;
+	char buf[1024];
+	char *url;
+
+	if (argc < 3 || 4 < argc)
+		usage(tar_tree_usage);
+
+	/* --remote=<repo> */
+	url = strdup(argv[1]+9);
+	pid = git_connect(fd, url, exec);
+	if (pid < 0)
+		return 1;
+
+	packet_write(fd[1], "want %s\n", argv[2]);
+	if (argv[3])
+		packet_write(fd[1], "base %s\n", argv[3]);
+	packet_flush(fd[1]);
+
+	len = packet_read_line(fd[0], buf, sizeof(buf));
+	if (!len)
+		die("git-tar-tree: expected ACK/NAK, got EOF");
+	if (buf[len-1] == '\n')
+		buf[--len] = 0;
+	if (strcmp(buf, "ACK")) {
+		if (5 < len && !strncmp(buf, "NACK ", 5))
+			die("git-tar-tree: NACK %s", buf + 5);
+		die("git-tar-tree: protocol error");
+	}
+	/* expect a flush */
+	len = packet_read_line(fd[0], buf, sizeof(buf));
+	if (len)
+		die("git-tar-tree: expected a flush");
+
+	/* Now, start reading from fd[0] and spit it out to stdout */
+	ret = copy_fd(fd[0], 1);
+	close(fd[0]);
+
+	ret |= finish_connect(pid);
+	return !!ret;
+}
+
+int cmd_tar_tree(int argc, const char **argv, char **envp)
+{
+	if (argc < 2)
+		usage(tar_tree_usage);
+	if (!strncmp("--remote=", argv[1], 9))
+		return remote_tar(argc, argv);
+	return generate_tar(argc, argv);
+}
diff --git a/builtin-upload-tar.c b/builtin-upload-tar.c
new file mode 100644
index 0000000..883b5aa
--- /dev/null
+++ b/builtin-upload-tar.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (c) 2006 Junio C Hamano
+ */
+#include "cache.h"
+#include "pkt-line.h"
+#include "exec_cmd.h"
+#include "builtin.h"
+
+static const char upload_tar_usage[] = "git-upload-tar <repo>";
+
+static int nack(const char *reason)
+{
+	packet_write(1, "NACK %s\n", reason);
+	packet_flush(1);
+	return 1;
+}
+
+int cmd_upload_tar(int argc, const char **argv, char **envp)
+{
+	int len;
+	char *dir = argv[1];
+	char buf[8129];
+	unsigned char sha1[20];
+	char *base = NULL;
+	char hex[41];
+	int ac;
+	const char *av[4];
+
+	if (argc != 2)
+		usage(upload_tar_usage);
+	if (!enter_repo(dir, 0))
+		return nak("not a git archive", dir);
+	len = packet_read_line(0, buf, sizeof(buf));
+	if (len < 5 || strncmp("want ", buf, 5))
+		return nak("expected want");
+	if (buf[len-1] == '\n')
+		buf[--len] = 0;
+	if (get_sha1(buf + 5, sha1))
+		return nak("expected sha1");
+        strcpy(hex, sha1_to_hex(sha1));
+
+	len = packet_read_line(0, buf, sizeof(buf));
+	if (len) {
+		if (len < 5 || strncmp("base ", buf, 5))
+			return nak("expected (optional) base");
+		if (buf[len-1] == '\n')
+			buf[--len] = 0;
+		base = strdup(buf + 5);
+		len = packet_read_line(0, buf, sizeof(buf));
+	}
+	if (len)
+		return nak("expected flush");
+
+	packet_write(1, "ACK\n");
+	packet_flush(1);
+
+	ac = 0;
+	av[ac++] = "tar-tree";
+	av[ac++] = hex;
+	if (base)
+		av[ac++] = base;
+	av[ac++] = NULL;
+	execv_git_cmd(av);
+	/* should it return that is an error */
+	return 1;
+}
diff --git a/builtin.h b/builtin.h
index ff559de..3ed5d65 100644
--- a/builtin.h
+++ b/builtin.h
@@ -26,5 +26,7 @@ extern int cmd_push(int argc, const char
 extern int cmd_grep(int argc, const char **argv, char **envp);
 extern int cmd_rev_list(int argc, const char **argv, char **envp);
 extern int cmd_check_ref_format(int argc, const char **argv, char **envp);
+extern int cmd_tar_tree(int argc, const char **argv, char **envp);
+extern int cmd_upload_tar(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index d0650bb..79d81b1 100644
--- a/git.c
+++ b/git.c
@@ -50,6 +50,8 @@ static void handle_internal_command(int 
 		{ "count-objects", cmd_count_objects },
 		{ "diff", cmd_diff },
 		{ "grep", cmd_grep },
+		{ "tar-tree", cmd_tar_tree },
+		{ "upload-tar", cmd_upload_tar },
 		{ "rev-list", cmd_rev_list },
 		{ "check-ref-format", cmd_check_ref_format }
 	};
-- 
1.3.3.gfad60
