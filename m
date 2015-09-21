From: larsxschneider@gmail.com
Subject: [PATCH v7 1/7] git-p4: add optional type specifier to gitConfig reader
Date: Tue, 22 Sep 2015 00:41:07 +0200
Message-ID: <1442875273-48610-2-git-send-email-larsxschneider@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:41:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9m4-0000PZ-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbbIUWlV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 18:41:21 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33595 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655AbbIUWlU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:41:20 -0400
Received: by wiclk2 with SMTP id lk2so168141129wic.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6fgESMrlgK/iTPGMxiK2Yr/WFvQ7zGqJzYOz5W3tyXI=;
        b=bvZ5h+f0DahoE0p9Zr1arNSUHxdvLXOCs5YPyykmjzCFNBxX6evD9DF4wmruBTF7yv
         QLauK6gQsmZ5jliK6w/sf0R1MZ8l4mq5hB2HByi1dIZfs2Sd9XUhn7pH9IDKfYw+KSle
         qNqu1n+QkQshQ98Zf5XYf8kGInxdtEWXVQGpf9n7FjrgmSdL9ytjVFGXHKk6kwgNl/fK
         J61aWW4R/+Gdh8fsrHBuyGoyVj5T1n2Z689FrZKV3YP/1Zxo9JD4dlpDHwn07PdoO2rh
         Xn1IiWgE6FZNLdiCnbvEPY4BzKTn+adyDohlB1YPPcwutq4tc04xW59V9oiLpyE5N46X
         qY4A==
X-Received: by 10.194.112.104 with SMTP id ip8mr25825051wjb.131.1442875279004;
        Mon, 21 Sep 2015 15:41:19 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s16sm121516wik.13.2015.09.21.15.41.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 15:41:18 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278351>

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
index 215f556..2659079 100755
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
