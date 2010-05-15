From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git-am: Ignore whitespace before patches
Date: Sat, 15 May 2010 17:23:08 +0000
Message-ID: <1273944188-9472-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 19:23:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODL5J-0004Us-73
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 19:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab0EORX1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 13:23:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:45415 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab0EORX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 13:23:26 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2117039fga.1
        for <git@vger.kernel.org>; Sat, 15 May 2010 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ls9fM++8XbXs8EM/qpWK/guEMcP/w4uFGCaC66XI7Vk=;
        b=dXw6DTGWhIhXW00ERkF3VJ6NGMREqWoZVp+09RwtqmoimJaE/B/92A1B3AYJYec5io
         JNoU42d+er14q9BoqHLxjF+5OOndYJrYYtZu9XTO9YQl0eAaCCiOV9LWZmGLNFyuNC3M
         cB8u0DDDoQo+q6kKnNe/+05lsUr6RzX3KVnew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ibUgSZ2ByR6d5BTsPhpxJS4utgSnAM3k9RvAq3NteArOkQdL/l3imbi7MPmV/FWCFB
         SD97qooomSLRMpAbxKv9i53dq3lIWEHGshDYRkaVYosRMkFJTLjR9YKazPsJS4X58tDI
         HnB/S5l9YtsX9D1GfDbDsMmymrfpPx6BIoPFM=
Received: by 10.87.15.13 with SMTP id s13mr5114317fgi.48.1273944204819;
        Sat, 15 May 2010 10:23:24 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 18sm5107101fks.35.2010.05.15.10.23.23
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 10:23:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.84.gd92f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147157>

Change git-am to ignore whitespace (as defined by sh's read) at the
beginning of patches.

Empty lines are wont to creep in at the beginning of patches, here's
an example from a raw Gmail attachment:

    20 20 20 20 20 20 20 20  20 20 20 20 20 20 20 20  |                =
|
    20 20 20 20 20 20 20 20  20 20 20 20 20 20 20 0a  |               .=
|
    52 65 74 75 72 6e 2d 50  61 74 68 3a 20 3c 61 76  |Return-Path: <av=
|

Whitespace is also likely to appear if the user copy/pastes the patch
around, e.g. via a pastebin, or any any number of other cases. This
harms nothing and makes git-am's detection more fault tolerant.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh     |   16 +++++++++++++++-
 t/t4150-am.sh |   30 ++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 1056075..1b4baa8 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -172,7 +172,21 @@ check_patch_format () {
 	# otherwise, check the first few lines of the first patch to try
 	# to detect its format
 	{
-		read l1
+		while read -r line
+		do
+			case "$line" in
+				"")
+					# Just skip whitespace
+					continue
+					;;
+				*)
+					# First non-empty line
+					l1=3D$line
+					break
+					;;
+			esac
+		done
+
 		read l2
 		read l3
 		case "$l1" in
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 810b04b..3d089de 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -318,6 +318,36 @@ test_expect_success 'am without --committer-date-i=
s-author-date' '
 	test "$at" !=3D "$ct"
 '
=20
+test_expect_success 'am applying a patch that begins with an empty lin=
e' '
+	git checkout first &&
+	test_tick &&
+	echo > patch1-white &&
+	cat patch1 >> patch1-white &&
+	git am patch1-white &&
+	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
+	at=3D$(sed -ne "/^author /s/.*> //p" head1) &&
+	ct=3D$(sed -ne "/^committer /s/.*> //p" head1) &&
+	test "$at" !=3D "$ct"
+'
+
+test_expect_success 'am applying a patch that begins with many empty l=
ines' '
+	git checkout first &&
+	test_tick &&
+	echo "   " > patch1-white2 &&
+	echo "  " >> patch1-white2 &&
+	echo " " >> patch1-white2 &&
+	echo "" >> patch1-white2 &&
+	echo " " >> patch1-white2 &&
+	echo "  " >> patch1-white2 &&
+	echo "   " >> patch1-white2 &&
+	cat patch1 >> patch1-white2 &&
+	git am patch1-white2 &&
+	git cat-file commit HEAD | sed -e "/^\$/q" >head1 &&
+	at=3D$(sed -ne "/^author /s/.*> //p" head1) &&
+	ct=3D$(sed -ne "/^committer /s/.*> //p" head1) &&
+	test "$at" !=3D "$ct"
+'
+
 # This checks for +0000 because TZ is set to UTC and that should
 # show up when the current time is used. The date in message is set
 # by test_tick that uses -0700 timezone; if this feature does not
--=20
1.7.1.84.gd92f8
