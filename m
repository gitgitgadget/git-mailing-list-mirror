From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 07/45] parse_pathspec: save original pathspec for reporting
Date: Fri, 15 Mar 2013 13:06:22 +0700
Message-ID: <1363327620-29017-8-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO4t-0004CH-2V
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab3COGYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:24:54 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:40805 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab3COGYv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:24:51 -0400
Received: by mail-ie0-f179.google.com with SMTP id k11so3938123iea.38
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=j1P0juCcqhdIbrLnxp6sl3wp5LLbgFpafWmIX1Y/et8=;
        b=rofwbxV4M/GmhxARN9R54+qz43USmx1Dfm4bek1VIPvqp3oCj/qKuRKoGP0fBDqit/
         P+8bKsttnJhliZ6JQ85e4rTzfgAQKpZp6fjxLuE44Tyg5MPeWoGDKapzRwgHMBrOJq81
         tgBiY1dc/oe8YmX0JGJ2CsRIQLUNsNrOyh6NeNJTga2nuUm3ycgakHuqF7PcJ4vGA1ap
         PlMk2h+U/jA/nO22EdzdGa3hATHrBkYpoLrBTXC9+lpugFajRrfQ0G+oH5K4IzCVW/HE
         Z/UQCjoOD2mJRvyFk6gSwJNzBDl/9dlFQn5wuzSkJa9/iNMKc1IhFrfO22YYze6c6u4d
         5BEA==
X-Received: by 10.50.6.3 with SMTP id w3mr419325igw.76.1363328691293;
        Thu, 14 Mar 2013 23:24:51 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id hi4sm742237igc.6.2013.03.14.23.24.47
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:24:50 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:07:53 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218193>

We usually use pathspec_item's match field for pathspec error
reporting. However "match" (or "raw") does not show the magic part,
which will play more important role later on. Preserve exact user
input for reporting.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c      | 1 +
 pathspec.c | 2 ++
 pathspec.h | 1 +
 3 files changed, 4 insertions(+)

diff --git a/dir.c b/dir.c
index a442467..8541ea7 100644
--- a/dir.c
+++ b/dir.c
@@ -1649,6 +1649,7 @@ int init_pathspec(struct pathspec *pathspec, cons=
t char **paths)
 		const char *path =3D paths[i];
=20
 		item->match =3D path;
+		item->original =3D path;
 		item->len =3D strlen(path);
 		item->flags =3D 0;
 		if (limit_pathspec_to_literal()) {
diff --git a/pathspec.c b/pathspec.c
index bc9d9ac..2bda633 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -202,6 +202,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	else
 		match =3D prefix_path(prefix, prefixlen, copyfrom);
 	*raw =3D item->match =3D match;
+	item->original =3D elt;
 	item->len =3D strlen(item->match);
 	if (limit_pathspec_to_literal())
 		item->nowildcard_len =3D item->len;
@@ -275,6 +276,7 @@ void parse_pathspec(struct pathspec *pathspec,
=20
 		pathspec->items =3D item =3D xmalloc(sizeof(*item));
 		item->match =3D prefix;
+		item->original =3D prefix;
 		item->nowildcard_len =3D item->len =3D strlen(prefix);
 		raw[0] =3D prefix;
 		raw[1] =3D NULL;
diff --git a/pathspec.h b/pathspec.h
index 937ec91..cc5841b 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -16,6 +16,7 @@ struct pathspec {
 	int max_depth;
 	struct pathspec_item {
 		const char *match;
+		const char *original;
 		unsigned magic;
 		int len;
 		int nowildcard_len;
--=20
1.8.0.rc0.19.g7bbb31d
