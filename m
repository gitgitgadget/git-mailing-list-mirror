From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Pull well-bounded pack files over ssh
Date: Mon, 4 Jul 2005 14:51:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0507041450350.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0507041416240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 20:54:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpW4m-000737-FS
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 20:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVGDSxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 14:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVGDSxs
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 14:53:48 -0400
Received: from iabervon.org ([66.92.72.58]:51972 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261562AbVGDSx2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 14:53:28 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DpW2d-00088Q-00; Mon, 4 Jul 2005 14:51:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0507041416240.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Initial version of support for transferring pack files over ssh. This works
by sending the source hashes that the target already has, and checking (in
bulk) whether the source has them as well. If the source has some hash that
the target has, the target will request a pack for the fetch, instead of
requesting individual objects, and the source will provide a pack that has
the requested object and all references, excluding those mentioned previously
and any they refer to.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---
commit 2045e6098dfa0f8760b6a4a65227a6ea51de990d
tree 3d3e671c0ac57ea66434768c2b3432352b7c20ae
parent a3d68b56cd5efaa06a7493aca61febb4f376fb49
author Daniel Barkalow <barkalow@iabervon.org> 1120501001 -0400
committer Daniel Barkalow <barkalow@silva-tulga.(none)> 1120501001 -0400

Index: ssh-pull.c
===================================================================
--- 8c3f58421885a9c1472f141bb32b668c2e65a5fc/ssh-pull.c  (mode:100644 sha1:0f2c3b5b9db324e20eb6ed0c52cc884b86349a08)
+++ 3d3e671c0ac57ea66434768c2b3432352b7c20ae/ssh-pull.c  (mode:100644 sha1:f792135e7afba6a8d68946a7f14aa339c4fc02e7)
@@ -4,11 +4,86 @@
 #include "pull.h"
 #include "refs.h"
 
+#include "pkt-line.h"
+#include <sys/wait.h>
+
+static const char *unpacker = "git-unpack-objects";
+
 static int fd_in;
 static int fd_out;
 
 static unsigned char remote_version = 0;
-static unsigned char local_version = 1;
+static unsigned char local_version = 2;
+
+static int sent_excludes = 0;
+static int accepted_excludes = 0;
+
+static int write_pack_from_fd(int fd)
+{
+	pid_t pid = fork();
+
+	if (pid < 0)
+		die("unpack fork failed");
+	if (!pid) {
+		execlp(unpacker, unpacker, NULL);
+		die("unpack execute failed");
+	}
+
+	for (;;) {
+		int status, code;
+		int retval = waitpid(pid, &status, 0);
+
+		if (retval < 0) {
+			if (errno == EINTR)
+				continue;
+			die("waitpid failed (%s)", strerror(retval));
+		}
+		if (retval != pid)
+			die("waitpid is confused");
+		if (WIFSIGNALED(status))
+			die("%s died of signal %d", unpacker, WTERMSIG(status));
+		if (!WIFEXITED(status))
+			die("%s died out of really strange complications", unpacker);
+		code = WEXITSTATUS(status);
+		if (code)
+			die("%s exited with error code %d", unpacker, code);
+		return 0;
+	}
+}
+
+static int handle_deferred_reads()
+{
+	signed char remote;
+	while (sent_excludes) {
+		if (read(fd_in, &remote, 1) < 1)
+			return -1;
+		if (!remote) {
+			if (get_verbosely) {
+				fprintf(stderr, "Exclude accepted\n");
+			}
+			accepted_excludes++;
+		}
+		sent_excludes--;
+	}
+	return 0;
+}
+
+static int fetch_pack(unsigned char *sha1)
+{
+	int ret;
+	char type = 'p';
+	signed char remote;
+	write(fd_out, &type, 1);
+	write(fd_out, sha1, 20);
+	if (read(fd_in, &remote, 1) < 1)
+		return -1;
+	if (remote < 0)
+		return remote;
+	if (get_verbosely)
+		fprintf(stderr, "Getting pack\n");
+	ret = write_pack_from_fd(fd_in);
+	return ret;
+}
 
 int fetch(unsigned char *sha1)
 {
@@ -17,6 +92,10 @@
 	char type = 'o';
 	if (has_sha1_file(sha1))
 		return 0;
+	if (handle_deferred_reads())
+		return -1;
+	if (accepted_excludes)
+		return fetch_pack(sha1);
 	write(fd_out, &type, 1);
 	write(fd_out, sha1, 20);
 	if (read(fd_in, &remote, 1) < 1)
@@ -44,6 +123,8 @@
 {
 	signed char remote;
 	char type = 'r';
+	if (handle_deferred_reads())
+		return -1;
 	write(fd_out, &type, 1);
 	write(fd_out, ref, strlen(ref) + 1);
 	read(fd_in, &remote, 1);
@@ -55,6 +136,15 @@
 
 void dont_fetch(const unsigned char *sha1)
 {
+	char type = 'd';
+	if (remote_version < 2)
+		return;
+	write(fd_out, &type, 1);
+	write(fd_out, sha1, 20);
+	sent_excludes++;
+	if (get_verbosely) {
+		fprintf(stderr, "Won't get %s\n", sha1_to_hex(sha1));
+	}
 }
 
 int main(int argc, char **argv)
@@ -76,7 +166,12 @@
 		} else if (argv[arg][1] == 'v') {
 			get_verbosely = 1;
 		} else if (argv[arg][1] == 'w') {
+			unsigned char *current = malloc(20);
 			write_ref = argv[arg + 1];
+			if (get_ref_sha1(write_ref, current))
+				free(current);
+			else
+				current_ref = current;
 			arg++;
 		}
 		arg++;
Index: ssh-push.c
===================================================================
--- 8c3f58421885a9c1472f141bb32b668c2e65a5fc/ssh-push.c  (mode:100644 sha1:090d6f9f8fbde2d736ac5bf563415b0fa402b5aa)
+++ 3d3e671c0ac57ea66434768c2b3432352b7c20ae/ssh-push.c  (mode:100644 sha1:10390948efacfa06f4f6fc6b2f3631cec6fcb876)
@@ -4,16 +4,88 @@
 
 #include <string.h>
 
-static unsigned char local_version = 1;
+static unsigned char local_version = 2;
 static unsigned char remote_version = 0;
 
-static int serve_object(int fd_in, int fd_out) {
+static void exec_pack_objects(void)
+{
+	static char *args[] = {
+		"git-pack-objects",
+		"--stdout",
+		NULL
+	};
+	execvp("git-pack-objects", args);
+	die("git-pack-objects exec failed (%s)", strerror(errno));
+}
+
+static void exec_rev_list(unsigned char *incl, unsigned char *excl)
+{
+	static char *args[1000];
+	char *buf = malloc(100);
+	int i = 0;
+
+	args[i++] = "git-rev-list";	/* 0 */
+	args[i++] = "--objects";	/* 1 */
+
+	args[i++] = buf;
+	snprintf(buf, 50, "^%s", sha1_to_hex(excl));
+	buf += 50;
+	args[i++] = buf;
+	snprintf(buf, 50, "%s", sha1_to_hex(incl));
+
+	args[i] = NULL;
+	execvp("git-rev-list", args);
+	die("git-rev-list exec failed (%s)", strerror(errno));
+}
+
+static void rev_list(int fd, unsigned char *incl, unsigned char *excl)
+{
+	int pipe_fd[2];
+	pid_t pack_objects_pid;
+
+	if (pipe(pipe_fd) < 0)
+		die("rev-list setup: pipe failed");
+	pack_objects_pid = fork();
+	if (!pack_objects_pid) {
+		dup2(pipe_fd[0], 0);
+		dup2(fd, 1);
+		close(pipe_fd[0]);
+		close(pipe_fd[1]);
+		close(fd);
+		exec_pack_objects();
+		die("pack-objects setup failed");
+	}
+	if (pack_objects_pid < 0)
+		die("pack-objects fork failed");
+	dup2(pipe_fd[1], 1);
+	close(pipe_fd[0]);
+	close(pipe_fd[1]);
+	close(fd);
+	exec_rev_list(incl, excl);
+}
+
+static int pack_objects(int fd, unsigned char *incl, unsigned char *excl)
+{
+	pid_t rev_list_pid;
+
+	rev_list_pid = fork();
+	if (!rev_list_pid) {
+		rev_list(fd, incl, excl);
+		die("rev-list setup failed");
+	}
+	if (rev_list_pid < 0)
+		die("rev-list fork failed");
+	/*
+	 * We don't wait for the rev-list pipeline in the parent:
+	 * we end up waiting for the other end instead
+	 */
+	return 0;
+}
+
+static int read_sha1(int fd_in, unsigned char *sha1)
+{
 	ssize_t size;
 	int posn = 0;
-	unsigned char sha1[20];
-	unsigned long objsize;
-	void *buf;
-	signed char remote;
 	do {
 		size = read(fd_in, sha1 + posn, 20 - posn);
 		if (size < 0) {
@@ -24,6 +96,18 @@
 			return -1;
 		posn += size;
 	} while (posn < 20);
+	return 0;
+}
+
+static int serve_object(int fd_in, int fd_out) {
+	unsigned char sha1[20];
+	unsigned long objsize;
+	void *buf;
+	signed char remote;
+	int posn;
+	ssize_t size;
+	if (read_sha1(fd_in, sha1))
+		return -1;
 	
 	/* fprintf(stderr, "Serving %s\n", sha1_to_hex(sha1)); */
 	remote = 0;
@@ -85,6 +169,48 @@
         return 0;
 }
 
+static unsigned char *excluded = NULL;
+
+static int serve_exclude(int fd_in, int fd_out)
+{
+	unsigned char sha1[20];
+	signed char remote;
+	if (read_sha1(fd_in, sha1))
+		return -1;
+
+	if (has_sha1_file(sha1)) {
+		remote = 0;
+		if (!excluded) {
+			excluded = malloc(20);
+			memcpy(excluded, sha1, 20);
+		}
+	} else {
+		remote = -1;
+	}
+
+	write(fd_out, &remote, 1);
+	
+	return 0;
+}
+
+static int serve_pack(int fd_in, int fd_out)
+{
+	unsigned char sha1[20];
+	signed char remote = 0;
+	if (read_sha1(fd_in, sha1))
+		return -1;
+
+	if (!has_sha1_file(sha1))
+		remote = -1;
+
+	write(fd_out, &remote, 1);
+
+	if (remote)
+		return 0;
+	if (pack_objects(fd_out, sha1, excluded))
+		return -1;
+	return 0;
+}
 
 static void service(int fd_in, int fd_out) {
 	char type;
@@ -102,6 +228,10 @@
 			return;
 		if (type == 'r' && serve_ref(fd_in, fd_out))
 			return;
+		if (type == 'd' && serve_exclude(fd_in, fd_out))
+			return;
+		if (type == 'p' && serve_pack(fd_in, fd_out))
+			return;
 	} while (1);
 }
 
