From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fetch & clone: do not output progress when not on a tty
Date: Tue, 20 Feb 2007 03:01:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702200259520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Feb 20 03:01:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJKKE-0004H0-AW
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 03:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbXBTCBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 21:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbXBTCBr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 21:01:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:45858 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932306AbXBTCBq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 21:01:46 -0500
Received: (qmail invoked by alias); 20 Feb 2007 02:01:44 -0000
X-Provags-ID: V01U2FsdGVkX19XHkIYBzZXoj7+R4b3iNzWoZz21CiDymInheToKA
	owGA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40198>


This adds the option "--no-progress" to fetch-pack and upload-pack,
and makes fetch and clone pass this option when stdout is not a tty.

While at documenting that option, also document --strict and --timeout
options for upload-pack.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	As promised, this is a working version of the patch I sent out 
	earlier. Another late-night patch. But I tested this, and it seems 
	to work properly.

 Documentation/git-fetch-pack.txt  |    5 ++++-
 Documentation/git-upload-pack.txt |   12 +++++++++++-
 fetch-pack.c                      |   16 +++++++++++++---
 git-clone.sh                      |    6 ++++--
 git-fetch.sh                      |    5 ++++-
 upload-pack.c                     |   24 +++++++++++++++++++-----
 6 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 105d76b..a99a5b3 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -8,7 +8,7 @@ git-fetch-pack - Receive missing objects from another repository
 
 SYNOPSIS
 --------
-'git-fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pack=<git-upload-pack>] [--depth=<n>] [-v] [<host>:]<directory> [<refs>...]
+'git-fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]
 
 DESCRIPTION
 -----------
@@ -63,6 +63,9 @@ OPTIONS
 \--depth=<n>::
 	Limit fetching to ancestor-chains not longer than n.
 
+\--no-progress::
+	Do not show the progress.
+
 \-v::
 	Run verbosely.
 
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 9da062d..c75c86e 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -8,7 +8,7 @@ git-upload-pack - Send objects packed back to git-fetch-pack
 
 SYNOPSIS
 --------
-'git-upload-pack' <directory>
+'git-upload-pack' [--strict] [--timeout=<n>] [--no-progress] <directory>
 
 DESCRIPTION
 -----------
@@ -23,6 +23,16 @@ repository.  For push operations, see 'git-send-pack'.
 
 OPTIONS
 -------
+
+\--strict::
+	Do not try <directory>/.git/ if <directory> is no git directory.
+
+\--timeout=<n>::
+	Interrupt transfer after <n> seconds of inactivity.
+
+\--no-progress::
+	Do not show the progress.
+
 <directory>::
 	The repository to sync from.
 
diff --git a/fetch-pack.c b/fetch-pack.c
index c787106..fc6b4e0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -15,8 +15,9 @@ static int quiet;
 static int verbose;
 static int fetch_all;
 static int depth;
+static int no_progress;
 static const char fetch_pack_usage[] =
-"git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pack=<git-upload-pack>] [--depth=<n>] [-v] [<host>:]<directory> [<refs>...]";
+"git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
 static const char *uploadpack = "git-upload-pack";
 
 #define COMPLETE	(1U << 0)
@@ -521,7 +522,7 @@ static int get_pack(int xd[2])
 	if (do_keep) {
 		*av++ = "index-pack";
 		*av++ = "--stdin";
-		if (!quiet)
+		if (!quiet && !no_progress)
 			*av++ = "-v";
 		if (use_thin_pack)
 			*av++ = "--fix-thin";
@@ -718,6 +719,10 @@ int main(int argc, char **argv)
 					st.st_mtime = 0;
 				continue;
 			}
+			if (!strcmp("--no-progress", arg)) {
+				no_progress = 1;
+				continue;
+			}
 			usage(fetch_pack_usage);
 		}
 		dest = arg;
@@ -727,7 +732,12 @@ int main(int argc, char **argv)
 	}
 	if (!dest)
 		usage(fetch_pack_usage);
