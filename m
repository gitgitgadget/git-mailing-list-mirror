From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 01/14] Change git_connect() to return a struct child_process instead of a pid_t.
Date: Fri, 19 Oct 2007 21:47:53 +0200
Message-ID: <1192823286-9654-2-git-send-email-johannes.sixt@telecom.at>
References: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 21:49:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iixqd-0002t3-0N
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 21:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973AbXJSTsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbXJSTsS
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 15:48:18 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:44481 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758208AbXJSTsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 15:48:09 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 072F097BD4;
	Fri, 19 Oct 2007 21:48:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.315.g2ce38
In-Reply-To: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61755>

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
index 27485d3..bfffa05 100644
--- a/cache.h
+++ b/cache.h
@@ -503,8 +503,8 @@ struct ref {
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
index 3d5c4ab..e66e171 100644
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
index 7b77624..147f44b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -365,7 +365,7 @@ int main(int argc, char **argv)
 	char *dest = NULL;
 	char **heads = NULL;
 	int fd[2], ret;
-	pid_t pid;
+	struct child_process *conn;
 	char *remote_name = NULL;
 	struct remote *remote = NULL;
 
@@ -433,12 +433,10 @@ int main(int argc, char **argv)
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
index 400af71..5132d28 100644
--- a/transport.c
+++ b/transport.c
@@ -601,18 +601,13 @@ static struct ref *get_refs_via_connect(const struct transport *transport)
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
1.5.3.4.315.g2ce38
