From: larsxschneider@gmail.com
Subject: [PATCH v8 1/7] git-p4: add optional type specifier to gitConfig reader
Date: Sat, 26 Sep 2015 09:54:58 +0200
Message-ID: <1443254104-14966-2-git-send-email-larsxschneider@gmail.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 09:56:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfkKy-0007ck-U7
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 09:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbbIZHzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Sep 2015 03:55:45 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35839 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbbIZHzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2015 03:55:23 -0400
Received: by wicge5 with SMTP id ge5so46639193wic.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2015 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UHoTrMzXTTzsnctTendu72LnbhrfIUSJeD/+YoOWQvQ=;
        b=m+dkAGukilAOcUHfdnSUEkwbw/EsQP3KSxaxKLRs+2o3ZXgYTv3b0u95nFtcyx5zKf
         hcbheZ2KU0KGmfF/VG9njdQBycCZwVgT9R9zgTfjtKQLuCXF3K3Q8nkgy1n3n8tmF9cL
         56zC9C1xGuE6it/i/Z50i6EYde6JSOR3UtZvYA5WxD2jkM9FhCBf2OHHhZ5xUgU/5ju9
         pNGcsRSHWqu5lZ11slFveZqRTKq8ONA24yDYl4VVG/3qv2mlyyk6Kg5rconLLJ0COAXh
         JR+CGmpjJg5PnrIdNew03u2jr46qru87b8N/WBS3bX8o8zSqAJ/oDgk5rSL2aAfOeUC9
         1wxw==
X-Received: by 10.194.205.68 with SMTP id le4mr12615235wjc.74.1443254122063;
        Sat, 26 Sep 2015 00:55:22 -0700 (PDT)
Received: from localhost.localdomain (tmo-102-235.customers.d1-online.com. [80.187.102.235])
        by smtp.gmail.com with ESMTPSA id it4sm7176613wjb.0.2015.09.26.00.55.17
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 26 Sep 2015 00:55:21 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278690>

=46rom: Lars Schneider <larsxschneider@gmail.com>

The functions =E2=80=9CgitConfig=E2=80=9D and =E2=80=9CgitConfigBool=E2=
=80=9D are almost identical.
Make =E2=80=9CgitConfig=E2=80=9D more generic by adding an optional typ=
e specifier.
Use the type specifier =E2=80=9C=E2=80=94bool=E2=80=9D with =E2=80=9Cgi=
tConfig=E2=80=9D to implement
=E2=80=9CgitConfigBool. This prepares the implementation of other type
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
