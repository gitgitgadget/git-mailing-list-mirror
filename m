From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to clone-pack the HEAD?
Date: Wed, 14 Dec 2005 22:21:23 -0800
Message-ID: <7vfyouricc.fsf@assigned-by-dhcp.cox.net>
References: <20051215004440.GM22159@pasky.or.cz>
	<7vfyovtaub.fsf@assigned-by-dhcp.cox.net>
	<20051215013201.GD10680@pasky.or.cz>
	<7vpsnzrv43.fsf@assigned-by-dhcp.cox.net>
	<7vlkynrurh.fsf@assigned-by-dhcp.cox.net>
	<7vpsnzq66x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 07:22:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmmUc-0002DQ-Jx
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 07:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbVLOGV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 01:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbVLOGV1
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 01:21:27 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:62144 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1161146AbVLOGV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 01:21:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215062046.SLGP15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 01:20:46 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vpsnzq66x.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 14 Dec 2005 21:29:10 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13683>

Junio C Hamano <junkio@cox.net> writes:

> Also I might want to give --keep option to fetch-pack as well;
> clone-pack has some static functions that we can extract out to
> a common file to link to both.

And this is the second installment, on top of the previous one.
I am a bit reluctant about this one only because of its size,
but I suspect it may be much easier to use for your purpose.

I'll keep this in the proposed updates branch for now (the other
one goes to master tonight), so if you like this one, please
holler, test out and ack.

-- >8 --
Subject: [PATCH] fetch-pack: -k option to keep downloaded pack.

Split out the functions that deal with the socketpair after
finishing git protocol handshake to receive the packed data into
a separate file, and use it in fetch-pack to keep/explode the
received pack data.  We earlier had something like that on
clone-pack side once, but the list discussion resulted in the
decision that it makes sense to always keep the pack for
clone-pack, so unpacking option is not enabled on the clone-pack
side, but we later still could do so easily if we wanted to with
this change.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-fetch-pack.txt |    7 +-
 Makefile                         |    1 
 cache.h                          |    5 +
 clone-pack.c                     |  136 ------------------------------
 fetch-clone.c                    |  172 ++++++++++++++++++++++++++++++++++++++
 fetch-pack.c                     |   58 +++++--------
 6 files changed, 206 insertions(+), 173 deletions(-)
 create mode 100644 fetch-clone.c

32cf3b780b1cf77cf2fa7042d31dfe969ad0b9b9
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index ea6faab..b507e9b 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -8,7 +8,7 @@ git-fetch-pack - Receive missing objects
 
 SYNOPSIS
 --------
-git-fetch-pack [-q] [--exec=<git-upload-pack>] [<host>:]<directory> [<refs>...]
+git-fetch-pack [-q] [-k] [--exec=<git-upload-pack>] [<host>:]<directory> [<refs>...]
 
 DESCRIPTION
 -----------
@@ -29,6 +29,11 @@ OPTIONS
 	Pass '-q' flag to 'git-unpack-objects'; this makes the
 	cloning process less verbose.
 
+-k::
+	Do not invoke 'git-unpack-objects' on received data, but
+	create a single packfile out of it instead, and store it
+	in the object database.
+
 --exec=<git-upload-pack>::
 	Use this to specify the path to 'git-upload-pack' on the
 	remote side, if is not found on your $PATH.
diff --git a/Makefile b/Makefile
index d494ad4..9fd2ed3 100644
--- a/Makefile
+++ b/Makefile
@@ -175,6 +175,7 @@ LIB_OBJS = \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
+	fetch-clone.o \
 	$(DIFF_OBJS)
 
 LIBS = $(LIB_FILE)
