From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 4/9] completion: improve ls-remote output filtering in
	__git_refs()
Date: Sat,  8 Oct 2011 16:54:38 +0200
Message-ID: <1318085683-29830-5-git-send-email-szeder@ira.uka.de>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 16:56:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCYJt-0000cQ-LK
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 16:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab1JHO4D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 10:56:03 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:55871 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab1JHO4B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 10:56:01 -0400
Received: from localhost6.localdomain6 (p5B130863.dip0.t-ipconnect.de [91.19.8.99])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MWtPb-1RbV8k1OwN-00XwqT; Sat, 08 Oct 2011 16:55:53 +0200
X-Mailer: git-send-email 1.7.7.187.ga41de
In-Reply-To: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:V2LIJx4aGviTNBAkI2D59ShZZvJ/CLvu443SD2oR+e6
 jHNdf2gzTZXFr/V9g1QmgjxgNwMc38WUMSnhD72pIn59Ul7wCI
 WnNDH4PQY5bjtpbzqcIZVRAPNFrP+YGhPFaEbyOrtq6RdQ2PDC
 gsnXPgPO8B5IqIAJTtb0oYRkLBkmEwQVG4BVuZ74H02HghmjpH
 x4yGtcqA/nHKfn80saBOH+4gXhF9iYVTIgv8N4kVFcHh/5o/AQ
 zWScUQMVW4itnFJxfQvh3QRwn4M8ZmquB57qs8sZpw5fbrppAH
 84VoCUTk24365383zeQ1kyXBE4ZKHY/mTOMq3GXie+s6p1Db0u
 Dq4+hZN2YL/OEEZt/oMNj60YvaE9DjRZRF2+qLQJ03+Q9o59Vt
 wMa06fmz0IrLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183148>

The remote-handling part of __git_refs() has a nice for loop and state
machine case statement to iterate over all words from the output of
'git ls-remote' to identify object names and ref names.  Since each
line in the output of 'git ls-remote' consists of an object name and a
ref name, we can do more effective filtering by using a while-read
loop and letting bash's word splitting take care of object names.
This way the code is easier to understand and the loop will need only
half the number of iterations than before.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6b5dc5cd..c6ab742d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -579,7 +579,7 @@ __git_tags ()
 # by checkout for tracking branches
 __git_refs ()
 {
-	local i is_hash=3Dy dir=3D"$(__gitdir "${1-}")" track=3D"${2-}"
+	local i hash dir=3D"$(__gitdir "${1-}")" track=3D"${2-}"
 	local format refs
 	if [ -d "$dir" ]; then
 		case "$cur" in
@@ -615,12 +615,12 @@ __git_refs ()
 		fi
 		return
 	fi
-	for i in $(git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/he=
ads/*' 'refs/remotes/*' 2>/dev/null); do
-		case "$is_hash,$i" in
-		y,*) is_hash=3Dn ;;
-		n,*^{}) is_hash=3Dy ;;
-		n,refs/*) is_hash=3Dy; echo "${i#refs/*/}" ;;
-		n,*) is_hash=3Dy; echo "$i" ;;
+	git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/heads/*' 'ref=
s/remotes/*' 2>/dev/null | \
+	while read hash i; do
+		case "$i" in
+		*^{}) ;;
+		refs/*) echo "${i#refs/*/}" ;;
+		*) echo "$i" ;;
 		esac
 	done
 }
--=20
1.7.7.187.ga41de
