From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: [PATCH] Fixes git-cherry algorithmic flaws
Date: Mon, 7 Aug 2006 13:30:13 +0300 (EEST)
Message-ID: <Pine.LNX.4.58.0608071328200.22971@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Aug 07 14:08:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA3uT-0008M7-20
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 14:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWHGMIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 Aug 2006 08:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWHGMIa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 08:08:30 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:20956 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932071AbWHGMIa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 08:08:30 -0400
Received: from kivilampi-30.cs.helsinki.fi (kivilampi-30.cs.helsinki.fi [128.214.9.42])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Mon, 07 Aug 2006 13:30:14 +0300
  id 000A88F6.44D71636.000079E3
Received: by kivilampi-30.cs.helsinki.fi (Postfix, from userid 50795)
	id E890BEAFF1; Mon,  7 Aug 2006 13:30:13 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by kivilampi-30.cs.helsinki.fi (Postfix) with ESMTP id DF5BBEAFE6;
	Mon,  7 Aug 2006 13:30:13 +0300 (EEST)
X-X-Sender: ijjarvin@kivilampi-30.cs.helsinki.fi
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25008>

Old algorithm:
        - printed IDs of identical patches with minus (-) sign; they
	  should not be printed at all
        - did not print anything from the changes in the upstream

Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>
---
 git-cherry.sh |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/git-cherry.sh b/git-cherry.sh
index f0e8831..fdf3de7 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -74,7 +74,8 @@ do
 	then
 		if test -f "$patch/$2"
 		then
-			sign=3D-
+			rm -rf "$patch/$2"
+			continue
 		else
 			sign=3D+
 		fi
@@ -88,6 +89,29 @@ do
 		esac
 	fi
 done
+
+for c in $inup
+do
+	set x `git-diff-tree -p $c | git-patch-id`
+	if test "$2" !=3D ""
+	then
+		if test -f "$patch/$2"
+		then
+			sign=3D-
+		else
+			continue
+		fi
+		case "$verbose" in
+		t)
+			c=3D$(git-rev-list --pretty=3Doneline --max-count=3D1 $c)
+		esac
+		case "$O" in
+		'')	O=3D"$sign $c" ;;
+		*)	O=3D"$sign $c$LF$O" ;;
+		esac
+	fi
+done
+
 case "$O" in
 '') ;;
 *)  echo "$O" ;;
--=20
1.4.1
