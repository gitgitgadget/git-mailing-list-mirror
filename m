From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/21] Add struct pathspec
Date: Wed, 15 Dec 2010 22:02:36 +0700
Message-ID: <1292425376-14550-2-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:04:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSstm-0000Cq-BS
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab0LOPEB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:04:01 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54659 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab0LOPEA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:04:00 -0500
Received: by yxt3 with SMTP id 3so1083931yxt.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UH/v706cNe7dbIO0/cpcTlJH2JjFMoGALz8vQV99PMs=;
        b=cb7xcRniAKcD51FYb1o5tyk7ySoqGUi5iJmBdX1uXfDTTd5Bd32mmbAvaDxVb8ONo5
         flKxJF6Rd9AVYFhQJtVoRn1Ze/hUGl8OtPf2+Nfmy+vN9TCvztE+tmS7bX0c9+dAzAi0
         4rNLqQJsn9EDBp2fLOoUfzPdNg9pqObtGYEwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kTV+0VE382c+DgFoW9ydxKw7QtiwuceK85Z42qQcpVr88tVQ+5DTG7We0rXjTM538u
         qROrO+DnMYiaoZwyPlhQ+1mfyke1T+q2uRdBghAL0nYcxsf0gfBeI9Ts6sy7BJOxD84J
         s8SwyC/S9tRcghcuHFpWRj7xfqOr6npjrmI1Y=
Received: by 10.42.240.133 with SMTP id la5mr5919224icb.327.1292425439154;
        Wed, 15 Dec 2010 07:03:59 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id f7sm846838icq.17.2010.12.15.07.03.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:03:58 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:03:06 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163758>

The old pathspec structure remains as pathspec.raw[]. New things are
stored in pathspec.items[]. There's no guarantee that the pathspec
order in raw[] is exactly as in items[].

raw[] is external (source) data and is untouched by pathspec
manipulation functions. It eases migration from old const char ** to
this new struct.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |   11 +++++++++++
 dir.c   |   31 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 2ef2fa3..9eeecc2 100644
--- a/cache.h
+++ b/cache.h
@@ -493,6 +493,17 @@ extern int index_name_is_other(const struct index_=
state *, const char *, int);
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
+struct pathspec {
+	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
+	int nr;
+	struct pathspec_item {
+		const char *match;
+		int len;
+	} *items;
+};
+
+extern int init_pathspec(struct pathspec *, const char **);
+extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const char **pa=
thspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int =
write_object, enum object_type type, const char *path);
 extern int index_path(unsigned char *sha1, const char *path, struct st=
at *st, int write_object);
diff --git a/dir.c b/dir.c
index 133f472..a88f2ef 100644
--- a/dir.c
+++ b/dir.c
@@ -1071,3 +1071,34 @@ int remove_path(const char *name)
 	return 0;
 }
=20
+int init_pathspec(struct pathspec *pathspec, const char **paths)
+{
+	const char **p =3D paths;
+	int i;
+
+	memset(pathspec, 0, sizeof(*pathspec));
+	if (!p)
+		return 0;
+	while (*p)
+		p++;
+	pathspec->raw =3D paths;
+	pathspec->nr =3D p - paths;
+	if (!pathspec->nr)
+		return 0;
+
+	pathspec->items =3D xmalloc(sizeof(struct pathspec_item)*pathspec->nr=
);
+	for (i =3D 0; i < pathspec->nr; i++) {
+		struct pathspec_item *item =3D pathspec->items+i;
+		const char *path =3D paths[i];
+
+		item->match =3D path;
+		item->len =3D strlen(path);
+	}
+	return 0;
+}
+
+void free_pathspec(struct pathspec *pathspec)
+{
+	free(pathspec->items);
+	pathspec->items =3D NULL;
+}
--=20
1.7.3.3.476.g10a82
