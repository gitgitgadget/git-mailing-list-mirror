From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: clone/fetch/upload.
Date: Thu, 14 Jul 2005 00:08:37 -0700
Message-ID: <7v64vdkgp6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 09:08:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsxpt-000487-7M
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 09:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbVGNHIk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 03:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVGNHIk
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 03:08:40 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:53396 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262932AbVGNHIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 03:08:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714070837.UEYU16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Jul 2005 03:08:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds documentation for 'smarter pull' family of commands.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-clone-pack.txt  |   13 +++++--
 Documentation/git-fetch-pack.txt  |   73 +++++++++++++++++++++++++++++++++++++
 Documentation/git-upload-pack.txt |   40 ++++++++++++++++++++
 fetch-pack.c                      |   11 ++++--
 4 files changed, 130 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/git-fetch-pack.txt
 create mode 100644 Documentation/git-upload-pack.txt

1ac6853af4e4a24eaf7008be9b4e9e033bc624f1
diff --git a/Documentation/git-clone-pack.txt b/Documentation/git-clone-pack.txt
--- a/Documentation/git-clone-pack.txt
+++ b/Documentation/git-clone-pack.txt
@@ -9,7 +9,7 @@ git-clone-pack - Clones a repository by 
 
 SYNOPSIS
 --------
-'git-clone-pack' [-q] [--exec=<git-upload-pack>] [<host>:]<directory> [<heads>...]
+'git-clone-pack' [-q] [--exec=<git-upload-pack>] [<host>:]<directory> [<head>...]
 
 DESCRIPTION
 -----------
@@ -36,10 +36,15 @@ OPTIONS
 	shells by having a lean .bashrc file (they set most of
 	the things up in .bash_profile).
 
-[<host>:]<directory::
-	The (possibly remote) repository to clone from.
+<host>::
+	A remote host that houses the repository.  When this
+	part is specified, 'git-upload-pack' is invoked via
+	ssh.
 
-<heads>...::
+<directory>::
+	The repository to sync from.
+
+<head>...::
 	The heads to update.  This is relative to $GIT_DIR
 	(e.g. "HEAD", "refs/heads/master").  When unspecified,
 	all heads are updated to match the remote repository.
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-fetch-pack.txt
@@ -0,0 +1,73 @@
+git-fetch-pack(1)
+=================
+v0.1, July 2005
+
+NAME
+----
+git-fetch-pack - Receive missing objects from another repository.
+
+
+SYNOPSIS
+--------
+git-fetch-pack [-q] [--exec=<git-upload-pack>] [<host>:]<directory> [<head>...] < <commit-list>
+
+DESCRIPTION
+-----------
+Invokes 'git-upload-pack' on a potentially remote repository,
+and asks it to send objects missing from this repository, to
+update the named heads.  The list of commits available locally
+is fed from the standard input, to be sent to 'git-upload-pack'
+running on the other end.
+
+This command can be used only when the local side has a common
+(ancestor) commit with the remote head that is being pulled
+from.  Use 'git-clone-pack' for that.
+
+
+OPTIONS
+-------
+-q::
+	Pass '-q' flag to 'git-unpack-objects'; this makes the
+	cloning process less verbose.
+
+--exec=<git-upload-pack>::
+	Use this to specify the path to 'git-upload-pack' on the
+	remote side, if is not found on your $PATH.
+	Installations of sshd ignores the user's environment
+	setup scripts for login shells (e.g. .bash_profile) and
+	your privately installed GIT may not be found on the system
+	default $PATH.  Another workaround suggested is to set
+	up your $PATH in ".bashrc", but this flag is for people
+	who do not want to pay the overhead for non-interactive
+	shells by having a lean .bashrc file (they set most of
+	the things up in .bash_profile).
+
+<host>::
+	A remote host that houses the repository.  When this
+	part is specified, 'git-upload-pack' is invoked via
+	ssh.
+
+<directory>::
+	The repository to sync from.
+
+<head>...::
+	The remote heads to update from. This is relative to
+	$GIT_DIR (e.g. "HEAD", "refs/heads/master").  When
+	unspecified, update from all heads the remote side has.
+
+	However the program refuses to work if more than one
+	remote head matches the specified heads.  I am not sure
+	what this means... Help!!!!!
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Junio C Hamano.
+
+GIT
+---
+Part of the link:git.html[git] suite
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-upload-pack.txt
@@ -0,0 +1,40 @@
+git-upload-pack(1)
+==================
+v0.1, July 2005
+
+NAME
+----
+git-upload-pack - Send missing objects packed.
+
+
+SYNOPSIS
+--------
+'git-upload-pack' <directory>
+
+DESCRIPTION
+-----------
+Invoked by 'git-clone-pack' and/or 'git-fetch-pack', learns what
+objects the other side is missing, and sends them after packing.
+
+This command is usually not invoked directly by the end user.
+The UI for the protocol is on the 'git-fetch-pack' side, and the
+program pair is meant to be used to pull updates from a remote
+repository.  For push operations, see 'git-send-pack'.
+
+
+OPTIONS
+-------
+<directory>::
+	The repository to sync from.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Junio C Hamano.
+
+GIT
+---
+Part of the link:git.html[git] suite
diff --git a/fetch-pack.c b/fetch-pack.c
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -3,7 +3,8 @@
 #include "pkt-line.h"
 #include <sys/wait.h>
 
-static const char fetch_pack_usage[] = "git-fetch-pack [host:]directory [heads]* < mycommitlist";
+static int quiet;
+static const char fetch_pack_usage[] = "git-fetch-pack [-q] [--exec=upload-pack] [host:]directory [heads]* < mycommitlist";
 static const char *exec = "git-upload-pack";
 
 static int find_common(int fd[2], unsigned char *result_sha1, unsigned char *remote)
@@ -98,7 +99,8 @@ static int fetch_pack(int fd[2], int nr_
 		dup2(fd[0], 0);
 		close(fd[0]);
 		close(fd[1]);
-		execlp("git-unpack-objects", "git-unpack-objects", NULL);
+		execlp("git-unpack-objects", "git-unpack-objects",
+		       quiet ? "-q" : NULL, NULL);
 		die("git-unpack-objects exec failed");
 	}
 	close(fd[0]);
@@ -134,7 +136,10 @@ int main(int argc, char **argv)
 		char *arg = argv[i];
 
 		if (*arg == '-') {
-			/* Arguments go here */
+			if (!strncmp("--exec=", arg, 7)) {
+				exec = arg + 7;
+				continue;
+			}
 			usage(fetch_pack_usage);
 		}
 		dest = arg;
