From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: [patch pasky 1/2] fix various issues in gitapply.sh (basically did
	not handle add/del/cm at all)
Date: Fri, 15 Apr 2005 11:28:38 +0200
Message-ID: <1113557318.23299.165.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rpmQ50Km7qpuLWx6yQYN"
Content-Transfer-Encoding: 8bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 15 11:23:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMN1i-0002oj-0p
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 11:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVDOJZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 05:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbVDOJZY
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 05:25:24 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:1243 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S261774AbVDOJY4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 05:24:56 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id 0312416822;
	Fri, 15 Apr 2005 11:24:50 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 2F3453A26DB;
	Fri, 15 Apr 2005 11:30:56 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12725-14; Fri, 15 Apr 2005 11:30:50 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 6D5B03A26DA;
	Fri, 15 Apr 2005 11:30:50 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-rpmQ50Km7qpuLWx6yQYN
Content-Type: multipart/mixed; boundary="=-4koeV8RMLK0cnWzCccwL"


--=-4koeV8RMLK0cnWzCccwL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

The egrep regex should not escape the '{' and '}', and also add a check
for ' \t' so that we do not pickup stuff like '+----', etc.  Fix typo in
assignment.  Check if file exists in new tree before adding/removing
(might add support for this lowlevel to increase speed?).  Fix typo in
line removing temp files.

Signed-off-by: Martin Schlemmer <azarah@gentoo.org>

gitapply.sh:  47b9346d2679b1bf34220fe4502f15c7d0737b0c
--- 47b9346d2679b1bf34220fe4502f15c7d0737b0c/gitapply.sh
+++ uncommitted/gitapply.sh
@@ -19,15 +19,22 @@
 # just handle it all ourselves.
 patch -p1 -N <$patchfifo &

-tee $patchfifo | egrep '^[+-]\{3\}' | {
+exits_in_cache() {
+       for x in $(ls-tree "$1"); do
+               [ "$x" =3D "$2" ] && return 0
+       done
+       return 1
+}
+
+tee $patchfifo | egrep '^[+-]{3}[ \t]' | {
        victim=3D
        origmode=3D

        while read sign file attrs; do
-               echo $sign $file $attrs ... >&2
+#              echo $sign $file $attrs ... >&2
                case $sign in
                "---")
-                       victim=3Dfile
+                       victim=3D$file
                        mode=3D$(echo $attrs | sed 's/.*mode:[0-7]*\([0-7]\=
{3\}\).*/\1/')
                        origmode=3D
                        [ "$mode" !=3D "$attrs" ] && origmode=3D$mode
@@ -35,14 +42,19 @@
                "+++")
                        if [ "$file" =3D "/dev/null" ]; then
                                torm=3D$(echo "$victim" | sed 's/[^\/]*\///=
') #-p1
-                               echo -ne "rm\0$torm\0"
+                               tree=3D$(echo $attrs | sed 's/.*tree:\([0-9=
a-f]\{40\}\).*/\1/')
+                               exits_in_cache "$tree" "$torm" && echo -ne =
"rm\0$torm\0"
                                continue
                        elif [ "$victim" =3D "/dev/null" ]; then
