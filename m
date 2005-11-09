From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: [PATCH 4/4] Make git-repack use git-pack-intersect
Date: Wed, 09 Nov 2005 02:25:48 +0100
Organization: Chalmers
Message-ID: <4371501C.6000204@etek.chalmers.se>
References: <43714EFB.5070705@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 09 02:26:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZeiP-0000wf-SP
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 02:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbVKIBZ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 Nov 2005 20:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbVKIBZ1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 20:25:27 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:53165 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030497AbVKIBZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 20:25:27 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout2-sn1.fre.skanova.net (7.2.060.1)
        id 436FB1AD00061828; Wed, 9 Nov 2005 02:25:26 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <43714EFB.5070705@etek.chalmers.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11382>

Make git-repack use git-pack-intersect.

Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>

---

 git-repack.sh |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

applies-to: 73e05dab832dd7320a5128fbf97e693f23ffb949
2cbd6ade19a768eca47f6f7313f6831226ee58b7
diff --git a/git-repack.sh b/git-repack.sh
index d341966..3f28300 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -32,10 +32,6 @@ case ",$all_into_one," in
 	rev_list=3D
 	rev_parse=3D'--all'
 	pack_objects=3D
-	# This part is a stop-gap until we have proper pack redundancy
-	# checker.
-	existing=3D`cd "$PACKDIR" && \
-	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
 	;;
 esac
 if [ "$local" ]; then
@@ -46,6 +42,14 @@ name=3D$(git-rev-list --objects $rev_list=20
 	exit 1
 if [ -z "$name" ]; then
 	echo Nothing new to pack.
+	if test "$remove_redandant" =3D t ; then
+		echo "Removing redundant packs."
+		sync
+		redundant=3D$(git-pack-intersect -a)
+		if test "$redundant" !=3D "" ; then
+			echo $redundant | xargs rm
+		fi
+	fi
 	exit 0
 fi
 echo "Pack pack-$name created."
@@ -58,20 +62,10 @@ exit
=20
 if test "$remove_redandant" =3D t
 then
-	# We know $existing are all redandant only when
-	# all-into-one is used.
-	if test "$all_into_one" !=3D '' && test "$existing" !=3D ''
-	then
-		sync
-		( cd "$PACKDIR" &&
-		  for e in $existing
-		  do
-			case "$e" in
-			./pack-$name.pack | ./pack-$name.idx) ;;
-			*)	rm -f $e ;;
-			esac
-		  done
-		)
+	sync
+	redundant=3D$(git-pack-intersect -a)
+	if test "$redundant" !=3D "" ; then
+		echo $redundant | xargs rm
 	fi
 fi
=20
---
0.99.9.GIT
