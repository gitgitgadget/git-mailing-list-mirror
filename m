From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fetch-pack: start multi-head pulling.
Date: Fri, 12 Aug 2005 02:41:38 -0700
Message-ID: <7vwtmr4hm5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 11:42:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3W2s-0005da-9A
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 11:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVHLJll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 05:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVHLJlk
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 05:41:40 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:20444 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750955AbVHLJlk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 05:41:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812094139.QLKI19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 05:41:39 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a beginning of resurrecting the multi-head pulling support
for git-fetch-pack command.  The git-fetch-script wrapper still
only knows about fetching a single head, without renaming, so it is
not very useful unless you directly call git-fetch-pack itself yet.

It also fixes a longstanding obsolete description of how the command
discovers the list of local commits.
---

Linus, I need a bit of guidance from you about this one; an
ancient commit 4f7770c87ce3c302e1639a7737a6d2531fe4b160 removed
the multi-head support fetch-pack once had, labelling it as "a
misguided attempt", and I would like to know if I am making the
same misguided attempt again.  This update actually makes
clone-pack almost redundant.


 Documentation/git-fetch-pack.txt |   18 +++++-------
 fetch-pack.c                     |   56 +++++++++++++++++++++++++++-----------
 git-fetch-script                 |    4 +++
 3 files changed, 51 insertions(+), 27 deletions(-)

880df673e412bae9603782833d8a80a7c7c59769
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -9,19 +9,19 @@ git-fetch-pack - Receive missing objects
 
 SYNOPSIS
 --------
-git-fetch-pack [-q] [--exec=<git-upload-pack>] [<host>:]<directory> [<head>...] < <commit-list>
+git-fetch-pack [-q] [--exec=<git-upload-pack>] [<host>:]<directory> [<refs>...]
 
 DESCRIPTION
 -----------
 Invokes 'git-upload-pack' on a potentially remote repository,
 and asks it to send objects missing from this repository, to
 update the named heads.  The list of commits available locally
-is fed from the standard input, to be sent to 'git-upload-pack'
-running on the other end.
+is found out by scanning local $GIT_DIR/refs/ and sent to
+'git-upload-pack' running on the other end.
 
-This command can be used only when the local side has a common
-(ancestor) commit with the remote head that is being pulled
-from.  Use 'git-clone-pack' for that.
+This command degenerates to download everything to complete the
+asked refs from the remote side when the local side does not
+have a common ancestor commit.
 
 
 OPTIONS
@@ -50,15 +50,11 @@ OPTIONS
 <directory>::
 	The repository to sync from.
 
-<head>...::
+<refs>...::
 	The remote heads to update from. This is relative to
 	$GIT_DIR (e.g. "HEAD", "refs/heads/master").  When
 	unspecified, update from all heads the remote side has.
 
-	However the program refuses to work if more than one
-	remote head matches the specified heads.  I am not sure
-	what this means... Help!!!!!
-
 
 Author
 ------
diff --git a/fetch-pack.c b/fetch-pack.c
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -4,10 +4,13 @@
 #include <sys/wait.h>
 
 static int quiet;
-static const char fetch_pack_usage[] = "git-fetch-pack [-q] [--exec=upload-pack] [host:]directory [heads]* < mycommitlist";
+static int verbose;
+static const char fetch_pack_usage[] =
+"git-fetch-pack [-q] [-v] [--exec=upload-pack] [host:]directory <refs>...";
 static const char *exec = "git-upload-pack";
 
-static int find_common(int fd[2], unsigned char *result_sha1, unsigned char *remote)
+static int find_common(int fd[2], unsigned char *result_sha1,
+		       struct ref *refs)
 {
 	static char line[1000];
 	int count = 0, flushes = 0, retval;
@@ -16,7 +19,16 @@ static int find_common(int fd[2], unsign
 	revs = popen("git-rev-list $(git-rev-parse --all)", "r");
 	if (!revs)
 		die("unable to run 'git-rev-list'");
-	packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
+
+	while (refs) {
+		unsigned char *remote = refs->old_sha1;
+		if (verbose)
+			fprintf(stderr,
+				"want %s (%s)\n", sha1_to_hex(remote),
+				refs->name);
+		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
+		refs = refs->next;
+	}
 	packet_flush(fd[1]);
 	flushes = 1;
 	retval = -1;
@@ -25,6 +37,8 @@ static int find_common(int fd[2], unsign
 		if (get_sha1_hex(line, sha1))
 			die("git-fetch-pack: expected object name, got crud");
 		packet_write(fd[1], "have %s\n", sha1_to_hex(sha1));
+		if (verbose)
+			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
 		if (!(31 & ++count)) {
 			packet_flush(fd[1]);
 			flushes++;
@@ -38,6 +52,8 @@ static int find_common(int fd[2], unsign
 			if (get_ack(fd[0], result_sha1)) {
 				flushes = 0;
 				retval = 0;
+				if (verbose)
+					fprintf(stderr, "got ack\n");
 				break;
 			}
 			flushes--;
@@ -45,19 +61,19 @@ static int find_common(int fd[2], unsign
 	}
 	pclose(revs);
 	packet_write(fd[1], "done\n");
+	if (verbose)
+		fprintf(stderr, "done\n");
 	while (flushes) {
 		flushes--;
-		if (get_ack(fd[0], result_sha1))
+		if (get_ack(fd[0], result_sha1)) {
+			if (verbose)
+				fprintf(stderr, "got ack\n");
 			return 0;
+		}
 	}
 	return retval;
 }
 
-/*
- * Eventually we'll want to be able to fetch multiple heads.
- *
- * Right now we'll just require a single match.
- */
 static int fetch_pack(int fd[2], int nr_match, char **match)
 {
 	struct ref *ref;
@@ -70,12 +86,8 @@ static int fetch_pack(int fd[2], int nr_
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	if (ref->next) {
-		packet_flush(fd[1]);
-		die("multiple remote heads");
-	}
-	if (find_common(fd, sha1, ref->old_sha1) < 0)
-		die("git-fetch-pack: no common commits");
+	if (find_common(fd, sha1, ref) < 0)
+		fprintf(stderr, "warning: no common commits\n");
 	pid = fork();
 	if (pid < 0)
 		die("git-fetch-pack: unable to fork off git-unpack-objects");
@@ -97,7 +109,11 @@ static int fetch_pack(int fd[2], int nr_
 		int code = WEXITSTATUS(status);
 		if (code)
 			die("git-unpack-objects died with error code %d", code);
-		puts(sha1_to_hex(ref->old_sha1));
+		while (ref) {
+			printf("%s %s\n",
+			       sha1_to_hex(ref->old_sha1), ref->name);
+			ref = ref->next;
+		}
 		return 0;
 	}
 	if (WIFSIGNALED(status)) {
@@ -124,6 +140,14 @@ int main(int argc, char **argv)
 				exec = arg + 7;
 				continue;
 			}
+			if (!strcmp("-q", arg)) {
+				quiet = 1;
+				continue;
+			}
+			if (!strcmp("-v", arg)) {
+				verbose = 1;
+				continue;
+			}
 			usage(fetch_pack_usage);
 		}
 		dest = arg;
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -31,6 +31,10 @@ rsync://*)
 	;;
 *)
 	head=$(git-fetch-pack "$merge_repo" "$merge_head")
+	if h=`expr "$head" : '\([^ ][^ ]*\) '`
+	then
+	    head=$h
+	fi
 	;;
 esac || exit 1
 
