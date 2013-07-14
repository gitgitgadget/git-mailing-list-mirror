From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/46] parse_pathspec: save original pathspec for reporting
Date: Sun, 14 Jul 2013 15:35:29 +0700
Message-ID: <1373790969-13000-7-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:37:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHng-0001LT-CD
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911Ab3GNIg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:36:56 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:32769 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:36:55 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so9892154pde.9
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BuArs6X9oUfO8QOwgdj+pMsDFqugdTvmkAz15TkgWpk=;
        b=fPgBXY50NTB2cuL4qpJMdBd6Vzce5ciFXC7Ndlqo5eBR8or3UfmwcrXspC2wp7b/dV
         9duQsNjN9B/Ka3oGnLnHeKAlueKkEUcbrFbG+7DMK78sQyE9X30XcnKI1E0e/JY2giM3
         vw/kRHYPQ97DnWQoYabDyzQFdVJpXeQiccaI4iZDXEfMba+x+Dm417RskCO1fj0Hh0oL
         vL9sPb+HN1S4NtQavk7OLumGeXjo1oMepprnYouzchVPXQpeqO0Iqa7PR5n/Hzsn6R8/
         CW3p59F8/18k5nNT76Qc7dmrf+/BS9FDcJuiPZ8tL9xmA9sxZByFbO9mePmbqjRM1SS/
         j0ew==
X-Received: by 10.68.41.106 with SMTP id e10mr49653096pbl.136.1373791015248;
        Sun, 14 Jul 2013 01:36:55 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id re16sm57801131pac.16.2013.07.14.01.36.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:36:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:37:07 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230318>

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
index 5f86e46..308028e 100644
--- a/dir.c
+++ b/dir.c
@@ -1599,6 +1599,7 @@ int init_pathspec(struct pathspec *pathspec, cons=
t char **paths)
 		const char *path =3D paths[i];
=20
 		item->match =3D path;
+		item->original =3D path;
 		item->len =3D strlen(path);
 		item->flags =3D 0;
 		if (limit_pathspec_to_literal()) {
diff --git a/pathspec.c b/pathspec.c
index ce942db..f94beb6 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -203,6 +203,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	else
 		match =3D prefix_path(prefix, prefixlen, copyfrom);
 	*raw =3D item->match =3D match;
+	item->original =3D elt;
 	item->len =3D strlen(item->match);
 	if (limit_pathspec_to_literal())
 		item->nowildcard_len =3D item->len;
@@ -277,6 +278,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		pathspec->items =3D item =3D xmalloc(sizeof(*item));
 		memset(item, 0, sizeof(*item));
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
1.8.2.83.gc99314b
