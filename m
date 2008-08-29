From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [RFC/PATCH 2/2] bash: use for-each-ref format 'refbasename'
Date: Fri, 29 Aug 2008 12:37:20 +0200
Message-ID: <31df5ea75841b142240e04ac82153c39d5e11abb.1220004755.git.szeder@ira.uka.de>
References: <0329f1ab2642e1dab701b5fc6517bfb1b4ea2d46.1220004755.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 12:38:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ1NP-00082Y-Hg
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 12:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286AbYH2Kha convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Aug 2008 06:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbYH2Kh3
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 06:37:29 -0400
Received: from francis.fzi.de ([141.21.7.5]:20511 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753194AbYH2KhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 06:37:25 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 12:37:21 +0200
X-Mailer: git-send-email 1.6.0.1.133.g10dd.dirty
In-Reply-To: <0329f1ab2642e1dab701b5fc6517bfb1b4ea2d46.1220004755.git.szeder@ira.uka.de>
In-Reply-To: <0329f1ab2642e1dab701b5fc6517bfb1b4ea2d46.1220004755.git.szeder@ira.uka.de>
References: <0329f1ab2642e1dab701b5fc6517bfb1b4ea2d46.1220004755.git.szeder@ira.uka.de>
X-OriginalArrivalTime: 29 Aug 2008 10:37:21.0469 (UTC) FILETIME=[37B596D0:01C909C3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using this format simplifies the code for completing refs and (in some
cases) improves performance significantly.

=46or repositories like the current git.git (with more than 200 refs)
there are no real performance difference, but for a repository with 200=
0
refs the total time needed to complete the refs is around 40% less (fro=
m
around 480ms to around 295ms).

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   26 ++++++------------------=
--
 1 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 4f64f8a..8269c42 100755
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
+		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refbasename)' \
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
+		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refbasename)' \
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
+		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refbasename)' \
+			refs/tags refs/heads refs/remotes
 		return
 	fi
 	for i in $(git ls-remote "$dir" 2>/dev/null); do
--=20
1.6.0.1.133.g10dd.dirty
