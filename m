From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: use for-each-ref format 'refname:short'
Date: Sat, 20 Sep 2008 00:15:25 +0200
Message-ID: <1221862525-20574-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 20 00:17:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgoHj-0000OG-7Y
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 00:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbYISWP5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 18:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbYISWP5
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 18:15:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:60573 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbYISWP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 18:15:57 -0400
Received: from [127.0.1.1] (p5B1335D9.dip0.t-ipconnect.de [91.19.53.217])
	by mrelayeu.kundenserver.de (node=mrelayeu1) with ESMTP (Nemesis)
	id 0MKwpI-1KgoG51yov-00071X; Sat, 20 Sep 2008 00:15:26 +0200
X-Mailer: git-send-email 1.6.0.2.294.g50836f
X-Provags-ID: V01U2FsdGVkX1/bIxP8xlvoJuGD+kjmBGgZFyLIwR2pydjw4zn
 dpqyT0b1ioiYkuIxOqyjxA24uoZNC697QDH2Kjfen4MRlB1HFP
 ltF6nqyp/AkK9R00K8ejw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96319>

Using this format simplifies the code for completing refs and (in some
cases) improves performance significantly.

=46or repositories like the current git.git (with more than 200 refs)
there is no real performance difference, but for a repository with 2000
refs the total time needed to complete the refs is reduced by ~25% (fro=
m
around 400ms to around 305ms).

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

 OK, so after the refname:short patch hit master, here is the updated
 patch to use it in bash completion.  The patch itself is the same as
 the original one, except, of course, the for-each-ref format name.  I
 have also adjusted the performance numbers in the commit message.

 contrib/completion/git-completion.bash |   26 ++++++------------------=
--
 1 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index d3fb6ae..fccb499 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -154,11 +154,8 @@ __git_heads ()
 {
 	local cmd i is_hash=3Dy dir=3D"$(__gitdir "$1")"
 	if [ -d "$dir" ]; then
-		for i in $(git --git-dir=3D"$dir" \
-			for-each-ref --format=3D'%(refname)' \
-			refs/heads ); do
-			echo "${i#refs/heads/}"
-		done
+		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
+			refs/heads
 		return
 	fi
 	for i in $(git ls-remote "$1" 2>/dev/null); do
@@ -175,11 +172,8 @@ __git_tags ()
 {
 	local cmd i is_hash=3Dy dir=3D"$(__gitdir "$1")"
 	if [ -d "$dir" ]; then
-		for i in $(git --git-dir=3D"$dir" \
-			for-each-ref --format=3D'%(refname)' \
-			refs/tags ); do
-			echo "${i#refs/tags/}"
-		done
+		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
+			refs/tags
 		return
 	fi
 	for i in $(git ls-remote "$1" 2>/dev/null); do
@@ -197,16 +191,8 @@ __git_refs ()
 	local cmd i is_hash=3Dy dir=3D"$(__gitdir "$1")"
 	if [ -d "$dir" ]; then
 		if [ -e "$dir/HEAD" ]; then echo HEAD; fi
-		for i in $(git --git-dir=3D"$dir" \
-			for-each-ref --format=3D'%(refname)' \
-			refs/tags refs/heads refs/remotes); do
-			case "$i" in
-				refs/tags/*)    echo "${i#refs/tags/}" ;;
-				refs/heads/*)   echo "${i#refs/heads/}" ;;
-				refs/remotes/*) echo "${i#refs/remotes/}" ;;
-				*)              echo "$i" ;;
-			esac
-		done
+		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
+			refs/tags refs/heads refs/remotes
 		return
 	fi
 	for i in $(git ls-remote "$dir" 2>/dev/null); do
--=20
1.6.0.2.294.g50836f
