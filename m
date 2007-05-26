From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add git-submodule command
Date: Sat, 26 May 2007 15:56:40 +0200
Message-ID: <11801878003599-git-send-email-hjemli@gmail.com>
References: <7v1wh4ped4.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 15:54:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrwjK-0001Fu-Lk
	for gcvg-git@gmane.org; Sat, 26 May 2007 15:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbXEZNyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 09:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbXEZNyn
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 09:54:43 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:44738 "EHLO mail48.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966AbXEZNym (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 09:54:42 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id l4QDsRNr012294;
	Sat, 26 May 2007 15:54:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.74.g2f36
In-Reply-To: <7v1wh4ped4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48472>

This command can be used to initialize, update and inspect submodules. It
uses a .gitmodules file, readable by git-config, in the top level directory
of the 'superproject' to specify a mapping between submodule paths and
repository url.

Example .gitmodules layout:

[module "git"]
	url = git://git.kernel.org/pub/scm/git/git.git

With this entry in .gitmodules (and a commit reference in the index entry for
the path "git"), the command 'git submodule init' will clone the repository
at kernel.org into the directory "git".

Known issues
============
There is currently no way to override the url found in the .gitmodules file,
except by manually creating the subproject repository. The place to fix this
in the script has a rather long comment about a possible plan.

Funny paths will be quoted in the output from git-ls-files, but git-submodule
does not attempt to unquote (or even detect the presence of) such paths.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

So here is another attempt on initial submodule porcelain, still trying to
keep it simple. A proper test-script hasn't materialized yet, sorry about
that.

 .gitignore                      |    1 +
 Documentation/cmd-list.perl     |    1 +
 Documentation/git-submodule.txt |   65 +++++++++++++
 Makefile                        |    2 +-
 git-submodule.sh                |  195 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 263 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-submodule.txt
 create mode 100755 git-submodule.sh

diff --git a/.gitignore b/.gitignore
index 4dc0c39..8fc4923 100644
--- a/.gitignore
+++ b/.gitignore
@@ -126,6 +126,7 @@ git-ssh-push
 git-ssh-upload
 git-status
 git-stripspace
+git-submodule
 git-svn
 git-svnimport
 git-symbolic-ref
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 443802a..51dc6b4 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -180,6 +180,7 @@ git-ssh-fetch                           synchingrepositories
 git-ssh-upload                          synchingrepositories
 git-status                              mainporcelain
 git-stripspace                          purehelpers
+git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
 git-svnimport                           foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
new file mode 100644
index 0000000..02932a7
--- /dev/null
+++ b/Documentation/git-submodule.txt
@@ -0,0 +1,65 @@
+git-submodule(1)
+================
+
+NAME
+----
+git-submodule - Initialize, update or inspect submodules
+
+
+SYNOPSIS
+--------
+'git-submodule' [--quiet] [--cached] [status|init|update] [--] [<path>...]
+
+
+COMMANDS
+--------
+status::
+	Show the status of the submodules. This will print the SHA-1 of the
+	currently checked out commit for each submodule, along with the
+	submodule path and the output of gitlink:git-describe[1] for the
+	SHA-1. Each SHA-1 will be prefixed with "-" if the submodule is not
+	initialized and "+" if the currently checked out submodule commit
+	does not match the SHA-1 found in the index of the containing
+	repository. This command is the default command for git-submodule.
+
+init::
+	Initialize the submodules, i.e. clone the git repositories specified
+	in the .gitmodules file and checkout the submodule commits specified
+	in the index of the containing repository. This will make the
+	submodules HEAD be detached.
+
+update::
+	Update the initialized submodules, i.e. checkout the submodule commits
+	specified in the index of the containing repository. This will make
+	the submodules HEAD be detached.
+
+
+OPTIONS
+-------
+-q, --quiet::
+	Only print error messages.
+
+--cached::
+	Display the SHA-1 stored in the index, not the SHA-1 of the currently
+	checked out submodule commit. This option is only valid for the
+	status command.
+
+<path>::
+	Path to submodule(s). When specified this will restrict the command
+	to only operate on the submodules found at the specified paths.
+
+FILES
+-----
+When cloning submodules, a .gitmodules file in the top-level directory
+of the containing repository is used to find the url of each submodule.
+This file should be formatted in the same way as $GIR_DIR/config. The key
+to each submodule url is "module.$path.url".
+
+
+AUTHOR
+------
+Written by Lars Hjemli <hjemli@gmail.com>
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 29243c6..5cf2169 100644
--- a/Makefile
+++ b/Makefile
@@ -209,7 +209,7 @@ SCRIPT_SH = \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
-	git-lost-found.sh git-quiltimport.sh
+	git-lost-found.sh git-quiltimport.sh git-submodule.sh
 
 SCRIPT_PERL = \
 	git-add--interactive.perl \
