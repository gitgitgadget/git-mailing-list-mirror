X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 6/6] remove .keep pack lock files when done with refs update
Date: Wed, 01 Nov 2006 17:06:25 -0500
Message-ID: <11624187883225-git-send-email-nico@cam.org>
References: <11624187853116-git-send-email-nico@cam.org>
 <11624187853865-git-send-email-nico@cam.org>
 <1162418786895-git-send-email-nico@cam.org>
 <1162418786390-git-send-email-nico@cam.org>
 <11624187871572-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 1 Nov 2006 22:06:59 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <11624187871572-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.4.3.3.g87b2-dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30666>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfOEP-0005ag-Tr for gcvg-git@gmane.org; Wed, 01 Nov
 2006 23:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752511AbWKAWGe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 17:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbWKAWGe
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 17:06:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63137 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1752511AbWKAWG3
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 17:06:29 -0500
Received: from localhost.localdomain ([74.56.106.175]) by
 VL-MH-MR002.ip.videotron.ca (Sun Java System Messaging Server 6.2-2.05 (built
 Apr 28 2005)) with ESMTP id <0J8200BN9O2PMF20@VL-MH-MR002.ip.videotron.ca>
 for git@vger.kernel.org; Wed, 01 Nov 2006 17:06:28 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This makes both git-fetch and git-push (fetch-pack and receive-pack)
safe against a possible race with aparallel git-repack -a -d that could
prune the new pack while it is not yet referenced, and remove the .keep
file after refs have been updated.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Documentation/git-index-pack.txt |   11 ++++
 git-fetch.sh                     |   10 ++++-
 index-pack.c                     |   38 +++++++++------
 receive-pack.c                   |   96 +++++++++++++++++++++++++++++---------
 4 files changed, 116 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 1235416..2229ee8 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -69,6 +69,17 @@ OPTIONS
 	locate any which have outlived their usefulness.
 
 
+Note
+----
+
+Once the index has been created, the list of object names is sorted
+and the SHA1 hash of that list is printed to stdout. If --stdin was
+also used then this is prefixed by either "pack\t", or "keep\t" if a
+new .keep file was successfully created. This is useful to remove a
+.keep file used as a lock to prevent the race with gitlink:git-repack[1]
+mentioned above.
+
+
 Author
 ------
 Written by Sergey Vlasov <vsu@altlinux.ru>
diff --git a/git-fetch.sh b/git-fetch.sh
index 2b5538f..e8ce296 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -51,7 +51,7 @@ do
 		verbose=Yes
 		;;
 	-k|--k|--ke|--kee|--keep)
-		keep=--keep
+		keep=-k -k
 		;;
 	--reflog-action=*)
 		rloga=`expr "z$1" : 'z-[^=]*=\(.*\)'`
@@ -368,6 +368,7 @@ fetch_main () {
       ;; # we are already done.
   *)
     ( : subshell because we muck with IFS
+      pack_lockfile=
       IFS=" 	$LF"
       (
 	  git-fetch-pack --thin $exec $keep "$remote" $rref || echo failed "$remote"
@@ -378,6 +379,12 @@ fetch_main () {
 	  failed)
 		  echo >&2 "Fetch failure: $remote"
 		  exit 1 ;;
+	  # special line coming from index-pack with the pack name
+	  pack)
+		  continue ;;
+	  keep)
+		  pack_lockfile="$GIT_OBJECT_DIRECTORY/pack/pack-$remote_name.keep"
+		  continue ;;
 	  esac
 	  found=
 	  single_force=
@@ -408,6 +415,7 @@ fetch_main () {
 	  append_fetch_head "$sha1" "$remote" \
 		  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
       done
+      if [ "$pack_lockfile" ]; then rm -f "$pack_lockfile"; fi
     ) || exit ;;
   esac
 
diff --git a/index-pack.c b/index-pack.c
index 8d64a88..042aea8 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -757,6 +757,7 @@ static void final(const char *final_pack
 		  const char *keep_name, const char *keep_msg,
 		  unsigned char *sha1)
 {
+	char *report = "pack";
 	char name[PATH_MAX];
 	int err;
 
@@ -767,18 +768,6 @@ static void final(const char *final_pack
 		if (err)
 			die("error while closing pack file: %s", strerror(errno));
 		chmod(curr_pack_name, 0444);
-
-		/*
-		 * Let's just mimic git-unpack-objects here and write
-		 * the last part of the buffer to stdout.
-		 */
-		while (input_len) {
-			err = xwrite(1, input_buffer + input_offset, input_len);
-			if (err <= 0)
-				break;
-			input_len -= err;
-			input_offset += err;
-		}
 	}
 
 	if (keep_msg) {
@@ -798,6 +787,7 @@ static void final(const char *final_pack
 				write_or_die(keep_fd, "\n", 1);
 			}
 			close(keep_fd);
+			report = "keep";
 		}
 	}
 
@@ -821,6 +811,27 @@ static void final(const char *final_pack
 		if (move_temp_to_file(curr_index_name, final_index_name))
 			die("cannot store index file");
 	}
