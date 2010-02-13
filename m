From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH 2/3] git-am: Add command line parameter `--keep-cr` passing it to git-mailsplit.
Date: Sat, 13 Feb 2010 17:59:21 +0100
Message-ID: <1266080362-24760-3-git-send-email-stefan.hahn@s-hahn.de>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 18:20:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgLfU-0003qK-4b
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 18:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468Ab0BMRUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 12:20:16 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:64459 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757178Ab0BMRUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 12:20:06 -0500
Received: from scotty.home (port-92-203-27-201.dynamic.qsc.de [92.203.27.201])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MMYTG-1NcSz43fAc-007rHG; Sat, 13 Feb 2010 18:20:05 +0100
Received: from scotty.home (smmsp@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1DHK1YN026401
	for <git@vger.kernel.org>; Sat, 13 Feb 2010 18:20:02 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1DH0kMM025104;
	Sat, 13 Feb 2010 18:00:46 +0100
X-Mailer: git-send-email 1.7.0.rc2.31.g49e2a
In-Reply-To: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX18fOZAJ89r05jmb9igTftp9jxgbnd6qvUS6bKJ
 ONuuH3gOqUMbAFF3fWLBRkMDB9pz3UjuI/GWhAsPH2K6tAMHsH
 WZycIxXSPcpdGtRsP0srA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139818>

The behaviour of git-mailsplit, which is called from git-am for
patches in mbox format, has been changed in commit c2ca1d79. The new
default behaviour will remove `\r` from line endings with `\r\n`.

If applying patches with the following command sequence

   git format-patch --stdout ... | git am ...

in repositories having files with dos and unix line endings,
git-mailsplit must be called with `--keep-cr` parameter.

This patch adds the command line parameter `--keep-cr` for git-am and
the configuration `am.keepcr`.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 Documentation/config.txt |    6 ++++++
 git-am.sh                |   27 ++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4c36aa9..aa452f3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -550,6 +550,12 @@ it will be treated as a shell command.  For example, defining
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.
 
+am.keepcr::
+	If true, git-am will call git-mailsplit for patches in mbox format 
+	with parameter '--keep-cr'. In this case git-mailsplit will
+	not remove `\r` from lines ending with `\r\n`. 
+	See linkgit:git-am[1], linkgit:git-mailsplit[1].
+
 apply.ignorewhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
 	whitespace, in the same way as the '--ignore-space-change'
diff --git a/git-am.sh b/git-am.sh
index c8b9cbb..3057a83 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -15,6 +15,7 @@ q,quiet         be quiet
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
+keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
 c,scissors      strip everything before a scissors line
 whitespace=     pass it through git-apply
 ignore-space-change pass it through git-apply
@@ -216,12 +217,12 @@ check_patch_format () {
 split_patches () {
 	case "$patch_format" in
 	mbox)
-		case "$rebasing" in
-		'')
-			keep_cr= ;;
-		?*)
-			keep_cr=--keep-cr ;;
-		esac
+		if test -n "$rebasing$keepcr"
+		then
+                    keep_cr=--keep-cr
+		else
+                    keep_cr=
+		fi
 		git mailsplit -d"$prec" -o"$dotest" -b $keep_cr -- "$@" > "$dotest/last" ||
 		clean_abort
 		;;
@@ -290,13 +291,18 @@ split_patches () {
 
 prec=4
 dotest="$GIT_DIR/rebase-apply"
-sign= utf8=t keep= skip= interactive= resolved= rebasing= abort=
+sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
 resolvemsg= resume= scissors= no_inbody_headers=
 git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
 allow_rerere_autoupdate=
 
+if test "$(git config --bool --get am.keepcr)" = true
+then 
+    keepcr=t
+fi
+
 while test $# != 0
 do
 	case "$1" in
@@ -347,6 +353,8 @@ do
 		allow_rerere_autoupdate="$1" ;;
 	-q|--quiet)
 		GIT_QUIET=t ;;
+	--keep-cr)
+		keepcr=t ;;
 	--)
 		shift; break ;;
 	*)
@@ -452,6 +460,7 @@ else
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
+	echo "$keepcr" >"$dotest/keepcr"
 	echo "$scissors" >"$dotest/scissors"
 	echo "$no_inbody_headers" >"$dotest/no_inbody_headers"
 	echo "$GIT_QUIET" >"$dotest/quiet"
@@ -495,6 +504,10 @@ if test "$(cat "$dotest/keep")" = t
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
1.7.0.rc2.31.g49e2a
