From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] topgit: Implement tg-import
Date: Wed, 13 Aug 2008 20:45:11 +0530
Message-ID: <1218640511-12693-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: git@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
To: pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Aug 13 17:16:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTI5K-0005Wc-9G
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 17:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbYHMPPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 11:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYHMPPW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 11:15:22 -0400
Received: from E23SMTP03.au.ibm.com ([202.81.18.172]:54154 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbYHMPPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 11:15:22 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m7DFEEEe031115
	for <git@vger.kernel.org>; Thu, 14 Aug 2008 01:14:14 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7DFFJHc1585362
	for <git@vger.kernel.org>; Thu, 14 Aug 2008 01:15:19 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m7DFFIVb000310
	for <git@vger.kernel.org>; Thu, 14 Aug 2008 01:15:19 +1000
Received: from localhost.localdomain ([9.77.121.107])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m7DFFCTX032699;
	Thu, 14 Aug 2008 01:15:13 +1000
X-Mailer: git-send-email 1.6.0.rc0.42.g186458.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92227>

From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

This can be used to import a set of commits
between range specified by range1..range2
This should help us to convert an already
existing quilt, stgit branches to topgit
managed one

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 Makefile     |    2 +-
 README       |    7 ++++++
 tg-import.sh |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletions(-)
 create mode 100644 tg-import.sh

diff --git a/Makefile b/Makefile
index 6eade1e..95624ac 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,7 @@ sharedir = $(PREFIX)/share/topgit
 hooksdir = $(cmddir)/hooks
 
 
-commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh
+commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh tg-import.sh
 hooks_in = hooks/pre-commit.sh
 
 commands_out = $(patsubst %.sh,%,$(commands_in))
diff --git a/README b/README
index b58a1b4..8b8f4d7 100644
--- a/README
+++ b/README
@@ -330,6 +330,13 @@ tg export
 	TODO: Make stripping of [PATCH] and other prefixes configurable
 	TODO: --mbox option for other mode of operation
 
+tg import
+~~~~~~~~
+	Import the commits between the given revision range into
+	a topgit managed branch
+
+	Usage: tg import rev1..rev2
+
 tg update
 ~~~~~~~~~
 	Update the current topic branch wrt. changes in the branches
diff --git a/tg-import.sh b/tg-import.sh
new file mode 100644
index 0000000..6c991c5
--- /dev/null
+++ b/tg-import.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# GPLv2
+
+
+tg_get_commit_msg()
+{
+	commit="$1"
+	git log -1 --pretty=format:"From: %an <%ae>%n%n%s%n%n%b" "$commit"
+}
+
+tg_get_branch_name()
+{
+	# nice sed script from git-format-patch.sh
+	commit="$1"
+	titleScript='
+	s/[^-a-z.A-Z_0-9]/-/g
+        s/\.\.\.*/\./g
+	s/\.*$//
+	s/--*/-/g
+	s/^-//
+	s/-$//
+	q
+'
+	git log -1 --pretty=format:"%s" "$commit" | sed -e "$titleScript"
+}
+
+tg_process_commit()
+{
+	commit="$1"
+	branch_name=$(tg_get_branch_name "$commit")
+	echo "Importing $commit to $branch_name"
+	tg create tp/"$branch_name"
+	git read-tree "$commit"
+	tg_get_commit_msg "$commit" > .topmsg
+	git add -f .topmsg .topdeps
+	git commit -C "$commit"
+}
+
+# nice arg verification stolen from git-format-patch.sh
+for revpair
+do
+	case "$revpair" in
+	?*..?*)
+		rev1=`expr "z$revpair" : 'z\(.*\)\.\.'`
+		rev2=`expr "z$revpair" : 'z.*\.\.\(.*\)'`
+		;;
+	*)
+		die "Unknow range spec $revpair"
+		;;
+	esac
+	git rev-parse --verify "$rev1^0" >/dev/null 2>&1 ||
+		die "Not a valid rev $rev1 ($revpair)"
+	git rev-parse --verify "$rev2^0" >/dev/null 2>&1 ||
+		die "Not a valid rev $rev2 ($revpair)"
+	git cherry -v "$rev1" "$rev2" |
+	while read sign rev comment
+	do
+		case "$sign" in
+		'-')
+			info "Merged already: $comment"
+			;;
+		*)
+			tg_process_commit "$rev"
+			;;
+		esac
+	done
+done
-- 
1.6.0.rc0.42.g186458.dirty
