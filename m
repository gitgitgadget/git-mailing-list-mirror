From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 01/14] Change git_connect() to return a struct child_process instead of a pid_t.
Date: Sat, 13 Oct 2007 22:06:11 +0200
Message-ID: <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 13 22:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnG0-0008MX-70
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174AbXJMUGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754591AbXJMUGc
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:06:32 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52568 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbXJMUG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:06:27 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 5501D13A5FA;
	Sat, 13 Oct 2007 22:06:25 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60760>

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
 builtin-archive.c    |    8 +++-----
 builtin-fetch-pack.c |    8 +++-----
 cache.h              |    4 ++--
 connect.c            |   31 +++++++++++++++++--------------
 peek-remote.c        |    8 +++-----
 send-pack.c          |    8 +++-----
 transport.c          |    9 ++-------
 7 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index a90c65c..346444b 100644
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
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 8f25d50..f56592f 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -762,7 +762,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 {
 	int i, ret;
 	int fd[2];
-	pid_t pid;
+	struct child_process *conn;
 	struct ref *ref;
 	struct stat st;
 
@@ -773,16 +773,14 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 			st.st_mtime = 0;
 	}
 
-	pid = git_connect(fd, (char *)dest, uploadpack,
+	conn = git_connect(fd, (char *)dest, uploadpack,
                           args.verbose ? CONNECT_VERBOSE : 0);
-	if (pid < 0)
-		return NULL;
 	if (heads && nr_heads)
 		nr_heads = remove_duplicates(nr_heads, heads);
 	ref = do_fetch_pack(fd, nr_heads, heads, pack_lockfile);
 	close(fd[0]);
 	close(fd[1]);
-	ret = finish_connect(pid);
+	ret = finish_connect(conn);
 
 	if (!ret && nr_heads) {
 		/* If the heads to pull were given, we should have
diff --git a/cache.h b/cache.h
index 16bdbb2..c428f87 100644
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
index aee78ff..b156f92 100644
--- a/connect.c
+++ b/connect.c
@@ -470,21 +470,22 @@ char *get_port(char *host)
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
@@ -570,15 +571,16 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
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
 		char command[MAX_CMD_LEN];
 		char *posn = command;
 		int size = MAX_CMD_LEN;
@@ -630,17 +632,18 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
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
index 4533d1b..b562953 100644
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
diff --git a/transport.c b/transport.c
index 3475cca..5d723b0 100644
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
+	struct child_process *conn = git_connect(fd, dest, data->uploadpack, 0);
 
 	get_remote_heads(fd[0], &refs, 0, NULL, 0);
 	packet_flush(fd[1]);
 
-	finish_connect(pid);
+	finish_connect(conn);
 
 	free(dest);
 
-- 
1.5.3.3.1134.gee562
