From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 2/6] run-command: support custom fd-set in async
Date: Fri,  5 Feb 2010 12:57:38 -0800
Message-ID: <1265403462-20572-3-git-send-email-spearce@spearce.org>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org>
Cc: Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 22:04:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVLh-0007bW-F2
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929Ab0BEVED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:04:03 -0500
Received: from george.spearce.org ([209.20.77.23]:41733 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab0BEVDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:03:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 62885381FE;
	Fri,  5 Feb 2010 20:57:44 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc1.199.g9253ab
In-Reply-To: <1265403462-20572-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139089>

From: Erik Faye-Lund <kusmabite@gmail.com>

This patch adds the possibility to supply a set of non-0 file
descriptors for async process communication instead of the
default-created pipe.

Additionally, we now support bi-directional communiction with the
async procedure, by giving the async function both read and write
file descriptors.

To retain compatiblity and similar "API feel" with start_command,
we require start_async callers to set .out = -1 to get a readable
file descriptor.  If either of .in or .out is 0, we supply no file
descriptor to the async process.

[sp: Note: Erik started this patch, and a huge bulk of it is
     his work.  All bugs were introduced later by Shawn.]

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/technical/api-run-command.txt |   50 +++++++++++++---
 builtin-fetch-pack.c                        |    7 +-
 convert.c                                   |    5 +-
 remote-curl.c                               |    7 +-
 run-command.c                               |   83 ++++++++++++++++++++++----
 run-command.h                               |    9 ++-
 upload-pack.c                               |    7 +-
 7 files changed, 131 insertions(+), 37 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index a1280dd..8994859 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -64,8 +64,8 @@ The functions above do the following:
 `start_async`::
 
 	Run a function asynchronously. Takes a pointer to a `struct
-	async` that specifies the details and returns a pipe FD
-	from which the caller reads. See below for details.
+	async` that specifies the details and returns a set of pipe FDs
+	for communication with the function. See below for details.
 
 `finish_async`::
 
@@ -180,17 +180,47 @@ The caller:
    struct async variable;
 2. initializes .proc and .data;
 3. calls start_async();
-4. processes the data by reading from the fd in .out;
-5. closes .out;
+4. processes communicates with proc through .in and .out;
+5. closes .in and .out;
 6. calls finish_async().
 
+The members .in, .out are used to provide a set of fd's for
+communication between the caller and the callee as follows:
+
+. Specify 0 to have no file descriptor passed.  The callee will
+  receive -1 in the corresponding argument.
+
+. Specify < 0 to have a pipe allocated; start_async() replaces
+  with the pipe FD in the following way:
+
+	.in: Returns the writable pipe end into which the caller
+	writes; the readable end of the pipe becomes the function's
+	in argument.
+
+	.out: Returns the readable pipe end from which the caller
+	reads; the writable end of the pipe becomes the function's
+	out argument.
+
+  The caller of start_async() must close the returned FDs after it
+  has completed reading from/writing from them.
+
+. Specify a file descriptor > 0 to be used by the function:
+
+	.in: The FD must be readable; it becomes the function's in.
+	.out: The FD must be writable; it becomes the function's out.
+
+  The specified FD is closed by start_async(), even if it fails to
+  run the function.
+
 The function pointer in .proc has the following signature:
 
-	int proc(int fd, void *data);
+	int proc(int in, int out, void *data);
 
-. fd specifies a writable file descriptor to which the function must
-  write the data that it produces. The function *must* close this
-  descriptor before it returns.
+. in, out specifies a set of file descriptors to which the function
+  must read/write the data that it needs/produces.  The function
+  *must* close these descriptors before it returns.  A descriptor
+  may be -1 if the caller did not configure a descriptor for that
+  direction.
 
 . data is the value that the caller has specified in the .data member
   of struct async.
@@ -205,8 +235,8 @@ because this facility is implemented by a pipe to a forked process on
 UNIX, but by a thread in the same address space on Windows:
 
 . It cannot change the program's state (global variables, environment,
-  etc.) in a way that the caller notices; in other words, .out is the
-  only communication channel to the caller.
+  etc.) in a way that the caller notices; in other words, .in and .out
+  are the only communication channels to the caller.
 
 . It must not change the program's state that the caller of the
   facility also uses.
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 8ed4a6f..dbd8b7b 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -586,12 +586,12 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
 	return retval;
 }
 
-static int sideband_demux(int fd, void *data)
+static int sideband_demux(int in, int out, void *data)
 {
 	int *xd = data;
 
-	int ret = recv_sideband("fetch-pack", xd[0], fd);
-	close(fd);
+	int ret = recv_sideband("fetch-pack", xd[0], out);
+	close(out);
 	return ret;
 }
 
@@ -613,6 +613,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
 		 */
 		demux.proc = sideband_demux;
 		demux.data = xd;
+		demux.out = -1;
 		if (start_async(&demux))
 			die("fetch-pack: unable to fork off sideband"
 			    " demultiplexer");
diff --git a/convert.c b/convert.c
index 491e714..e70ee09 100644
--- a/convert.c
+++ b/convert.c
@@ -241,7 +241,7 @@ struct filter_params {
 	const char *cmd;
 };
 
-static int filter_buffer(int fd, void *data)
+static int filter_buffer(int in, int out, void *data)
 {
 	/*
 	 * Spawn cmd and feed the buffer contents through its stdin.
@@ -254,7 +254,7 @@ static int filter_buffer(int fd, void *data)
 	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
 	child_process.in = -1;
-	child_process.out = fd;
+	child_process.out = out;
 
 	if (start_command(&child_process))
 		return error("cannot fork to run external filter %s", params->cmd);
@@ -291,6 +291,7 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	memset(&async, 0, sizeof(async));
 	async.proc = filter_buffer;
 	async.data = &params;
+	async.out = -1;
 	params.src = src;
 	params.size = len;
 	params.cmd = cmd;
diff --git a/remote-curl.c b/remote-curl.c
index 3edbf57..6bb3366 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -184,13 +184,13 @@ static struct discovery* discover_refs(const char *service)
 	return last;
 }
 
-static int write_discovery(int fd, void *data)
+static int write_discovery(int in, int out, void *data)
 {
 	struct discovery *heads = data;
 	int err = 0;
-	if (write_in_full(fd, heads->buf, heads->len) != heads->len)
+	if (write_in_full(out, heads->buf, heads->len) != heads->len)
 		err = 1;
-	close(fd);
+	close(out);
 	return err;
 }
 
@@ -202,6 +202,7 @@ static struct ref *parse_git_refs(struct discovery *heads)
 	memset(&async, 0, sizeof(async));
 	async.proc = write_discovery;
 	async.data = heads;
+	async.out = -1;
 
 	if (start_async(&async))
 		die("cannot start thread to parse advertised refs");
diff --git a/run-command.c b/run-command.c
index bfd2312..0d95340 100644
--- a/run-command.c
+++ b/run-command.c
@@ -327,17 +327,51 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
 static unsigned __stdcall run_thread(void *data)
 {
 	struct async *async = data;
-	return async->proc(async->fd_for_proc, async->data);
+	return async->proc(async->proc_in, async->proc_out, async->data);
 }
 #endif
 
 int start_async(struct async *async)
 {
-	int pipe_out[2];
+	int need_in, need_out;
+	int fdin[2], fdout[2];
+	int proc_in, proc_out;
 
-	if (pipe(pipe_out) < 0)
-		return error("cannot create pipe: %s", strerror(errno));
-	async->out = pipe_out[0];
+	need_in = async->in < 0;
+	if (need_in) {
+		if (pipe(fdin) < 0) {
+			if (async->out > 0)
+				close(async->out);
+			return error("cannot create pipe: %s", strerror(errno));
+		}
+		async->in = fdin[1];
+	}
+
+	need_out = async->out < 0;
+	if (need_out) {
+		if (pipe(fdout) < 0) {
+			if (need_in)
+				close_pair(fdin);
+			else if (async->in)
+				close(async->in);
+			return error("cannot create pipe: %s", strerror(errno));
+		}
+		async->out = fdout[0];
+	}
+
+	if (need_in)
+		proc_in = fdin[0];
+	else if (async->in)
+		proc_in = async->in;
+	else
+		proc_in = -1;
+
+	if (need_out)
+		proc_out = fdout[1];
+	else if (async->out)
+		proc_out = async->out;
+	else
+		proc_out = -1;
 
 #ifndef WIN32
 	/* Flush stdio before fork() to avoid cloning buffers */
@@ -346,24 +380,47 @@ int start_async(struct async *async)
 	async->pid = fork();
 	if (async->pid < 0) {
 		error("fork (async) failed: %s", strerror(errno));
-		close_pair(pipe_out);
-		return -1;
+		goto error;
 	}
 	if (!async->pid) {
-		close(pipe_out[0]);
-		exit(!!async->proc(pipe_out[1], async->data));
+		if (need_in)
+			close(fdin[1]);
+		if (need_out)
+			close(fdout[0]);
+		exit(!!async->proc(proc_in, proc_out, async->data));
 	}
-	close(pipe_out[1]);
+
+	if (need_in)
+		close(fdin[0]);
+	else if (async->in)
+		close(async->in);
+
+	if (need_out)
+		close(fdout[1]);
+	else if (async->out)
+		close(async->out);
 #else
-	async->fd_for_proc = pipe_out[1];
+	async->proc_in = proc_in;
+	async->proc_out = proc_out;
 	async->tid = (HANDLE) _beginthreadex(NULL, 0, run_thread, async, 0, NULL);
 	if (!async->tid) {
 		error("cannot create thread: %s", strerror(errno));
-		close_pair(pipe_out);
-		return -1;
+		goto error;
 	}
 #endif
 	return 0;
+
+error:
+	if (need_in)
+		close_pair(fdin);
+	else if (async->in)
+		close(async->in);
+
+	if (need_out)
+		close_pair(fdout);
+	else if (async->out)
+		close(async->out);
+	return -1;
 }
 
 int finish_async(struct async *async)
diff --git a/run-command.h b/run-command.h
index a29171a..65ccb1c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -64,17 +64,20 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
  */
 struct async {
 	/*
-	 * proc writes to fd and closes it;
+	 * proc reads from in; closes it before return
+	 * proc writes to out; closes it before return
 	 * returns 0 on success, non-zero on failure
 	 */
-	int (*proc)(int fd, void *data);
+	int (*proc)(int in, int out, void *data);
 	void *data;
+	int in;		/* caller writes here and closes it */
 	int out;	/* caller reads from here and closes it */
 #ifndef WIN32
 	pid_t pid;
 #else
 	HANDLE tid;
-	int fd_for_proc;
+	int proc_in;
+	int proc_out;
 #endif
 };
 
diff --git a/upload-pack.c b/upload-pack.c
index df15181..dc464d7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -105,12 +105,12 @@ static void show_edge(struct commit *commit)
 	fprintf(pack_pipe, "-%s\n", sha1_to_hex(commit->object.sha1));
 }
 
-static int do_rev_list(int fd, void *create_full_pack)
+static int do_rev_list(int in, int out, void *create_full_pack)
 {
 	int i;
 	struct rev_info revs;
 
-	pack_pipe = xfdopen(fd, "w");
+	pack_pipe = xfdopen(out, "w");
 	init_revisions(&revs, NULL);
 	revs.tag_objects = 1;
 	revs.tree_objects = 1;
@@ -162,8 +162,9 @@ static void create_pack_file(void)
 	int arg = 0;
 
 	if (shallow_nr) {
+		memset(&rev_list, 0, sizeof(rev_list));
 		rev_list.proc = do_rev_list;
-		rev_list.data = 0;
+		rev_list.out = -1;
 		if (start_async(&rev_list))
 			die("git upload-pack: unable to fork git-rev-list");
 		argv[arg++] = "pack-objects";
-- 
1.7.0.rc1.199.g9253ab
