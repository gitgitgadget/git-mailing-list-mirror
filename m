From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC 3/3] gitignore: support "**" with wildmatch()
Date: Mon,  7 May 2012 20:01:57 +0700
Message-ID: <1336395717-7799-4-git-send-email-pclouds@gmail.com>
References: <1336395717-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 15:06:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRNdi-0008PZ-6r
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 15:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653Ab2EGNGF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 09:06:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51177 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179Ab2EGNGD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 09:06:03 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6653083pbb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NnArySn71AhW2TW7keukhqkFpnTsNRWSpXjyjnVcA4o=;
        b=esK6aHsaHv0h1ueI098L68ntuOThd2EZA/2FlfybHFN/KJMOAGYSLm4q62dDEYkNCs
         TIbwn0GTz1RcnSTE7qRby7IVIPTNgEtSnrPhyh9shzeMKzPK1ip8XtJXgKZai7Fejamb
         sNyE3ULhjb4qUIggTYKddMP7zeItWEDzLftOQN8tTaydAYEvP0ODsDIKDoJw/YC3ffKf
         j/SEh+Oxgsg9lwWBuz/5j2mYpUDW6EtF4tD8Q9GsJs9U4yVEZ57/FxmXWa4SNCrS/8LE
         MXs5NNAZVphWOg4/RwVKZ/5nBODnMEL6OCWw7wovQ7XzaYt+jb01k4ZGAyS+hybTt+xe
         znww==
Received: by 10.68.227.6 with SMTP id rw6mr8530982pbc.28.1336395963118;
        Mon, 07 May 2012 06:06:03 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id d2sm18268268pbw.39.2012.05.07.06.05.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 May 2012 06:06:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 07 May 2012 20:02:26 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336395717-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197268>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |   20 ++++++++++++++++----
 dir.h |    1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index e98760c..75140f6 100644
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
@@ -335,6 +336,11 @@ void add_exclude(const char *string, const char *b=
ase,
 		x->flags |=3D EXC_FLAG_NODIR;
 	if (no_wildcard(string))
 		x->flags |=3D EXC_FLAG_NOWILDCARD;
+	else if (strstr(string, "**")) {
+		if (ignore_case)
+			warning(_("core.ignorecase is ignored in '%s' because of \"**\""), =
string);
+		x->flags |=3D EXC_FLAG_WILDMATCH;
+	}
 	if (*string =3D=3D '*' && no_wildcard(string+1))
 		x->flags |=3D EXC_FLAG_ENDSWITH;
 	ALLOC_GROW(which->excludes, which->nr + 1, which->alloc);
@@ -549,11 +555,17 @@ int excluded_from_list(const char *pathname,
 				if (x->flags & EXC_FLAG_NOWILDCARD) {
 					if (!strcmp_icase(exclude, pathname + baselen))
 						return to_exclude;
-				} else {
-					if (fnmatch_icase(exclude, pathname+baselen,
-						    FNM_PATHNAME) =3D=3D 0)
-					    return to_exclude;
+					continue;
+				}
+
+				if (x->flags & EXC_FLAG_WILDMATCH) {
+					if (wildmatch(exclude, pathname + baselen))
+						return to_exclude;
+					continue;
 				}
+				if (fnmatch_icase(exclude, pathname + baselen,
+						  FNM_PATHNAME) =3D=3D 0)
+					return to_exclude;
 			}
 		}
 	}
diff --git a/dir.h b/dir.h
index 58b6fc7..794f412 100644
--- a/dir.h
+++ b/dir.h
@@ -10,6 +10,7 @@ struct dir_entry {
 #define EXC_FLAG_NOWILDCARD 2
 #define EXC_FLAG_ENDSWITH 4
 #define EXC_FLAG_MUSTBEDIR 8
+#define EXC_FLAG_WILDMATCH 16
=20
 struct exclude_list {
 	int nr;
--=20
1.7.8.36.g69ee2
