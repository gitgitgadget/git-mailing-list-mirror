From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6/6] t5000: test long filenames
Date: Mon, 20 May 2013 11:58:29 +0200
Message-ID: <1369043909-59207-7-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 20 11:58:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeMro-0004UC-Dx
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 11:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab3ETJ6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 05:58:46 -0400
Received: from india601.server4you.de ([85.25.151.105]:56482 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab3ETJ6h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 05:58:37 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFDA8FE.dip0.t-ipconnect.de [79.253.168.254])
	by india601.server4you.de (Postfix) with ESMTPSA id 3324C567
	for <git@vger.kernel.org>; Mon, 20 May 2013 11:58:35 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224950>

Add a file with a long name to the test archive in order to check
entries with pax extended headers.  Also add a check for tar versions
that doen't understand this format.  Those versions should extract the
headers as a regular files.  Add code to check_tar() to interpret the
path header if present, so that our tests work even with those tar
versions.

It's important to use the fallback code only if needed to still be
able to detect git archive errorously creating pax headers as regular
file entries (with a suitable tar version, of course).

The archive used to check for pax header support in tar was generated
using GNU tar 1.26 and its option --format=3Dpax.

Tested successfully on NetBSD 6.1, which has a tar version lacking pax
header support.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t5000-tar-tree.sh |  46 ++++++++++++++++++++++++++++++++++++++++++++=
++
 t/t5000/pax.tar     | Bin 0 -> 10240 bytes
 2 files changed, 46 insertions(+)
 create mode 100644 t/t5000/pax.tar

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index a1f35d2..c2023b1 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -30,6 +30,32 @@ GUNZIP=3D${GUNZIP:-gzip -d}
=20
 SUBSTFORMAT=3D%H%n
=20
+test_lazy_prereq TAR_NEEDS_PAX_FALLBACK '
+	(
+		mkdir pax &&
+		cd pax &&
+		"$TAR" xf "$TEST_DIRECTORY"/t5000/pax.tar &&
+		test -f PaxHeaders.1791/file
+	)
+'
+
+get_pax_header() {
+	file=3D$1
+	header=3D$2=3D
+
+	while read len rest
+	do
+		if test "$len" =3D $(echo "$len $rest" | wc -c)
+		then
+			case "$rest" in
+			$header*)
+				echo "${rest#$header}"
+				;;
+			esac
+		fi
+	done <"$file"
+}
+
 check_tar() {
 	tarfile=3D$1.tar
 	listfile=3D$1.lst
@@ -40,6 +66,24 @@ check_tar() {
 		(mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile
 	'
=20
+	test_expect_success TAR_NEEDS_PAX_FALLBACK ' interpret pax headers' '
+		(
+			cd $dir &&
+			for header in *.paxheader
+			do
+				data=3D${header%.paxheader}.data &&
+				if test -h $data -o -e $data
+				then
+					path=3D$(get_pax_header $header path) &&
+					if test -n "$path"
+					then
+						mv "$data" "$path"
+					fi
+				fi
+			done
+		)
+	'
+
 	test_expect_success ' validate filenames' '
 		(cd ${dir_with_prefix}a && find .) | sort >$listfile &&
 		test_cmp a.lst $listfile
@@ -54,6 +98,8 @@ test_expect_success \
     'populate workdir' \
     'mkdir a &&
      echo simple textfile >a/a &&
+     ten=3D0123456789 && hundred=3D$ten$ten$ten$ten$ten$ten$ten$ten$te=
n$ten &&
+     echo long filename >a/four$hundred &&
      mkdir a/bin &&
      cp /bin/sh a/bin &&
      printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
diff --git a/t/t5000/pax.tar b/t/t5000/pax.tar
new file mode 100644
index 0000000000000000000000000000000000000000..d91173714991fded560fcd6=
a8aaec6aa6ec7f5e8
GIT binary patch
literal 10240
zcmeIy%?g4*5Ww+0_Y^*X&3@?Sp?k+(L29F*2+YXGPl*s(6d@sk|6W#S)Sdakm@c<v
zvkB!sRJT<7LN5=3Deb5OG`X;<!?>h^Yh?xL+x+Gv-HHCB5i+IVkN(#%@Lz{l>lx~$rg
z2GWzmuipCRCcpUG2dyNR`g93vZSz%O3b*p9Sn-k>pDo&KIhx%KXMfulr%w}@f7;`7
zyU`e%|L&jgG5=3DzmO1_@SxRf~Zp8x84t>bJTc^pGH_qWm2pU!{O2LS{SKmY**5I_I{
l1Q0*~0R#|0009ILKmY**5I_I{1Q0*~0R#|00D->}cmml}KZ5`O

literal 0
HcmV?d00001

--=20
1.8.2.3
