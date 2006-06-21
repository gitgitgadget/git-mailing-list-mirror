From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] Retire git-clone-pack
Date: Wed, 21 Jun 2006 01:14:07 -0700
Message-ID: <7vhd2f3oz4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 21 10:14:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsxqs-0004F0-RS
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 10:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWFUIOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 04:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWFUIOL
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 04:14:11 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52632 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932476AbWFUIOI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 04:14:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621081408.DKT27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 04:14:08 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22240>

The program is not used by git-clone since git-fetch-pack was extended
to allow its caller do what git-clone-pack alone did, and git-clone was
updated to use it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Logically this does not belong to the series, but retiring
   clone-pack lets me get away without having to update the
   callers of the function I'll be updating in the next one.

 .gitignore                         |    1 
 Documentation/git-clone-pack.txt   |   64 ------------
 Documentation/git-clone.txt        |    4 -
 Documentation/git-receive-pack.txt |    3 -
 Documentation/git-upload-pack.txt  |    2 
 Documentation/git.txt              |    6 -
 INSTALL                            |    2 
 Makefile                           |    2 
 clone-pack.c                       |  186 ------------------------------------
 9 files changed, 7 insertions(+), 263 deletions(-)

diff --git a/.gitignore b/.gitignore
index afd0876..65aa939 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,7 +17,6 @@ git-cherry
 git-cherry-pick
 git-clean
 git-clone
-git-clone-pack
 git-commit
 git-commit-tree
 git-convert-objects
diff --git a/Documentation/git-clone-pack.txt b/Documentation/git-clone-pack.txt
deleted file mode 100644
index 09f43ee..0000000
--- a/Documentation/git-clone-pack.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-git-clone-pack(1)
-=================
-
-NAME
-----
-git-clone-pack - Clones a repository by receiving packed objects
-
-
-SYNOPSIS
---------
-'git-clone-pack' [--exec=<git-upload-pack>] [<host>:]<directory> [<head>...]
-
-DESCRIPTION
------------
-Clones a repository into the current repository by invoking
-'git-upload-pack', possibly on the remote host via ssh, in
-the named repository, and stores the sent pack in the local
-repository.
-
-OPTIONS
--------
---exec=<git-upload-pack>::
-	Use this to specify the path to 'git-upload-pack' on the
-	remote side, if it is not found on your $PATH.
-	Installations of sshd ignore the user's environment
-	setup scripts for login shells (e.g. .bash_profile) and
-	your privately installed git may not be found on the system
-	default $PATH.  Another workaround suggested is to set
-	up your $PATH in ".bashrc", but this flag is for people
-	who do not want to pay the overhead for non-interactive
-	shells by having a lean .bashrc file (they set most of
-	the things up in .bash_profile).
-
-<host>::
-	A remote host that houses the repository.  When this
-	part is specified, 'git-upload-pack' is invoked via
-	ssh.
-
-<directory>::
-	The repository to sync from.
-
-<head>...::
-	The heads to update.  This is relative to $GIT_DIR
-	(e.g. "HEAD", "refs/heads/master").  When unspecified,
-	all heads are updated to match the remote repository.
-+
-Usually all the refs from existing repository are stored
-under the same name in the new repository.  Giving explicit
-<head> arguments instead writes the object names and refs to
-the standard output, just like get-fetch-pack does.
-
-Author
-------
-Written by Linus Torvalds <torvalds@osdl.org>
-
-Documentation
---------------
-Documentation by Junio C Hamano.
-
-
-GIT
----
-Part of the gitlink:git[7] suite
-
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index a90521e..f973c64 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -62,7 +62,7 @@ OPTIONS
 --quiet::
 -q::
 	Operate quietly.  This flag is passed to "rsync" and
-	"git-clone-pack" commands when given.
+	"git-fetch-pack" commands when given.
 
 -n::
 	No checkout of HEAD is performed after the clone is complete.
@@ -85,7 +85,7 @@ OPTIONS
 --upload-pack <upload-pack>::
 -u <upload-pack>::
 	When given, and the repository to clone from is handled