-                               echo -ne "add\0$file\0"
+                               toadd=3D$(echo "$file" | sed 's/[^\/]*\///'=
) #-p1
+                               tree=3D$(echo "$file" | sed -e 's/\([^\/]*\=
)\/.*/\1/')
+                               exits_in_cache "$tree" "$toadd" || echo -ne=
 "add\0$toadd\0"
                        fi
                        mode=3D$(echo $attrs | sed 's/.*mode:[0-7]*\([0-7]\=
{3\}\).*/\1/')
                        if [ "$mode" ] && [ "$mode" !=3D "$attrs" ] && [ "$=
origmode" !=3D "$mode" ]; then
-                               echo -ne "cm\0$mode\0$file\0"
+                               tochmod=3D$(echo "$file" | sed 's/[^\/]*\//=
/') #-p1
+                               # need a space else numbers gets converted
+                               echo -ne "cm\0 $mode\0$tochmod\0"
                        fi
                        ;;
                *)
@@ -74,4 +86,4 @@
 done
 ' padding

-rm $pathfifo $todo $gonefile
+rm $patchfifo $todo $gonefile


--=20
Martin Schlemmer


--=-4koeV8RMLK0cnWzCccwL
Content-Disposition: attachment; filename=git-gitapply-fixes.patch
Content-Type: text/x-patch; name=git-gitapply-fixes.patch; charset=UTF-8
Content-Transfer-Encoding: base64

Z2l0YXBwbHkuc2g6ICA0N2I5MzQ2ZDI2NzliMWJmMzQyMjBmZTQ1MDJmMTVjN2QwNzM3YjBjDQot
LS0gNDdiOTM0NmQyNjc5YjFiZjM0MjIwZmU0NTAyZjE1YzdkMDczN2IwYy9naXRhcHBseS5zaA0K
KysrIHVuY29tbWl0dGVkL2dpdGFwcGx5LnNoDQpAQCAtMTksMTUgKzE5LDIyIEBADQogIyBqdXN0
IGhhbmRsZSBpdCBhbGwgb3Vyc2VsdmVzLg0KIHBhdGNoIC1wMSAtTiA8JHBhdGNoZmlmbyAmDQog
DQotdGVlICRwYXRjaGZpZm8gfCBlZ3JlcCAnXlsrLV1cezNcfScgfCB7DQorZXhpdHNfaW5fY2Fj
aGUoKSB7DQorCWZvciB4IGluICQobHMtdHJlZSAiJDEiKTsgZG8NCisJCVsgIiR4IiA9ICIkMiIg
XSAmJiByZXR1cm4gMA0KKwlkb25lDQorCXJldHVybiAxDQorfQ0KKw0KK3RlZSAkcGF0Y2hmaWZv
IHwgZWdyZXAgJ15bKy1dezN9WyBcdF0nIHwgew0KIAl2aWN0aW09DQogCW9yaWdtb2RlPQ0KIA0K
IAl3aGlsZSByZWFkIHNpZ24gZmlsZSBhdHRyczsgZG8NCi0JCWVjaG8gJHNpZ24gJGZpbGUgJGF0
dHJzIC4uLiA+JjINCisjCQllY2hvICRzaWduICRmaWxlICRhdHRycyAuLi4gPiYyDQogCQljYXNl
ICRzaWduIGluDQogCQkiLS0tIikNCi0JCQl2aWN0aW09ZmlsZQ0KKwkJCXZpY3RpbT0kZmlsZQ0K
IAkJCW1vZGU9JChlY2hvICRhdHRycyB8IHNlZCAncy8uKm1vZGU6WzAtN10qXChbMC03XVx7M1x9
XCkuKi9cMS8nKQ0KIAkJCW9yaWdtb2RlPQ0KIAkJCVsgIiRtb2RlIiAhPSAiJGF0dHJzIiBdICYm
IG9yaWdtb2RlPSRtb2RlDQpAQCAtMzUsMTQgKzQyLDE5IEBADQogCQkiKysrIikNCiAJCQlpZiBb
ICIkZmlsZSIgPSAiL2Rldi9udWxsIiBdOyB0aGVuDQogCQkJCXRvcm09JChlY2hvICIkdmljdGlt
IiB8IHNlZCAncy9bXlwvXSpcLy8vJykgIy1wMQ0KLQkJCQllY2hvIC1uZSAicm1cMCR0b3JtXDAi
DQorCQkJCXRyZWU9JChlY2hvICRhdHRycyB8IHNlZCAncy8uKnRyZWU6XChbMC05YS1mXVx7NDBc
fVwpLiovXDEvJykNCisJCQkJZXhpdHNfaW5fY2FjaGUgIiR0cmVlIiAiJHRvcm0iICYmIGVjaG8g
LW5lICJybVwwJHRvcm1cMCINCiAJCQkJY29udGludWUNCiAJCQllbGlmIFsgIiR2aWN0aW0iID0g
Ii9kZXYvbnVsbCIgXTsgdGhlbg0KLQkJCQllY2hvIC1uZSAiYWRkXDAkZmlsZVwwIg0KKwkJCQl0
b2FkZD0kKGVjaG8gIiRmaWxlIiB8IHNlZCAncy9bXlwvXSpcLy8vJykgIy1wMQ0KKwkJCQl0cmVl
PSQoZWNobyAiJGZpbGUiIHwgc2VkIC1lICdzL1woW15cL10qXClcLy4qL1wxLycpDQorCQkJCWV4
aXRzX2luX2NhY2hlICIkdHJlZSIgIiR0b2FkZCIgfHwgZWNobyAtbmUgImFkZFwwJHRvYWRkXDAi
DQogCQkJZmkNCiAJCQltb2RlPSQoZWNobyAkYXR0cnMgfCBzZWQgJ3MvLiptb2RlOlswLTddKlwo
WzAtN11cezNcfVwpLiovXDEvJykNCiAJCQlpZiBbICIkbW9kZSIgXSAmJiBbICIkbW9kZSIgIT0g
IiRhdHRycyIgXSAmJiBbICIkb3JpZ21vZGUiICE9ICIkbW9kZSIgXTsgdGhlbg0KLQkJCQllY2hv
IC1uZSAiY21cMCRtb2RlXDAkZmlsZVwwIg0KKwkJCQl0b2NobW9kPSQoZWNobyAiJGZpbGUiIHwg
c2VkICdzL1teXC9dKlwvLy8nKSAjLXAxDQorCQkJCSMgbmVlZCBhIHNwYWNlIGVsc2UgbnVtYmVy
cyBnZXRzIGNvbnZlcnRlZA0KKwkJCQllY2hvIC1uZSAiY21cMCAkbW9kZVwwJHRvY2htb2RcMCIN
CiAJCQlmaQ0KIAkJCTs7DQogCQkqKQ0KQEAgLTc0LDQgKzg2LDQgQEANCiBkb25lDQogJyBwYWRk
aW5nDQogDQotcm0gJHBhdGhmaWZvICR0b2RvICRnb25lZmlsZQ0KK3JtICRwYXRjaGZpZm8gJHRv
ZG8gJGdvbmVmaWxlDQo=


--=-4koeV8RMLK0cnWzCccwL--

--=-rpmQ50Km7qpuLWx6yQYN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCX4lGqburzKaJYLYRAhlSAJ4gIpw+qajfAyoAYkY1YbG7e1NybQCfdIQ8
Q6qpreb+Je3yElX/h0s2jSs=
=htSo
-----END PGP SIGNATURE-----

--=-rpmQ50Km7qpuLWx6yQYN--

