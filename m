From: Heiko Hund <hhund@astaro.com>
Subject: [TopGit PATCH] --strip option for tg export
Date: Thu, 12 Nov 2009 11:15:08 +0100
Message-ID: <1258020908-31714-1-git-send-email-hhund@astaro.com>
Cc: Heiko Hund <hhund@astaro.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 11:30:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Wwi-0002p7-0T
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 11:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbZKLKaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 05:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbZKLKaT
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 05:30:19 -0500
Received: from dhost002-50.dex002.intermedia.net ([64.78.21.148]:18261 "EHLO
	dhost002-50.dex002.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751730AbZKLKaS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 05:30:18 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2009 05:30:18 EST
Received: from MISD002-3.dex002.intermedia.net ([64.78.61.45]) by dhost002-50.dex002.intermedia.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 12 Nov 2009 02:15:11 -0800
Received: from localhost.localdomain ([213.144.15.3]) by MISD002-3.dex002.intermedia.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 12 Nov 2009 02:15:10 -0800
X-Mailer: git-send-email 1.6.0.4
X-OriginalArrivalTime: 12 Nov 2009 10:15:10.0917 (UTC) FILETIME=[04657750:01CA6381]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132762>

This introduces the '--strip[=N]' option for 'tg export --quilt' to enable
export of a flat quilt series, even if the tg branch names are structured
hierarchically.

It may be useful if you - like me - structure your topgit branches like
"t/<NN>/<NAME>" to keep the overview in git, but don't want the exported
quilt series to be spread across subdirectories.

In contrast to '--flatten' this option removes the first 'N' or all
subdirectories from the topgit branch name, while keeping compatible with
the existing options. The remaining ones can still be flattened. Patch
names can still get numbered.

Signed-off-by: Heiko Hund <hhund@astaro.com>

---
 README       |    8 +++++---
 tg-export.sh |   47 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/README b/README
index 495c70b..44b60e1 100644
--- a/README
+++ b/README
@@ -429,9 +429,11 @@ tg export
 	In '--quilt' mode the patches are named like the originating topgit
 	branch.  So usually they end up in subdirectories of the output
 	directory.  With option '--flatten' the names are mangled such that
-	they end up directly in the output dir (i.e. slashed are substituted by
-	underscores).  With '--numbered' (which implies '--flatten') the patch
-	names get a number as prefix to allow getting the order without
+	they end up directly in the output dir (i.e. slashes are substituted by
+	underscores).  With option '--strip[=N]' the first 'N' subdirectories (all
+	if no 'N' is given) get stripped off.  Names are always '--strip'ped
+	before '--flatten'ed.  With option '--numbered' (which implies '--flatten')
+	the patch names get a number as prefix to allow getting the order without
 	consulting the series file, which eases sending out the patches.
 
 	Usage: tg export ([(--collapse | --linearize)] BRANCH | --quilt DIR)
diff --git a/tg-export.sh b/tg-export.sh
index a16c290..a65c731 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -9,6 +9,8 @@ output=
 driver=collapse
 flatten=false
 numbered=false
+strip=false
+stripval=0
 
 
 ## Parse options
@@ -23,6 +25,17 @@ while [ -n "$1" ]; do
 	--numbered)
 		flatten=true;
 		numbered=true;;
+	--strip*)
+		val=${arg#*=}
+		if [ "$val" = "--strip" ]; then
+			strip=true
+			stripval=9999
+		elif [ -n "$val" -a "x$(echo $val | sed -e 's/[0-9]//g')" = "x" ]; then
+			strip=true
+			stripval=$val
+		else
+			die "invalid parameter $arg"
+		fi;;
 	--quilt)
 		driver=quilt;;
 	--collapse)
@@ -49,6 +62,9 @@ done
 [ "$driver" = "quilt" ] || ! "$flatten" ||
 	die "--flatten works only with the quilt driver"
 
+[ "$driver" = "quilt" ] || ! "$strip" ||
+	die "--strip works only with the quilt driver"
+
 if [ -z "$branches" ]; then
 	# this check is only needed when no branches have been passed
 	name="$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
@@ -162,16 +178,27 @@ quilt()
 		return
 	fi
 
-	if "$flatten"; then
-		bn="$(echo "$_dep.diff" | sed -e 's#_#__#g' -e 's#/#_#g')";
-		dn="";
-	else
-		bn="$(basename "$_dep.diff")";
-		dn="$(dirname "$_dep.diff")/";
-		if [ "x$dn" = "x./" ]; then
-			dn="";
-		fi;
-	fi;
+	_dep_tmp=$_dep
+
+	if "$strip"; then
+		i=$stripval
+		while [ "$i" -gt 0 ]; do
+			[ "$_dep_tmp" = "${_dep_tmp#*/}" ] && break
+			_dep_tmp=${_dep_tmp#*/}
+			i=$((i - 1))
+		done
+	fi
+
+	bn="$(basename "$_dep_tmp.diff")"
+	dn="$(dirname "$_dep_tmp.diff")/"
+	[ "x$dn" = "x./" ] && dn=""
+
+	if "$flatten" && [ "$dn" ]; then
+		bn="$(echo "$_dep_tmp.diff" | sed -e 's#_#__#g' -e 's#/#_#g')"
+		dn=""
+	fi
+
+	unset _dep_tmp
 
 	if [ -e "$playground/$_dep" ]; then
 		# We've already seen this dep
-- 
tg: (f59e4f9..) strip_param_for_export (depends on: 0.8)
