From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv4 1/4] parse-remote: function to get the tracking branch to be merge
Date: Fri, 12 Jun 2009 00:39:18 +0200
Message-ID: <1244759961-4750-2-git-send-email-santi@agolina.net>
References: <1244759961-4750-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 00:39:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEsw3-00070r-27
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 00:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760988AbZFKWjR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 18:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762798AbZFKWjQ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 18:39:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:9150 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762030AbZFKWjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 18:39:15 -0400
Received: by fg-out-1718.google.com with SMTP id d23so34657fga.17
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 15:39:15 -0700 (PDT)
Received: by 10.86.31.18 with SMTP id e18mr2903049fge.72.1244759955566;
        Thu, 11 Jun 2009 15:39:15 -0700 (PDT)
Received: from localhost (p5B0D383D.dip.t-dialin.net [91.13.56.61])
        by mx.google.com with ESMTPS id e20sm228569fga.25.2009.06.11.15.39.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 15:39:12 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.222.g479ad6
In-Reply-To: <1244759961-4750-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121368>

The only user of get_remote_refs_for_fetch was "git pull --rebase" and
it only wanted the tracking branch to be merge. So, add a simple
function (get_remote_merge_branch) with this new meaning.

No behavior changes. The new function behaves like the old code in
"git pull --rebase". In particular, it only works with the default
refspec mapping and with remote branches, not tags.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---

Changes since v3:
  - Explain why the new function does not change the behavior.
  - Remove the for loop.

 git-parse-remote.sh |   29 +++++++++++++++++++++++++++++
 git-pull.sh         |    7 ++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index a296719..a991564 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -229,6 +229,34 @@ get_remote_refs_for_fetch () {
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
+	    ref=3D$1
+	    # FIXME: It should return the tracking branch
+	    #        Currently only works with the default mapping
+	    case "$ref" in
+	    +*)
+		ref=3D$(expr "z$ref" : 'z+\(.*\)')
+		;;
+	    esac
+	    expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
+	    remote=3D$(expr "z$ref" : 'z\([^:]*\):')
+	    case "$remote" in
+	    '' | HEAD ) remote=3DHEAD ;;
+	    heads/*) remote=3D${remote#heads/} ;;
+	    refs/heads/*) remote=3D${remote#refs/heads/} ;;
+	    refs/* | tags/* | remotes/* ) remote=3D
+	    esac
+
+	    [ -n "$remote" ] && echo "refs/remotes/$repo/$remote"
+	esac
+}
+
 resolve_alternates () {
 	# original URL (xxx.git)
 	top_=3D`expr "z$1" : 'z\([^:]*:/*[^/]*\)/'`
@@ -262,3 +290,4 @@ get_uploadpack () {
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
1.6.3.2.206.g417f7
