From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/45] parse_pathspec: save original pathspec for reporting
Date: Sun,  9 Jun 2013 13:25:39 +0700
Message-ID: <1370759178-1709-7-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:25:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ4M-0008G2-2O
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763Ab3FIGZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:25:34 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:59537 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab3FIGZa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:25:30 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so6094655pbb.8
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gr7uGJl2DQtxWykGAwBiHHfTfaGqfBdZXWXpL0CyBzQ=;
        b=NTmzsNd0JqQz4IpqNaI8pracH+WMbF4X00F0sDFuINKpwwEDp6zj5QcvvNVOu/0GMQ
         qAyi0ooFP40bh9vyyw5c0lqRhGPmnfDi11kL2dhNR9IZFTftuIuy7kXrcYXPzVBgcApn
         /iUpaXmbQcNtRvV+dKCWmygFzHY+m4/8mPM/nQ9qPhQVb8w1tP5850u2FLgnn1KHDxtT
         OjCtE4wZff7tlLLVkAw9MUXWRxepuZWS5BlJoSXK9xpZPZyuzvNSAjo+8HYvvN+NPqki
         9D6U+zq7I9fOgdoKbSISjD7tfAOmEjseCWcrWO5uPO3UG+NniDwx9FSqiR7WsiCoBdjg
         bjNg==
X-Received: by 10.66.226.233 with SMTP id rv9mr9211629pac.155.1370759130170;
        Sat, 08 Jun 2013 23:25:30 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id cp1sm5476714pbc.42.2013.06.08.23.25.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:25:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:27:01 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226898>

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
index b8e68c2..c0b284f 100644
--- a/dir.c
+++ b/dir.c
@@ -1601,6 +1601,7 @@ int init_pathspec(struct pathspec *pathspec, cons=
t char **paths)
 		const char *path =3D paths[i];
=20
 		item->match =3D path;
+		item->original =3D path;
 		item->len =3D strlen(path);
 		item->flags =3D 0;
 		if (limit_pathspec_to_literal()) {
diff --git a/pathspec.c b/pathspec.c
index b49bd51..89bdc7f 100644
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
