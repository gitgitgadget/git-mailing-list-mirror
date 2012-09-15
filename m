From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] Support "**" in .gitignore and .gitattributes patterns using wildmatch()
Date: Sat, 15 Sep 2012 19:02:04 +0700
Message-ID: <1347710524-15404-6-git-send-email-pclouds@gmail.com>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 14:03:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCr5c-0003IB-UI
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 14:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab2IOMC7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2012 08:02:59 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60555 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab2IOMCc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 08:02:32 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2989164dad.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 05:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yGysl4PzwmvQClLyq+75Ytsv4DGfBz+UGhjkaNMkK4U=;
        b=IuZXSAkj0iYcILw8D0TB+E/0JGzqRu4YmdRVkbS8YeX2OypTAnNTTcZ/tX3Y7VF3BN
         //3k/xC76TNrWNbF/XtBVbp9PxnXlvUC5ru1hQnYOA2MD9a18zBxED7k4k4TBYbptb+s
         a+ATAJEqzbJKQV+hQ4EW0gF24CjlYRaKWDEziI2vr/V2QlANW0/ToayueQJpqzE0re0p
         DhxvAl0gZ+krvEvq3xaCa3CmYF/D5eqny0TDEgNceXOoX75TWZr0D6Gdg9zDezouXeMN
         MXnW/0vpYGPiELFMWUrzVJOCERUeHvVLMFQUUWnDv/giPNUOLspghJGdSt1Mcv7kaWIC
         RfRg==
Received: by 10.68.225.199 with SMTP id rm7mr10260571pbc.150.1347710552730;
        Sat, 15 Sep 2012 05:02:32 -0700 (PDT)
Received: from lanh ([115.74.56.159])
        by mx.google.com with ESMTPS id kp3sm2843751pbc.64.2012.09.15.05.02.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 05:02:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Sep 2012 19:02:34 +0700
X-Mailer: git-send-email 1.7.12.403.gce5cf6f.dirty
In-Reply-To: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205552>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitignore.txt | 3 +++
 attr.c                      | 4 +++-
 dir.c                       | 5 ++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index c1f692a..eb81d31 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -93,6 +93,9 @@ PATTERN FORMAT
    For example, "Documentation/{asterisk}.html" matches
    "Documentation/git.html" but not "Documentation/ppc/ppc.html"
    or "tools/perf/Documentation/perf.html".
++
+Contrary to fnmatch(3), git matches "**" to anything including
+slashes, similar to rsync(1).
=20
  - A leading slash matches the beginning of the pathname.
    For example, "/{asterisk}.c" matches "cat-file.c" but not
diff --git a/attr.c b/attr.c
index 3430faf..f06ad95 100644
--- a/attr.c
+++ b/attr.c
@@ -12,6 +12,7 @@
 #include "exec_cmd.h"
 #include "attr.h"
 #include "dir.h"
+#include "compat/wildmatch.h"
=20
 const char git_attr__true[] =3D "(builtin)true";
 const char git_attr__false[] =3D "\0(builtin)false";
@@ -666,7 +667,8 @@ static int path_matches(const char *pathname, int p=
athlen,
 		return 0;
 	if (baselen !=3D 0)
 		baselen++;
-	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) =3D=3D=
 0;
+	return (ignore_case && iwildmatch(pattern, pathname + baselen)) ||
+		(!ignore_case && wildmatch(pattern, pathname + baselen));
 }
=20
 static int macroexpand_one(int attr_nr, int rem);
diff --git a/dir.c b/dir.c
index 4868339..c17f9ff 100644
--- a/dir.c
+++ b/dir.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "refs.h"
+#include "compat/wildmatch.h"
=20
 struct path_simplify {
 	int len;
@@ -575,7 +576,9 @@ int excluded_from_list(const char *pathname,
 			namelen -=3D prefix;
 		}
=20
-		if (!namelen || !fnmatch_icase(exclude, name, FNM_PATHNAME))
+		if (!namelen ||
+		    ((ignore_case && iwildmatch(exclude, name)) ||
+		     (!ignore_case && wildmatch(exclude, name))))
 			return to_exclude;
 	}
 	return -1; /* undecided */
--=20
1.7.12.403.gce5cf6f.dirty
