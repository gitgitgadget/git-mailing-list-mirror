X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] enhance clone and fetch -k experience
Date: Fri, 27 Oct 2006 15:42:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610271502200.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 27 Oct 2006 20:03:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30344>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdXb7-0007tZ-TQ for gcvg-git@gmane.org; Fri, 27 Oct
 2006 21:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752433AbWJ0TmT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 15:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbWJ0TmT
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 15:42:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:5933 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1752433AbWJ0TmS
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 15:42:18 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7T00A6T82HWBD0@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Fri,
 27 Oct 2006 15:42:18 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Now that index-pack can be streamed with a pack, it is probably a good 
idea to use it directly instead of creating a temporary file and running 
index-pack afterwards.  This way index-pack can abort early whenever a 
corruption is encountered even if the pack has not been fully 
downloaded, it can display a progress percentage as it knows how much to 
expects, and it is a bit faster since the pack indexing is partially 
done as data is received. Using fetch -k doesn't need to disable thin 
pack generation on the remote end either.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/fetch-clone.c b/fetch-clone.c
index 76b99af..96cdab4 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -3,97 +3,6 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include <sys/wait.h>
-#include <sys/time.h>
-
-static int finish_pack(const char *pack_tmp_name, const char *me)
-{
-	int pipe_fd[2];
-	pid_t pid;
-	char idx[PATH_MAX];
-	char final[PATH_MAX];
-	char hash[41];
-	unsigned char sha1[20];
-	char *cp;
-	int err = 0;
-
-	if (pipe(pipe_fd) < 0)
-		die("%s: unable to set up pipe", me);
-
-	strcpy(idx, pack_tmp_name); /* ".git/objects/pack-XXXXXX" */
-	cp = strrchr(idx, '/');
-	memcpy(cp, "/pidx", 5);
-
-	pid = fork();
-	if (pid < 0)
-		die("%s: unable to fork off git-index-pack", me);
-	if (!pid) {
-		close(0);
-		dup2(pipe_fd[1], 1);
-		close(pipe_fd[0]);
-		close(pipe_fd[1]);
-		execl_git_cmd("index-pack", "-o", idx, pack_tmp_name, NULL);
-		error("cannot exec git-index-pack <%s> <%s>",
-		      idx, pack_tmp_name);
-		exit(1);
-	}
-	close(pipe_fd[1]);
-	if (read(pipe_fd[0], hash, 40) != 40) {
-		error("%s: unable to read from git-index-pack", me);
-		err = 1;
-	}
-	close(pipe_fd[0]);
-
-	for (;;) {
-		int status, code;
-
-		if (waitpid(pid, &status, 0) < 0) {
-			if (errno == EINTR)
-				continue;
-			error("waitpid failed (%s)", strerror(errno));
-			goto error_die;
-		}
-		if (WIFSIGNALED(status)) {
-			int sig = WTERMSIG(status);
-			error("git-index-pack died of signal %d", sig);
-			goto error_die;
-		}
-		if (!WIFEXITED(status)) {
-			error("git-index-pack died of unnatural causes %d",
-			      status);
-			goto error_die;
-		}
-		code = WEXITSTATUS(status);
-		if (code) {
-			error("git-index-pack died with error code %d", code);
-			goto error_die;
-		}
-		if (err)
-			goto error_die;
-		break;
-	}
-	hash[40] = 0;
-	if (get_sha1_hex(hash, sha1)) {
-		error("git-index-pack reported nonsense '%s'", hash);
-		goto error_die;
-	}
-	/* Now we have pack in pack_tmp_name[], and
-	 * idx in idx[]; rename them to their final names.
-	 */
-	snprintf(final, sizeof(final),
-		 "%s/pack/pack-%s.pack", get_object_directory(), hash);
-	move_temp_to_file(pack_tmp_name, final);
-	chmod(final, 0444);
-	snprintf(final, sizeof(final),
-		 "%s/pack/pack-%s.idx", get_object_directory(), hash);
-	move_temp_to_file(idx, final);
-	chmod(final, 0444);
-	return 0;
-
- error_die:
-	unlink(idx);
-	unlink(pack_tmp_name);
-	exit(1);
-}
 
 static pid_t setup_sideband(int sideband, const char *me, int fd[2], int xd[2])
 {
@@ -128,7 +37,7 @@ static pid_t setup_sideband(int sideband
 	return side_pid;
 }
 
-int receive_unpack_pack(int xd[2], const char *me, int quiet, int sideband)
+static int get_pack(int xd[2], const char *me, int sideband, const char **argv)
 {
 	int status;
 	pid_t pid, side_pid;
@@ -142,135 +51,37 @@ int receive_unpack_pack(int xd[2], const
 		dup2(fd[0], 0);
 		close(fd[0]);
 		close(fd[1]);
-		execl_git_cmd("unpack-objects", quiet ? "-q" : NULL, NULL);
-		die("git-unpack-objects exec failed");
+		execv_git_cmd(argv);
+		die("%s exec failed", argv[0]);
 	}
 	close(fd[0]);
 	close(fd[1]);
 	while (waitpid(pid, &status, 0) < 0) {
 		if (errno != EINTR)
-			die("waiting for git-unpack-objects: %s",
-			    strerror(errno));
+			die("waiting for %s: %s", argv[0], strerror(errno));
 	}
 	if (WIFEXITED(status)) {
 		int code = WEXITSTATUS(status);
 		if (code)
-			die("git-unpack-objects died with error code %d",
-			    code);
+			die("%s died with error code %d", argv[0], code);
 		return 0;
 	}
 	if (WIFSIGNALED(status)) {
 		int sig = WTERMSIG(status);
-		die("git-unpack-objects died of signal %d", sig);
+		die("%s died of signal %d", argv[0], sig);
 	}
-	die("git-unpack-objects died of unnatural causes %d", status);
+	die("%s died of unnatural causes %d", argv[0], status);
 }
 
-/*
- * We average out the download speed over this many "events", where
- * an event is a minimum of about half a second. That way, we get
- * a reasonably stable number.
- */
-#define NR_AVERAGE (4)
-
-/*
- * A "binary msec" is a power-of-two-msec, aka 1/1024th of a second.
- * Keeping the time in that format means that "bytes / msecs" means
- * the same as kB/s (modulo rounding).
- *
- * 1000512 is a magic number (usecs in a second, rounded up by half
- * of 1024, to make "rounding" come out right ;)
- */
-#define usec_to_binarymsec(x) ((int)(x) / (1000512 >> 10))
+int receive_unpack_pack(int xd[2], const char *me, int quiet, int sideband)
+{
+	const char *argv[3] = { "unpack-objects", quiet ? "-q" : NULL, NULL };
+	return get_pack(xd, me, sideband, argv);
+}
 
 int receive_keep_pack(int xd[2], const char *me, int quiet, int sideband)
 {
-	char tmpfile[PATH_MAX];
-	int ofd, ifd, fd[2];
-	unsigned long total;
-	static struct timeval prev_tv;
-	struct average {
-		unsigned long bytes;
-		unsigned long time;
-	} download[NR_AVERAGE] = { {0, 0}, };
-	unsigned long avg_bytes, avg_time;
-	int idx = 0;
-
-	setup_sideband(sideband, me, fd, xd);
-
-	ifd = fd[0];
-	snprintf(tmpfile, sizeof(tmpfile),
-		 "%s/pack/tmp-XXXXXX", get_object_directory());
-	ofd = mkstemp(tmpfile);
-	if (ofd < 0)
-		return error("unable to create temporary file %s", tmpfile);
-
-	gettimeofday(&prev_tv, NULL);
-	total = 0;
-	avg_bytes = 0;
-	avg_time = 0;
-	while (1) {
-		char buf[8192];
-		ssize_t sz, wsz, pos;
-		sz = read(ifd, buf, sizeof(buf));
-		if (sz == 0)
-			break;
-		if (sz < 0) {
-			if (errno != EINTR && errno != EAGAIN) {
-				error("error reading pack (%s)", strerror(errno));
-				close(ofd);
-				unlink(tmpfile);
-				return -1;
-			}
-			sz = 0;
-		}
-		pos = 0;
-		while (pos < sz) {
-			wsz = write(ofd, buf + pos, sz - pos);
-			if (wsz < 0) {
-				error("error writing pack (%s)",
-				      strerror(errno));
-				close(ofd);
-				unlink(tmpfile);
-				return -1;
-			}
-			pos += wsz;
-		}
-		total += sz;
-		if (!quiet) {
-			static unsigned long last;
-			struct timeval tv;
-			unsigned long diff = total - last;
-			/* not really "msecs", but a power-of-two millisec (1/1024th of a sec) */
-			unsigned long msecs;
-
-			gettimeofday(&tv, NULL);
-			msecs = tv.tv_sec - prev_tv.tv_sec;
-			msecs <<= 10;
-			msecs += usec_to_binarymsec(tv.tv_usec - prev_tv.tv_usec);
-
-			if (msecs > 500) {
-				prev_tv = tv;
-				last = total;
-
-				/* Update averages ..*/
-				avg_bytes += diff;
-				avg_time += msecs;
-				avg_bytes -= download[idx].bytes;
-				avg_time -= download[idx].time;
-				download[idx].bytes = diff;
-				download[idx].time = msecs;
-				idx++;
-				if (idx >= NR_AVERAGE)
-					idx = 0;
-
-				fprintf(stderr, "%4lu.%03luMB  (%lu kB/s)      \r",
-					total >> 20,
-					1000*((total >> 10) & 1023)>>10,
-					avg_bytes / avg_time );
-			}
-		}
-	}
-	close(ofd);
-	return finish_pack(tmpfile, me);
+	const char *argv[5] = { "index-pack", "--stdin", "--fix-thin",
+				quiet ? NULL : "-v", NULL };
+	return get_pack(xd, me, sideband, argv);
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index 90b7940..36ea092 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -518,8 +518,6 @@ int main(int argc, char **argv)
 	}
 	if (!dest)
 		usage(fetch_pack_usage);
-	if (keep_pack)
-		use_thin_pack = 0;
 	pid = git_connect(fd, dest, exec);
 	if (pid < 0)
