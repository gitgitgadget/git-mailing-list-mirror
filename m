From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: git-am: Add command line parameter `--keep-cr` passing it to
	git-mailsplit.
Date: Thu, 11 Feb 2010 19:14:12 +0100
Message-ID: <20100211181412.GD15028@scotty.home>
References: <1265911741-14840-1-git-send-email-stefan.hahn@s-hahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 19:14:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfdYT-00050B-6f
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 19:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721Ab0BKSOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 13:14:16 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:52818 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab0BKSOP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 13:14:15 -0500
Received: from scotty.home (port-92-203-5-233.dynamic.qsc.de [92.203.5.233])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Le9EG-1O2v4T3m4S-00qFP5; Thu, 11 Feb 2010 19:14:14 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1BIEDCY015176
	for <git@vger.kernel.org>; Thu, 11 Feb 2010 19:14:13 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1BIED6v015175
	for git@vger.kernel.org; Thu, 11 Feb 2010 19:14:13 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <1265911741-14840-1-git-send-email-stefan.hahn@s-hahn.de>
X-Mailer: git-send-email 1.7.0.rc1.50.g84249.dirty
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1/idQUfe2iOTuNP1KjMPcOvLHl/TwIOLGLHM60
 +o8NjjzqQelbZhivLn8hePmYRyowLIumYzO3sZXZQbYCj9bM0x
 OMT6KbiIQtWJ/aLeiv6BQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139613>

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
1.7.0.rc1.50.g84249.dirty
