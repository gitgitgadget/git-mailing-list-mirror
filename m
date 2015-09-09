From: larsxschneider@gmail.com
Subject: [PATCH v4 1/5] git-p4: add optional type specifier to gitConfig reader
Date: Wed,  9 Sep 2015 13:59:06 +0200
Message-ID: <1441799950-54633-2-git-send-email-larsxschneider@gmail.com>
References: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 13:59:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZe2O-0001L2-En
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 13:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbbIIL7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 07:59:21 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37764 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbIIL7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 07:59:14 -0400
Received: by wicfx3 with SMTP id fx3so18846725wic.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 04:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JLkXMGqyh+wNw6CtiX72g8vn/ZuGiSz5nWKGSCKfZRw=;
        b=pEVrSGPLZSzJdmzUyR4KRtIRJDJ+ucED/lXG6AOXTGycvMKnWrbEJ7b7dgfzy1DZG0
         NGVZj3/gAouXj+8yZPrspTQwhuxatsGooXKTmYAuC0jH8pTAs2J2V9UnGCa0LxEPAP9F
         n2xx42PAAyJ7McpWh1u7Ac8u78pDjsBJ/3SbPHq2kkt7TKYe6TqPDgvM3+KXC7lmL3CD
         uWDTsfZwXjpnVjABe3XB4JAw0Qn2AyalSBqpb+fQzktkSuP1PV7OMSFTIHcXk/d5tb47
         cZ23NJzUB3j+NxvD55i7VFgVncW0nGKauWIK+VjnhoFugplyYw+Ths9u6GCT7QbO7725
         hP1w==
X-Received: by 10.180.82.98 with SMTP id h2mr52099700wiy.37.1441799953501;
        Wed, 09 Sep 2015 04:59:13 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u1sm3498338wiz.22.2015.09.09.04.59.12
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Sep 2015 04:59:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277547>

=46rom: Lars Schneider <larsxschneider@gmail.com>

The functions =E2=80=9CgitConfig=E2=80=9D and =E2=80=9CgitConfigBool=E2=
=80=9D are almost identical. Make =E2=80=9CgitConfig=E2=80=9D more gene=
ric by adding an optional type specifier. Use the type specifier =E2=80=
=9C=E2=80=94bool=E2=80=9D with =E2=80=9CgitConfig=E2=80=9D to implement=
 =E2=80=9CgitConfigBool. This prepares the implementation of other type=
 specifiers such as =E2=80=9C=E2=80=94int=E2=80=9D.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
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
