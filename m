From: larsxschneider@gmail.com
Subject: [PATCH v4] git-p4: add config git-p4.pathEncoding
Date: Wed,  2 Sep 2015 16:57:33 +0200
Message-ID: <1441205853-52065-2-git-send-email-larsxschneider@gmail.com>
References: <1441205853-52065-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org, gitster@pobox.com, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 16:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX9Ty-0003nx-KL
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 16:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbbIBO5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2015 10:57:46 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35162 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311AbbIBO5n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 10:57:43 -0400
Received: by wicge5 with SMTP id ge5so44061352wic.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WthLrNMbcKphNmb65ZhTK4wVSnP3+qDFl+jX+QG33c0=;
        b=jMr3no3J5cs92pkMRV7pCqqiDLIzy3nt9h6ln76VOaIVyLRuB3o23x71JBmCB8ygNO
         DIo1V2+7SgONXQ7mx+0s9H2QXv9orc5nww13vIiVnd8NlmzXWBfoBzV1i09KkkFlM4Q4
         qMrbpl+lamz6j3WRXLQwXbcpR07VgrxkM5DMG9l9viBO4bVjDcFkODbkRTjP3IwCKpME
         z8ihvDwuLC9lpGfysEHKgOvf3LerXogHgKaLc7GXceAlfEZukfJSdeKtZ66pZ4vSnUmU
         pE7s3jJgGc+7xOmj0LvH71nktIGgNmCJhge+U+DtunN1Scg3jGW+R0wYN6MZEuEEfkl+
         oU8w==
X-Received: by 10.180.85.74 with SMTP id f10mr4487134wiz.45.1441205861961;
        Wed, 02 Sep 2015 07:57:41 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id ej6sm3990789wid.24.2015.09.02.07.57.39
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 07:57:41 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1441205853-52065-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277092>

=46rom: Lars Schneider <larsxschneider@gmail.com>

Perforce keeps the encoding of a path as given by the originating OS.
Git expects paths encoded as UTF-8. Add a config to tell git-p4 what
encoding Perforce had used for the paths. This encoding is used to
transcode the paths to UTF-8. As an example, Perforce on my Windows
box uses =E2=80=9Ccp1252=E2=80=9D to encode path names.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt        |  7 +++++
 git-p4.py                       |  3 ++
 t/t9822-git-p4-path-encoding.sh | 65 +++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 75 insertions(+)
 create mode 100755 t/t9822-git-p4-path-encoding.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 82aa5d6..bf3adf9 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -510,6 +510,13 @@ git-p4.useClientSpec::
 	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
 	This variable is a boolean, not the name of a p4 client.
=20
+git-p4.pathEncoding::
+	Perforce keeps the encoding of a path as given by the originating OS.
+	Git expects paths encoded as UTF-8. Use this config to tell git-p4=20
+	what encoding Perforce had used for the paths. This encoding is used
+	to transcode the paths to UTF-8. As an example, Perforce on my Window=
s
+	box uses =E2=80=9Ccp1252=E2=80=9D to encode path names.
+
 Submit variables
 ~~~~~~~~~~~~~~~~
 git-p4.detectRenames::
diff --git a/git-p4.py b/git-p4.py
index 073f87b..706fcdc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2213,6 +2213,9 @@ class P4Sync(Command, P4UserMap):
             text =3D regexp.sub(r'$\1$', text)
             contents =3D [ text ]
=20
+        if gitConfig("git-p4.pathEncoding"):
+            relPath =3D relPath.decode(gitConfig("git-p4.pathEncoding"=
)).encode('utf8', 'replace')
+
         self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
=20
         # total length...
diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-enco=
ding.sh
new file mode 100755
index 0000000..3a1779a
--- /dev/null
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+test_description=3D'Clone repositories with non ASCII paths'
+
+. ./lib-git-p4.sh
+
+UTF8_ESCAPED=3D"a-\303\244_o-\303\266_u-\303\274.txt"
+ISO8859_ESCAPED=3D"\141\55\344\137\157\55\366\137\165\55\374\56\164\17=
0\164"
+
+# You can generate the ISO8859_ESCAPED with the following command:
+# printf "$UTF8_ESCAPED" | \
+# iconv -f utf-8 -t iso8859-1 | \
+# xxd -ps -u -c 1 | xargs bash -c 'for v; do echo "ibase=3D16; obase=3D=
8; $v" | bc; done' bash | \
+# tr "\n" "\\"
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'Create a repo containing iso8859-1 encoded paths'=
 '
+	cd "$cli" &&
+
+	ISO8859=3D"$(printf "$ISO8859_ESCAPED")" &&
+	echo content123 >"$ISO8859" &&
+	p4 add "$ISO8859" &&
+	p4 submit -d "test commit"
+'
+
+test_expect_success 'Clone repo containing iso8859-1 encoded paths wit=
hout git-p4.pathEncoding' '
+	git p4 clone --destination=3D"$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		UTF8=3D"$(printf "$UTF8_ESCAPED")" &&
+		echo $UTF8 >expect &&
+		git -c core.quotepath=3Dfalse ls-files >actual &&
+		test_must_fail test_cmp expect actual
+	)
+'
+
+test_expect_success 'Clone repo containing iso8859-1 encoded paths wit=
h git-p4.pathEncoding' '
+
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		git config git-p4.pathEncoding iso8859-1 &&
+		git p4 clone --use-client-spec --destination=3D"$git" //depot &&
+		UTF8=3D"$(printf "$UTF8_ESCAPED")" &&
+		echo $UTF8 >expect &&
+		git -c core.quotepath=3Dfalse ls-files >actual &&
+		test_cmp expect actual &&
+		cat >expect <<-\EOF &&
+		content123
+		EOF
+		cat $UTF8 >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
--=20
1.9.5 (Apple Git-50.3)
