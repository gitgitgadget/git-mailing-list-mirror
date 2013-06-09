From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/45] parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
Date: Sun,  9 Jun 2013 13:25:40 +0700
Message-ID: <1370759178-1709-8-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:25:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ4P-0008He-VN
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814Ab3FIGZh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:25:37 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38020 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab3FIGZh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:25:37 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so1764871pac.26
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mSXdCylG+ESXsaOK5gJOwpohP74JREK7VWCC26PSUfw=;
        b=pvr4Te673URDORfDfF7L4BZjdkvvgnRlkwZ2sTF0bpDYFaLBfAZlVUIPHMX5y4NOQR
         /2165ijb/WeUpsK2CyY8IKczFSotL1XnTOyGQlcGopn+38A2fY+V9SlJr1f0oeOJdgft
         LP4A/oZTqlm/XLqKBJaTktGTkF3eTy6xOmxSp8JTQ6Buh2FrHAO3tNa3z4gc19frHcLW
         mSrDIjDVP0kx2RG9zzXeBe/gepajFwhcHqeUfGVhwEFTU0A50YjMvXabhub+pncCGXFJ
         VtIIXusGM6V+R5WRaqzSn3A3eTY6WOBeskuiLsZALDOnbRyXn+NxshfuMeoDjdDBiyNs
         0AIg==
X-Received: by 10.68.252.36 with SMTP id zp4mr5248068pbc.51.1370759136751;
        Sat, 08 Jun 2013 23:25:36 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id uv1sm5528492pbc.16.2013.06.08.23.25.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:25:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:27:07 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226899>

We have two ways of dealing with empty pathspec:

1. limit it to current prefix
2. match the entire working directory

Some commands go with #1, some #2. get_pathspec() and parse_pathspec()
only support #1. Make parse_pathspec() reject empty pathspec by
default. #1 and #2 can be specified via new flags. This makes it more
expressive about default behavior at command level.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 13 ++++++++++++-
 pathspec.h |  4 ++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 89bdc7f..9e68321 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -271,10 +271,20 @@ void parse_pathspec(struct pathspec *pathspec,
 	if (!entry && !prefix)
 		return;
=20
+	if ((flags & PATHSPEC_PREFER_CWD) &&
+	    (flags & PATHSPEC_PREFER_FULL))
+		die("BUG: PATHSPEC_PREFER_CWD and PATHSPEC_PREFER_FULL are incompati=
ble");
+
 	/* No arguments with prefix -> prefix pathspec */
 	if (!entry) {
 		static const char *raw[2];
=20
+		if (flags & PATHSPEC_PREFER_FULL)
+			return;
+
+		if (!(flags & PATHSPEC_PREFER_CWD))
+			die("BUG: parse_pathspec cannot take no arguments in this case");
+
 		pathspec->items =3D item =3D xmalloc(sizeof(*item));
 		memset(item, 0, sizeof(*item));
 		item->match =3D prefix;
@@ -340,7 +350,8 @@ const char **get_pathspec(const char *prefix, const=
 char **pathspec)
 	struct pathspec ps;
 	parse_pathspec(&ps,
 		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
-		       0, prefix, pathspec);
+		       PATHSPEC_PREFER_CWD,
+		       prefix, pathspec);
 	return ps.raw;
 }
=20
diff --git a/pathspec.h b/pathspec.h
index cc5841b..d630e8b 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -24,6 +24,10 @@ struct pathspec {
 	} *items;
 };
=20
+/* parse_pathspec flags */
+#define PATHSPEC_PREFER_CWD (1<<0) /* No args means match cwd */
+#define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everything =
*/
+
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
 			   unsigned magic_mask,
--=20
1.8.2.83.gc99314b
