From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] Remove all old packfiles when doing "git repack -a -d"
Date: Fri, 18 Nov 2005 21:36:12 +0100
Message-ID: <437E3B3C.9000409@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junio C Hamano <junkio@cox.net>,
	=?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Fri Nov 18 21:35:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdCxg-0006FM-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbVKRUfs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 Nov 2005 15:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbVKRUfr
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:35:47 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:15324 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1161202AbVKRUfp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 15:35:45 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 437DDFC200014971; Fri, 18 Nov 2005 21:35:42 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12257>

No point in running git-pack-redundant if we already know=20
which packs are redundant.

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---
This should be correct. I even tested it.


 git-repack.sh |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

applies-to: 8c987c24bed7f7a30f4e74b12e8acc2cc5eeea93
2f49d2a3a7cf0fc64edfad2febf986252392b667
diff --git a/git-repack.sh b/git-repack.sh
index e58fdd6..55a7b27 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -63,9 +63,22 @@ exit
 if test "$remove_redundant" =3D t
 then
 	sync
-	redundant=3D$(git-pack-redundant --all)
-	if test "$redundant" !=3D "" ; then
-		echo $redundant | xargs rm
+	if test "$all_into_one" =3D t
+	then
+		cd "$PACKDIR"
+		existing=3D`find . -type f \( -name '*.pack' -o -name '*.idx' \) -pr=
int`
+		for e in $existing
+		do
+			case "$e" in
+			./pack-$name.pack | ./pack-$name.idx) ;;
+			*)      rm -f $e ;;
+			esac
+		done
+	else
+		redundant=3D$(git-pack-redundant --all)
+		if test "$redundant" !=3D "" ; then
+			echo $redundant | xargs rm
+		fi
 	fi
 fi
=20
---
0.99.9.GIT