-	pid = git_connect(fd, dest, uploadpack);
+	if (no_progress) {
+		char buf[256];
+		snprintf(buf, sizeof(buf), "%s --no-progress", uploadpack);
+		pid = git_connect(fd, dest, buf);
+	} else
+		pid = git_connect(fd, dest, uploadpack);
 	if (pid < 0)
 		return 1;
 	if (heads && nr_heads)
diff --git a/git-clone.sh b/git-clone.sh
index 1bd54de..86890ea 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -79,6 +79,8 @@ origin=
 origin_override=
 use_separate_remote=t
 depth=
+no_progress=
+test -t 1 || no_progress=--no-progress
 while
 	case "$#,$1" in
 	0,*) break ;;
@@ -290,8 +292,8 @@ yes,yes)
 		;;
 	*)
 		case "$upload_pack" in
-		'') git-fetch-pack --all -k $quiet $depth "$repo" ;;
-		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth "$repo" ;;
+		'') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
+		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress "$repo" ;;
 		esac >"$GIT_DIR/CLONE_HEAD" ||
 			die "fetch-pack from '$repo' failed."
 		;;
diff --git a/git-fetch.sh b/git-fetch.sh
index d230995..5d3fec0 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -24,6 +24,8 @@ update_head_ok=
 exec=
 keep=
 shallow_depth=
+no_progress=
+test -t 1 || no_progress=--no-progress
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -386,7 +388,8 @@ fetch_main () {
     ( : subshell because we muck with IFS
       IFS=" 	$LF"
       (
-	  git-fetch-pack --thin $exec $keep $shallow_depth "$remote" $rref ||
+	  git-fetch-pack --thin $exec $keep $shallow_depth $no_progress \
+		"$remote" $rref ||
 	  echo failed "$remote"
       ) |
       (
diff --git a/upload-pack.c b/upload-pack.c
index 3648aae..4eb21cf 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,7 +10,7 @@
 #include "revision.h"
 #include "list-objects.h"
 
-static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
+static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] [--no-progress] <dir>";
 
 /* bits #0..7 in revision.h, #8..10 in commit.c */
 #define THEY_HAVE	(1u << 11)
@@ -26,7 +26,7 @@ static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=n
 static unsigned long oldest_have;
 
 static int multi_ack, nr_our_refs;
-static int use_thin_pack, use_ofs_delta;
+static int use_thin_pack, use_ofs_delta, no_progress;
 static struct object_array have_obj;
 static struct object_array want_obj;
 static unsigned int timeout;
@@ -164,6 +164,9 @@ static void create_pack_file(void)
 		die("git-upload-pack: unable to fork git-pack-objects");
 	}
 	if (!pid_pack_objects) {
+		char *argv[10];
+		int i = 0;
+
 		dup2(lp_pipe[0], 0);
 		dup2(pu_pipe[1], 1);
 		dup2(pe_pipe[1], 2);
@@ -174,9 +177,16 @@ static void create_pack_file(void)
 		close(pu_pipe[1]);
 		close(pe_pipe[0]);
 		close(pe_pipe[1]);
-		execl_git_cmd("pack-objects", "--stdout", "--progress",
-			      use_ofs_delta ? "--delta-base-offset" : NULL,
-			      NULL);
+
+		argv[i++] = "pack-objects";
+		argv[i++] = "--stdout";
+		if (!no_progress)
+			argv[i++] = "--progress";
+		if (use_ofs_delta)
+			argv[i++] = "--delta-base-offset";
+		argv[i++] = NULL;
+
+		execv_git_cmd(argv);
 		kill(pid_rev_list, SIGKILL);
 		die("git-upload-pack: unable to exec git-pack-objects");
 	}
@@ -660,6 +670,10 @@ int main(int argc, char **argv)
 			timeout = atoi(arg+10);
 			continue;
 		}
+		if (!strcmp(arg, "--no-progress")) {
+			no_progress = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			i++;
 			break;
-- 
1.5.0.1.2140.gcfff-dirty
