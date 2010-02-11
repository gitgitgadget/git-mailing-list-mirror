From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH 3/4] git-am: Add command line parameter `--keep-cr` passing it to git-mailsplit.
Date: Thu, 11 Feb 2010 22:26:18 +0100
Message-ID: <1265923579-24900-4-git-send-email-stefan.hahn@s-hahn.de>
References: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 22:27:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfgZG-0004pW-72
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 22:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918Ab0BKV1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 16:27:14 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:53409 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756755Ab0BKV1K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 16:27:10 -0500
Received: from scotty.home (port-92-203-5-233.dynamic.qsc.de [92.203.5.233])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0M51cU-1NuaaV3GRi-00yffS; Thu, 11 Feb 2010 22:27:06 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1BLR4ma025038;
	Thu, 11 Feb 2010 22:27:04 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1BLR4uQ025034;
	Thu, 11 Feb 2010 22:27:04 +0100
X-Mailer: git-send-email 1.7.0.rc2.17.g39385
In-Reply-To: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1/Vu9sVfR9JC2RjQkgfE4U3wF+p2ExpejNGVr3
 OLqnhHUGl3GzjNYoq7IV8JL5j7IgUQIYwqv1I+VfAXwyb9NMiX
 dGaw80yiVvj9unlFkAuBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139631>

If applying patches with the following command sequence

   git format-patch --stdout ... | git am ...

in repositories having files with dos and unix line endings
git-mailsplit, which is called from git-am must be called with
`--keep-cr` parameter since commit c2ca1d79.

This patch adds the command line parameter `--keep-cr` for git-am.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 git-am.sh |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c8b9cbb..c3101ae 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -15,6 +15,7 @@ q,quiet         be quiet
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
+e,keep-cr       pass --keep-cr flag to git-mailsplit for mbox format
 c,scissors      strip everything before a scissors line
 whitespace=     pass it through git-apply
 ignore-space-change pass it through git-apply
@@ -216,10 +217,12 @@ check_patch_format () {
 split_patches () {
 	case "$patch_format" in
 	mbox)
-		case "$rebasing" in
-		'')
+		case "$rebasing,$keepcr" in
+		'','')
 			keep_cr= ;;
-		?*)
+		'',t)
+			keep_cr=--keep-cr ;;
+		?*,t)
 			keep_cr=--keep-cr ;;
 		esac
 		git mailsplit -d"$prec" -o"$dotest" -b $keep_cr -- "$@" > "$dotest/last" ||
@@ -290,7 +293,7 @@ split_patches () {
 
 prec=4
 dotest="$GIT_DIR/rebase-apply"
-sign= utf8=t keep= skip= interactive= resolved= rebasing= abort=
+sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
 resolvemsg= resume= scissors= no_inbody_headers=
 git_apply_opt=
 committer_date_is_author_date=
@@ -347,6 +350,8 @@ do
 		allow_rerere_autoupdate="$1" ;;
 	-q|--quiet)
 		GIT_QUIET=t ;;
+        -e|--keep-cr)
+                keepcr=t ;;
 	--)
 		shift; break ;;
 	*)
@@ -452,6 +457,7 @@ else
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
+	echo "$keepcr" >"$dotest/keepcr"
 	echo "$scissors" >"$dotest/scissors"
 	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
 	echo "$GIT_QUIET" >"$dotest/quiet"
@@ -495,6 +501,10 @@ if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
 fi
+if test "$(cat "$dotest/keepcr")" = t
+then
+	keepcr=--keep-cr
+fi
 case "$(cat "$dotest/scissors")" in
 t)
 	scissors=--scissors ;;
-- 
1.7.0.rc2.17.g39385
