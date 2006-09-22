From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Fetch: default remote repository from config
Date: Sat, 23 Sep 2006 01:26:46 +0200
Message-ID: <878xkba3ex.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 23 01:27:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQuQ2-0004zR-A9
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 01:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWIVX0v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Sep 2006 19:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWIVX0v
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 19:26:51 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:23438 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S964920AbWIVX0v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 19:26:51 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8MNQmQ25741
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 01:26:48 +0200
To: git <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27545>


If in branch "foo" and this in config:

[branch "foo"]
        remote=3Dbar

"git fetch" =3D "git fetch bar"
"git  pull" =3D "git pull  bar"

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/config.txt |    3 +++
 git-fetch.sh             |   11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bb2fbc3..fa20e28 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -119,6 +119,9 @@ apply.whitespace::
 	Tells `git-apply` how to handle whitespaces, in the same way
 	as the '--whitespace' option. See gitlink:git-apply[1].
=20
+branch.<name>.remote::
+	When in branch <name>, it tells `git pull` which remote to fetch.
+
 pager.color::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/git-fetch.sh b/git-fetch.sh
index 09a5d6c..e3b8f26 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -68,11 +68,12 @@ done
=20
 case "$#" in
 0)
-	test -f "$GIT_DIR/branches/origin" ||
-		test -f "$GIT_DIR/remotes/origin" ||
-			git-repo-config --get remote.origin.url >/dev/null ||
-				die "Where do you want to fetch from today?"
-	set origin ;;
+	curr_branch=3D$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
+	origin=3D$(git-repo-config --get "branch.$curr_branch.remote")
+	origin=3D${origin:-origin}
+	test -n "$(get_remote_url ${origin})" ||
+		die "Where do you want to fetch from today?"
+	set x $origin ; shift ;;
 esac
=20
 remote_nick=3D"$1"
--=20
1.4.2.1.g4b5cd
