From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCHv3 1/4] parse-remote: function to get the tracking branch to be merge
Date: Mon,  8 Jun 2009 11:00:48 +0200
Message-ID: <1244451651-22651-2-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 11:01:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDajW-0001Ws-KM
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 11:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbZFHJAs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 05:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbZFHJAs
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 05:00:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:28402 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbZFHJAr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 05:00:47 -0400
Received: by fg-out-1718.google.com with SMTP id d23so721017fga.17
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 02:00:49 -0700 (PDT)
Received: by 10.86.57.9 with SMTP id f9mr6932099fga.62.1244451649805;
        Mon, 08 Jun 2009 02:00:49 -0700 (PDT)
Received: from localhost (p5B0D59E7.dip.t-dialin.net [91.13.89.231])
        by mx.google.com with ESMTPS id e20sm66273fga.15.2009.06.08.02.00.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Jun 2009 02:00:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.308.g426b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only user of get_remote_refs_for_fetch was "git pull --rebase" and
it only wanted the tracking branch to be merge. So, add a simple
function with this new meaning.

No behavior changes.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 git-parse-remote.sh |   33 +++++++++++++++++++++++++++++++++
 git-pull.sh         |    7 ++-----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index a296719..8b3ba72 100755
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
