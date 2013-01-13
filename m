From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/31] parse_pathspec: save original pathspec for reporting
Date: Sun, 13 Jan 2013 19:35:12 +0700
Message-ID: <1358080539-17436-5-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMnQ-0005qJ-2U
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010Ab3AMMf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:35:56 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:63970 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996Ab3AMMfz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:35:55 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so1412986dak.2
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=nJACbGRXzrqXqnlmJA8vR7QcEcTQ7zrP0IQxBLuZXV0=;
        b=DpsSAXaGS+SZazrZmlQaw4BLYMAw1krYsfm5vl7NaeHb9Ct4Roi8myuy+1UTOdfSwl
         HsZ6n70BHFB/vSYRmy7o6zknsVLVK3Kk0HT+5v+CHYW330e2P1oFzRjBi4KkeILDT5WX
         09OfF4P67BvYCjGsbvEXslLloCWnA7UMqQo5oO2/128610RyWT40dbzdzclzO1DyC+lr
         V+q+K/GlPOfYuUpqa9j1RjXXSE/eSlKsK04sJWdoxlGbNiyn+D6bEQFrqHXCrJpzevZl
         CG+Dw4TUvir+OOg/T6iuLyaigFxWbxACqRcNWVfdF5CY8/Y9xpCIajLt91wheMez+J60
         VT6g==
X-Received: by 10.68.231.10 with SMTP id tc10mr242678026pbc.81.1358080555205;
        Sun, 13 Jan 2013 04:35:55 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id vk5sm6288758pbc.34.2013.01.13.04.35.51
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:35:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:36:09 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213344>

We usually use pathspec_item's match field for pathspec error
reporting. However "match" (or "raw") does not show the magic part,
which will play more important role later on. Preserve exact user
input for reporting.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h | 1 +
 dir.c   | 1 +
 setup.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/cache.h b/cache.h
index 759c62a..136e4c7 100644
--- a/cache.h
+++ b/cache.h
@@ -485,6 +485,7 @@ struct pathspec {
 	int max_depth;
 	struct pathspec_item {
 		const char *match;
+		const char *original;
 		unsigned magic;
 		int len;
 		int nowildcard_len;
diff --git a/dir.c b/dir.c
index 8454c13..beb7532 100644
--- a/dir.c
+++ b/dir.c
@@ -1538,6 +1538,7 @@ int init_pathspec(struct pathspec *pathspec, cons=
t char **paths)
 		const char *path =3D paths[i];
=20
 		item->match =3D path;
+		item->original =3D path;
 		item->len =3D strlen(path);
 		item->flags =3D 0;
 		if (limit_pathspec_to_literal()) {
diff --git a/setup.c b/setup.c
index 92adefc..a1ad012 100644
--- a/setup.c
+++ b/setup.c
@@ -249,6 +249,7 @@ static unsigned prefix_pathspec(struct pathspec_ite=
m *item,
 	else
 		match =3D prefix_path(prefix, prefixlen, copyfrom);
 	*raw =3D item->match =3D match;
+	item->original =3D elt;
 	item->len =3D strlen(item->match);
 	item->flags =3D 0;
 	if (limit_pathspec_to_literal())
@@ -295,6 +296,7 @@ static void parse_pathspec(struct pathspec *pathspe=
c,
=20
 		pathspec->items =3D item =3D xmalloc(sizeof(*item));
 		item->match =3D prefix;
+		item->original =3D prefix;
 		item->nowildcard_len =3D item->len =3D strlen(prefix);
 		raw[0] =3D prefix;
 		raw[1] =3D NULL;
--=20
1.8.0.rc2.23.g1fb49df
