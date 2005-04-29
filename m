From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] allow cg-log to display commit entries for particular
 files/directories
Date: Thu, 28 Apr 2005 23:27:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504282308200.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 05:21:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRM4Z-0006Dn-Ft
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 05:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVD2D1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 23:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVD2D1M
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 23:27:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:7649 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262376AbVD2D1F
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 23:27:05 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFO00KQAUX2FN@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Apr 2005 23:27:02 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch allows for one or more paths to be specified with the effect 
of restricting the log to commits that affected those files or files 
under given directories.

This is not perfect as some merge commits might or might not be listed.
But usually they're not really interesting in the context of this 
feature.  It is otherwise pretty simple and effective until a better 
tool is available.

For example:

	cg-log arch/arm/kernel/

will show all commits that affected files under arch/arm/kernel/ 
starting from the head branch.

Signed-off-by: Nicolas Pitre <nico@cam.org>

--- k/cg-log
+++ l/cg-log
@@ -14,6 +14,9 @@
 #
 # Takes an id resolving to a commit to start from (HEAD by default),
 # or id1:id2 representing an (id1;id2] range of commits to show.
+#
+# May also take one or more files and/or directories to reduce the
+# log to commits modifying those files/directories only.
 
 . cg-Xlib
 
@@ -33,14 +36,16 @@ else
 	coldefault=
 fi
 
-if echo "$1" | grep -q ':'; then
-	id1=$(commit-id $(echo "$1" | cut -d : -f 1)) || exit 1
-	id2=$(commit-id $(echo "$1" | cut -d : -f 2)) || exit 1
+id="$1"; [ -a "$1" ] && id="" || shift
+
+if echo "$id" | grep -q ':'; then
+	id1=$(commit-id $(echo "$id" | cut -d : -f 1)) || exit 1
+	id2=$(commit-id $(echo "$id" | cut -d : -f 2)) || exit 1
 	revls="rev-tree $id2 ^$id1"
 	revsort="sort -rn"
 	revfmt="rev-tree"
 else
-	id1="$(commit-id $1)" || exit 1
+	id1="$(commit-id $id)" || exit 1
 	revls="rev-list $id1" || exit 1
 	revsort="cat"
 	revfmt="rev-list"
@@ -48,6 +53,10 @@ fi
 
 $revls | $revsort | while read time commit parents; do
 	[ "$revfmt" = "rev-list" ] && commit="$time"
+	if [ $# -ne 0 ]; then
+		parent=$(cat-file commit $commit | sed -n '2s/parent //p;2Q')
+		[ "$parent" ] && [ "$(diff-tree -r $commit $parent "$@")" ] || continue
+	fi
 	echo $colheader""commit ${commit%:*} $coldefault;
 	cat-file commit $commit | \
 		while read key rest; do
