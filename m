From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 9/9] completion: remove broken dead code from __git_heads()
	and __git_tags()
Date: Sat,  8 Oct 2011 16:54:43 +0200
Message-ID: <1318085683-29830-10-git-send-email-szeder@ira.uka.de>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 16:57:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCYKn-0000yP-Rw
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 16:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab1JHO5B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 10:57:01 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:64768 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab1JHO5A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 10:57:00 -0400
Received: from localhost6.localdomain6 (p5B130863.dip0.t-ipconnect.de [91.19.8.99])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M1MLN-1QxVU92jXd-00twZm; Sat, 08 Oct 2011 16:56:57 +0200
X-Mailer: git-send-email 1.7.7.187.ga41de
In-Reply-To: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:c1oHj4o8WdgGg1PbD64a8CBf2ZOxRPQOJkbnrV9mZzv
 FeF2WMjk4f6VjnwqN9kwC4d5Engt7U7nYPaaSCiYMM7JuNg3sE
 N4Hxr3UAx4zAuEcPhOVQ9ATaXiNcdwOF2hA2Z9wp3OpquX5Vyl
 8r5JP31NMUpyb0Prho2fXJqh2wYNP9uPHIr5D5MP+KLvQyVRxx
 h+E5GAzGbJqG6mbfx+a1EFwkLdmKQllGTalI6X15dl1CNkcy6w
 Lp4KpcQaPZBeSVygvTz5a9zsS+EWkwcigrgijoGmgVhm+dm9tm
 2LMCKNhWFCOJ0f2cW4qNqCQaGsFfpzc6XsAzAIoIHeqq3HZCoe
 yUb7D3DeDxdwvPdyqeU4zqVVVrIC4qaj/X7FejPzhfbhHeAZL9
 p6oqwcPr13cQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183153>

__git_heads() was introduced in 5de40f5 (Teach bash about
git-repo-config., 2006-11-27), and __git_tags() in 88e21dc (Teach bash
about completing arguments for git-tag, 2007-08-31).  As their name
suggests, __git_heads() is supposed to list only branches, and
__git_tags() only tags.

Since their introduction both of these functions consist of two
distinct parts.  The first part gets branches or tags, respectively,
from a local repositoty using 'git for-each-ref'.  The second part
queries a remote repository given as argument using 'git ls-remote'.

These remote-querying parts are broken in both functions since their
introduction, because they list both branches and tags from the remote
repository.  (The 'git ls-remote' query is not limited to list only
heads or tags, respectively, and the for loop filtering the query
results prints everything except dereferenced tags.)  This breakage
could be easily fixed by passing the '--heads' or '--tags' options or
appropriate refs patterns to the 'git ls-remote' invocations.

However, that no one noticed this breakage yet is probably not a
coincidence: neither of these two functions were used to query a
remote repository, the remote-querying parts were dead code already
upon thier introduction and remained dead ever since.

Since those parts of code are broken, are and were never used, stop
the bit-rotting and remove them.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   22 ++--------------------
 1 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index d7151220..802b703d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -536,42 +536,24 @@ __gitcomp_nl ()
 	COMPREPLY=3D($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))
 }
=20
-# __git_heads accepts 0 or 1 arguments (to pass to __gitdir)
 __git_heads ()
 {
-	local cmd i is_hash=3Dy dir=3D"$(__gitdir "${1-}")"
+	local dir=3D"$(__gitdir)"
 	if [ -d "$dir" ]; then
 		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
 			refs/heads
 		return
 	fi
-	for i in $(git ls-remote "${1-}" 2>/dev/null); do
-		case "$is_hash,$i" in
-		y,*) is_hash=3Dn ;;
-		n,*^{}) is_hash=3Dy ;;
-		n,refs/heads/*) is_hash=3Dy; echo "${i#refs/heads/}" ;;
-		n,*) is_hash=3Dy; echo "$i" ;;
-		esac
-	done
 }
=20
-# __git_tags accepts 0 or 1 arguments (to pass to __gitdir)
 __git_tags ()
 {
-	local cmd i is_hash=3Dy dir=3D"$(__gitdir "${1-}")"
+	local dir=3D"$(__gitdir)"
 	if [ -d "$dir" ]; then
 		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
 			refs/tags
 		return
 	fi
-	for i in $(git ls-remote "${1-}" 2>/dev/null); do
-		case "$is_hash,$i" in
-		y,*) is_hash=3Dn ;;
-		n,*^{}) is_hash=3Dy ;;
-		n,refs/tags/*) is_hash=3Dy; echo "${i#refs/tags/}" ;;
-		n,*) is_hash=3Dy; echo "$i" ;;
-		esac
-	done
 }
=20
 # __git_refs accepts 0, 1 (to pass to __gitdir), or 2 arguments
--=20
1.7.7.187.ga41de
