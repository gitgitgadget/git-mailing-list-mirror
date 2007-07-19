From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [REVISED PATCH 3/6] Add git-notes
Date: Thu, 19 Jul 2007 03:31:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707190331050.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160023360.14781@racer.site> <7v8x9h6igv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 04:52:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBM7l-000163-QY
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 04:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbXGSCwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 22:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756712AbXGSCwO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 22:52:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:50198 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753599AbXGSCwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 22:52:13 -0400
Received: (qmail invoked by alias); 19 Jul 2007 02:31:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 19 Jul 2007 04:31:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bK2xodZ/bSym1IW6WIgndLgkGFXIHmzzFWIo6+7
	+zk0QTgGARMGFR
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x9h6igv.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52927>


This script allows you to edit and show commit notes easily.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore   |    1 +
 Makefile     |    2 +-
 git-notes.sh |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletions(-)
 create mode 100755 git-notes.sh

diff --git a/.gitignore b/.gitignore
index 20ee642..125613f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -83,6 +83,7 @@ git-mktag
 git-mktree
 git-name-rev
 git-mv
+git-notes
 git-pack-redundant
 git-pack-objects
 git-pack-refs
diff --git a/Makefile b/Makefile
index 119d949..10a9342 100644
--- a/Makefile
+++ b/Makefile
@@ -213,7 +213,7 @@ SCRIPT_SH = \
 	git-merge-resolve.sh git-merge-ours.sh \
 	git-lost-found.sh git-quiltimport.sh git-submodule.sh \
 	git-filter-branch.sh \
-	git-stash.sh
+	git-stash.sh git-notes.sh
 
 SCRIPT_PERL = \
 	git-add--interactive.perl \
diff --git a/git-notes.sh b/git-notes.sh
new file mode 100755
index 0000000..031e911
--- /dev/null
+++ b/git-notes.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+USAGE="(edit | show) [commit]"
+. git-sh-setup
+
+test -n "$3" && usage
+
+test -z "$GIT_NOTES_REF" && GIT_NOTES_REF="$(git config core.notesref)"
+test -z "$GIT_NOTES_REF" && GIT_NOTES_REF="refs/notes/commits"
+
+COMMIT=$(git rev-parse --verify --default HEAD "$2") || die "Invalid ref: $2"
+NAME=$(echo $COMMIT | sed "s/^../&\//")
+
+MESSAGE="$GIT_DIR"/new-notes
+trap '
+	test -f "$MESSAGE" && rm "$MESSAGE"
+' 0
+
+case "$1" in
+edit)
+	GIT_NOTES_REF= git log -1 $COMMIT | sed "s/^/#/" > "$MESSAGE"
+
+	GIT_INDEX_FILE="$MESSAGE".idx
+	export GIT_INDEX_FILE
+
+	CURRENT_HEAD=$(git show-ref "$GIT_NOTES_REF" | cut -f 1 -d ' ')
+	if [ -z "$CURRENT_HEAD" ]; then
+		PARENT=
+	else
+		PARENT="-p $CURRENT_HEAD"
+		git read-tree "$GIT_NOTES_REF" || die "Could not read index"
+		git cat-file blob :$NAME >> "$MESSAGE" 2> /dev/null
+	fi
+
+	${VISUAL:-${EDITOR:-vi}} "$MESSAGE"
+
+	grep -v ^# < "$MESSAGE" | git stripspace > "$MESSAGE".processed
+	mv "$MESSAGE".processed "$MESSAGE"
+	if [ -s "$MESSAGE" ]; then
+		BLOB=$(git hash-object -w "$MESSAGE") ||
+			die "Could not write into object database"
+		git update-index --add --cacheinfo 0644 $BLOB $NAME ||
+			die "Could not write index"
+	else
+		test -z "$CURRENT_HEAD" &&
+			die "Will not initialise with empty tree"
+		git update-index --force-remove $NAME ||
+			die "Could not update index"
+	fi
+
+	TREE=$(git write-tree) || die "Could not write tree"
+	NEW_HEAD=$(echo Annotate $COMMIT | git commit-tree $TREE $PARENT) ||
+		die "Could not annotate"
+	git update-ref -m "Annotate $COMMIT" \
+		"$GIT_NOTES_REF" $NEW_HEAD $CURRENT_HEAD
+;;
+show)
+	git show "$GIT_NOTES_REF":$NAME
+;;
+*)
+	usage
+esac
-- 
1.5.3.rc1.16.g9d6f-dirty
