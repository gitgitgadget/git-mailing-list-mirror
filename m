From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 1/5] Change git_connect() to return a struct child_process instead of a pid_t.
Date: Wed,  3 Oct 2007 22:09:36 +0200
Message-ID: <1191442180-15905-2-git-send-email-johannes.sixt@telecom.at>
References: <200709302340.17644.johannes.sixt@telecom.at>
 <1191442180-15905-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 03 22:09:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdAXb-0003Ig-Mi
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 22:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbXJCUJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 16:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbXJCUJr
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 16:09:47 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:33593 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbXJCUJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 16:09:42 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id A4A8B10ADA2;
	Wed,  3 Oct 2007 22:09:40 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1191442180-15905-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59874>

This prepares the API of git_connect() and finish_connect() to operate on
a struct child_process. Currently, we just use that object as a placeholder
for the pid that we used to return. A follow-up patch will change the
implementation of git_connect() and finish_connect() to make full use
of the object.

Old code had early-return-on-error checks at the calling sites of
git_connect(), but since git_connect() dies on errors anyway, these checks
were removed.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
	I don't replace the waitpid() in finish_connect() by
	finish_command() because (1) that's not the purpose of this patch
	and (2) there is no corresponding start_command(), yet.

	-- Hannes

 builtin-archive.c |    8 +++-----
 cache.h           |    4 ++--
 connect.c         |   31 +++++++++++++++++--------------
 fetch-pack.c      |    8 +++-----
 peek-remote.c     |    8 +++-----
 send-pack.c       |    8 +++-----
 6 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 04385de..76f8d3d 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -30,7 +30,7 @@ static int run_remote_archiver(const char *remote, int argc,
 {
 	char *url, buf[LARGE_PACKET_MAX];
 	int fd[2], i, len, rv;
-	pid_t pid;
+	struct child_process *conn;
 	const char *exec = "git-upload-archive";
 	int exec_at = 0;
 
@@ -46,9 +46,7 @@ static int run_remote_archiver(const char *remote, int argc,
 	}
 
 	url = xstrdup(remote);
-	pid = git_connect(fd, url, exec, 0);
-	if (pid < 0)
-		return pid;
+	conn = git_connect(fd, url, exec, 0);
 
 	for (i = 1; i < argc; i++) {
 		if (i == exec_at)
@@ -76,7 +74,7 @@ static int run_remote_archiver(const char *remote, int argc,
 	rv = recv_sideband("archive", fd[0], 1, 2);
 	close(fd[0]);
 	close(fd[1]);
-	rv |= finish_connect(pid);
+	rv |= finish_connect(conn);
 
 	return !!rv;
 }
diff --git a/cache.h b/cache.h
index e0abcd6..548fb52 100644
--- a/cache.h
+++ b/cache.h
@@ -502,8 +502,8 @@ struct ref {
 #define REF_TAGS	(1u << 2)
 
 #define CONNECT_VERBOSE       (1u << 0)
-extern pid_t git_connect(int fd[2], char *url, const char *prog, int flags);
-extern int finish_connect(pid_t pid);
+extern struct child_process *git_connect(int fd[2], char *url, const char *prog, int flags);
+extern int finish_connect(struct child_process *conn);
 extern int path_match(const char *path, int nr, char **match);
 extern int get_ack(int fd, unsigned char *result_sha1);
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags);
diff --git a/connect.c b/connect.c
index 06d279e..458a502 100644
--- a/connect.c
+++ b/connect.c
@@ -468,21 +468,22 @@ char *get_port(char *host)
 }
 
 /*
- * This returns 0 if the transport protocol does not need fork(2),
- * or a process id if it does.  Once done, finish the connection
+ * This returns NULL if the transport protocol does not need fork(2), or a
+ * struct child_process object if it does.  Once done, finish the connection
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
+	struct child_process *conn;
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
+	conn = xcalloc(1, sizeof(*conn));
+	conn->pid = fork();
+	if (conn->pid < 0)
 		die("unable to fork");
-	if (!pid) {
+	if (!conn->pid) {
 		struct strbuf cmd;
 
 		strbuf_init(&cmd, MAX_CMD_LEN);
@@ -625,17 +627,18 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 	close(pipefd[1][0]);
 	if (free_path)
 		free(path);
-	return pid;
+	return conn;
 }
 
-int finish_connect(pid_t pid)
+int finish_connect(struct child_process *conn)
 {
-	if (pid == 0)
+	if (conn == NULL)
 		return 0;
 
-	while (waitpid(pid, NULL, 0) < 0) {
+	while (waitpid(conn->pid, NULL, 0) < 0) {
 		if (errno != EINTR)
 			return -1;
 	}
+	free(conn);
 	return 0;
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index 9c81305..d06b5ec 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -668,7 +668,7 @@ int main(int argc, char **argv)
 	int i, ret, nr_heads;
 	char *dest = NULL, **heads;
 	int fd[2];
-	pid_t pid;
+	struct child_process *conn;
 	struct stat st;
 
 	setup_git_directory();
@@ -733,15 +733,13 @@ int main(int argc, char **argv)
 	}
 	if (!dest)
 		usage(fetch_pack_usage);
-	pid = git_connect(fd, dest, uploadpack, verbose ? CONNECT_VERBOSE : 0);
-	if (pid < 0)
-		return 1;
+	conn = git_connect(fd, dest, uploadpack, verbose ? CONNECT_VERBOSE : 0);
 	if (heads && nr_heads)
 		nr_heads = remove_duplicates(nr_heads, heads);
 	ret = fetch_pack(fd, nr_heads, heads);
 	close(fd[0]);
 	close(fd[1]);
-	ret |= finish_connect(pid);
+	ret |= finish_connect(conn);
 
 	if (!ret && nr_heads) {
 		/* If the heads to pull were given, we should have
diff --git a/peek-remote.c b/peek-remote.c
index ceb7871..8d20f7c 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
 	int i, ret;
 	char *dest = NULL;
 	int fd[2];
-	pid_t pid;
+	struct child_process *conn;
 	int nongit = 0;
 	unsigned flags = 0;
 
@@ -64,12 +64,10 @@ int main(int argc, char **argv)
 	if (!dest || i != argc - 1)
 		usage(peek_remote_usage);
 
-	pid = git_connect(fd, dest, uploadpack, 0);
-	if (pid < 0)
-		return 1;
+	conn = git_connect(fd, dest, uploadpack, 0);
 	ret = peek_remote(fd, flags);
 	close(fd[0]);
 	close(fd[1]);
-	ret |= finish_connect(pid);
+	ret |= finish_connect(conn);
 	return !!ret;
 }
diff --git a/send-pack.c b/send-pack.c
index f74e66a..f4c7bbf 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -362,7 +362,7 @@ int main(int argc, char **argv)
 	char *dest = NULL;
 	char **heads = NULL;
 	int fd[2], ret;
-	pid_t pid;
+	struct child_process *conn;
 	char *remote_name = NULL;
 	struct remote *remote = NULL;
 
@@ -426,12 +426,10 @@ int main(int argc, char **argv)
 		}
 	}
 
-	pid = git_connect(fd, dest, receivepack, verbose ? CONNECT_VERBOSE : 0);
-	if (pid < 0)
-		return 1;
+	conn = git_connect(fd, dest, receivepack, verbose ? CONNECT_VERBOSE : 0);
 	ret = send_pack(fd[0], fd[1], remote, nr_heads, heads);
 	close(fd[0]);
 	close(fd[1]);
-	ret |= finish_connect(pid);
+	ret |= finish_connect(conn);
 	return !!ret;
 }
-- 
1.5.3.3.1134.gee562
