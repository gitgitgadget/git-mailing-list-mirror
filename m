From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: Re: Remove unneeded packs
Date: Sun, 13 Nov 2005 11:58:11 +0100
Organization: Chalmers
Message-ID: <43771C43.7000104@etek.chalmers.se>
References: <1131800663.29461.11.camel@blade> <4375EA80.7070405@op5.se>	<1131802238.29461.18.camel@blade> <43766687.2000007@etek.chalmers.se> <7voe4pclwm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	=?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:58:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbFYX-0002VN-HU
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 11:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVKMK5t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 Nov 2005 05:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVKMK5t
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 05:57:49 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:60857 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932414AbVKMK5t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 05:57:49 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.060.1)
        id 43721F89000F2246; Sun, 13 Nov 2005 11:57:45 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7voe4pclwm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11731>

Junio C Hamano wrote:
> Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:
>>This is most likley because the pack b3c6... contains unreachable obj=
ects.
>>git-pack-redundant only makes sure that all objects present in packfi=
les
>>still are present in packfiles after the redundant packs have been re=
moved.
>>...
>>I'm thinking of the possibility passing a list of objects to be ignor=
ed
>>on stdin to git-pack-redundant. This would hopefully solve this probl=
em.
>=20
>=20
> But once you go down that path, wouldn't doing 'repack -a -d'
> become looking simpler and more attractive, I wonder?
>=20
>=20

It depends on how expensive git-fsck-objects --full --unreacahble is ve=
rsus
a full repack.

Howerver, if I read the source correctly git-fsck-objects doesn't curre=
ntly test=20
the reachablility of packed objects. This would have to change, and I'm=
 not certain
of how to do that properly.

Note that the following patch is reqired if git-repack -a -d is to work=
 as expected.
(Remove all packs except the new one)

Btw, I'm sending this patch in utf8, let's see if it works...

----
Subject: [PATCH] Make sure all old packfiles are removed when doing a f=
ull repack

This is nessecary because unrachable objects in packfiles makes git-pac=
k-redundant
flag them as non-redundant.

Signed-off-by: Lukas Sandstr=C3=83=C2=B6m <lukass@etek.chalmers.se>

---

 git-repack.sh |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

applies-to: 9a0f0c748316751fbf593a21f2b16bcdd975095a
08df1f641bd3f98a607a8413d647667adc18a633
diff --git a/git-repack.sh b/git-repack.sh
index f347207..293bb50 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -32,6 +32,8 @@ case ",$all_into_one," in
 	rev_list=3D
 	rev_parse=3D'--all'
 	pack_objects=3D
+	existing=3D`cd "$PACKDIR" && \
+	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
 	;;
 esac
 if [ "$local" ]; then
@@ -60,7 +62,19 @@ mv .tmp-pack-$name.pack "$PACKDIR/pack-$
 mv .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" ||
 exit
=20
-if test "$remove_redandant" =3D t
+if test "$all_into_one" =3D t
+then
+	sync
+	( cd "$PACKDIR" &&
+		for e in $existing
+		do
+		case "$e" in
+		./pack-$name.pack | ./pack-$name.idx) ;;
+		*)	rm -f $e ;;
+		esac
+		done
+	)
+else if test "$remove_redandant" =3D t
 then
 	sync
 	redundant=3D$(git-pack-redundant --all)
---
0.99.9.GIT