-	by 'git-clone-pack', '--exec=<upload-pack>' is passed to
+	by 'git-fetch-pack', '--exec=<upload-pack>' is passed to
 	the command to specify non-default path for the command
 	run on the other end.
 
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 60debca..f9457d4 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -18,8 +18,7 @@ information fed from the remote end.
 This command is usually not invoked directly by the end user.
 The UI for the protocol is on the 'git-send-pack' side, and the
 program pair is meant to be used to push updates to remote
-repository.  For pull operations, see 'git-fetch-pack' and
-'git-clone-pack'.
+repository.  For pull operations, see 'git-fetch-pack'.
 
 The command allows for creation and fast forwarding of sha1 refs
 (heads/tags) on the remote end (strictly speaking, it is the
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 4795e98..b2c9307 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Invoked by 'git-clone-pack' and/or 'git-fetch-pack', learns what
+Invoked by 'git-fetch-pack', learns what
 objects the other side is missing, and sends them after packing.
 
 This command is usually not invoked directly by the end user.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index d4472b5..51f20c6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -192,10 +192,6 @@ the working tree.
 Synching repositories
 ~~~~~~~~~~~~~~~~~~~~~
 
-gitlink:git-clone-pack[1]::
-	Clones a repository into the current repository (engine
-	for ssh and local transport).
-
 gitlink:git-fetch-pack[1]::
 	Updates from a remote repository (engine for ssh and
 	local transport).
@@ -237,7 +233,7 @@ gitlink:git-update-server-info[1]::
 	clients discover references and packs on it.
 
 gitlink:git-upload-pack[1]::
-	Invoked by 'git-clone-pack' and 'git-fetch-pack' to push
+	Invoked by 'git-fetch-pack' to push
 	what are asked for.
 
 gitlink:git-upload-tar[1]::
diff --git a/INSTALL b/INSTALL
index 63af8ec..f8337e2 100644
--- a/INSTALL
+++ b/INSTALL
@@ -96,7 +96,7 @@ Issues of note:
 
 	$ mkdir manual && cd manual
 	$ git init-db
-	$ git clone-pack git://git.kernel.org/pub/scm/git/git.git man html |
+	$ git fetch-pack git://git.kernel.org/pub/scm/git/git.git man html |
 	  while read a b
 	  do
 	    echo $a >.git/$b
diff --git a/Makefile b/Makefile
index 0887945..ae5e8d7 100644
--- a/Makefile
+++ b/Makefile
@@ -149,7 +149,7 @@ SIMPLE_PROGRAMS = \
 
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS = \
-	git-checkout-index$X git-clone-pack$X \
+	git-checkout-index$X \
 	git-convert-objects$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-mailinfo$X git-merge-base$X \
diff --git a/clone-pack.c b/clone-pack.c
deleted file mode 100644
index a4370f5..0000000
--- a/clone-pack.c
+++ /dev/null
@@ -1,186 +0,0 @@
-#include "cache.h"
-#include "refs.h"
-#include "pkt-line.h"
-
-static const char clone_pack_usage[] =
-"git-clone-pack [--exec=<git-upload-pack>] [<host>:]<directory> [<heads>]*";
-static const char *exec = "git-upload-pack";
-
-static int quiet = 0;
-
-static void clone_handshake(int fd[2], struct ref *ref)
-{
-	unsigned char sha1[20];
-
-	while (ref) {
-		packet_write(fd[1], "want %s\n", sha1_to_hex(ref->old_sha1));
-		ref = ref->next;
-	}
-	packet_flush(fd[1]);
-
-	/* We don't have nuttin' */
-	packet_write(fd[1], "done\n");
-	if (get_ack(fd[0], sha1))
-		error("Huh! git-clone-pack got positive ack for %s", sha1_to_hex(sha1));
-}
-
-static int is_master(struct ref *ref)
-{
-	return !strcmp(ref->name, "refs/heads/master");
-}
-
-static void write_one_ref(struct ref *ref)
-{
-	char *path = git_path("%s", ref->name);
-	int fd;
-	char *hex;
-
-	if (!strncmp(ref->name, "refs/", 5) &&
-	    check_ref_format(ref->name + 5)) {
-		error("refusing to create funny ref '%s' locally", ref->name);
-		return;
-	}
-
-	if (safe_create_leading_directories(path))
-		die("unable to create leading directory for %s", ref->name);
-	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, 0666);
-	if (fd < 0)
-		die("unable to create ref %s", ref->name);
-	hex = sha1_to_hex(ref->old_sha1);
-	hex[40] = '\n';
-	if (write(fd, hex, 41) != 41)
-		die("unable to write ref %s", ref->name);
-	close(fd);
-}
-
-static void write_refs(struct ref *ref)
-{
-	struct ref *head = NULL, *head_ptr, *master_ref;
-	char *head_path;
-
-	/* Upload-pack must report HEAD first */
-	if (!strcmp(ref->name, "HEAD")) {
-		head = ref;
-		ref = ref->next;
-	}
-	head_ptr = NULL;
-	master_ref = NULL;
-	while (ref) {
-		if (is_master(ref))
-			master_ref = ref;
-		if (head &&
-		    !memcmp(ref->old_sha1, head->old_sha1, 20) &&
-		    !strncmp(ref->name, "refs/heads/",11) &&
-		    (!head_ptr || ref == master_ref))
-			head_ptr = ref;
-
-		write_one_ref(ref);
-		ref = ref->next;
-	}
-	if (!head) {
-		fprintf(stderr, "No HEAD in remote.\n");
-		return;
-	}
-
-	head_path = strdup(git_path("HEAD"));
-	if (!head_ptr) {
-		/*
-		 * If we had a master ref, and it wasn't HEAD, we need to undo the
-		 * symlink, and write a standalone HEAD. Give a warning, because that's
-		 * really really wrong.
-		 */
-		if (master_ref) {
-			error("HEAD doesn't point to any refs! Making standalone HEAD");
-			unlink(head_path);
-		}
-		write_one_ref(head);
-		free(head_path);
-		return;
-	}
-
-	/* We reset to the master branch if it's available */
-	if (master_ref)
-		return;
-
-	fprintf(stderr, "Setting HEAD to %s\n", head_ptr->name);
-
-	/*
-	 * Uhhuh. Other end didn't have master. We start HEAD off with
-	 * the first branch with the same value.
-	 */
-	if (create_symref(head_path, head_ptr->name) < 0)
-		die("unable to link HEAD to %s", head_ptr->name);
-	free(head_path);
-}
-
-static int clone_pack(int fd[2], int nr_match, char **match)
-{
-	struct ref *refs;
-	int status;
-
-	get_remote_heads(fd[0], &refs, nr_match, match, 1);
-	if (!refs) {
-		packet_flush(fd[1]);
-		die("no matching remote head");
-	}
-	clone_handshake(fd, refs);
-
-	status = receive_keep_pack(fd, "git-clone-pack", quiet);
-	if (!quiet)
-		fprintf(stderr, "\n");
-
-	if (!status) {
-		if (nr_match == 0)
-			write_refs(refs);
-		else
-			while (refs) {
-				printf("%s %s\n",
-				       sha1_to_hex(refs->old_sha1),
-				       refs->name);
-				refs = refs->next;
-			}
-	}
-	return status;
-}
-
-int main(int argc, char **argv)
-{
-	int i, ret, nr_heads;
-	char *dest = NULL, **heads;
-	int fd[2];
-	pid_t pid;
-
-	setup_git_directory();
-
-	nr_heads = 0;
-	heads = NULL;
-	for (i = 1; i < argc; i++) {
-		char *arg = argv[i];
-
-		if (*arg == '-') {
-			if (!strcmp("-q", arg)) {
-				quiet = 1;
-				continue;
-			}
-			if (!strncmp("--exec=", arg, 7)) {
-				exec = arg + 7;
-				continue;
-			}
-			usage(clone_pack_usage);
-		}
-		dest = arg;
-		heads = argv + i + 1;
-		nr_heads = argc - i - 1;
-		break;
-	}
-	if (!dest)
-		usage(clone_pack_usage);
-	pid = git_connect(fd, dest, exec);
-	if (pid < 0)
-		return 1;
-	ret = clone_pack(fd, nr_heads, heads);
-	close(fd[0]);
-	close(fd[1]);
-	finish_connect(pid);
-	return ret;
-}
-- 
1.4.0.gbb3f