diff --git a/git-submodule.sh b/git-submodule.sh
new file mode 100755
index 0000000..1601bca
--- /dev/null
+++ b/git-submodule.sh
@@ -0,0 +1,195 @@
+#!/bin/sh
+#
+# git-submodules.sh: init, update or list git submodules
+#
+# Copyright (c) 2007 Lars Hjemli
+
+USAGE='[--quiet] [--cached] [status|init|update] [--] [<path>...]'
+. git-sh-setup
+require_work_tree
+
+init=
+update=
+status=
+quiet=
+cached=
+
+#
+# print stuff on stdout unless -q was specified
+#
+say()
+{
+	if test -z "$quiet"
+	then
+		echo "$@"
+	fi
+}
+
+#
+# Run clone + checkout on missing submodules
+#
+# $@ = requested paths (default to all)
+#
+modules_init()
+{
+	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	while read mode sha1 stage path
+	do
+		# Skip submodule paths that already contain a .git directory.
+		# This will also trigger if $path is a symlink to a git
+		# repository
+		test -d "$path"/.git && continue
+
+		# If there already is a directory at the submodule path,
+		# expect it to be empty (since that is the default checkout
+		# action) and try to remove it.
+		# Note: if $path is a symlink to a directory the test will
+		# succeed but the rmdir will fail. We might want to fix this.
+		if test -d "$path"
+		then
+			rmdir "$path" 2>/dev/null ||
+			die "Directory '$path' exist, but is neither empty "
+			    "nor a git repository"
+		fi
+
+		test -e "$path"
+		die "A file already exist at path '$path'"
+
+		url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
+		test -z "$url" &&
+		die "No url found for submodule '$path' in .gitmodules"
+
+		# MAYBE FIXME: this would be the place to check GIT_CONFIG
+		# for a preferred url for this submodule, possibly like this:
+		#
+		# modname=$(GIT_CONFIG=.gitmodules git-config module."$path".name)
+		# alturl=$(git-config module."$modname".url)
+		#
+		# This would let the versioned .gitmodules file use the submodule
+		# path as key, while the unversioned GIT_CONFIG would use the
+		# logical modulename (if present) as key. But this would need
+		# another fallback mechanism if the module wasn't named.
+
+		git-clone -n "$url" "$path" ||
+		die "Clone of submodule '$path' failed"
+
+		(unset GIT_DIR && cd "$path" && git-checkout -q "$sha1") ||
+		die "Checkout of submodule '$path' failed"
+
+		say "Submodule '$path' initialized"
+	done
+}
+
+#
+# Checkout correct revision of each initialized submodule
+#
+# $@ = requested paths (default to all)
+#
+modules_update()
+{
+	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	while read mode sha1 stage path
+	do
+		if ! test -d "$path"/.git
+		then
+			# Only mention uninitialized submodules when its
+			# path have been specified
+			test "$#" != "0" &&
+			say "Submodule '$path' not initialized"
+			continue;
+		fi
+		subsha1=$(unset GIT_DIR && cd "$path" &&
+			git-rev-parse --verify HEAD) ||
+		die "Unable to find current revision of submodule '$path'"
+
+		if test "$subsha1" != "$sha1"
+		then
+			(unset GIT_DIR && cd "$path" && git-fetch &&
+				git-checkout -q "$sha1") ||
+			die "Unable to checkout '$sha1' in submodule '$path'"
+
+			say "Submodule '$path': checked out '$sha1'"
+		fi
+	done
+}
+
+#
+# List all registered submodules, prefixed with:
+#  - submodule not initialized
+#  + different revision checked out
+#
+# If --cached was specified the revision in the index will be printed
+# instead of the currently checked out revision.
+#
+# $@ = requested paths (default to all)
+#
+modules_list()
+{
+	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	while read mode sha1 stage path
+	do
+		if ! test -d "$path"/.git
+		then
+			say "-$sha1 $path"
+			continue;
+		fi
+		revname=$(unset GIT_DIR && cd "$path" && git-describe $sha1)
+		if git diff-files --quiet -- "$path"
+		then
+			say " $sha1 $path ($revname)"
+		else
+			if test -z "$cached"
+			then
+				sha1=$(unset GIT_DIR && cd "$path" && git-rev-parse --verify HEAD)
+				revname=$(unset GIT_DIR && cd "$path" && git-describe $sha1)
+			fi
+			say "+$sha1 $path ($revname)"
+		fi
+	done
+}
+
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	init)
+		init=1
+		;;
+	update)
+		update=1
+		;;
+	status)
+		status=1
+		;;
+	-q|--quiet)
+		quiet=1
+		;;
+	--cached)
+		cached=1
+		;;
+	--)
+		break
+		;;
+	-*)
+		usage
+		;;
+	*)
+		break
+		;;
+	esac
+	shift
+done
+
+case "$init,$update,$status,$cached" in
+1,,,)
+	modules_init "$@"
+	;;
+,1,,)
+	modules_update "$@"
+	;;
+,,*,*)
+	modules_list "$@"
+	;;
+*)
+	usage
+	;;
+esac
-- 
1.5.2.74.ga303-dirty
