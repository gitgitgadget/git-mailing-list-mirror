X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/5] allow cloning a repository "shallowly"
Date: Mon, 30 Oct 2006 20:09:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0610302009160.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 30 Oct 2006 19:22:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30511>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GecWj-0006Cp-2F for gcvg-git@gmane.org; Mon, 30 Oct
 2006 20:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161463AbWJ3TJn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 14:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbWJ3TJn
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 14:09:43 -0500
Received: from mail.gmx.de ([213.165.64.20]:16798 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1161433AbWJ3TJm (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 14:09:42 -0500
Received: (qmail invoked by alias); 30 Oct 2006 19:09:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp045) with SMTP; 30 Oct 2006 20:09:36 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


By specifying a depth, you can now clone a repository such that
all fetched ancestor-chains' length is at most "depth". For example,
if the upstream repository has only 2 branches ("A" and "B"), which
are linear, and you specify depth 3, you will get A, A~1, A~2, A~3,
B, B~1, B~2, and B~3. The ends are automatically made shallow
commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fetch-pack.c  |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 git-clone.sh  |   19 +++++++++++++++--
 upload-pack.c |   21 ++++++++++++++++++-
 3 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 488adc9..9619d6e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -8,8 +8,9 @@ static int keep_pack;
 static int quiet;
 static int verbose;
 static int fetch_all;
+static int depth;
 static const char fetch_pack_usage[] =
-"git-fetch-pack [--all] [-q] [-v] [-k] [--thin] [--exec=upload-pack] [host:]directory <refs>...";
+"git-fetch-pack [--all] [-q] [-v] [-k] [--thin] [--exec=upload-pack] [--depth=<n>] [host:]directory <refs>...";
 static const char *exec = "git-upload-pack";
 
 #define COMPLETE	(1U << 0)
@@ -179,10 +180,29 @@ static int find_common(int fd[2], unsign
 	}
 	if (is_repository_shallow())
 		write_shallow_commits(fd[1], 1);
+	if (depth > 0)
+		packet_write(fd[1], "deepen %d", depth);
 	packet_flush(fd[1]);
 	if (!fetching)
 		return 1;
 
+	if (depth >  0) {
+		char line[1024];
+		unsigned char sha1[20];
+		int len;
+
+		while ((len = packet_read_line(fd[0], line, sizeof(line)))) {
+			if (!strncmp("shallow ", line, 8)) {
+				if (get_sha1_hex(line + 8, sha1))
+					die("invalid shallow line: %s", line);
+				/* no need making it shallow if we have it already */
+				if (lookup_object(sha1))
+					continue;
+				register_shallow(sha1);
+			}
+		}
+	}
+
 	flushes = 0;
 	retval = -1;
 	while ((sha1 = get_rev())) {
@@ -480,6 +500,8 @@ int main(int argc, char **argv)
 	char *dest = NULL, **heads;
 	int fd[2];
 	pid_t pid;
+	struct stat st;
+	struct lock_file lock;
 
 	setup_git_directory();
 
@@ -513,6 +535,12 @@ int main(int argc, char **argv)
 				verbose = 1;
 				continue;
 			}
+			if (!strncmp("--depth=", arg, 8)) {
+				depth = strtol(arg + 8, NULL, 0);
+				if (stat(git_path("shallow"), &st))
+					st.st_mtime = 0;
+				continue;
+			}
 			usage(fetch_pack_usage);
 		}
 		dest = arg;
@@ -522,6 +550,8 @@ int main(int argc, char **argv)
 	}
 	if (!dest)
 		usage(fetch_pack_usage);
+	if (is_repository_shallow() && depth > 0)
+		die("Deepening of a shallow repository not yet supported!");
 	pid = git_connect(fd, dest, exec);
 	if (pid < 0)
 		return 1;
@@ -543,5 +573,34 @@ int main(int argc, char **argv)
 			}
 	}
 
