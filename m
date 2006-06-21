From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] upload-pack/fetch-pack: support side-band communication
Date: Wed, 21 Jun 2006 04:01:47 -0700
Message-ID: <7vsllyzs9w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 21 13:02:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft0T3-00008F-6f
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 13:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWFULBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 07:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWFULBt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 07:01:49 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:37769 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751501AbWFULBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 07:01:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621110147.SUYZ5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 07:01:47 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22261>

This implements a protocol extension between fetch-pack and
upload-pack to allow stderr stream from upload-pack (primarily
used for the progress bar display) to be passed back.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * With this, fetching and cloning over git+ssh:// and git://
   does not discard the progress bar and error messages that
   upload-pack emits on its standard output.  They are sent to
   the downloader and shown to the user.

   Somehow this does not work when connecting to git daemon that
   runs under inetd.  Fixes appreciated.

 cache.h       |    4 ++-
 fetch-clone.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 fetch-pack.c  |   22 +++++++++++++-----
 pkt-line.c    |    4 ++-
 pkt-line.h    |    1 +
 upload-pack.c |   60 +++++++++++++++++++++++++++++++++++++++++-------
 6 files changed, 139 insertions(+), 23 deletions(-)

diff --git a/cache.h b/cache.h
index eaa5c0c..efeafea 100644
--- a/cache.h
+++ b/cache.h
@@ -374,8 +374,8 @@ extern char git_commit_encoding[MAX_ENCO
 extern int copy_fd(int ifd, int ofd);
 
 /* Finish off pack transfer receiving end */
-extern int receive_unpack_pack(int fd[2], const char *me, int quiet);
-extern int receive_keep_pack(int fd[2], const char *me, int quiet);
+extern int receive_unpack_pack(int fd[2], const char *me, int quiet, int);
+extern int receive_keep_pack(int fd[2], const char *me, int quiet, int);
 
 /* pager.c */
 extern void setup_pager(void);
diff --git a/fetch-clone.c b/fetch-clone.c
index da1b3ff..c16b0c4 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "exec_cmd.h"
+#include "pkt-line.h"
 #include <sys/wait.h>
 #include <sys/time.h>
 
@@ -23,7 +24,7 @@ static int finish_pack(const char *pack_
 
 	pid = fork();
 	if (pid < 0)
-		die("git-clone-pack: unable to fork off git-index-pack");
+		die("%s: unable to fork off git-index-pack", me);
 	if (!pid) {
 		close(0);
 		dup2(pipe_fd[1], 1);
@@ -94,11 +95,69 @@ static int finish_pack(const char *pack_
 	exit(1);
 }
 
-int receive_unpack_pack(int fd[2], const char *me, int quiet)
+static pid_t setup_sideband(int sideband, const char *me, int fd[2], int xd[2])
+{
+	pid_t side_pid;
+
+	if (!sideband) {
+		fd[0] = xd[0];
+		fd[1] = xd[1];
+		return 0;
+	}
+	/* xd[] is talking with upload-pack; subprocess reads from
+	 * xd[0], spits out band#2 to stderr, and feeds us band#1
+	 * through our fd[0].
+	 */
+	if (pipe(fd) < 0)
+		die("%s: unable to set up pipe", me);
+	side_pid = fork();
+	if (side_pid < 0)
+		die("%s: unable to fork off sideband demultiplexer", me);
+	if (!side_pid) {
+		/* subprocess */
+		close(fd[0]);
+		if (xd[0] != xd[1])
+			close(xd[1]);
+		while (1) {
+			char buf[1024];
+			int len = packet_read_line(xd[0], buf, sizeof(buf));
+			if (len == 0)
+				break;
+			if (len < 1)
+				die("%s: protocol error: no band designator",
+				    me);
+			len--;
+			switch (buf[0] & 0xFF) {
+			case 3:
+				safe_write(2, buf+1, len);
+				fprintf(stderr, "\n");
+				exit(1);
+			case 2:
+				safe_write(2, buf+1, len);
+				continue;
+			case 1:
+				safe_write(fd[1], buf+1, len);
+				continue;
+			default:
+				die("%s: protocol error: bad band #%d",
+				    me, (buf[0] & 0xFF));
+			}
+		}
+		exit(0);
+	}
+	close(xd[0]);
+	close(fd[1]);
+	fd[1] = xd[1];
+	return side_pid;
+}
+
+int receive_unpack_pack(int xd[2], const char *me, int quiet, int sideband)
 {
 	int status;
-	pid_t pid;
+	pid_t pid, side_pid;
+	int fd[2];
 
+	side_pid = setup_sideband(sideband, me, fd, xd);
 	pid = fork();
 	if (pid < 0)
 		die("%s: unable to fork off git-unpack-objects", me);
@@ -147,10 +206,10 @@ #define NR_AVERAGE (4)
  */
 #define usec_to_binarymsec(x) ((int)(x) / (1000512 >> 10))
 
-int receive_keep_pack(int fd[2], const char *me, int quiet)
+int receive_keep_pack(int xd[2], const char *me, int quiet, int sideband)
 {
 	char tmpfile[PATH_MAX];
-	int ofd, ifd;
+	int ofd, ifd, fd[2];
 	unsigned long total;
 	static struct timeval prev_tv;
 	struct average {
@@ -160,6 +219,8 @@ int receive_keep_pack(int fd[2], const c
 	unsigned long avg_bytes, avg_time;
 	int idx = 0;
 
+	setup_sideband(sideband, me, fd, xd);
+
 	ifd = fd[0];
 	snprintf(tmpfile, sizeof(tmpfile),
 		 "%s/pack/tmp-XXXXXX", get_object_directory());
diff --git a/fetch-pack.c b/fetch-pack.c
index 7d23a80..f2c51eb 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -25,7 +25,7 @@ #define POPPED		(1U << 4)
 #define MAX_IN_VAIN 256
 
 static struct commit_list *rev_list = NULL;
-static int non_common_revs = 0, multi_ack = 0, use_thin_pack = 0;
+static int non_common_revs = 0, multi_ack = 0, use_thin_pack = 0, use_sideband;
 
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -165,9 +165,14 @@ static int find_common(int fd[2], unsign
 			continue;
 		}
 
-		packet_write(fd[1], "want %s%s%s\n", sha1_to_hex(remote),
-			     (multi_ack ? " multi_ack" : ""),
-			     (use_thin_pack ? " thin-pack" : ""));
+		if (!fetching)
+			packet_write(fd[1], "want %s%s%s%s\n",
+				     sha1_to_hex(remote),
+				     (multi_ack ? " multi_ack" : ""),
+				     (use_sideband ? " side-band" : ""),
+				     (use_thin_pack ? " thin-pack" : ""));
+		else
+			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
 		fetching++;
 	}
 	packet_flush(fd[1]);
@@ -421,6 +426,11 @@ static int fetch_pack(int fd[2], int nr_
 			fprintf(stderr, "Server supports multi_ack\n");
 		multi_ack = 1;
 	}
+	if (server_supports("side-band")) {
+		if (verbose)
+			fprintf(stderr, "Server supports side-band\n");
+		use_sideband = 1;
+	}
 	if (!ref) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
@@ -437,9 +447,9 @@ static int fetch_pack(int fd[2], int nr_
 			fprintf(stderr, "warning: no common commits\n");
 
 	if (keep_pack)
-		status = receive_keep_pack(fd, "git-fetch-pack", quiet);
+		status = receive_keep_pack(fd, "git-fetch-pack", quiet, use_sideband);
 	else
-		status = receive_unpack_pack(fd, "git-fetch-pack", quiet);
+		status = receive_unpack_pack(fd, "git-fetch-pack", quiet, use_sideband);
 
 	if (status)
 		die("git-fetch-pack: fetch failed.");
diff --git a/pkt-line.c b/pkt-line.c
index bb3bab0..3d724ac 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -16,8 +16,9 @@ #include "pkt-line.h"
  * The writing side could use stdio, but since the reading
  * side can't, we stay with pure read/write interfaces.
  */
-static void safe_write(int fd, const void *buf, unsigned n)
+ssize_t safe_write(int fd, const void *buf, ssize_t n)
 {
+	ssize_t nn = n;
 	while (n) {
 		int ret = xwrite(fd, buf, n);
 		if (ret > 0) {
@@ -29,6 +30,7 @@ static void safe_write(int fd, const voi
 			die("write error (disk full?)");
 		die("write error (%s)", strerror(errno));
 	}
+	return nn;
 }
 
 /*
diff --git a/pkt-line.h b/pkt-line.h
index 51d0cbe..9abef24 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -8,5 +8,6 @@ void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
 int packet_read_line(int fd, char *buffer, unsigned size);
+ssize_t safe_write(int, const void *, ssize_t);
 
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index 13eaa22..7b86f69 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -21,6 +21,7 @@ static int use_thin_pack = 0;
 static unsigned char has_sha1[MAX_HAS][20];
 static unsigned char needs_sha1[MAX_NEEDS][20];
 static unsigned int timeout = 0;
+static int use_sideband = 0;
 
 static void reset_timeout(void)
 {
@@ -34,6 +35,43 @@ static int strip(char *line, int len)
 	return len;
 }
 
+#define PACKET_MAX 1000
+static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
+{
+	ssize_t ssz;
+	const char *p;
+
+	if (!data) {
+		if (!use_sideband)
+			return 0;
+		packet_flush(1);
+	}
+
+	if (!use_sideband) {
+		if (fd == 3)
+			/* emergency quit */
+			fd = 2;
+		return safe_write(fd, data, sz);
+	}
+	p = data;
+	ssz = sz;
+	while (sz) {
+		unsigned n;
+		char hdr[5];
+
+		n = sz;
+		if (PACKET_MAX - 5 < n)
+			n = PACKET_MAX - 5;
+		sprintf(hdr, "%04x", n + 5);
+		hdr[4] = fd;
+		safe_write(1, hdr, 5);
+		safe_write(1, p, n);
+		p += n;
+		sz -= n;
+	}
+	return ssz;
+}
+
 static void create_pack_file(void)
 {
 	/* Pipes between rev-list to pack-objects, pack-objects to us
@@ -43,6 +81,8 @@ static void create_pack_file(void)
 	pid_t pid_rev_list, pid_pack_objects;
 	int create_full_pack = (nr_our_refs == nr_needs && !nr_has);
 	char data[8193], progress[128];
+	char abort_msg[] = "aborting due to possible repository "
+		"corruption on the remote side.";
 	int buffered = -1;
 
 	if (pipe(lp_pipe) < 0)
@@ -132,7 +172,6 @@ static void create_pack_file(void)
 
 	while (1) {
 		const char *who;
-		char *cp;
 		struct pollfd pfd[2];
 		pid_t pid;
 		int status;
@@ -199,19 +238,18 @@ static void create_pack_file(void)
 				}
 				else
 					buffered = -1;
-				sz = xwrite(1, data, sz);
+				sz = send_client_data(1, data, sz);
 				if (sz < 0)
 					goto fail;
 			}
 			if (0 <= pe && (pfd[pe].revents & (POLLIN|POLLHUP))) {
-				/* Status ready; we do not use it for now,
-				 * but later we will add side-band to send it
-				 * to the other side.
+				/* Status ready; we ship that in the side-band
+				 * or dump to the standard error.
 				 */
 				sz = read(pe_pipe[0], progress,
 					  sizeof(progress));
 				if (0 < sz)
-					write(2, progress, sz);
+					send_client_data(2, progress, sz);
 				else if (sz == 0) {
 					close(pe_pipe[0]);
 					pe_pipe[0] = -1;
@@ -259,11 +297,12 @@ static void create_pack_file(void)
 		/* flush the data */
 		if (0 <= buffered) {
 			data[0] = buffered;
-			sz = xwrite(1, data, 1);
+			sz = send_client_data(1, data, 1);
 			if (sz < 0)
 				goto fail;
 			fprintf(stderr, "flushed.\n");
 		}
+		send_client_data(1, NULL, 0);
 		return;
 	}
  fail:
@@ -271,7 +310,8 @@ static void create_pack_file(void)
 		kill(pid_pack_objects, SIGKILL);
 	if (pid_rev_list)
 		kill(pid_rev_list, SIGKILL);
-	die("git-upload-pack: aborting due to possible repository corruption on the remote side.");
+	send_client_data(3, abort_msg, sizeof(abort_msg));
+	die("git-upload-pack: %s", abort_msg);
 }
 
 static int got_sha1(char *hex, unsigned char *sha1)
@@ -378,6 +418,8 @@ static int receive_needs(void)
 			multi_ack = 1;
 		if (strstr(line+45, "thin-pack"))
 			use_thin_pack = 1;
+		if (strstr(line+45, "side-band"))
+			use_sideband = 1;
 
 		/* We have sent all our refs already, and the other end
 		 * should have chosen out of them; otherwise they are
@@ -399,7 +441,7 @@ static int receive_needs(void)
 
 static int send_ref(const char *refname, const unsigned char *sha1)
 {
-	static char *capabilities = "multi_ack thin-pack";
+	static char *capabilities = "multi_ack thin-pack side-band";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
-- 
1.4.0.g160a
