From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 20:09:03 +0200
Message-ID: <11801165433267-git-send-email-hjemli@gmail.com>
References: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 20:07:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HreC0-00059W-S5
	for gcvg-git@gmane.org; Fri, 25 May 2007 20:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763503AbXEYSG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 14:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763507AbXEYSG6
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 14:06:58 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:54614 "EHLO mail48.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763503AbXEYSG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 14:06:57 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id l4PI6pC9010372;
	Fri, 25 May 2007 20:06:51 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.74.gea9f
In-Reply-To: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48398>

This command can be used to initialize, update and inspect submodules. It
uses a .gitmodules file, readable by git-config, in the top level directory
of the 'superproject' to specify a mapping between submodule paths and
repository url. There is currently no way to override the mappings in the
.gitmodules file, except by manually creating the subproject repository.

Example .gitmodules layout:

[module "git"]
	url = git://git.kernel.org/pub/scm/git/git.git
	branch = maint

The branch-key in .gitmodules is optional. When specified, 'git-submodule -u'
will checkout the named branch if its tip matches the commit-sha1 in the
superprojects index. Otherwise, 'git-submodule -u' will create a detached
HEAD in the submodule.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

This is an updated patch that hopefully deals with all the previous issues.

I've also added support for specifying module.$path.branch in .gitmodules,
but not support for general url rewriting based on local config. If that
is a wanted feature, it should be trivial to add later on.

Btw: testing this quickly becomes tedious, so I'll try to make a proper
testscript later tonight.


 Documentation/git-submodule.txt |   63 ++++++++++++++
 Makefile                        |    2 +-
 git-submodule.sh                |  178 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-submodule.txt
 create mode 100755 git-submodule.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
new file mode 100644
index 0000000..81236aa
--- /dev/null
+++ b/Documentation/git-submodule.txt
@@ -0,0 +1,63 @@
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
+'git-submodule' [--init | --update | --cached] [--quiet] [--] [<path>...]
+
+
+DESCRIPTION
+-----------
+The command shows the status of each specified submodule path, or all
+submodules if none is specified. Each submodule sha1 is prefixed with '-'
+if the submodule is uninitialized and '+' if the checked out version of
+the submodule is different from the commit sha1 stored in the index.
+
+
+OPTIONS
+-------
+<path>::
+	Path to submodule(s)
+
+-i, --init::
+	Initialize the specified submodules, i.e. clone the git repository
+	specified in .gitmodules and checkout the sha1 specified in the
+	index.
+
+-u, --update::
+	Update the specified submodules, i.e. checkout the sha1 specified
+	in the index
+
+--cached::
+	Display the sha1 stored in the index, not the currently checked
+	out revsion.
+
+-q, --quiet::
+	Be quiet
+
+
+FILES
+-----
+When cloning submodules, a .gitmodules file in the top-level directory
+of the containing work-tree is examined for the url of each submodule.
+The url is the value of the key module.$path.url.
+
+When updating submodules, the same .gitmodules file is examined for a key
+named 'module.$path.branch'. If found, and if the named branch is currently
+at the same revision as the commit-id in the containing repositories index,
+the specified branch will be checked out in the submodule. If not found, or
+if the branch isn't currently positioned at the wanted revision, a checkout
+of the wanted sha1 will happen in the submodule, leaving its HEAD detached.
+
+Author
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
index 0000000..51a0f47
--- /dev/null
+++ b/git-submodule.sh
@@ -0,0 +1,178 @@
+#!/bin/sh
+#
+# git-submodules.sh: init, update or list git submodules
+#
+# Copyright (c) 2007 Lars Hjemli
+
+USAGE='[--init | --update | --cached] [--quiet] [--] [<path>...]'
+. git-sh-setup
+require_work_tree
+
+init=
+update=
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
+	while read mode rev stage path
+	do
+		if ! test -d "$path/.git"
+		then
+			say "Submodule '$path' not initialized"
+			continue;
+		fi
+		subsha1=$(unset GIT_DIR && cd "$path" && git-rev-parse --verify HEAD) ||
+		die "Unable to find current revision of submodule '$path'"
+
+		if test "$subsha1" != "$rev"
+		then
+			$(unset GIT_DIR && cd "$path" && git-fetch)
+			branch=$(GIT_CONFIG=.gitmodules git-config module."$path".branch)
+			if test "$branch" != ""
+			then
+				branch_sha1=$(unset GIT_DIR && cd "$path" &&
+					git-rev-parse --verify "$branch")
+				if test "$branch_sha1" = "$rev"
+				then
+					rev="$branch"
+				fi
+			fi
+			$(unset GIT_DIR && cd "$path" && git-checkout -q "$rev") ||
+			die "Unable to checkout '$rev' in submodule '$path'"
+
+			say "Submodule '$path': checked out '$rev'"
+		fi
+	done
+}
+
+#
+# List all registered submodules, prefixed with:
+#  - submodule not initialized
+#  + different version checked out
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
+
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	-i|--init)
+		init=1
+		;;
+	-u|--update)
+		update=1
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
+case "$init,$update,$cached" in
+1,,)
+	modules_init $@
+	;;
+,1,)
+	modules_update $@
+	;;
+,,*)
+	modules_list $@
+	;;
+*)
+	usage
+	;;
+esac
-- 
1.5.2.74.gea9f
