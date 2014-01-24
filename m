From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/9] Convert some match_pathspec_depth() to dir_path_match()
Date: Fri, 24 Jan 2014 20:40:29 +0700
Message-ID: <1390570836-20394-3-git-send-email-pclouds@gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pawel.sikora@agmk.net,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 14:35:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6guu-00051N-9j
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 14:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbaAXNfT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 08:35:19 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:44541 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaAXNfS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 08:35:18 -0500
Received: by mail-pd0-f177.google.com with SMTP id x10so3127573pdj.22
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 05:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dyRYUFCss6Rzf/pQIU4LS2Pt140uk2/D6j+N/bkprCo=;
        b=eRoo3OmsZgpQfUhKYdYgdH1iHsAu4Ku3XGWJ74N5AhQJSA2AqTpYQgwj8Id1AN0Mp7
         mlma67bsHL6GJYTgMzAK+7rz/W+tp1cHLOOGm/QG3vYHOXbsrG/+R5GIHSp8BwWNu+Xq
         MX4y/Z+5wjBagx9Mb92b4Yl4N+Z3pwSHiKLFbyA3GkfnspFX27OLx+ZWPb97o4Ie6mMZ
         BBrjExhy8r5A0IODgMSivWXz2h5hk3iMJ3JC2TjShdntoo/+yWeV3gr3lWhBh/43f7Hp
         wmL2OJfqgRpcnDhk7yEM6Bj4EmK9w9wGgHHH0ygoO9s5zY8rxNn5btBD2C68eZxCiq6f
         VlVw==
X-Received: by 10.66.180.200 with SMTP id dq8mr14546786pac.104.1390570517638;
        Fri, 24 Jan 2014 05:35:17 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id tu3sm7751617pab.1.2014.01.24.05.35.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 05:35:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 24 Jan 2014 20:40:52 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241001>

This helps reduce the number of match_pathspec_depth() call sites and
show how m_p_d() is used. And it usage is:

 - match against an index entry (ce_path_match or match_pathspec_depth
   in ls-files)

 - match against a dir_entry from read_directory (dir_path_match and
   match_pathspec_depth in clean.c, which will be converted later)

 - resolve-undo (rerere.c and ls-files.c)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c      | 3 +--
 builtin/grep.c     | 4 +---
 builtin/ls-files.c | 2 +-
 dir.h              | 7 +++++++
 wt-status.c        | 4 ++--
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 2a2722f..672adc0 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -208,8 +208,7 @@ static char *prune_directory(struct dir_struct *dir=
, struct pathspec *pathspec,
 	i =3D dir->nr;
 	while (--i >=3D 0) {
 		struct dir_entry *entry =3D *src++;
-		if (match_pathspec_depth(pathspec, entry->name, entry->len,
-					 prefix, seen))
+		if (dir_path_match(entry, pathspec, prefix, seen))
 			*dst++ =3D entry;
 		else if (flag & WARN_IMPLICIT_DOT)
 			/*
diff --git a/builtin/grep.c b/builtin/grep.c
index 3d924c2..69ac2d8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -524,9 +524,7 @@ static int grep_directory(struct grep_opt *opt, con=
st struct pathspec *pathspec,
=20
 	fill_directory(&dir, pathspec);
 	for (i =3D 0; i < dir.nr; i++) {
-		const char *name =3D dir.entries[i]->name;
-		int namelen =3D strlen(name);
-		if (!match_pathspec_depth(pathspec, name, namelen, 0, NULL))
+		if (!dir_path_match(dir.entries[i], pathspec, 0, NULL))
 			continue;
 		hit |=3D grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e1cf6d8..e238608 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -64,7 +64,7 @@ static void show_dir_entry(const char *tag, struct di=
r_entry *ent)
 	if (len >=3D ent->len)
 		die("git ls-files: internal error - directory entry not superset of =
prefix");
=20
-	if (!match_pathspec_depth(&pathspec, ent->name, ent->len, len, ps_mat=
ched))
+	if (!dir_path_match(ent, &pathspec, len, ps_matched))
 		return;
=20
 	fputs(tag, stdout);
diff --git a/dir.h b/dir.h
index 42793e5..65f54b6 100644
--- a/dir.h
+++ b/dir.h
@@ -212,4 +212,11 @@ static inline int ce_path_match(const struct cache=
_entry *ce,
 	return match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, se=
en);
 }
=20
+static inline int dir_path_match(const struct dir_entry *ent,
+				 const struct pathspec *pathspec,
+				 int prefix, char *seen)
+{
+	return match_pathspec_depth(pathspec, ent->name, ent->len, prefix, se=
en);
+}
+
 #endif
diff --git a/wt-status.c b/wt-status.c
index 295c09e..a452407 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -552,7 +552,7 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 	for (i =3D 0; i < dir.nr; i++) {
 		struct dir_entry *ent =3D dir.entries[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
-		    match_pathspec_depth(&s->pathspec, ent->name, ent->len, 0, NULL)=
)
+		    dir_path_match(ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->untracked, ent->name);
 		free(ent);
 	}
@@ -560,7 +560,7 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 	for (i =3D 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent =3D dir.ignored[i];
 		if (cache_name_is_other(ent->name, ent->len) &&
-		    match_pathspec_depth(&s->pathspec, ent->name, ent->len, 0, NULL)=
)
+		    dir_path_match(ent, &s->pathspec, 0, NULL))
 			string_list_insert(&s->ignored, ent->name);
 		free(ent);
 	}
--=20
1.8.5.2.240.g8478abd
