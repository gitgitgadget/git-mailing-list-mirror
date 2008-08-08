From: Thomas Rast <trast@student.ethz.ch>
Subject: [TOY PATCH] filter-branch: add option --delete-unchanged
Date: Fri,  8 Aug 2008 22:10:24 +0200
Message-ID: <1218226224-25273-1-git-send-email-trast@student.ethz.ch>
References: <1218153031-18443-1-git-send-email-trast@student.ethz.ch>
Cc: Jan Wielemaker <J.Wielemaker@uva.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 22:11:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRYJ0-0008DB-7G
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 22:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbYHHUKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbYHHUKT
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 16:10:19 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:21460 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbYHHUKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 16:10:19 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 22:10:17 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 22:10:17 +0200
X-Mailer: git-send-email 1.6.0.rc2.26.g50c1
In-Reply-To: <1218153031-18443-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 08 Aug 2008 20:10:17.0566 (UTC) FILETIME=[C6C8F7E0:01C8F992]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91708>

With --delete-unchanged, we nuke refs whose targets did not change
during rewriting.  It is intended to be used along with
--subdirectory-filter to clean out old refs from before the first
commit to the filtered subdirectory.  (They would otherwise keep the
old history alive.)

Obviously this is a rather dangerous mode of operation.

Note the "sort -u" is required: Without it, --all includes
'origin/master' twice (from 'origin/master' and via 'origin/HEAD'),
and the second pass concludes it is unchanged and nukes the ref.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This applies on top of "filter-branch: be more helpful when an
annotated tag changes".

I'm not really sure if this should go in, but it might have solved
Jan's problem.

 git-filter-branch.sh |   33 +++++++++++++++++++++++----------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a140337..539b2e6 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -114,6 +114,7 @@ filter_tag_name=
 filter_subdir=
 orig_namespace=refs/original/
 force=
+delete_unchanged=
 while :
 do
 	case "$1" in
@@ -126,6 +127,11 @@ do
 		force=t
 		continue
 		;;
+	--delete-unchanged-refs)
+		shift
+		delete_unchanged=t
+		continue
+		;;
 	-*)
 		;;
 	*)
@@ -215,6 +221,7 @@ export GIT_DIR GIT_WORK_TREE
 
 # The refs should be updated if their heads were rewritten
 git rev-parse --no-flags --revs-only --symbolic-full-name --default HEAD "$@" |
+sort -u |
 sed -e '/^^/d' >"$tempdir"/heads
 
 test -s "$tempdir"/heads ||
@@ -344,7 +351,7 @@ do
 	sha1=$(git rev-parse "$ref"^0)
 	rewritten=$(map $sha1)
 
-	test $sha1 = "$rewritten" &&
+	test $sha1 = "$rewritten" -a -z "$delete_unchanged" &&
 		warn "WARNING: Ref '$ref' is unchanged" &&
 		continue
 
@@ -355,16 +362,22 @@ do
 			die "Could not delete $ref"
 	;;
 	$_x40)
-		echo "Ref '$ref' was rewritten"
-		if ! git update-ref -m "filter-branch: rewrite" \
-					"$ref" $rewritten $sha1 2>/dev/null; then
-			if test $(git cat-file -t "$ref") = tag; then
-				if test -z "$filter_tag_name"; then
-					warn "WARNING: You said to rewrite tagged commits, but not the corresponding tag."
-					warn "WARNING: Perhaps use '--tag-name-filter cat' to rewrite the tag."
+		if test "$delete_unchanged" -a $sha1 = "$rewritten"; then
+			echo "Ref '$ref' was deleted because it is unchanged"
+			git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
+				die "Could not delete $ref"
+		else
+			echo "Ref '$ref' was rewritten"
+			if ! git update-ref -m "filter-branch: rewrite" \
+			   "$ref" $rewritten $sha1 2>/dev/null; then
+				if test $(git cat-file -t "$ref") = tag; then
+					if test -z "$filter_tag_name"; then
+						warn "WARNING: You said to rewrite tagged commits, but not the corresponding tag."
+						warn "WARNING: Perhaps use '--tag-name-filter cat' to rewrite the tag."
+					fi
+				else
+					die "Could not rewrite $ref"
 				fi
-			else
-				die "Could not rewrite $ref"
 			fi
 		fi
 	;;
-- 
1.6.0.rc2.24.gf1dd.dirty
