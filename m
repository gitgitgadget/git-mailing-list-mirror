From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv2 1/3] parse-remote: function to get the tracking branch to be merge
Date: Sun,  7 Jun 2009 11:44:20 +0200
Message-ID: <1244367862-6306-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 11:44:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDEvn-000847-RS
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 11:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbZFGJoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 05:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbZFGJoK
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 05:44:10 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:59715 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbZFGJoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 05:44:09 -0400
Received: by bwz9 with SMTP id 9so2420856bwz.37
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 02:44:10 -0700 (PDT)
Received: by 10.204.51.210 with SMTP id e18mr5295534bkg.69.1244367850060;
        Sun, 07 Jun 2009 02:44:10 -0700 (PDT)
Received: from localhost (p5B0D6736.dip.t-dialin.net [91.13.103.54])
        by mx.google.com with ESMTPS id 19sm2094308fkr.55.2009.06.07.02.44.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Jun 2009 02:44:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.308.g426b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120961>

The only user of get_remote_refs_for_fetch was "git pull --rebase" and
it only wanted the tracking branch to be merge. So, add a simple
function with this new meaning.

No behavior changes.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 git-parse-remote.sh |   33 +++++++++++++++++++++++++++++++++
 git-pull.sh         |    7 ++-----
 2 files changed, 35 insertions(+), 5 deletions(-)
 mode change 100755 =3D> 100644 git-parse-remote.sh

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
old mode 100755
new mode 100644
index a296719..8b3ba72
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -229,6 +229,38 @@ get_remote_refs_for_fetch () {
 	esac
 }
=20
+get_remote_merge_branch () {
+	case "$#" in
+	0|1)
+	    die "internal error: get-remote-merge-branch." ;;
+	*)
+	    repo=3D$1
+	    shift
+	    # FIXME: It should return the tracking branch
+	    #        Currently only works with the default mapping
+	    for ref
+	    do
+		case "$ref" in
+		+*)
+			ref=3D$(expr "z$ref" : 'z+\(.*\)')
+			;;
+		esac
+		expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
+		remote=3D$(expr "z$ref" : 'z\([^:]*\):')
+		case "$remote" in
+		'' | HEAD ) remote=3DHEAD ;;
+		heads/*) remote=3D${remote#heads/} ;;
+		refs/heads/*) remote=3D${remote#refs/heads/} ;;
+		refs/* | tags/* | remotes/* ) break
+		esac
+
+		echo "refs/remotes/$repo/$remote"
+		break
+	    done
+	    ;;
+	esac
+}
+
 resolve_alternates () {
 	# original URL (xxx.git)
 	top_=3D`expr "z$1" : 'z\([^:]*:/*[^/]*\)/'`
@@ -262,3 +294,4 @@ get_uploadpack () {
 		;;
 	esac
 }
+
diff --git a/git-pull.sh b/git-pull.sh
index 3526153..3cf2663 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -125,12 +125,9 @@ test true =3D "$rebase" && {
 	die "refusing to pull with rebase: your working tree is not up-to-dat=
e"
=20
 	. git-parse-remote &&
-	origin=3D"$1"
-	test -z "$origin" && origin=3D$(get_default_remote)
-	reflist=3D"$(get_remote_refs_for_fetch "$@" 2>/dev/null |
-		sed "s|refs/heads/\(.*\):|\1|")" &&
+	reflist=3D"$(get_remote_merge_branch "$@" 2>/dev/null)" &&
 	oldremoteref=3D"$(git rev-parse -q --verify \
-		"refs/remotes/$origin/$reflist")"
+		"$reflist")"
 }
 orig_head=3D$(git rev-parse -q --verify HEAD)
 git fetch $verbosity --update-head-ok "$@" || exit 1
--=20
1.6.3.1.308.g426b5
