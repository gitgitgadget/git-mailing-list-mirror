From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] grep: pass true path name to grep machinery
Date: Wed, 10 Oct 2012 18:34:53 +0700
Message-ID: <1349868894-3579-3-git-send-email-pclouds@gmail.com>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org>
 <1349868894-3579-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 13:36:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLua1-0006HH-GL
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 13:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab2JJLfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 07:35:50 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:40573 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab2JJLft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 07:35:49 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so134109dak.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DD3VubPRbwKEU9h+FBJHkym3Jv+AQ0n+7Bm73qbXYD8=;
        b=mDcm9Tw6gBl1Uu7bge3taswl3RD+6XX3VZvUru6C4Q6bIGGSfgB3Ubi191Be10kWhM
         7+sR6jsISasvOZcahHkPnnmPxd/o/IT3a+mmciJvDr91GFi/mq8XVNPqRHJ8C1afAp3k
         UxMVvnhi1q9Kk5Leit1qcoZEt2CDFyjKv+iyhVgMzKmjOkFuRDt81MEjW4p/izesNVp5
         R50zT6sNx6jI2w85Bm/wSegXWoVkBW94e0jqFT6QcT4vJ0rCi71yFFfasGFoEpfUpN35
         Jef1tVQtwwpuuFIsRjN65bHV8ySx0g7BAovp9sigG+c80OCGVJ4np9//CiHR4PabgWQF
         fcVA==
Received: by 10.68.252.133 with SMTP id zs5mr12659058pbc.152.1349868949312;
        Wed, 10 Oct 2012 04:35:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id wo9sm904784pbc.53.2012.10.10.04.35.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 04:35:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 18:35:37 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207402>

=46rom: Jeff King <peff@peff.net>

Having path name (if available) may be useful. For example, if grep
machinery needs to look up git attributes, it'll need a good path
name. grep_source->name is not good because it's for display purpose
only.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c | 17 +++++++++++------
 grep.c         |  8 ++++++--
 grep.h         |  4 +++-
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 377c904..0211e35 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -86,7 +86,7 @@ static pthread_cond_t cond_result;
 static int skip_first_line;
=20
 static void add_work(struct grep_opt *opt, enum grep_source_type type,
-		     const char *name, const void *id)
+		     const char *name, const char *path, const void *id)
 {
 	grep_lock();
=20
@@ -94,7 +94,7 @@ static void add_work(struct grep_opt *opt, enum grep_=
source_type type,
 		pthread_cond_wait(&cond_write, &grep_mutex);
 	}
=20
-	grep_source_init(&todo[todo_end].source, type, name, id);
+	grep_source_init(&todo[todo_end].source, type, name, path, id);
 	if (opt->binary !=3D GREP_BINARY_TEXT)
 		grep_source_load_driver(&todo[todo_end].source);
 	todo[todo_end].done =3D 0;
@@ -383,9 +383,14 @@ static int grep_sha1(struct grep_opt *opt, const u=
nsigned char *sha1,
 		strbuf_addstr(&pathbuf, filename);
 	}
=20
+	/* XXX We seem to get all kinds of junk via the filename field here,
+	 * including partial filenames, sha1:path, etc. We could parse it
+	 * ourselves, but that is probably insanity. We should ask the
+	 * caller to break it down more for us. For now, just pass NULL. */
+
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, sha1);
+		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, NULL, sha1);
 		strbuf_release(&pathbuf);
 		return 0;
 	} else
@@ -394,7 +399,7 @@ static int grep_sha1(struct grep_opt *opt, const un=
signed char *sha1,
 		struct grep_source gs;
 		int hit;
=20
-		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, sha1);
+		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, NULL, sha1);
 		strbuf_release(&pathbuf);
 		hit =3D grep_source(opt, &gs);
=20
@@ -414,7 +419,7 @@ static int grep_file(struct grep_opt *opt, const ch=
ar *filename)
=20
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename);
+		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename, filename);
 		strbuf_release(&buf);
 		return 0;
 	} else
@@ -423,7 +428,7 @@ static int grep_file(struct grep_opt *opt, const ch=
ar *filename)
 		struct grep_source gs;
 		int hit;
=20
-		grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename);
+		grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename)=
;
 		strbuf_release(&buf);
 		hit =3D grep_source(opt, &gs);
=20
diff --git a/grep.c b/grep.c
index edc7776..06bc1c6 100644
--- a/grep.c
+++ b/grep.c
@@ -1373,7 +1373,7 @@ int grep_buffer(struct grep_opt *opt, char *buf, =
unsigned long size)
 	struct grep_source gs;
 	int r;
=20
-	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL);
+	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
 	gs.buf =3D buf;
 	gs.size =3D size;
=20
@@ -1384,10 +1384,12 @@ int grep_buffer(struct grep_opt *opt, char *buf=
, unsigned long size)
 }
=20
 void grep_source_init(struct grep_source *gs, enum grep_source_type ty=
pe,
-		      const char *name, const void *identifier)
+		      const char *name, const char *path,
+		      const void *identifier)
 {
 	gs->type =3D type;
 	gs->name =3D name ? xstrdup(name) : NULL;
+	gs->path =3D path ? xstrdup(path) : NULL;
 	gs->buf =3D NULL;
 	gs->size =3D 0;
 	gs->driver =3D NULL;
@@ -1409,6 +1411,8 @@ void grep_source_clear(struct grep_source *gs)
 {
 	free(gs->name);
 	gs->name =3D NULL;
+	free(gs->path);
+	gs->path =3D NULL;
 	free(gs->identifier);
 	gs->identifier =3D NULL;
 	grep_source_clear_data(gs);
diff --git a/grep.h b/grep.h
index c256ac6..c2cf57b 100644
--- a/grep.h
+++ b/grep.h
@@ -158,11 +158,13 @@ struct grep_source {
 	char *buf;
 	unsigned long size;
=20
+	char *path; /* for attribute lookups */
 	struct userdiff_driver *driver;
 };
=20
 void grep_source_init(struct grep_source *gs, enum grep_source_type ty=
pe,
-		      const char *name, const void *identifier);
+		      const char *name, const char *path,
+		      const void *identifier);
 void grep_source_clear_data(struct grep_source *gs);
 void grep_source_clear(struct grep_source *gs);
 void grep_source_load_driver(struct grep_source *gs);
--=20
1.7.12.1.406.g6ab07c4
