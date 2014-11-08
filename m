From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 22/22] untracked cache: guard and disable on system changes
Date: Sat,  8 Nov 2014 16:39:55 +0700
Message-ID: <1415439595-469-23-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:41:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2Wj-0001xQ-6w
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbaKHJlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:41:44 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:54770 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712AbaKHJlm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:41:42 -0500
Received: by mail-pa0-f49.google.com with SMTP id lj1so5056289pab.36
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AHrMdJu925ZxIAV809D1cG3CK1iOfgfOI4mqIQGXpvo=;
        b=iIaD2yQ4zahkDtIZ21/m7E4SWdZJKRDjGnheAggd3gt/qjL5xF0XUB5jzFInC3++jr
         a2ii5EUgXtnpYwnVMPCDmq3fSjFCFVXtcLcNJEYjVBs5+pFft2/VQjXfycmqyZRlTUpJ
         CsO4lclDGiiwScw6NiJwEZjLq3lLTu59CO4SJnZJSGuMPltmTIDJk91nhnZgbIIQZK3Q
         2DDLRH4tpZJ6NapnSEl0REIgFGKZMOkHATIVy/8sYvn6WWOVoL92wAKmqTdwxxeiUsze
         cYjuDrjcdxwcyY2ovAYVvaHhmWS2xOAyhlMCXMMT6SOUbJZ22CTvtP7u+073IjmOnV1s
         HHCw==
X-Received: by 10.70.90.45 with SMTP id bt13mr18076322pdb.111.1415439701938;
        Sat, 08 Nov 2014 01:41:41 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id d15sm4292857pbu.34.2014.11.08.01.41.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:41:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:41:56 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user enables untracked cache, then

 - move worktree to an unsupported filesystem
 - or simply upgrade OS
 - or move the whole (portable) disk from one machine to another
 - or access a shared fs from another machine

there's no guarantee that untracked cache can still function properly.
Record the worktree location and OS footprint in the cache. If it
changes, err on the safe side and disable the cache. The user can
'update-index --untracked-cache' again to make sure all conditions are
met.

This change does not cover all bases, you can fool it if you try
hard. The point is to stop accidents.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c                       | 44 +++++++++++++++++++++++++++++++++++++=
++++---
 git-compat-util.h           |  1 +
 test-dump-untracked-cache.c |  1 +
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index a99bd63..2324c52 100644
--- a/dir.c
+++ b/dir.c
@@ -2227,10 +2227,22 @@ static void write_one_dir(struct strbuf *out, s=
truct untracked_cache_dir *untrac
 			write_one_dir(out, untracked->dirs[i]);
 }
=20
+static void get_ident_string(struct strbuf *sb)
+{
+	struct utsname uts;
+
+	if (uname(&uts))
+		die_errno(_("failed to get kernel name and information"));
+	strbuf_addf(sb, "Location %s, system %s %s %s", get_git_work_tree(),
+		    uts.sysname, uts.release, uts.version);
+}
+
 void write_untracked_extension(struct strbuf *out, struct untracked_ca=
che *untracked)
 {
 	struct ondisk_untracked_cache *ouc;
-	int len =3D 0;
+	struct strbuf sb =3D STRBUF_INIT;
+	unsigned char varbuf[16];
+	int len =3D 0, varint_len;
 	if (untracked->exclude_per_dir)
 		len =3D strlen(untracked->exclude_per_dir);
 	ouc =3D xmalloc(sizeof(*ouc) + len);
@@ -2240,6 +2252,13 @@ void write_untracked_extension(struct strbuf *ou=
t, struct untracked_cache *untra
 	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.sha1);
 	ouc->dir_flags =3D htonl(untracked->dir_flags);
 	memcpy(ouc->exclude_per_dir, untracked->exclude_per_dir, len + 1);
+
+	get_ident_string(&sb);
+	varint_len =3D encode_varint(sb.len + 1, varbuf);
+	strbuf_add(out, varbuf, varint_len);
+	strbuf_add(out, sb.buf, sb.len + 1);
+	strbuf_release(&sb);
+
 	strbuf_add(out, ouc, sizeof(*ouc) + len);
 	if (untracked->root)
 		write_one_dir(out, untracked->root);
@@ -2355,10 +2374,29 @@ static void load_sha1_stat(struct sha1_stat *sh=
a1_stat,
=20
 struct untracked_cache *read_untracked_extension(const void *data, uns=
igned long sz)
 {
-	const struct ondisk_untracked_cache *ouc =3D data;
+	const struct ondisk_untracked_cache *ouc;
 	struct untracked_cache *uc;
+	const unsigned char *next =3D data;
+	struct strbuf sb =3D STRBUF_INIT;
 	int len;
=20
+	len =3D decode_varint(&next);
+	if (sz <=3D (next - (const unsigned char *)data) + len ||
+	    next[len - 1] !=3D '\0')
+		return NULL;
+
+	get_ident_string(&sb);
+	if (strcmp(sb.buf, (const char *)next)) {
+		warning(_("system identification does not match, untracked cache dis=
abled.\n"
+			  "Stored: %s\nCurrent: %s\n"),
+			next, sb.buf);
+		strbuf_release(&sb);
+		return NULL;
+	}
+	strbuf_release(&sb);
+	ouc =3D (const struct ondisk_untracked_cache *)(next + len);
+	sz -=3D (const char *)ouc - (const char *)data;
+
 	if (sz < sizeof(*ouc))
 		return NULL;
=20
@@ -2373,7 +2411,7 @@ struct untracked_cache *read_untracked_extension(=
const void *data, unsigned long
 	if (sz =3D=3D len)
 		return uc;
 	if (sz > len &&
-	    read_one_dir(&uc->root, (const unsigned char *)data + len,
+	    read_one_dir(&uc->root, (const unsigned char *)ouc + len,
 			 sz - len) =3D=3D sz - len)
 		return uc;
 	free_untracked_cache(uc);
diff --git a/git-compat-util.h b/git-compat-util.h
index f587749..6b1f259 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -125,6 +125,7 @@
 #else
 #include <poll.h>
 #endif
+#include <sys/utsname.h>
=20
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
diff --git a/test-dump-untracked-cache.c b/test-dump-untracked-cache.c
index 710441e..25d855d 100644
--- a/test-dump-untracked-cache.c
+++ b/test-dump-untracked-cache.c
@@ -44,6 +44,7 @@ int main(int ac, char **av)
 {
 	struct untracked_cache *uc;
 	struct strbuf base =3D STRBUF_INIT;
+	setup_git_directory();
 	if (read_cache() < 0)
 		die("unable to read index file");
 	uc =3D the_index.untracked;
--=20
2.1.0.rc0.78.gc0d8480
