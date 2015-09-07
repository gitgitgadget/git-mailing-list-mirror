From: larsxschneider@gmail.com
Subject: [PATCH v3 1/5] git-p4: add optional type specifier to gitConfig reader
Date: Mon,  7 Sep 2015 14:21:14 +0200
Message-ID: <1441628478-86503-2-git-send-email-larsxschneider@gmail.com>
References: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:21:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYvQd-0000L3-6i
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 14:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbbIGMV0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2015 08:21:26 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34650 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbbIGMVY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 08:21:24 -0400
Received: by wicfx3 with SMTP id fx3so86845807wic.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JLkXMGqyh+wNw6CtiX72g8vn/ZuGiSz5nWKGSCKfZRw=;
        b=E8HePUY6dfRfYyJkjiXzqRj+tPypSFvLwAfa8RQASP+ogz9h/xyus1e44+R9Tl9sDM
         Heu3KPVITiE5qA7/8hm1V2RM4A88yHWz8ll6YpQx9GISuFGaj8AmRzb810OBBJpHr7/g
         UYrBsVtncn9qNLqdZgfWRGsUHchVILRhR6npehtKLcHU6xjmhjXKqBQ9s/Ka6FGM0csf
         9q1ck6omLhVZ/rqSFyC6SJ5DHQ5ertG0LyVmWOKr4ocUlCOiSN6aq7GeM/5jnZXPlgvL
         rF21UAmJnqyG9lC8zrhJDKLaT79QWQc6l2YGfCuc3jnt5EuMuwHroh0MvMFW9nyVxl8C
         fH7A==
X-Received: by 10.194.171.200 with SMTP id aw8mr34522513wjc.62.1441628483751;
        Mon, 07 Sep 2015 05:21:23 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id gc19sm2441591wic.19.2015.09.07.05.21.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Sep 2015 05:21:22 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277453>

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
