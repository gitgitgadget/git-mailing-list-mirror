From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] grep: stop looking at random places for .gitattributes
Date: Wed, 10 Oct 2012 20:59:04 +0700
Message-ID: <1349877544-17648-3-git-send-email-pclouds@gmail.com>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349877544-17648-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 15:59:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLwpE-0007nH-Ok
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 15:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579Ab2JJN7l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 09:59:41 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40780 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435Ab2JJN7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 09:59:39 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so624082pad.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0Qg9JYOnsR5u6bane3zjTE3abHJQ0FIDoEmJYLuqi+4=;
        b=LI0aH8qVs5Wkk9JkfcV1RvU4T0HZNcNPDttQ7DEusMVUcgo/HxbT8NNT5VpIErzbYn
         xT9Kg8Q3buzpVFTt500+CQjczL9l4oN9CdIMNNtIJl+n+CO1+I3rQoKia8gQ0imErGbv
         Fq7sIgv2hDLcpN2GzEvZYOJg5SXeg3U9DfWNX42M6UlSZcC1ZcNwuhKxlT1Lt7KSxb58
         kS+GzjuseLkgtvKnYTrU6D2jExq9oFVCOGw2FQBcbEy07rjKM9TLjn+1b3ksmd3Q9yNj
         9vgjY3aSrRSE362lwpA/U5Uk88gPe8OVf4vi+UG+oLdCvxAoAPTBUmzv6ZfpsSV+T1Vd
         rybQ==
Received: by 10.66.81.199 with SMTP id c7mr62567296pay.19.1349877575690;
        Wed, 10 Oct 2012 06:59:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id pj10sm1069657pbb.46.2012.10.10.06.59.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 06:59:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 20:59:26 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349877544-17648-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207413>

grep searches for .gitattributes using "name" field in struct
grep_source but that field is not real on-disk path name. For example,
"grep pattern rev" fills the field with "rev:path", which is
non-existent usually until somebody exploits it to drive git away.

This patch passes real paths down to grep_source_load_driver(). Except
grepping a blob, all other cases should have right paths down to
grep_source_load_driver(). In other words, .gitattributes are still
respected.

Initial-work-by: Jeff King <peff@peff.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c         | 22 ++++++++++++----------
 grep.c                 | 11 ++++++++---
 grep.h                 |  4 +++-
 t/t7008-grep-binary.sh | 22 ++++++++++++++++++++++
 4 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 377c904..f6c5ba2 100644
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
@@ -371,7 +371,8 @@ static void *lock_and_read_sha1_file(const unsigned=
 char *sha1, enum object_type
 }
=20
 static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
-		     const char *filename, int tree_name_len)
+		     const char *filename, int tree_name_len,
+		     const char *path)
 {
 	struct strbuf pathbuf =3D STRBUF_INIT;
=20
@@ -385,7 +386,7 @@ static int grep_sha1(struct grep_opt *opt, const un=
signed char *sha1,
=20
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, sha1);
+		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
 		strbuf_release(&pathbuf);
 		return 0;
 	} else
@@ -394,7 +395,7 @@ static int grep_sha1(struct grep_opt *opt, const un=
signed char *sha1,
 		struct grep_source gs;
 		int hit;
=20
-		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, sha1);
+		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
 		strbuf_release(&pathbuf);
 		hit =3D grep_source(opt, &gs);
=20
@@ -414,7 +415,7 @@ static int grep_file(struct grep_opt *opt, const ch=
ar *filename)
=20
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename);
+		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename, filename);
 		strbuf_release(&buf);
 		return 0;
 	} else
@@ -423,7 +424,7 @@ static int grep_file(struct grep_opt *opt, const ch=
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
@@ -479,7 +480,7 @@ static int grep_cache(struct grep_opt *opt, const s=
truct pathspec *pathspec, int
 		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
 			if (ce_stage(ce))
 				continue;
-			hit |=3D grep_sha1(opt, ce->sha1, ce->name, 0);
+			hit |=3D grep_sha1(opt, ce->sha1, ce->name, 0, ce->name);
 		}
 		else
 			hit |=3D grep_file(opt, ce->name);
@@ -518,7 +519,8 @@ static int grep_tree(struct grep_opt *opt, const st=
ruct pathspec *pathspec,
 		strbuf_add(base, entry.path, te_len);
=20
 		if (S_ISREG(entry.mode)) {
-			hit |=3D grep_sha1(opt, entry.sha1, base->buf, tn_len);
+			hit |=3D grep_sha1(opt, entry.sha1, base->buf, tn_len,
+					 base->buf + tn_len);
 		}
 		else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
@@ -548,7 +550,7 @@ static int grep_object(struct grep_opt *opt, const =
struct pathspec *pathspec,
 		       struct object *obj, const char *name)
 {
 	if (obj->type =3D=3D OBJ_BLOB)
-		return grep_sha1(opt, obj->sha1, name, 0);
+		return grep_sha1(opt, obj->sha1, name, 0, NULL);
 	if (obj->type =3D=3D OBJ_COMMIT || obj->type =3D=3D OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
diff --git a/grep.c b/grep.c
index edc7776..e36c01b 100644
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
@@ -1501,7 +1505,8 @@ void grep_source_load_driver(struct grep_source *=
gs)
 		return;
=20
 	grep_attr_lock();
-	gs->driver =3D userdiff_find_by_path(gs->name);
+	if (gs->path)
+		gs->driver =3D userdiff_find_by_path(gs->path);
 	if (!gs->driver)
 		gs->driver =3D userdiff_find_by_name("default");
 	grep_attr_unlock();
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
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index fd6410f..2c85a30 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -111,6 +111,28 @@ test_expect_success 'grep respects binary diff att=
ribute' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'grep --cached respects binary diff attribute' '
+	git grep --cached text t >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --cached respects binary diff attribute (2)'=
 '
+	git add .gitattributes &&
+	rm .gitattributes &&
+	git grep --cached text t >actual &&
+	test_cmp expect actual &&
+	git checkout .gitattributes &&
+	git rm --cached .gitattributes
+'
+
+test_expect_success 'grep tree respects binary diff attribute' '
+	git commit -m new &&
+	echo "Binary file HEAD:t matches" >expect &&
+	git grep text HEAD -- t >actual &&
+	test_cmp expect actual &&
+	git reset HEAD^
+'
+
 test_expect_success 'grep respects not-binary diff attribute' '
 	echo binQary | q_to_nul >b &&
 	git add b &&
--=20
1.7.12.1.406.g6ab07c4
