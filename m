From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/8] mv: split submodule move preparation code out
Date: Sun, 10 Aug 2014 09:29:31 +0700
Message-ID: <1407637776-19794-4-git-send-email-pclouds@gmail.com>
References: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 04:30:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGIta-0003cQ-7c
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 04:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbaHJC37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2014 22:29:59 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:56426 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaHJC36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 22:29:58 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so9224512pad.36
        for <git@vger.kernel.org>; Sat, 09 Aug 2014 19:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KTkuOsQV2PjskVIE+a8wmP1i4kctunqS+9BBjDPnBxw=;
        b=oc+3TUhiUZydXfwQZ+zGLT4xBWydEn7ikntO6DXDxj83KsnzPeb9LS8YqRgTRu5n4X
         7xp7cI1njE/ZsGrbgBr87UPY//ppJFRHDTfyxRSzY3w1umX4m+tctuOsPoOT8rnuyUBl
         3GB8dNhPL7ngb7YmMq8lNxqrOojYjFyVLaz5PhIeT7carn4im1OOYS3iRggW6t0o25Ym
         2UW8mS6w/LIDDoCZxYhkvJS8SS3l8eYbaGKBKOZm3ywzry+6W6kCZOUS2mpXSzM5b/3W
         frHfH53TGEz0D7zk7hcFGQ/EzRQOSAdMgrX/T89jolnefVDY61x6t3moZwGV4oGoq3Lt
         8pRw==
X-Received: by 10.66.169.136 with SMTP id ae8mr33262028pac.14.1407637797817;
        Sat, 09 Aug 2014 19:29:57 -0700 (PDT)
Received: from lanh ([115.73.228.225])
        by mx.google.com with ESMTPSA id co14sm41817733pac.43.2014.08.09.19.29.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2014 19:29:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Aug 2014 09:30:00 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255079>

"Huh?" is removed from die() message.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index c48129e..524f4e5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -61,6 +61,23 @@ static const char *add_slash(const char *path)
 static struct lock_file lock_file;
 #define SUBMODULE_WITH_GITDIR ((const char *)1)
=20
+static void prepare_move_submodule(const char *src, int first,
+				   const char **submodule_gitfile)
+{
+	struct strbuf submodule_dotgit =3D STRBUF_INIT;
+	if (!S_ISGITLINK(active_cache[first]->ce_mode))
+		die(_("Directory %s is in index and no submodule?"), src);
+	if (!is_staging_gitmodules_ok())
+		die(_("Please stage your changes to .gitmodules or stash them to pro=
ceed"));
+	strbuf_addf(&submodule_dotgit, "%s/.git", src);
+	*submodule_gitfile =3D read_gitfile(submodule_dotgit.buf);
+	if (*submodule_gitfile)
+		*submodule_gitfile =3D xstrdup(*submodule_gitfile);
+	else
+		*submodule_gitfile =3D SUBMODULE_WITH_GITDIR;
+	strbuf_release(&submodule_dotgit);
+}
+
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, gitmodules_modified =3D 0;
@@ -132,20 +149,10 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 			bad =3D _("cannot move directory over file");
 		else if (src_is_dir) {
 			int first =3D cache_name_pos(src, length);
-			if (first >=3D 0) {
-				struct strbuf submodule_dotgit =3D STRBUF_INIT;
-				if (!S_ISGITLINK(active_cache[first]->ce_mode))
-					die (_("Huh? Directory %s is in index and no submodule?"), src);
-				if (!is_staging_gitmodules_ok())
-					die (_("Please, stage your changes to .gitmodules or stash them t=
o proceed"));
-				strbuf_addf(&submodule_dotgit, "%s/.git", src);
-				submodule_gitfile[i] =3D read_gitfile(submodule_dotgit.buf);
-				if (submodule_gitfile[i])
-					submodule_gitfile[i] =3D xstrdup(submodule_gitfile[i]);
-				else
-					submodule_gitfile[i] =3D SUBMODULE_WITH_GITDIR;
-				strbuf_release(&submodule_dotgit);
-			} else {
+			if (first >=3D 0)
+				prepare_move_submodule(src, first,
+						       submodule_gitfile + i);
+			else {
 				const char *src_w_slash =3D add_slash(src);
 				int last, len_w_slash =3D length + 1;
=20
--=20
2.1.0.rc0.78.gc0d8480
