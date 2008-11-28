From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: complete full refs
Date: Fri, 28 Nov 2008 01:46:38 +0100
Message-ID: <20081128004638.GA6854@neumann>
References: <1227792947-4055-1-git-send-email-szeder@ira.uka.de>
	<20081127212938.GB23984@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 28 01:53:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5rbS-00019t-5z
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 01:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbYK1Avq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Nov 2008 19:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbYK1Avp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 19:51:45 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:55725 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbYK1Avp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 19:51:45 -0500
Received: from [127.0.1.1] (p5B1338EC.dip0.t-ipconnect.de [91.19.56.236])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1L5rVH189v-0004OE; Fri, 28 Nov 2008 01:46:39 +0100
Content-Disposition: inline
In-Reply-To: <20081127212938.GB23984@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/duSzOkqp+0UuwlTYe67DjZDYR+InoD9IWtBg
 PiNO0HBKkKYq6xYl3AgXxPv3Nfuqaww/dbCU1vA2fEoWTm7YkR
 ztlCAwSj3YdLhSk+IWsHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101852>

Sometimes it's handy to complete full refs, e.g. the user has some
refs outside of refs/{heads,remotes,tags} or the user wants to
complete some git command's special refs (like 'git show
refs/bisect/bad').

To do that, we check whether the ref to be completed starts with
'refs/' or is 'refs' (to reduce the risk of matching 'refs-').  If it
does, then we offer full refs for completion; otherwise everything
works as usual.

This way the impact on the common case is fairly small (hopefully not
many users have branches or tags starting with 'refs'), and in the
special case the cost of typing out 'refs' is bearable.

While at it, also remove the unused 'cmd' variable from '__git_refs'.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

On Thu, Nov 27, 2008 at 01:29:38PM -0800, Shawn O. Pearce wrote:
> I wonder if the pattern shouldn't be:
>=20
> 	refs|refs/*)
>=20
> to reduce the risk of matching "refs-" and trying to do a full ref
> match instead of a short ref match.
Good point.  Adjusted the code and commit message accordingly.


 contrib/completion/git-completion.bash |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0ee071b..244ed41 100755
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
+		refs|refs/*)
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
