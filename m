From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] grep: stop looking at random places for .gitattributes
Date: Fri, 12 Oct 2012 17:49:38 +0700
Message-ID: <1350038978-26153-1-git-send-email-pclouds@gmail.com>
References: <1349877544-17648-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 12:50:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMcog-0005yP-2K
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 12:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325Ab2JLKty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2012 06:49:54 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:51175 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab2JLKtx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 06:49:53 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1274038dak.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dN/qknTuxUOM1Cgs6jYhzpnHwwUd8SXnUTqRgaR9tkw=;
        b=qjAm2vaNWF7JNxq2/ky6pmZubZ3E8QBceI7Cmpjni8EDEvaiOxkGjLTtI++/pNdT+C
         KCeY13QwNZOB4EQnWthiFWO3C3I3WsmDIIh4Fh5EGpIilr23Qp4En7ClS1Ld61K7dl/7
         A7jX0cYtPLG1GafzyplAaS3hKm/EGyO93inR6IwyvQP4f/+skf+T2XM4qWzP9KXn/94n
         t1Km39h5MpIAFsgD42DFqW9C3Gutt1ojFQva15sb0nmxbTlsaXxrbSwPmlGCwooI/eQ6
         7WisGG8W935Ax0MssYG67/BcfEuV/IgOjzTV3+gtk+sttfoIyZUuRpYg9iKXzeMc+urj
         hweQ==
Received: by 10.68.248.74 with SMTP id yk10mr8111811pbc.86.1350038992852;
        Fri, 12 Oct 2012 03:49:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id iq3sm4284955pbc.5.2012.10.12.03.49.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Oct 2012 03:49:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 12 Oct 2012 17:49:39 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349877544-17648-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207542>

grep searches for .gitattributes using "name" field in struct
grep_source but that field is not real on-disk path name. For example,
"grep pattern rev" fills the field with "rev:path", and Git looks for
=2Egitattributes in the (non-existent but exploitable) path "rev:path"
instead of "path".

This patch passes real paths down to grep_source_load_driver() when:

 - grep on work tree
 - grep on the index
 - grep a commit (or a tag if it points to a commit)

so that these cases look up .gitattributes at proper paths.
=2Egitattributes lookup is disabled in all other cases.

Initial-work-by: Jeff King <peff@peff.net>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This fixes t7008 as Johannes commented and makes "git grep foo HEAD:t"
 not look up worktree's .gitattributes (in fact it does not look up
 anywhere).

 The quote_path_relative() patch is not required, it's an independent
 design issue.

 builtin/grep.c         | 31 ++++++++++++++++++-------------
 grep.c                 | 11 ++++++++---
 grep.h                 |  4 +++-
 t/t7008-grep-binary.sh | 22 ++++++++++++++++++++++
 4 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 82530a6..38a17eb 100644
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
@@ -497,7 +498,8 @@ static int grep_cache(struct grep_opt *opt, const s=
truct pathspec *pathspec, int
 }
=20
 static int grep_tree(struct grep_opt *opt, const struct pathspec *path=
spec,
-		     struct tree_desc *tree, struct strbuf *base, int tn_len)
+		     struct tree_desc *tree, struct strbuf *base, int tn_len,
+		     int check_attr)
 {
 	int hit =3D 0;
 	enum interesting match =3D entry_not_interesting;
@@ -518,7 +520,8 @@ static int grep_tree(struct grep_opt *opt, const st=
ruct pathspec *pathspec,
 		strbuf_add(base, entry.path, te_len);
=20
 		if (S_ISREG(entry.mode)) {
-			hit |=3D grep_sha1(opt, entry.sha1, base->buf, tn_len);
+			hit |=3D grep_sha1(opt, entry.sha1, base->buf, tn_len,
+					 check_attr ? base->buf + tn_len : NULL);
 		}
 		else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
@@ -533,7 +536,8 @@ static int grep_tree(struct grep_opt *opt, const st=
ruct pathspec *pathspec,
=20
 			strbuf_addch(base, '/');
 			init_tree_desc(&sub, data, size);
-			hit |=3D grep_tree(opt, pathspec, &sub, base, tn_len);
+			hit |=3D grep_tree(opt, pathspec, &sub, base, tn_len,
+					 check_attr);
 			free(data);
 		}
 		strbuf_setlen(base, old_baselen);
@@ -548,7 +552,7 @@ static int grep_object(struct grep_opt *opt, const =
struct pathspec *pathspec,
 		       struct object *obj, const char *name)
 {
 	if (obj->type =3D=3D OBJ_BLOB)
-		return grep_sha1(opt, obj->sha1, name, 0);
+		return grep_sha1(opt, obj->sha1, name, 0, NULL);
 	if (obj->type =3D=3D OBJ_COMMIT || obj->type =3D=3D OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
@@ -571,7 +575,8 @@ static int grep_object(struct grep_opt *opt, const =
struct pathspec *pathspec,
 			strbuf_addch(&base, ':');
 		}
 		init_tree_desc(&tree, data, size);
-		hit =3D grep_tree(opt, pathspec, &tree, &base, base.len);
+		hit =3D grep_tree(opt, pathspec, &tree, &base, base.len,
+				obj->type =3D=3D OBJ_COMMIT);
 		strbuf_release(&base);
 		free(data);
 		return hit;
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
index fd6410f..26f8319 100755
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
+	test_when_finished "git rm --cached .gitattributes" &&
+	test_when_finished "git checkout .gitattributes" &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep revision respects binary diff attribute' '
+	git commit -m new &&
+	echo "Binary file HEAD:t matches" >expect &&
+	git grep text HEAD -- t >actual &&
+	test_when_finished "git reset HEAD^" &&
+	test_cmp expect actual
+'
+
 test_expect_success 'grep respects not-binary diff attribute' '
 	echo binQary | q_to_nul >b &&
 	git add b &&
--=20
1.7.12.1.406.g6ab07c4
