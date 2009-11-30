From: "Bernhard R. Link" <brlink@debian.org>
Subject: [PATCH 1/7] add new command git equal-tree-marker
Date: Mon, 30 Nov 2009 15:43:58 +0100
Message-ID: <9e6833ef7188f41d6ea46ddcf92929af284b4adb.1259524136.git.brlink@debian.org>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 15:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF7Tw-0006qp-Vz
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 15:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbZK3Onx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 09:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZK3Onx
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 09:43:53 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:33529
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752802AbZK3Onw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 09:43:52 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7Tq-0000y9-J0
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:43:58 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7Tq-0000qW-H8
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:43:58 +0100
Content-Disposition: inline
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134104>

This adds a new commit denoting tha current branch has the same
tree as another branch, thus allowing fast-forward from the named
commits to this one.

TODO: manpage, rewrite as builtin once the semantics are accepted?
---
 .gitignore               |    1 +
 Makefile                 |    1 +
 git-equal-tree-marker.sh |   50 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100644 git-equal-tree-marker.sh

diff --git a/.gitignore b/.gitignore
index ac02a58..248d146 100644
--- a/.gitignore
+++ b/.gitignore
@@ -39,6 +39,7 @@
 /git-difftool
 /git-difftool--helper
 /git-describe
+/git-equal-tree-marker
 /git-fast-export
 /git-fast-import
 /git-fetch
diff --git a/Makefile b/Makefile
index 4dba10e..913d4c4 100644
--- a/Makefile
+++ b/Makefile
@@ -336,6 +336,7 @@ TEST_PROGRAMS =
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
+SCRIPT_SH += git-equal-tree-marker.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
diff --git a/git-equal-tree-marker.sh b/git-equal-tree-marker.sh
new file mode 100644
index 0000000..403cc56
--- /dev/null
+++ b/git-equal-tree-marker.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Bernhard R. Link
+#
+# Create a new commit making HEAD parent of the arguments,
+# which must be commits with the same tree.
+
+set -e
+
+USAGE='<head>...'
+LONG_USAGE='Make current HEAD parent of the given heads (which need to have the same tree).'
+SUBDIRECTORY_OK=Yes
+OPTIONS_SPEC=
+. git-sh-setup
+cd_to_toplevel
+
+# is there really no function for this?
+tree_of_commit() {
+	git cat-file commit "$1" | grep '^tree ' | head -n 1 | sed -e 's/^tree //'
+}
+
+head="$(git rev-parse --verify HEAD)"
+htree="$(tree_of_commit $head)"
+parents=""
+while test $# -gt 0
+do
+	case "$1" in
+	-h|--h|--he|--hel|--help)
+		usage
+		;;
+	*)
+		h="$(git rev-parse --verify $1)"
+		tree="$(tree_of_commit "$h")"
+		if test "x${htree}" != "x${tree}" ; then
+			echo "Tree of $h is not the same as tree of $head" >&2
+			exit 1
+		fi
+		parents="$parents -p $h"
+		;;
+	esac
+	shift
+done
+
+if test "x$parents" = "x" ; then
+	echo "Not enough arguments!" >&2
+	exit 1
+fi
+
+new_commit="$(echo "Equal tree marker" | git commit-tree "$tree" -p "$head" $parents)"
+git-update-ref HEAD "$new_commit"
-- 
1.6.6.rc0.82.g60a15.dirty
