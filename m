From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: complete full refs
Date: Thu, 27 Nov 2008 14:35:47 +0100
Message-ID: <1227792947-4055-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 27 14:37:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5h3X-0001MG-36
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 14:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbYK0Nft convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Nov 2008 08:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277AbYK0Nft
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 08:35:49 -0500
Received: from francis.fzi.de ([141.21.7.5]:54244 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753238AbYK0Nft (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 08:35:49 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 27 Nov 2008 14:35:47 +0100
X-Mailer: git-send-email 1.6.0.4.814.gfe502
X-OriginalArrivalTime: 27 Nov 2008 13:35:47.0607 (UTC) FILETIME=[0E3E1A70:01C95095]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101810>

Sometimes it's handy to complete full refs, e.g. the user has some
refs outside of refs/{heads,remotes,tags} or the user wants to
complete some git command's special refs (like 'git show
refs/bisect/bad').

To do that, we check whether the ref to be completed starts with
'refs'.  If it does, then we offer full refs for completion; otherwise
everything works as usual.

This way the impact on the common case is fairly small (hopefully not
many users have branches or tags starting with 'refs'), and in the
special case the cost of typing out 'refs' is bearable.

While at it, also remove the unused 'cmd' variable from '__git_refs'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0ee071b..39bf18b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -188,11 +188,22 @@ __git_tags ()
=20
 __git_refs ()
 {
-	local cmd i is_hash=3Dy dir=3D"$(__gitdir "$1")"
+	local i is_hash=3Dy dir=3D"$(__gitdir "$1")"
+	local cur=3D"${COMP_WORDS[COMP_CWORD]}" format refs
 	if [ -d "$dir" ]; then
-		if [ -e "$dir/HEAD" ]; then echo HEAD; fi
-		git --git-dir=3D"$dir" for-each-ref --format=3D'%(refname:short)' \
-			refs/tags refs/heads refs/remotes
+		case "$cur" in
+		refs*)
+			format=3D"refname"
+			refs=3D"${cur%/*}"
+			;;
+		*)
+			if [ -e "$dir/HEAD" ]; then echo HEAD; fi
+			format=3D"refname:short"
+			refs=3D"refs/tags refs/heads refs/remotes"
+			;;
+		esac
+		git --git-dir=3D"$dir" for-each-ref --format=3D"%($format)" \
+			$refs
 		return
 	fi
 	for i in $(git ls-remote "$dir" 2>/dev/null); do
--=20
1.6.0.4.814.gfe502
