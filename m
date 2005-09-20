From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/8] cogito: Merge *-id scripts into cg-object-id.
Date: Mon, 19 Sep 2005 22:11:42 -0400
Message-ID: <1127182302.31115.16.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 04:13:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXbo-0004ZD-Du
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVITCLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVITCLp
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:11:45 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:22955 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964838AbVITCLp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:11:45 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHXbj-00062u-Tc
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:11:44 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHXbi-0001gy-93
	for git@vger.kernel.org; Mon, 19 Sep 2005 22:11:42 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8954>

Merge *-id scripts into cg-object-id.
    
It's easier to have one script with one manpage.

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -10,11 +10,11 @@ INSTALL?=install
 
 ### --- END CONFIGURATION SECTION ---
 
 
 
-SCRIPT=	cg-commit-id cg-tree-id cg-parent-id cg-add cg-admin-lsobj cg-admin-uncommit \
+SCRIPT=	cg-object-id cg-add cg-admin-lsobj cg-admin-uncommit \
 	cg-branch-add cg-branch-ls cg-reset cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-merge cg-mkpatch cg-patch \
 	cg-fetch cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update \
 	cg cg-admin-ls cg-upload cg-branch-chg cg-admin-cat cg-clean
 
@@ -76,12 +76,14 @@ sedlibdir=$(shell echo $(libdir) | sed '
 install: install-cogito
 
 install-cogito: $(SCRIPT) $(LIB_SCRIPT) $(GEN_SCRIPT)
 	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
-	for i in 'cg-cancel:cg-reset' 'commit-id:cg-commit-id' \
-		'tree-id:cg-tree-id' 'parent-id:cg-parent-id' \
+	for i in 'cg-cancel:cg-reset' 'commit-id:cg-object-id' \
+		'tree-id:cg-object-id' 'parent-id:cg-object-id' \
+		'cg-commit-id:cg-object-id' \
+		'cg-tree-id:cg-object-id' 'cg-parent-id:cg-object-id' \
 		'cg-pull:cg-fetch' 'cg-push:cg-upload'; do \
 		old=`echo $$i | cut -d : -f 1`; \
 		new=`echo $$i | cut -d : -f 2`; \
 		rm -f $(DESTDIR)$(bindir)/$$old; \
 		ln -s $$new $(DESTDIR)$(bindir)/$$old; \
diff --git a/cg-commit-id b/cg-commit-id
deleted file mode 100755
--- a/cg-commit-id
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/usr/bin/env bash
-#
-# Get ID of commit associated with given id or HEAD.
-# Copyright (c) Petr Baudis, 2005
-#
-# Takes the appropriate ID, defaults to HEAD.
-
-USAGE="cg-commit-id [COMMIT_ID]"
-
-id="$1"
-normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
-type=${normid#* }
-normid=${normid% *}
-[ "$type" ] || type=$(git-cat-file -t "$normid")
-
-if [ "$type" != "commit" ]; then
-	echo "Invalid commit id: $normid" >&2
-	exit 1
-fi
-
-echo $normid
diff --git a/cg-object-id b/cg-object-id
new file mode 100755
--- /dev/null
+++ b/cg-object-id
@@ -0,0 +1,83 @@
+#!/usr/bin/env bash
+#
+# Get SHA1 ID of commit or tree associated with given ID or HEAD.
+# Copyright (c) Petr Baudis, 2005
+# Copyright (c) Pavel Roskin 2005
+#
+# If the ID is not provided, HEAD is used.  The default behavior is to
+# show the commit ID.
+#
+# OPTIONS
+# -------
+# -p::
+#	Get ID of parent commit(s) to a given revision or HEAD.
+#	NOTE: Multiple SHA1s will be returned for commits with multiple
+#	parents.
+#
+# -t::
+#	Get ID of tree associated with given commit or HEAD.
+#
+# OBJECT_ID::
+#	An ID resolving to a commit.
+
+USAGE="cg-object-id [-p] [-t] [OBJECT_ID]"
+
+. ${COGITO_LIB}cg-Xlib
+
+show_parent=
+show_tree=
+while optparse; do
+	if optparse -p; then
+		show_parent=1
+	elif optparse -t; then
+		show_tree=1
+	else
+		optfail
+	fi
+done
+
+# Compatibility code
+case $_cg_cmd in
+	*parent*) show_parent=1;;
+	*tree*) show_tree=1;;
+esac
+
+if [ "$show_parent" -a "$show_tree" ]; then
+	echo "Cannot show parent and tree ID at the same time." >&2
+	exit 1
+fi
+
+id="${ARGS[0]}"
+if [ "$show_parent" ]; then
+	id="$id"^
+fi
+
+normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
+
+if [ "$show_parent" ]; then
+	echo ${normid% *}
+	exit 0
+fi
+
+type=${normid#* }
+normid=${normid% *}
+[ "$type" ] || type=$(git-cat-file -t "$normid")
+if [ "$show_tree" ]; then
+	if [ "$type" = "commit" ]; then
+		normid=$(git-cat-file commit "$normid" | sed -e 's/tree //;q')
+		type=$(git-cat-file -t "$normid")
+	fi
+
+	if [ "$type" != "tree" ]; then
+		echo "Invalid tree id: $normid" >&2
+		exit 1
+	fi
+else
+	if [ "$type" != "commit" ]; then
+		echo "Invalid commit id: $normid" >&2
+		exit 1
+	fi
+fi
+
+echo $normid
+
diff --git a/cg-parent-id b/cg-parent-id
deleted file mode 100755
--- a/cg-parent-id
+++ /dev/null
@@ -1,13 +0,0 @@
-#!/usr/bin/env bash
-#
-# Get ID of parent commit to a given revision or HEAD.
-# Copyright (c) Petr Baudis, 2005
-#
-# Takes ID of the current commit, defaults to HEAD.
-#
-# NOTE: Will return multiple SHA1s if ID is a commit with multiple parents.
-
-USAGE="cg-parent-id [COMMIT_ID]"
-
-normid=$(. ${COGITO_LIB}cg-Xnormid "$1"^)
-echo ${normid%% *}
diff --git a/cg-tree-id b/cg-tree-id
deleted file mode 100755
--- a/cg-tree-id
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/usr/bin/env bash
-#
-# Get ID of tree associated with given commit or HEAD.
-# Copyright (c) Petr Baudis, 2005
-#
-# Takes ID of the appropriate commit, defaults to HEAD.
-
-USAGE="cg-tree-id [COMMIT_ID]"
-
-id="$1"
-normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
-type=${normid#* }
-normid=${normid% *}
-[ "$type" ] || type=$(git-cat-file -t "$normid")
-
-if [ "$type" = "commit" ]; then
-	normid=$(git-cat-file commit "$normid" | sed -e 's/tree //;q')
-	type=$(git-cat-file -t "$normid")
-fi
-
-if [ "$type" != "tree" ]; then
-	echo "Invalid tree id: $normid" >&2
-	exit 1
-fi
-
-echo $normid

-- 
Regards,
Pavel Roskin
