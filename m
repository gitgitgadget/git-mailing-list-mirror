From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 08/45] parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
Date: Fri, 15 Mar 2013 13:06:23 +0700
Message-ID: <1363327620-29017-9-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:25:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO5B-0004VB-V2
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab3COGY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:24:59 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:61024 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab3COGY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:24:58 -0400
Received: by mail-ia0-f171.google.com with SMTP id z13so2916838iaz.30
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=n5/f1OHId8IB1W/Et+XkiPufKyJtQIzqcr8IZwdjj6I=;
        b=KUD6fU6VsEsDd6ktAcnwjj106KOmdFG/im/VopOIKzL0qptyxyDO4OWkrl04ssbK4M
         GhkPd0ge7o/jXsLwf3frUOskEp/kMZ1fKlqdVu/4KfFEQtTfCKI1HohSh4CXWm72V/12
         P2F2aTRT9kSOws+Lb/Bg2nujC+eEtuV6B4rm1Jt9j7cCW5EFaOJIL6oHfs91nkm5/xB4
         t/v1gU8vWrVLKIGzfUD690LsLjKmUZw9CX4y+QkokmNpQdSIJoUJ2E+UHKcoiMQNdMCD
         c125qNYZh9CXsCJny4y7aNv7uKQ2LFwsMCuNHENHo/Gdzzu3mhob3Vd+bGmfLKdxNl4u
         cqhA==
X-Received: by 10.50.88.233 with SMTP id bj9mr409090igb.55.1363328697635;
        Thu, 14 Mar 2013 23:24:57 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id ur12sm736118igb.8.2013.03.14.23.24.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:24:57 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:08:00 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218195>

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
index 2bda633..6dd944a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -270,10 +270,20 @@ void parse_pathspec(struct pathspec *pathspec,
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
 		item->match =3D prefix;
 		item->original =3D prefix;
@@ -338,7 +348,8 @@ const char **get_pathspec(const char *prefix, const=
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
1.8.0.rc0.19.g7bbb31d
