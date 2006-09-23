From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 1/4 (take 4)] fetch: default remote repository from branch properties
Date: Sat, 23 Sep 2006 22:50:41 +0200
Message-ID: <8764fefgta.fsf@gmail.com>
References: <87ac4qfgvc.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 23 22:50:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRESX-0006Gv-B7
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 22:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWIWUuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 16:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWIWUuq
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 16:50:46 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:55989 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S964904AbWIWUuq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 16:50:46 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8NKohQ04204
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 22:50:43 +0200
To: git <git@vger.kernel.org>
In-Reply-To: <87ac4qfgvc.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Sat, 23 Sep
	2006 22:49:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27628>


If in branch "foo" and this in config:

[branch "foo"]
       remote=3Dbar

"git fetch" =3D "git fetch bar"
"git  pull" =3D "git pull  bar"

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/config.txt |    3 +++
 git-fetch.sh             |    9 ++++-----
 git-parse-remote.sh      |    6 ++++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bb2fbc3..04c5094 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -119,6 +119,9 @@ apply.whitespace::
 	Tells `git-apply` how to handle whitespaces, in the same way
 	as the '--whitespace' option. See gitlink:git-apply[1].
=20
+branch.<name>.remote::
+	When in branch <name>, it tells `git fetch` which remote to fetch.
+
 pager.color::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/git-fetch.sh b/git-fetch.sh
index 09a5d6c..50ad101 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -68,11 +68,10 @@ done
=20
 case "$#" in
 0)
-	test -f "$GIT_DIR/branches/origin" ||
-		test -f "$GIT_DIR/remotes/origin" ||
-			git-repo-config --get remote.origin.url >/dev/null ||
-				die "Where do you want to fetch from today?"
-	set origin ;;
+	origin=3D$(get_default_remote)
+	test -n "$(get_remote_url ${origin})" ||
+		die "Where do you want to fetch from today?"
+	set x $origin ; shift ;;
 esac
=20
 remote_nick=3D"$1"
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 187f088..6999816 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -68,6 +68,12 @@ get_remote_url () {
 	esac
 }
=20
+get_default_remote () {
+	curr_branch=3D$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
+	origin=3D$(git-repo-config --get "branch.$curr_branch.remote")
+	echo ${origin:-origin}
+}
+
 get_remote_default_refs_for_push () {
 	data_source=3D$(get_data_source "$1")
 	case "$data_source" in
--=20
1.4.2.1.g279b
