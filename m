From: aneesh.kumar@gmail.com
Subject: [PATCH] topgit: Implement tg-import
Date: Tue, 12 Aug 2008 22:05:43 +0530
Message-ID: <1218558943-14398-1-git-send-email-aneesh.kumar@gmail.com>
Cc: git@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
To: pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Aug 12 19:04:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSxIJ-00041D-AR
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 19:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbYHLRDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 13:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbYHLRDT
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 13:03:19 -0400
Received: from E23SMTP02.au.ibm.com ([202.81.18.163]:38420 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbYHLRDS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 13:03:18 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m7CGZWj4014757
	for <git@vger.kernel.org>; Wed, 13 Aug 2008 02:35:32 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7CGZumZ304222
	for <git@vger.kernel.org>; Wed, 13 Aug 2008 02:35:56 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m7CGZuTA023170
	for <git@vger.kernel.org>; Wed, 13 Aug 2008 02:35:56 +1000
Received: from localhost.localdomain ([9.77.81.154])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id m7CGZnWX023097;
	Wed, 13 Aug 2008 02:35:50 +1000
X-Mailer: git-send-email 1.6.0.rc0.42.g186458.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92116>

From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

This can be used to import a set of commits
between range specified by range1..range2
This should help us to convert an already
existing quilt, stgit branches to topgit
managed one

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---
 tg-import.sh |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100644 tg-import.sh

diff --git a/tg-import.sh b/tg-import.sh
new file mode 100644
index 0000000..0158f3b
--- /dev/null
+++ b/tg-import.sh
@@ -0,0 +1,97 @@
+#!/bin/bash
+#derived out of git-format-patch.sh
+
+function die()
+{
+	echo >&2 "$@"
+	exit 1
+}
+
+function tg_get_commit_msg
+{
+	commit=$1
+commitScript='
+	1,/^$/d
+	: loop
+	/^$/b loop
+	: body
+	p
+	n
+	b body'
+	author=$(git cat-file commit "$commit" | grep author |
+		cut -d ">" -f 1 | sed -ne "s/author//gp")
+	echo "From: "$author">"
+	git cat-file commit "$commit" | sed -ne "$commitScript"
+}
+
+function tg_get_patch
+{
+	git show $1
+}
+
+function tg_get_branch_name
+{
+
+titleScript='
+	1,/^$/d
+	: loop
+	/^$/b loop
+	s/[^-a-z.A-Z_0-9]/-/g
+        s/\.\.\.*/\./g
+	s/\.*$//
+	s/--*/-/g
+	s/^-//
+	s/-$//
+	q
+'
+	commit=$1
+	title=$(git cat-file commit "$commit" | sed -e "$titleScript")
+	echo ${title}
+}
+
+tmp=.tmp-series$$
+trap 'rm -f $tmp-*' 0 1 2 3 15
+
+series=$tmp-series
+# Now we have what we want in $@
+for revpair
+do
+	case "$revpair" in
+	?*..?*)
+		rev1=`expr "z$revpair" : 'z\(.*\)\.\.'`
+		rev2=`expr "z$revpair" : 'z.*\.\.\(.*\)'`
+		;;
+	*)
+		echo >&2 "Unknow range spec $revpair"
+		exit
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
+			echo >&2 "Merged already: $comment"
+			;;
+		*)
+			echo $rev
+			;;
+		esac
+	done
+done >$series
+
+while read commit
+do
+	branch_name=$(tg_get_branch_name $commit)
+	echo "Importing $commit to $branch_name"
+	tg create tp/$branch_name
+	tg_get_commit_msg $commit > .topmsg
+	git add .topmsg
+	git commit -a -m "Add the commit message for the topic branch"
+	tg_get_patch $commit | patch -p1
+	git commit -a -m "Import the initial patch to the topic branch"
+done < $series
-- 
1.6.0.rc0.42.g186458.dirty
