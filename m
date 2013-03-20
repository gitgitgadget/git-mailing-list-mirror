From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/45] parse_pathspec: support stripping submodule trailing slashes
Date: Wed, 20 Mar 2013 19:16:15 +0700
Message-ID: <1363781779-14947-3-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 20 13:17:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIHx7-0003Kp-P5
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334Ab3CTMQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Mar 2013 08:16:40 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55062 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169Ab3CTMQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:16:39 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so1291268pbc.8
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=kFGxbjQRiWVJ0xEB9fLFEGoYmXVUHoaGgt89UvqOScU=;
        b=pmHqhtut7JaNwLMLbSHVSevyn5GcR5nFkRw38RxrtBO33Hgx4vnuHBKXmL0qcnN+TX
         ypo+YKe6lv1wQ00mMNcOaDNF/E1jHX5fLYZuiD8kQIvrmG/u+APTVwwpklPotYkC/i8D
         /5Y57SxFy09xaSvJjzWO8URMrZClqyRyHUZrIiPiNFWSFeDM5LJ94PVFUGAEYuAmq5ku
         mkjO2dfKZfq+GlJzteuacantBxNW/3OTMa+cGIXGFMUIk0GVFN2KTtcI5JJkhbwTloYU
         zfbTbkbpKeAH8jNV0UAkm7Y+LdjiJUX5cMx0Yh5oVEr+dYldnKgVUWGxUq7oAU/OG6Pw
         d/QA==
X-Received: by 10.68.162.129 with SMTP id ya1mr2777604pbb.22.1363781798594;
        Wed, 20 Mar 2013 05:16:38 -0700 (PDT)
Received: from lanh ([115.74.40.216])
        by mx.google.com with ESMTPS id qp13sm1954707pbb.3.2013.03.20.05.16.35
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:16:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Mar 2013 19:16:34 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363781779-14947-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218590>

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
index fb5443c..57ad9ba 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -204,6 +204,15 @@ static unsigned prefix_pathspec(struct pathspec_it=
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
index aa98597..7935b26 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -31,6 +31,8 @@ struct pathspec {
 #define PATHSPEC_PREFER_CWD (1<<0) /* No args means match cwd */
 #define PATHSPEC_PREFER_FULL (1<<1) /* No args means match everything =
*/
 #define PATHSPEC_MAXDEPTH_VALID (1<<2) /* max_depth field is valid */
+/* stripping the trailing slash if the given path is a gitlink */
+#define PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP (1<<3)
=20
 extern int init_pathspec(struct pathspec *, const char **);
 extern void parse_pathspec(struct pathspec *pathspec,
--=20
1.8.0.rc0.19.g7bbb31d