+
+	if (!from_stdin) {
+		printf("%s\n", sha1_to_hex(sha1));
+	} else {
+		char buf[48];
+		int len = snprintf(buf, sizeof(buf), "%s\t%s\n",
+				   report, sha1_to_hex(sha1));
+		xwrite(1, buf, len);
+
+		/*
+		 * Let's just mimic git-unpack-objects here and write
+		 * the last part of the input buffer to stdout.
+		 */
+		while (input_len) {
+			err = xwrite(1, input_buffer + input_offset, input_len);
+			if (err <= 0)
+				break;
+			input_len -= err;
+			input_offset += err;
+		}
+	}
 }
 
 int main(int argc, char **argv)
@@ -937,8 +948,5 @@ int main(int argc, char **argv)
 	free(index_name_buf);
 	free(keep_name_buf);
 
-	if (!from_stdin)
-		printf("%s\n", sha1_to_hex(sha1));
-
 	return 0;
 }
diff --git a/receive-pack.c b/receive-pack.c
index be4c3fb..8bb5683 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -3,8 +3,10 @@
 #include "refs.h"
 #include "pkt-line.h"
 #include "run-command.h"
+#include "exec_cmd.h"
 #include "commit.h"
 #include "object.h"
+#include <sys/wait.h>
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
@@ -251,12 +253,13 @@ static const char *parse_pack_header(str
 	return NULL;
 }
 
+static const char *pack_lockfile;
+
 static const char *unpack(void)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
 	char hdr_arg[38];
-	int code;
 
 	hdr_err = parse_pack_header(&hdr);
 	if (hdr_err)
@@ -265,33 +268,13 @@ static const char *unpack(void)
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
 
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
+		int code;
 		const char *unpacker[3];
 		unpacker[0] = "unpack-objects";
 		unpacker[1] = hdr_arg;
 		unpacker[2] = NULL;
 		code = run_command_v_opt(1, unpacker, RUN_GIT_CMD);
-	} else {
-		const char *keeper[6];
-		char my_host[255], keep_arg[128 + 255];
-
-		if (gethostname(my_host, sizeof(my_host)))
-			strcpy(my_host, "localhost");
-		snprintf(keep_arg, sizeof(keep_arg),
-				"--keep=receive-pack %i on %s",
-				getpid(), my_host);
-
-		keeper[0] = "index-pack";
-		keeper[1] = "--stdin";
-		keeper[2] = "--fix-thin";
-		keeper[3] = hdr_arg;
-		keeper[4] = keep_arg;
-		keeper[5] = NULL;
-		code = run_command_v_opt(1, keeper, RUN_GIT_CMD);
-		if (!code)
-			reprepare_packed_git();
-	}
-
-	switch (code) {
+		switch (code) {
 		case 0:
 			return NULL;
 		case -ERR_RUN_COMMAND_FORK:
@@ -308,6 +291,71 @@ static const char *unpack(void)
 			return "unpacker died strangely";
 		default:
 			return "unpacker exited with error code";
+		}
+	} else {
+		const char *keeper[6];
+		int fd[2], s, len, status;
+		pid_t pid;
+		char keep_arg[256];
+		char packname[46];
+
+		s = sprintf(keep_arg, "--keep=receive-pack %i on ", getpid());
+		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
+			strcpy(keep_arg + s, "localhost");
+
+		keeper[0] = "index-pack";
+		keeper[1] = "--stdin";
+		keeper[2] = "--fix-thin";
+		keeper[3] = hdr_arg;
+		keeper[4] = keep_arg;
+		keeper[5] = NULL;
+
+		if (pipe(fd) < 0)
+			return "index-pack pipe failed";
+		pid = fork();
+		if (pid < 0)
+			return "index-pack fork failed";
+		if (!pid) {
+			dup2(fd[1], 1);
+			close(fd[1]);
+			close(fd[0]);
+			execv_git_cmd(keeper);
+			die("execv of index-pack failed");
+		}
+		close(fd[1]);
+
+		/*
+		 * The first thing we expects from index-pack's output
+		 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
+		 * %40s is the newly created pack SHA1 name.  In the "keep"
+		 * case, we need it to remove the corresponding .keep file
+		 * later on.  If we don't get that then tough luck with it.
+		 */
+		for (len = 0;
+		     len < 46 && (s = xread(fd[0], packname+len, 46-len)) > 0;
+		     len += s);
+		close(fd[0]);
+		if (len == 46 && packname[45] == '\n' &&
+		    memcmp(packname, "keep\t", 5) == 0) {
+			char path[PATH_MAX];
+			packname[45] = 0;
+			snprintf(path, sizeof(path), "%s/pack/pack-%s.keep",
+				 get_object_directory(), packname + 5);
+			pack_lockfile = xstrdup(path);
+		}
+
+		/* Then wrap our index-pack process. */
+		while (waitpid(pid, &status, 0) < 0)
+			if (errno != EINTR)
+				return "waitpid failed";
+		if (WIFEXITED(status)) {
+			int code = WEXITSTATUS(status);
+			if (code)
+				return "index-pack exited with error code";
+			reprepare_packed_git();
+			return NULL;
+		}
+		return "index-pack abnormal exit";
 	}
 }
 
@@ -363,6 +411,8 @@ int main(int argc, char **argv)
 		const char *unpack_status = unpack();
 		if (!unpack_status)
 			execute_commands();
+		if (pack_lockfile)
+			unlink(pack_lockfile);
 		if (report_status)
 			report(unpack_status);
 	}
-- 
1.4.3.3.g87b2-dirty