diff --git a/cache.h b/cache.h
index c78d8ae..cb87bec 100644
--- a/cache.h
+++ b/cache.h
@@ -338,4 +338,9 @@ extern char git_default_name[MAX_GITNAME
 extern char git_commit_encoding[MAX_ENCODING_LENGTH];
 
 extern int copy_fd(int ifd, int ofd);
+
+/* Finish off pack transfer receiving end */
+extern int receive_unpack_pack(int fd[2], const char *me, int quiet);
+extern int receive_keep_pack(int fd[2], const char *me);
+
 #endif /* CACHE_H */
diff --git a/clone-pack.c b/clone-pack.c
index b5ce5d3..03dbc2e 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
-#include <sys/wait.h>
 
 static const char clone_pack_usage[] =
 "git-clone-pack [--exec=<git-upload-pack>] [<host>:]<directory> [<heads>]*";
@@ -112,139 +111,6 @@ static void write_refs(struct ref *ref)
 	free(head_path);
 }
 
-static int finish_pack(const char *pack_tmp_name)
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
-		die("git-clone-pack: unable to set up pipe");
-
-	strcpy(idx, pack_tmp_name); /* ".git/objects/pack-XXXXXX" */
-	cp = strrchr(idx, '/');
-	memcpy(cp, "/pidx", 5);
-
-	pid = fork();
-	if (pid < 0)
-		die("git-clone-pack: unable to fork off git-index-pack");
-	if (!pid) {
-		close(0);
-		dup2(pipe_fd[1], 1);
-		close(pipe_fd[0]);
-		close(pipe_fd[1]);
-		execlp("git-index-pack","git-index-pack",
-		       "-o", idx, pack_tmp_name, NULL);
-		error("cannot exec git-index-pack <%s> <%s>",
-		      idx, pack_tmp_name);
-		exit(1);
-	}
-	close(pipe_fd[1]);
-	if (read(pipe_fd[0], hash, 40) != 40) {
-		error("git-clone-pack: unable to read from git-index-pack");
-		err = 1;
-	}
-	close(pipe_fd[0]);
-
-	for (;;) {
-		int status, code;
-		int retval = waitpid(pid, &status, 0);
-
-		if (retval < 0) {
-			if (errno == EINTR)
-				continue;
-			error("waitpid failed (%s)", strerror(retval));
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
-
-static int clone_without_unpack(int fd[2])
-{
-	char tmpfile[PATH_MAX];
-	int ofd, ifd;
-
-	ifd = fd[0];
-	snprintf(tmpfile, sizeof(tmpfile),
-		 "%s/pack/tmp-XXXXXX", get_object_directory());
-	ofd = mkstemp(tmpfile);
-	if (ofd < 0)
-		return error("unable to create temporary file %s", tmpfile);
-
-	while (1) {
-		char buf[8192];
-		ssize_t sz, wsz, pos;
-		sz = read(ifd, buf, sizeof(buf));
-		if (sz == 0)
-			break;
-		if (sz < 0) {
-			error("error reading pack (%s)", strerror(errno));
-			close(ofd);
-			unlink(tmpfile);
-			return -1;
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
-	}
-	close(ofd);
-	return finish_pack(tmpfile);
-}
-
 static int clone_pack(int fd[2], int nr_match, char **match)
 {
 	struct ref *refs;
@@ -257,7 +123,7 @@ static int clone_pack(int fd[2], int nr_
 	}
 	clone_handshake(fd, refs);
 
-	status = clone_without_unpack(fd);
+	status = receive_keep_pack(fd, "git-clone-pack");
 
 	if (!status) {
 		if (nr_match == 0)
diff --git a/fetch-clone.c b/fetch-clone.c
new file mode 100644
index 0000000..2b2aa15
--- /dev/null
+++ b/fetch-clone.c
@@ -0,0 +1,172 @@
+#include "cache.h"
+#include <sys/wait.h>
+
+static int finish_pack(const char *pack_tmp_name, const char *me)
+{
+	int pipe_fd[2];
+	pid_t pid;
+	char idx[PATH_MAX];
+	char final[PATH_MAX];
+	char hash[41];
+	unsigned char sha1[20];
+	char *cp;
+	int err = 0;
+
+	if (pipe(pipe_fd) < 0)
+		die("%s: unable to set up pipe", me);
+
+	strcpy(idx, pack_tmp_name); /* ".git/objects/pack-XXXXXX" */
+	cp = strrchr(idx, '/');
+	memcpy(cp, "/pidx", 5);
+
+	pid = fork();
+	if (pid < 0)
+		die("git-clone-pack: unable to fork off git-index-pack");
+	if (!pid) {
+		close(0);
+		dup2(pipe_fd[1], 1);
+		close(pipe_fd[0]);
+		close(pipe_fd[1]);
+		execlp("git-index-pack","git-index-pack",
+		       "-o", idx, pack_tmp_name, NULL);
+		error("cannot exec git-index-pack <%s> <%s>",
+		      idx, pack_tmp_name);
+		exit(1);
+	}
+	close(pipe_fd[1]);
+	if (read(pipe_fd[0], hash, 40) != 40) {
+		error("%s: unable to read from git-index-pack", me);
+		err = 1;
+	}
+	close(pipe_fd[0]);
+
+	for (;;) {
+		int status, code;
+		int retval = waitpid(pid, &status, 0);
+
+		if (retval < 0) {
+			if (errno == EINTR)
+				continue;
+			error("waitpid failed (%s)", strerror(retval));
+			goto error_die;
+		}
+		if (WIFSIGNALED(status)) {
+			int sig = WTERMSIG(status);
+			error("git-index-pack died of signal %d", sig);
+			goto error_die;
+		}
+		if (!WIFEXITED(status)) {
+			error("git-index-pack died of unnatural causes %d",
+			      status);
+			goto error_die;
+		}
+		code = WEXITSTATUS(status);
+		if (code) {
+			error("git-index-pack died with error code %d", code);
+			goto error_die;
+		}
+		if (err)
+			goto error_die;
+		break;
+	}
+	hash[40] = 0;
+	if (get_sha1_hex(hash, sha1)) {
+		error("git-index-pack reported nonsense '%s'", hash);
+		goto error_die;
+	}
+	/* Now we have pack in pack_tmp_name[], and
+	 * idx in idx[]; rename them to their final names.
+	 */
+	snprintf(final, sizeof(final),
+		 "%s/pack/pack-%s.pack", get_object_directory(), hash);
+	move_temp_to_file(pack_tmp_name, final);
+	chmod(final, 0444);
+	snprintf(final, sizeof(final),
+		 "%s/pack/pack-%s.idx", get_object_directory(), hash);
+	move_temp_to_file(idx, final);
+	chmod(final, 0444);
+	return 0;
+
+ error_die:
+	unlink(idx);
+	unlink(pack_tmp_name);
+	exit(1);
+}
+
+int receive_unpack_pack(int fd[2], const char *me, int quiet)
+{
+	int status;
+	pid_t pid;
+
+	pid = fork();
+	if (pid < 0)
+		die("%s: unable to fork off git-unpack-objects", me);
+	if (!pid) {
+		dup2(fd[0], 0);
+		close(fd[0]);
+		close(fd[1]);
+		execlp("git-unpack-objects", "git-unpack-objects",
+		       quiet ? "-q" : NULL, NULL);
+		die("git-unpack-objects exec failed");
+	}
+	close(fd[0]);
+	close(fd[1]);
+	while (waitpid(pid, &status, 0) < 0) {
+		if (errno != EINTR)
+			die("waiting for git-unpack-objects: %s",
+			    strerror(errno));
+	}
+	if (WIFEXITED(status)) {
+		int code = WEXITSTATUS(status);
+		if (code)
+			die("git-unpack-objects died with error code %d",
+			    code);
+		return 0;
+	}
+	if (WIFSIGNALED(status)) {
+		int sig = WTERMSIG(status);
+		die("git-unpack-objects died of signal %d", sig);
+	}
+	die("git-unpack-objects died of unnatural causes %d", status);
+}
+
+int receive_keep_pack(int fd[2], const char *me)
+{
+	char tmpfile[PATH_MAX];
+	int ofd, ifd;
+
+	ifd = fd[0];
+	snprintf(tmpfile, sizeof(tmpfile),
+		 "%s/pack/tmp-XXXXXX", get_object_directory());
+	ofd = mkstemp(tmpfile);
+	if (ofd < 0)
+		return error("unable to create temporary file %s", tmpfile);
+
+	while (1) {
+		char buf[8192];
+		ssize_t sz, wsz, pos;
+		sz = read(ifd, buf, sizeof(buf));
+		if (sz == 0)
+			break;
+		if (sz < 0) {
+			error("error reading pack (%s)", strerror(errno));
+			close(ofd);
+			unlink(tmpfile);
+			return -1;
+		}
+		pos = 0;
+		while (pos < sz) {
+			wsz = write(ofd, buf + pos, sz - pos);
+			if (wsz < 0) {
+				error("error writing pack (%s)",
+				      strerror(errno));
+				close(ofd);
+				unlink(tmpfile);
+				return -1;
+			}
+			pos += wsz;
+		}
+	}
+	close(ofd);
+	return finish_pack(tmpfile, me);
+}
diff --git a/fetch-pack.c b/fetch-pack.c
index 58ba209..2528053 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -3,13 +3,12 @@
 #include "pkt-line.h"
 #include "commit.h"
 #include "tag.h"
-#include <time.h>
-#include <sys/wait.h>
 
+static int keep_pack;
 static int quiet;
 static int verbose;
 static const char fetch_pack_usage[] =
-"git-fetch-pack [-q] [-v] [--exec=upload-pack] [host:]directory <refs>...";
+"git-fetch-pack [-q] [-v] [-k] [--exec=upload-pack] [host:]directory <refs>...";
 static const char *exec = "git-upload-pack";
 
 #define COMPLETE	(1U << 0)
@@ -363,7 +362,6 @@ static int fetch_pack(int fd[2], int nr_
 	struct ref *ref;
 	unsigned char sha1[20];
 	int status;
-	pid_t pid;
 
 	get_remote_heads(fd[0], &ref, 0, NULL, 0);
 	if (server_supports("multi_ack")) {
@@ -381,40 +379,22 @@ static int fetch_pack(int fd[2], int nr_
 	}
 	if (find_common(fd, sha1, ref) < 0)
 		fprintf(stderr, "warning: no common commits\n");
-	pid = fork();
-	if (pid < 0)
-		die("git-fetch-pack: unable to fork off git-unpack-objects");
-	if (!pid) {
-		dup2(fd[0], 0);
-		close(fd[0]);
-		close(fd[1]);
-		execlp("git-unpack-objects", "git-unpack-objects",
-		       quiet ? "-q" : NULL, NULL);
-		die("git-unpack-objects exec failed");
-	}
-	close(fd[0]);
-	close(fd[1]);
-	while (waitpid(pid, &status, 0) < 0) {
-		if (errno != EINTR)
-			die("waiting for git-unpack-objects: %s", strerror(errno));
-	}
-	if (WIFEXITED(status)) {
-		int code = WEXITSTATUS(status);
-		if (code)
-			die("git-unpack-objects died with error code %d", code);
-all_done:
-		while (ref) {
-			printf("%s %s\n",
-			       sha1_to_hex(ref->old_sha1), ref->name);
-			ref = ref->next;
-		}
-		return 0;
-	}
-	if (WIFSIGNALED(status)) {
-		int sig = WTERMSIG(status);
-		die("git-unpack-objects died of signal %d", sig);
+
+	if (keep_pack)
+		status = receive_keep_pack(fd, "git-fetch-pack");
+	else
+		status = receive_unpack_pack(fd, "git-fetch-pack", quiet);
+
+	if (status)
+		die("git-fetch-pack: fetch failed.");
+
+ all_done:
+	while (ref) {
+		printf("%s %s\n",
+		       sha1_to_hex(ref->old_sha1), ref->name);
+		ref = ref->next;
 	}
-	die("Sherlock Holmes! git-unpack-objects died of unnatural causes %d!", status);
+	return 0;
 }
 
 int main(int argc, char **argv)
@@ -440,6 +420,10 @@ int main(int argc, char **argv)
 				quiet = 1;
 				continue;
 			}
+			if (!strcmp("-k", arg)) {
+				keep_pack = 1;
+				continue;
+			}
 			if (!strcmp("-v", arg)) {
 				verbose = 1;
 				continue;
-- 
0.99.9n
