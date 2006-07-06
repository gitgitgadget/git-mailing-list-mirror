From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: git on HP-UX
Date: Thu, 6 Jul 2006 09:50:34 +0200
Organization: NextSoft
Message-ID: <200607060950.34558.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jul 06 09:50:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyOdG-0003mP-9u
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 09:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWGFHui convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Jul 2006 03:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWGFHui
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 03:50:38 -0400
Received: from s3.icr.cz ([82.142.72.7]:23235 "EHLO s3.icr.cz")
	by vger.kernel.org with ESMTP id S964984AbWGFHui convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 03:50:38 -0400
Received: (from root@localhost)
	by s3.icr.cz (8.11.4/8.11.4) id k667oZ425112
	for git@vger.kernel.org; Thu, 6 Jul 2006 09:50:35 +0200
Received: from michal.rokos.cz (mx1.evangnet.cz [88.83.237.35] (may be forged))
	by s3.icr.cz (8.11.4/8.11.4) with ESMTP id k667oZS25072
	for <git@vger.kernel.org>; Thu, 6 Jul 2006 09:50:35 +0200
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
X-scanner: scanned by Inflex 1.0.10 - (http://pldaniels.com/inflex/)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23380>

Hello,

I needed following changes in order to make git compile on HP-UX:
# uname -s -r -m
HP-UX B.11.11 9000/800

Packages installed:
OpenSSL	A.00.09.07-d.002
perl		B.5.6.1.C
+ unofficial:
gcc		4.1.1
libiconv	1.10
make	3.80
zlib		1.2.3

Has to be compiled with:
PERL_PATH=3D/opt/perl/bin/perl gmake prefix=3D/opt/git install

Please keep me on CC (I'm not subscribed).

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

--- a/Makefile
+++ b/Makefile
@@ -328,6 +328,17 @@ ifeq ($(uname_S),IRIX64)
 	# for now, build 32-bit version
 	ALL_LDFLAGS +=3D -L/usr/lib32
 endif
+ifeq ($(uname_S),HP-UX)
+	NO_IPV6 =3D YesPlease
+	NO_CURL =3D YesPlease
+	NO_SETENV =3D YesPlease
+	NO_STRCASESTR =3D YesPlease
+	NO_STRLCPY =3D YesPlease
+	NEEDS_LIBICONV =3D YesPlease
+	ALL_CFLAGS +=3D -D_REENTRANT -D_XOPEN_SOURCE -D_HPUX_SOURCE -I/opt/op=
enssl/include -Dhstrerror=3Dstrerror
+	ALL_LDFLAGS +=3D -L/opt/openssl/lib
+	INSTALL =3D $(PWD)/compat/compat_install
+endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 =3D YesPlease
 endif
--- a/compat/compat_install	2006-07-06 09:31:27.000000000 +0200
+++ b/compat/compat_install	2006-07-06 09:31:18.000000000 +0200
@@ -0,0 +1,34 @@
+#!/usr/bin/sh
+#
+# Copyright (c) 2006 Michal Rokos
+#
+# Dummy 'install' replacement intended to be used
+# on HP-UX under sh-posix.
+
+while getopts 'dm:' opt; do
+    case $opt in
+    d) DIR_MODE=3D1;;
+    m) MODE=3D$OPTARG;;
+    \?) echo "Unknown argument $OPTARG"; exit 1;;
+    esac
+done
+shift $((OPTIND-1))
+
+if [[ -n "$DIR_MODE" ]] && [[ -n "$MODE" ]]; then
+    mkdir -p -m "$MODE" "$@"
+elif [[ -n "$DIR_MODE" ]]; then
+    mkdir -p "$@"
+else
+    set -A args "$@"
+    last=3D$#
+    dest=3D${args[last-1]}
+    unset args[last-1]
+    set "${args[@]}"
+
+    cp "$@" "$dest"
+
+    [[ -n "$MODE" ]] && chmod "$MODE" "$@"
+fi
+
+exit 0
+

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
