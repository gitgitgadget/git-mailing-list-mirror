From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add git-submodule command
Date: Sat, 26 May 2007 02:17:08 +0200
Message-ID: <11801386283399-git-send-email-hjemli@gmail.com>
References: <8c5c35580705251501u6346c27by1d133efc3d157bf2@mail.gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 02:15:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrjw9-0005QQ-Oe
	for gcvg-git@gmane.org; Sat, 26 May 2007 02:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbXEZAPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 20:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753267AbXEZAPI
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 20:15:08 -0400
Received: from mail44.e.nsc.no ([193.213.115.44]:52004 "EHLO mail44.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbXEZAPH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 20:15:07 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail44.nsc.no (8.13.8/8.13.5) with ESMTP id l4Q0EuEo000984;
	Sat, 26 May 2007 02:14:56 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.74.ga303
In-Reply-To: <8c5c35580705251501u6346c27by1d133efc3d157bf2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48434>

This command can be used to initialize, update and inspect submodules. It
uses a .gitmodules file, readable by git-config, in the top level directory
of the 'superproject' to specify a mapping between submodule paths and
repository url. There is currently no way to override the mappings in the
.gitmodules file, except by manually creating the subproject repository.

Example .gitmodules layout:

[module "git"]
	url = git://git.kernel.org/pub/scm/git/git.git

With this entry in .gitmodules (and a commit reference in the index entry for
the path "git"), the command 'git submodule init' will clone the repository
at kernel.org into the directory "git".

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

On 5/26/07, Lars Hjemli <hjemli@gmail.com> wrote:
> I'll redo the patch, removing the branch-specific things, and try to
> shut up :)

This is my final uttering ;-)


 .gitignore                      |    1 +
 Documentation/git-submodule.txt |   65 +++++++++++++++
 Makefile                        |    2 +-
 git-submodule.sh                |  172 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+), 1 deletions(-)
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
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
new file mode 100644
index 0000000..2135331
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
+	Show the status of the submodules. This will print the sha1 of the
+	currently checked out commit for each submodule, along with the
+	submodule path and the output of gitlink:git-describe[1] for the
+	sha1. Each sha1 will be prefixed with '-' if the submodule is not
+	initialized and '+' if the currently checked out submodule commit
+	does not match the sha1 found in the index of the containing
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
+	Display the sha1 stored in the index, not the sha1 of the currently
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
index 0000000..247b1ee
--- /dev/null
+++ b/git-submodule.sh
@@ -0,0 +1,172 @@
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
+		echo -e "$@"
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
+	git ls-files --stage -- $@ | grep -e '^160000 ' |
+	while read mode sha1 stage path
+	do
+		test -d "$path/.git" && continue
+
+		if test -d "$path"
+		then
+			rmdir "$path" 2>/dev/null ||
+			die "Directory '$path' exist, but not as a submodule"
+		fi
+
+		test -e "$path" &&
+		die "A file already exist at path '$path'"
+
+		url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
+		test -z "$url" &&
+		die "No url found for submodule '$path' in .gitmodules"
+
+		git-clone "$url" "$path" ||
+		die "Clone of submodule '$path' failed"
+
+		$(unset GIT_DIR && cd "$path" && git-checkout -q "$sha1") ||
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
+	git ls-files --stage -- $@ | grep -e '^160000 ' |
+	while read mode sha1 stage path
+	do
+		if ! test -d "$path/.git"
+		then
+			say "Submodule '$path' not initialized"
+			continue;
+		fi
+		subsha1=$(unset GIT_DIR && cd "$path" &&
+			git-rev-parse --verify HEAD) ||
+		die "Unable to find current revision of submodule '$path'"
+
+		if test "$subsha1" != "$sha1"
+		then
+			$(unset GIT_DIR && cd "$path" && git-fetch &&
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
+	git ls-files --stage -- $@ | grep -e '^160000 ' |
+	while read mode sha1 stage path
+	do
+		if ! test -d "$path/.git"
+		then
+			say "-$sha1 $path"
+			continue;
+		fi
+		revname=$(unset GIT_DIR && cd "$path" && git-describe $sha1)
+		if git diff-files --quiet -- "$path"
+		then
+			say " $sha1 $path\t($revname)"
+		else
+			if test -z "$cached"
+			then
+				sha1=$(unset GIT_DIR && cd "$path" && git-rev-parse --verify HEAD)
+				revname=$(unset GIT_DIR && cd "$path" && git-describe $sha1)
+			fi
+			say "+$sha1 $path\t($revname)"
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
+	modules_init $@
+	;;
+,1,,)
+	modules_update $@
+	;;
+,,*,*)
+	modules_list $@
+	;;
+*)
+	usage
+	;;
+esac
-- 
1.5.2.74.ga303