+	if (!ret && depth > 0) {
+		struct cache_time mtime;
+		char *shallow = git_path("shallow");
+		int fd;
+
+		mtime.sec = st.st_mtime;
+#ifdef USE_NSEC
+		mtime.usec = st.st_mtim.usec;
+#endif
+		if (stat(shallow, &st)) {
+			if (mtime.sec)
+				die("shallow file was removed during fetch");
+		} else if (st.st_mtime != mtime.sec
+#ifdef USE_NSEC
+				|| st.st_mtim.usec != mtime.usec
+#endif
+			  )
+			die("shallow file was changed during fetch");
+
+		fd = hold_lock_file_for_update(&lock, shallow, 1);
+		if (!write_shallow_commits(fd, 0)) {
+			unlink(lock.filename);
+			rollback_lock_file(&lock);
+		} else {
+			close(fd);
+			commit_lock_file(&lock);
+		}
+	}
+
 	return !!ret;
 }
diff --git a/git-clone.sh b/git-clone.sh
index 3f006d1..595c070 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -116,6 +116,7 @@ reference=
 origin=
 origin_override=
 use_separate_remote=
+depth=
 while
 	case "$#,$1" in
 	0,*) break ;;
@@ -158,6 +159,10 @@ while
 	*,-u|*,--upload-pack)
 		shift
 		upload_pack="--exec=$1" ;;
+	1,--depth) usage;;
+	*,--depth)
+		shift
+		depth="--depth=$1";;
 	*,-*) usage ;;
 	*) break ;;
 	esac
@@ -265,6 +270,10 @@ yes,yes)
 *)
 	case "$repo" in
 	rsync://*)
+		case "$depth" in
+		"") ;;
+		*) die "shallow over rsync not supported" ;;
+		esac
 		rsync $quiet -av --ignore-existing  \
 			--exclude info "$repo/objects/" "$GIT_DIR/objects/" ||
 		exit
@@ -293,6 +302,10 @@ yes,yes)
 		git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
 		;;
 	https://*|http://*|ftp://*)
+		case "$depth" in
+		"") ;;
+		*) die "shallow over http or ftp not supported" ;;
+		esac
 		if test -z "@@NO_CURL@@"
 		then
 			clone_dumb_http "$repo" "$D"
@@ -302,8 +315,8 @@ yes,yes)
 		;;
 	*)
 		case "$upload_pack" in
-		'') git-fetch-pack --all -k $quiet "$repo" ;;
-		*) git-fetch-pack --all -k $quiet "$upload_pack" "$repo" ;;
+		'') git-fetch-pack --all -k $quiet $depth "$repo" ;;
+		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth "$repo" ;;
 		esac >"$GIT_DIR/CLONE_HEAD" ||
 			die "fetch-pack from '$repo' failed."
 		;;
diff --git a/upload-pack.c b/upload-pack.c
index 8dd6121..ebe1e5a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -488,7 +488,7 @@ static void receive_needs(void)
 {
 	struct object_array shallows = {0, 0, NULL};
 	static char line[1000];
-	int len;
+	int len, depth = 0;
 
 	for (;;) {
 		struct object *o;
@@ -509,6 +509,13 @@ static void receive_needs(void)
 			add_object_array(object, NULL, &shallows);
 			continue;
 		}
+		if (!strncmp("deepen ", line, 7)) {
+			char *end;
+			depth = strtol(line + 7, &end, 0);
+			if (end == line + 7 || depth <= 0)
+				die("Invalid deepen: %s", line);
+			continue;
+		}
 		if (strncmp("want ", line, 5) ||
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git-upload-pack: protocol error, "
@@ -540,6 +547,18 @@ static void receive_needs(void)
 			add_object_array(o, NULL, &want_obj);
 		}
 	}
+	if (depth > 0) {
+		struct commit_list *result, *backup;
+		if (shallows.nr > 0)
+			die("Deepening a shallow repository not yet supported");
+		backup = result = get_shallow_commits(&want_obj, depth);
+		while (result) {
+			packet_write(1, "shallow %s",
+					sha1_to_hex(result->item->object.sha1));
+			result = result->next;
+		}
+		free_commit_list(backup);
+	}
 	if (shallows.nr > 0) {
 		int i;
 		for (i = 0; i < shallows.nr; i++)
-- 
1.4.3.3.gca42
