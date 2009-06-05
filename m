From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH 1/3] parse-remote: function to get the tracking branch to be merge
Date: Fri,  5 Jun 2009 21:53:35 +0200
Message-ID: <1244231617-17754-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 21:53:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCfTx-0004P8-Ck
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 21:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbZFETxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 15:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbZFETxc
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 15:53:32 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:58238 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbZFETxb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 15:53:31 -0400
Received: by fxm9 with SMTP id 9so811145fxm.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 12:53:32 -0700 (PDT)
Received: by 10.103.160.9 with SMTP id m9mr2242703muo.96.1244231612129;
        Fri, 05 Jun 2009 12:53:32 -0700 (PDT)
Received: from localhost (p5B0D54CB.dip.t-dialin.net [91.13.84.203])
        by mx.google.com with ESMTPS id 23sm1371824mun.46.2009.06.05.12.53.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 12:53:31 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.308.g426b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120823>

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
