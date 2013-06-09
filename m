From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/45] parse_pathspec: support stripping submodule trailing slashes
Date: Sun,  9 Jun 2013 13:25:43 +0700
Message-ID: <1370759178-1709-11-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:26:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ4j-0008Ru-W5
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab3FIGZ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:25:58 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43171 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab3FIGZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:25:57 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so6259130pdi.25
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=17SF7JWXlgVrkzOJxGmzpBCr0zI/8oIvQ4PVF/yv0pM=;
        b=UNel2TySU8ou210e538eLsuUYTUR/7DMtJkL307hshfbTrZo4fb1CEOkoLMgrJq7Ug
         YT+PBsZAJnDTVBibk5S+k7McSEYwQfyAw5q4GcfydekVVc1HeeoPlVxnJbhKidNDUXYp
         gt8YQpQmOniIVNoZ8I3O5UIGuqMJ0mMux0tHvkZCzNXRp8mGHBR1mfGuyKpwK6Fx1UyV
         +F5nTBosJq2Vmb6lqeoSFXo2RvTQhivYXfnRGY64y3WCo8QHSy0X2sPIe4i5osw6HNin
         l6Kv0BXJLRChCUsEkyOGJpC1dZtpSOWsc7zHsBtcdoWfwpbFKfuiRVU7xxoHq/Dfk9zw
         zCnw==
X-Received: by 10.68.224.228 with SMTP id rf4mr5254480pbc.50.1370759157226;
        Sat, 08 Jun 2013 23:25:57 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id 3sm5471605pbj.46.2013.06.08.23.25.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:25:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:27:27 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226902>

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
index a352ef1..e3c8339 100644
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
1.8.2.83.gc99314b
