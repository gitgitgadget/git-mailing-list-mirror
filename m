From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH 2/3] git-am: Add command line parameter `--keep-cr` passing
	it to git-mailsplit.
Date: Sat, 13 Feb 2010 18:11:27 +0100
Message-ID: <20100213171127.GB14754@scotty.home>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 18:11:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgLWz-00075B-LU
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 18:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757562Ab0BMRLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 12:11:31 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:57021 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757426Ab0BMRLa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 12:11:30 -0500
Received: from scotty.home (port-92-203-27-201.dynamic.qsc.de [92.203.27.201])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0M1QSH-1O0CjJ32mv-00u3n3; Sat, 13 Feb 2010 18:11:29 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1DHBROG025940;
	Sat, 13 Feb 2010 18:11:27 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1DHBRop025938;
	Sat, 13 Feb 2010 18:11:27 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
X-Mailer: git-send-email 1.7.0.rc2.31.g49e2a
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX181beJV0qoGVQeKwYgvlo6W6Tg4td0iYm9hLip
 uwNUHVmtzdFFVrO2IA1ZhlDfsFsipTcWTy6jc87oZCKFiaeD/0
 3ns7dDKEKb+fS5ijkcjEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139815>

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
