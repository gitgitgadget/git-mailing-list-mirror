From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] clone-pack and clone-script: documentation and add a missing parameter.
Date: Wed, 13 Jul 2005 20:25:54 -0700
Message-ID: <7vhdeykr0d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 05:26:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsuMS-00083O-Ke
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 05:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbVGNDZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 23:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbVGNDZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 23:25:58 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39331 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262880AbVGNDZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 23:25:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714032553.OVLL19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 23:25:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

While adding the documentation for these two commands, I noticed
that the name of the program on the other end (git-upload-pack)
is already almost configurable but git-clone-pack lacked command
line parameter parsing to actually use anything but default, so
I introduced --exec= like other remote commands while I was at it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-clone-pack.txt   |   60 ++++++++++++++++++++++++++++++++++++
 Documentation/git-clone-script.txt |   60 ++++++++++++++++++++++++++++++++++++
 Documentation/git.txt              |    7 ++++
 clone-pack.c                       |    6 +++-
 git-clone-script                   |   12 ++++++-
 5 files changed, 142 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/git-clone-pack.txt
 create mode 100644 Documentation/git-clone-script.txt

7fffcd07cc6e81c0e50ee4d0f0d32d1aadb243c6
diff --git a/Documentation/git-clone-pack.txt b/Documentation/git-clone-pack.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-clone-pack.txt
@@ -0,0 +1,60 @@
+git-clone-pack(1)
+=================
+v0.1, July 2005
+
+NAME
+----
+git-clone-pack - Clones a repository by receiving packed objects.
+
+
+SYNOPSIS
+--------
+'git-clone-pack' [-q] [--exec=<git-upload-pack>] [<host>:]<directory> [<heads>...]
+
+DESCRIPTION
+-----------
+Clones a repository into the current repository by invoking
+'git-upload-pack', possibly on the remote host via ssh, in
+the named repository, and invoking 'git-unpack-objects' locally
+to receive the pack.
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
+[<host>:]<directory::
+	The (possibly remote) repository to clone from.
+
+<heads>...::
+	The heads to update.  This is relative to $GIT_DIR
+	(e.g. "HEAD", "refs/heads/master").  When unspecified,
+	all heads are updated to match the remote repository.
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
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-clone-script.txt b/Documentation/git-clone-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-clone-script.txt
@@ -0,0 +1,60 @@
+git-clone-script(1)
+===================
+v0.1, July 2005
+
+NAME
+----
+git-clone-script - Clones a repository.
+
+
+SYNOPSIS
+--------
+'git clone' [-l] [-u <upload-pack>] [-q] <repository> <directory>
+
+DESCRIPTION
+-----------
+Clones a repository into a newly created directory.
+
+OPTIONS
+-------
+-l::
+	When the repository to clone from is on a local machine,
+	this flag bypasses normal "git aware" transport
+	mechanism and clones the repository by making a copy of
+	HEAD and everything under objects and refs directories.
+	The files under .git/objects/ directory are hardlinked
+	to save space when possible.
+
+-q::
+	Operate quietly.  This flag is passed to "rsync" and
+	"git-clone-pack" commands when given.
+
+-u <upload-pack>::
+	When given, and the repository to clone from is handled
+	by 'git-clone-pack', '--exec=<upload-pack>' is passed to
+	the command to specify non-default path for the command
+	run on the other end.
+
+<repository>::
+	The (possibly remote) repository to clone from.  It can
+	be an "rsync://host/dir" URL, an "http://host/dir" URL,
+	or [<host>:]/dir notation that is used by 'git-clone-pack'.
+	Currently http transport is not supported.
+
+<directory>::
+	The name of a new directory to be cloned into.  It is an
+	error to specify an existing directory.
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Junio C Hamano.
+
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -127,6 +127,13 @@ link:git-apply-patch-script.html[git-app
 link:git-convert-cache.html[git-convert-cache]::
 	Converts old-style GIT repository
 
+link:git-clone-script.html[git-clone-script]::
+	Clones a repository into the current repository (user interface)
+
+link:git-clone-pack.html[git-clone-pack]::
+	Clones a repository into the current repository (engine
+	for ssh and local transport)
+
 link:git-http-pull.html[git-http-pull]::
 	Downloads a remote GIT repository via HTTP
 
diff --git a/clone-pack.c b/clone-pack.c
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -4,7 +4,7 @@
 #include <sys/wait.h>
 
 static int quiet;
-static const char clone_pack_usage[] = "git-clone-pack [host:]directory [heads]*";
+static const char clone_pack_usage[] = "git-clone-pack [-q] [--exec=<git-upload-pack>] [<host>:]<directory> [<heads>]*";
 static const char *exec = "git-upload-pack";
 
 struct ref {
@@ -196,6 +196,10 @@ int main(int argc, char **argv)
 				quiet = 1;
 				continue;
 			}
+			if (!strncmp("--exec=", arg, 7)) {
+				exec = arg + 7;
+				continue;
+			}
 			usage(clone_pack_usage);
 		}
 		dest = arg;
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -6,7 +6,7 @@
 # Clone a repository into a different directory that does not yet exist.
 
 usage() {
-	echo >&2 "* git clone [-l] <repo> <dir>"
+	echo >&2 "* git clone [-l] [-q] [-u <upload-pack>] <repo> <dir>"
 	exit 1
 }
 
@@ -16,11 +16,16 @@ get_repo_base() {
 
 quiet=
 use_local=no
+upload_pack=
 while
 	case "$#,$1" in
 	0,*) break ;;
         *,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
 	*,-q|*,--quiet) quiet=-q ;;
+	1,-u|*,--upload-pack) usage ;;
+	*,-u|*,--upload-pack)
+		shift
+		upload_pack="--exec=$2" ;;
 	*,-*) usage ;;
 	*) break ;;
 	esac
@@ -90,6 +95,9 @@ http://*)
 	exit 1
 	;;
 *)
-	cd "$D" && git-clone-pack $quiet "$repo"
+	cd "$D" && case "$upload_pack" in
+	'') git-clone-pack $quiet "$repo" ;;
+	*) git-clone-pack $quiet "$upload_pack" "$repo" ;;
+	esac
 	;;
 esac
