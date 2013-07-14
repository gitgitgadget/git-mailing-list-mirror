From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/46] parse_pathspec: support stripping submodule trailing slashes
Date: Sun, 14 Jul 2013 15:35:33 +0700
Message-ID: <1373790969-13000-11-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:37:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHo6-0001dY-K4
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953Ab3GNIhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:37:20 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:64246 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3GNIhS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:37:18 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so10350974pbc.29
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JQekGjws7AiBVpq8ZwgI92MOiir/1o8uHanOa3DlIuo=;
        b=h9DgUNB4i6QL28yR2raclTpfb90crQD8B9F6sDyHiUaAVp4xUFVFpJSAFaJrXziXH6
         0SPG8TmgHLKafUfXNx+FUBKHPuMVAzTO6LsyF+/kcMqypNX7Wt5zDdzAf7ewQCY5CTE3
         s60ByfrfLr+7evuRpUhCTUd5xaHVv2dZP8nBZJJx9jfStZtFpDaT+d21RVjwEq/MMS3h
         Fl2fAztWR/uzpu2iYtqXuuhoiKlIPiChBf/b7aOJQEB5xm6atMScul4oazwCn+0+tqP9
         adpBRhzsBqfI05T/uZDTXXA2B6mcaICEIlrJF7hayWD/dJJIXM8rdUS9e5Z7vQPbmNuV
         Vgmg==
X-Received: by 10.68.113.2 with SMTP id iu2mr48985922pbb.108.1373791038398;
        Sun, 14 Jul 2013 01:37:18 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id ai6sm57807019pad.15.2013.07.14.01.37.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:37:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:37:30 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230322>

This flag is equivalent to builtin/ls-files.c:strip_trailing_slashes()
and is intended to replace that function when ls-files is converted to
use parse_pathspec.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 9 +++++++++
 pathspec.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 06778fc..1c07c23 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -205,6 +205,15 @@ static unsigned prefix_pathspec(struct pathspec_it=
em *item,
 	*raw =3D item->match =3D match;
 	item->original =3D elt;
 	item->len =3D strlen(item->match);
+
+	if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
+	    (item->len >=3D 1 && item->match[item->len - 1] =3D=3D '/') &&
+	    (i =3D cache_name_pos(item->match, item->len - 1)) >=3D 0 &&
+	    S_ISGITLINK(active_cache[i]->ce_mode)) {
+		item->len--;
+		match[item->len] =3D '\0';
+	}
+
 	if (limit_pathspec_to_literal())
 		item->nowildcard_len =3D item->len;
 	else
diff --git a/pathspec.h b/pathspec.h
index aa98597..5144851 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -31,6 +31,8 @@ struct pathspec {
 #define PATHSPEC_PREFER_CWD (1<<0) /* No args means match cwd */
 #define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everything =
*/
 #define PATHSPEC_MAXDEPTH_VALID (1<<2) /* max_depth field is valid */
+/* strip the trailing slash if the given path is a gitlink */
+#define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<3)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
--=20
1.8.2.83.gc99314b
