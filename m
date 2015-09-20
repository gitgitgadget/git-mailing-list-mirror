From: larsxschneider@gmail.com
Subject: [PATCH v6 1/7] git-p4: add optional type specifier to gitConfig reader
Date: Sun, 20 Sep 2015 22:26:21 +0200
Message-ID: <1442780787-65166-2-git-send-email-larsxschneider@gmail.com>
References: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org, sunshine@sunshineco.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 22:27:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdlCj-00044H-2m
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 22:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbbITU05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Sep 2015 16:26:57 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38372 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbbITU0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 16:26:32 -0400
Received: by wiclk2 with SMTP id lk2so87352601wic.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qHnq0MKgRkNpuWfNzelmW4VMcMmJsBcerWnszhRSJEc=;
        b=w7pbTpJ8zUSEbCzAXRyKuFLQ9crD/+9TuDCgn8Q2dMm4ouIa4WQUIYEB4DcDkVBcCZ
         3RY6UhaLBnH1XiqRK1Vgo3hvJvwEr5IWrZhO/smjPJVus6xVnxiKp+HVVEsugWOvCw61
         C5O6qqO4el79XXm4I/ni+hlcp+kwyZj9RoXaDZ633zVy653qnSVSZFCFJMi3w789AgBn
         nOpzMHkeG0vO0dTNPQz2bDl7NDnw+ZOmJL8Bh086pPciG82PlgLYcF8snctJugN0Z20z
         2ClwhFfa+b8J/Qxd8ZlwRiq01Y9dZhMPJg9p2t93YMvG37XLnLsjIQkCws2FtqGGc4HM
         KCRQ==
X-Received: by 10.180.103.199 with SMTP id fy7mr9389002wib.85.1442780790964;
        Sun, 20 Sep 2015 13:26:30 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-188-106-098-135.188.106.pools.vodafone-ip.de. [188.106.98.135])
        by smtp.gmail.com with ESMTPSA id go2sm9869879wib.20.2015.09.20.13.26.29
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 13:26:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278268>

=46rom: Lars Schneider <larsxschneider@gmail.com>

The functions =E2=80=9CgitConfig=E2=80=9D and =E2=80=9CgitConfigBool=E2=
=80=9D are almost identical. Make =E2=80=9CgitConfig=E2=80=9D more gene=
ric by adding an optional type specifier. Use the type specifier =E2=80=
=9C=E2=80=94bool=E2=80=9D with =E2=80=9CgitConfig=E2=80=9D to implement=
 =E2=80=9CgitConfigBool. This prepares the implementation of other type=
 specifiers such as =E2=80=9C=E2=80=94int=E2=80=9D.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Acked-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 073f87b..c139cab 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -604,9 +604,12 @@ def gitBranchExists(branch):
=20
 _gitConfig =3D {}
=20
-def gitConfig(key):
+def gitConfig(key, typeSpecifier=3DNone):
     if not _gitConfig.has_key(key):
-        cmd =3D [ "git", "config", key ]
+        cmd =3D [ "git", "config" ]
+        if typeSpecifier:
+            cmd +=3D [ typeSpecifier ]
+        cmd +=3D [ key ]
         s =3D read_pipe(cmd, ignore_error=3DTrue)
         _gitConfig[key] =3D s.strip()
     return _gitConfig[key]
@@ -617,10 +620,7 @@ def gitConfigBool(key):
        in the config."""
=20
     if not _gitConfig.has_key(key):
-        cmd =3D [ "git", "config", "--bool", key ]
-        s =3D read_pipe(cmd, ignore_error=3DTrue)
-        v =3D s.strip()
-        _gitConfig[key] =3D v =3D=3D "true"
+        _gitConfig[key] =3D gitConfig(key, '--bool') =3D=3D "true"
     return _gitConfig[key]
=20
 def gitConfigList(key):
--=20
2.5.1
