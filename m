From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 11:51:04 +0200
Message-ID: <11800866643203-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 11:49:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrWPv-00008p-2Z
	for gcvg-git@gmane.org; Fri, 25 May 2007 11:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbXEYJs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 05:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbXEYJs5
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 05:48:57 -0400
Received: from mail42.e.nsc.no ([193.213.115.42]:61542 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbXEYJs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 05:48:57 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id l4P9mqgQ028617;
	Fri, 25 May 2007 11:48:52 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.73.g18bece-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48349>

This command can be used to initialize, update and inspect submodules. It
uses a .gitmodules file, readable by git-config, in the top level directory
of the 'superproject' to specify a mapping between submodule paths and
repository url. There is currently no way to override the mappings in the
.gitmodules file, except by manually creating the subproject repository.

Example .gitmodules layout:

[module "git"]
	url = git://git.kernel.org/pub/scm/git/git.git

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

On 5/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 24 May 2007, Lars Hjemli wrote:
> > What I think would be nice is some porcelain support to manually init,
> > update and see the checked out version of selected subprojects, but as
> > standalone commands.
>
> Yes, a la git-remote. I'd be much happier with that, too, especially since
> I think that this can be a relatively small and easy-to-review script.

So, here it is. Please be kind :)

Btw: I've never managed to get asciidoc working on my machine, so the doc
isn't checked in any other format than plain text.


 Documentation/git-submodule.txt |   49 ++++++++++++
 Makefile                        |    2 +-
 git-submodule.sh                |  163 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-submodule.txt
 create mode 100755 git-submodule.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
new file mode 100644
index 0000000..6ec917c
--- /dev/null
+++ b/Documentation/git-submodule.txt
@@ -0,0 +1,49 @@
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
+'git-submodule' [--init | --update | --cached] [--quiet] <path>...
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
+	Path to submodule
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
index 0000000..c4a1cc3
--- /dev/null
+++ b/git-submodule.sh
@@ -0,0 +1,163 @@
+#!/bin/sh
+#
+# git-submodule.sh: init, update or list git submodules
+#
+# Copyright (c) 2007 Lars Hjemli
+
+USAGE='[-i | --init | -u | --update] [-q | --quiet] [--cached] <path>...'
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
+# Find all (requested) submodules, run clone + checkout on missing paths
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
+		$(cd "$path" && git-checkout -q "$sha1") ||
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
+		subsha1=$(cd "$path" && git-rev-parse --verify HEAD) ||
+		die "Unable to find current revision of submodule '$path'"
+
+		if test "$subsha1" != "$sha1"
+		then
+			$(cd "$path" && git-fetch && git-checkout -q "$sha1") ||
+			die "Unable to checkout revision $sha1 of submodule '$path'"
+
+			say "Submodule '$path' reset to revision $sha1"
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
+		revname=$(cd "$path" && git-describe $sha1)
+		if git diff-files --quiet -- "$path"
+		then
+			say " $sha1 $path\t($revname)"
+		else
+			if test -z "$cached"
+			then
+				sha1=$(cd "$path" && git-rev-parse --verify HEAD)
+				revname=$(cd "$path" && git-describe $sha1)
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
+
+if test "$init" = "1"
+then
+	modules_init $@
+elif test "$update" = "1"
+then
+	modules_update $@
+else
+	modules_list $@
+fi
-- 
1.5.2.73.g18bece-dirty
