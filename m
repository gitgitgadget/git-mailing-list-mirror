From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 1/5] Change git_connect() to return a struct child_process instead of a pid_t.
Date: Sun, 30 Sep 2007 22:09:57 +0200
Message-ID: <1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 30 22:10:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic57o-0002lG-71
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 22:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbXI3UKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 16:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbXI3UKO
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 16:10:14 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:36898 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbXI3UKF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 16:10:05 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id B36D69721C;
	Sun, 30 Sep 2007 22:10:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59558>

This prepares the API of git_connect() and finish_connect() to operate on
a struct child_process. Currently, we just use that object as a placeholder
for the pid that we used to return. A follow-up patch will change the
implementation of git_connect() and finish_connect() to make full use
of the object.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-archive.c    |    8 +++-----
 builtin-fetch-pack.c |    8 +++-----
 cache.h              |    4 ++--
 connect.c            |   28 +++++++++++++++-------------
 peek-remote.c        |    8 +++-----
 send-pack.c          |    8 +++-----
 transport.c          |    9 ++-------
 7 files changed, 31 insertions(+), 42 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 04385de..76db6cf 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -30,7 +30,7 @@ static int run_remote_archiver(const char *remote, int argc,
 {
 	char *url, buf[LARGE_PACKET_MAX];
 	int fd[2], i, len, rv;
-	pid_t pid;
+	struct child_process *chld;
 	const char *exec = "git-upload-archive";
 	int exec_at = 0;
 
@@ -46,9 +46,7 @@ static int run_remote_archiver(const char *remote, int argc,
 	}
 
 	url = xstrdup(remote);
-	pid = git_connect(fd, url, exec, 0);
-	if (pid < 0)
-		return pid;
+	chld = git_connect(fd, url, exec, 0);
 
 	for (i = 1; i < argc; i++) {
 		if (i == exec_at)
@@ -76,7 +74,7 @@ static int run_remote_archiver(const char *remote, int argc,
 	rv = recv_sideband("archive", fd[0], 1, 2);
 	close(fd[0]);
 	close(fd[1]);
-	rv |= finish_connect(pid);
+	rv |= finish_connect(chld);
 
 	return !!rv;
 }
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 8f25d50..19c144d 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -762,7 +762,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 {
 	int i, ret;
 	int fd[2];
-	pid_t pid;
+	struct child_process *chld;
 	struct ref *ref;
 	struct stat st;
 
@@ -773,16 +773,14 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 			st.st_mtime = 0;
 	}
 
-	pid = git_connect(fd, (char *)dest, uploadpack,
+	chld = git_connect(fd, (char *)dest, uploadpack,
                           args.verbose ? CONNECT_VERBOSE : 0);
-	if (pid < 0)
-		return NULL;
 	if (heads && nr_heads)
 		nr_heads = remove_duplicates(nr_heads, heads);
 	ref = do_fetch_pack(fd, nr_heads, heads, pack_lockfile);
 	close(fd[0]);
 	close(fd[1]);
-	ret = finish_connect(pid);
+	ret = finish_connect(chld);
 
 	if (!ret && nr_heads) {
 		/* If the heads to pull were given, we should have
diff --git a/cache.h b/cache.h
index 27485d3..32ce8a7 100644
--- a/cache.h
+++ b/cache.h
@@ -503,8 +503,8 @@ struct ref {
 #define REF_TAGS	(1u << 2)
 
 #define CONNECT_VERBOSE       (1u << 0)
-extern pid_t git_connect(int fd[2], char *url, const char *prog, int flags);
-extern int finish_connect(pid_t pid);
+extern struct child_process *git_connect(int fd[2], char *url, const char *prog, int flags);
+extern int finish_connect(struct child_process *chld);
 extern int path_match(const char *path, int nr, char **match);
 extern int get_ack(int fd, unsigned char *result_sha1);
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags);
diff --git a/connect.c b/connect.c
index 3d5c4ab..f6dcab9 100644
--- a/connect.c
+++ b/connect.c
@@ -468,21 +468,22 @@ char *get_port(char *host)
 }
 
 /*
- * This returns 0 if the transport protocol does not need fork(2),
+ * This returns NULL if the transport protocol does not need fork(2),
  * or a process id if it does.  Once done, finish the connection
  * with finish_connect() with the value returned from this function
- * (it is safe to call finish_connect() with 0 to support the former
+ * (it is safe to call finish_connect() with NULL to support the former
  * case).
  *
- * Does not return a negative value on error; it just dies.
+ * If it returns, the connect is successful; it just dies on errors.
  */
-pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
+struct child_process *git_connect(int fd[2], char *url,
+				  const char *prog, int flags)
 {
 	char *host, *path = url;
 	char *end;
 	int c;
 	int pipefd[2][2];
-	pid_t pid;
+	struct child_process *chld;
 	enum protocol protocol = PROTO_LOCAL;
 	int free_path = 0;
 	char *port = NULL;
@@ -568,15 +569,16 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 		free(target_host);
 		if (free_path)
 			free(path);
-		return 0;
+		return NULL;
 	}
 
 	if (pipe(pipefd[0]) < 0 || pipe(pipefd[1]) < 0)
 		die("unable to create pipe pair for communication");
-	pid = fork();
-	if (pid < 0)
+	chld = xcalloc(1, sizeof(*chld));
+	chld->pid = fork();
+	if (chld->pid < 0)
 		die("unable to fork");
-	if (!pid) {
+	if (!chld->pid) {
 		struct strbuf cmd;
 
 		strbuf_init(&cmd, MAX_CMD_LEN);
@@ -625,15 +627,15 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 	close(pipefd[1][0]);
 	if (free_path)
 		free(path);
-	return pid;
+	return chld;
 }
 
-int finish_connect(pid_t pid)
+int finish_connect(struct child_process *chld)
 {
-	if (pid == 0)
+	if (chld == NULL)
 		return 0;
 
-	while (waitpid(pid, NULL, 0) < 0) {
+	while (waitpid(chld->pid, NULL, 0) < 0) {
 		if (errno != EINTR)
 			return -1;
 	}
diff --git a/peek-remote.c b/peek-remote.c
index ceb7871..59cc8eb 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
 	int i, ret;
 	char *dest = NULL;
 	int fd[2];
-	pid_t pid;
+	struct child_process *chld;
 	int nongit = 0;
 	unsigned flags = 0;
 
@@ -64,12 +64,10 @@ int main(int argc, char **argv)
 	if (!dest || i != argc - 1)
 		usage(peek_remote_usage);
 
-	pid = git_connect(fd, dest, uploadpack, 0);
-	if (pid < 0)
-		return 1;
+	chld = git_connect(fd, dest, uploadpack, 0);
 	ret = peek_remote(fd, flags);
 	close(fd[0]);
 	close(fd[1]);
-	ret |= finish_connect(pid);
+	ret |= finish_connect(chld);
 	return !!ret;
 }
diff --git a/send-pack.c b/send-pack.c
index 4533d1b..e9257fd 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -362,7 +362,7 @@ int main(int argc, char **argv)
 	char *dest = NULL;
 	char **heads = NULL;
 	int fd[2], ret;
-	pid_t pid;
+	struct child_process *chld;
 	char *remote_name = NULL;
 	struct remote *remote = NULL;
 
@@ -426,12 +426,10 @@ int main(int argc, char **argv)
 		}
 	}
 
-	pid = git_connect(fd, dest, receivepack, verbose ? CONNECT_VERBOSE : 0);
-	if (pid < 0)
-		return 1;
+	chld = git_connect(fd, dest, receivepack, verbose ? CONNECT_VERBOSE : 0);
 	ret = send_pack(fd[0], fd[1], remote, nr_heads, heads);
 	close(fd[0]);
 	close(fd[1]);
-	ret |= finish_connect(pid);
+	ret |= finish_connect(chld);
 	return !!ret;
 }
diff --git a/transport.c b/transport.c
index 3475cca..54ed9bc 100644
--- a/transport.c
+++ b/transport.c
@@ -279,18 +279,13 @@ static struct ref *get_refs_via_connect(const struct transport *transport)
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
 	int fd[2];
-	pid_t pid;
 	char *dest = xstrdup(transport->url);
-
-	pid = git_connect(fd, dest, data->uploadpack, 0);
-
-	if (pid < 0)
-		die("Failed to connect to \"%s\"", transport->url);
+	struct child_process *chld = git_connect(fd, dest, data->uploadpack, 0);
 
 	get_remote_heads(fd[0], &refs, 0, NULL, 0);
 	packet_flush(fd[1]);
 
-	finish_connect(pid);
+	finish_connect(chld);
 
 	free(dest);
 
-- 
1.5.3.3.1134.gee562
