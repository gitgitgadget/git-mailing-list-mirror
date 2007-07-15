From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/6] Add git-notes
Date: Mon, 16 Jul 2007 00:23:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160023360.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:24:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADRi-0001RN-IE
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbXGOXYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755114AbXGOXYG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:24:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:53326 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754878AbXGOXYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:24:05 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:24:02 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp050) with SMTP; 16 Jul 2007 01:24:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lAMY1GWNlbMkxe/7yBWm2BSQJTm5+hU3J6ubSgr
	zosldhHlw/lQHI
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707152326080.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52602>


This script allows you to edit and show commit notes easily.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore   |    1 +
 Makefile     |    2 +-
 git-notes.sh |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletions(-)
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
index 0000000..e0ad0b9
--- /dev/null
+++ b/git-notes.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+USAGE="(edit | show) [commit]"
+. git-sh-setup
+
+test -n "$3" && usage
+
+test -z "$GIT_NOTES_REF" && GIT_NOTES_REF="$(git config core.notesref)"
+test -z "$GIT_NOTES_REF" &&
+	die "No notes ref set."
+
+COMMIT=$(git rev-parse --verify --default HEAD "$2")
+NAME=$(echo $COMMIT | sed "s/^../&\//")
+
+case "$1" in
+edit)
+	MESSAGE="$GIT_DIR"/new-notes
+	GIT_NOTES_REF= git log -1 $COMMIT | sed "s/^/#/" > "$MESSAGE"
+
+	GIT_INDEX_FILE="$MESSAGE".idx
+	export GIT_INDEX_FILE
+
+	CURRENT_HEAD=$(git show-ref $GIT_NOTES_REF | cut -f 1 -d ' ')
+	if [ -z "$CURRENT_HEAD" ]; then
+		PARENT=
+	else
+		PARENT="-p $OLDTIP"
+		git read-tree $GIT_NOTES_REF || die "Could not read index"
+		git cat-file blob :$NAME >> "$MESSAGE" 2> /dev/null
+	fi
+
+	${VISUAL:-${EDITOR:-vi}} "$MESSAGE"
+
+	grep -v ^# < "$MESSAGE" | git stripspace > "$MESSAGE".processed
+	mv "$MESSAGE".processed "$MESSAGE"
+	if [ -z "$(cat "$MESSAGE")" ]; then
+		test -z "$CURRENT_HEAD" &&
+			die "Will not initialise with empty tree"
+		git update-index --force-remove $NAME ||
+			die "Could not update index"
+	else
+		BLOB=$(git hash-object -w "$MESSAGE") ||
+			die "Could not write into object database"
+		git update-index --add --cacheinfo 0644 $BLOB $NAME ||
+			die "Could not write index"
+	fi
+
+	TREE=$(git write-tree) || die "Could not write tree"
+	NEW_HEAD=$(: | git commit-tree $TREE $PARENT) ||
+		die "Could not annotate"
+	case "$CURRENT_HEAD" in
+	'') git update-ref $GIT_NOTES_REF $NEW_HEAD ;;
+	*) git update-ref $GIT_NOTES_REF $NEW_HEAD $CURRENT_HEAD;;
+	esac
+;;
+show)
+	git show "$GIT_NOTES_REF":$NAME
+;;
+*)
+	usage
+esac
-- 
1.5.3.rc1.2718.gd2dc9-dirty
