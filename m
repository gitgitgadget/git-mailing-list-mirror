From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] archive: support filtering paths with glob
Date: Sun, 21 Sep 2014 10:55:06 +0700
Message-ID: <1411271706-1151-1-git-send-email-pclouds@gmail.com>
References: <1433062.XhRCATRB3s@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peter@lekensteyn.nl,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 05:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVYF6-0002JZ-DD
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 05:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbaIUDzO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2014 23:55:14 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41730 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbaIUDzN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 23:55:13 -0400
Received: by mail-pd0-f172.google.com with SMTP id y10so2346979pdj.31
        for <git@vger.kernel.org>; Sat, 20 Sep 2014 20:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9bpOnkc2GwrL8I2i4AZQanzKTkIHGjG0lmB7BYog7kg=;
        b=zWvzMAhDQba14p5kEWaOFl258qqZor7JPn1PoiVuzVaOOJytRp40CSQBhnzLkZpw5h
         eWX7r0WNVI+6i8ISDBTtXJb8kHsOJfU4tIv9EhIlmyOGNMf+3kq+7QTBO/GcqAa7waKQ
         I+iTvvmJ4KKXCXg0w7if/z8Tc1pRfmQ2zG0ubeusdLlpny3FCKafkTcQsbV6EHcD8BXp
         S8TiVaafm5ykeLLNvjZoc4TI8MX5zKwsxzqPKTiodxWEakIltFYVECZe9I70a1IBIgdA
         IWDeGUHly17HBXD5FhnLtRhFfe+PI+zJhmL4fSqVbvaPJpSuwO62bWZxwf4BdJW07ujw
         mbpg==
X-Received: by 10.68.161.197 with SMTP id xu5mr45623pbb.160.1411271712465;
        Sat, 20 Sep 2014 20:55:12 -0700 (PDT)
Received: from lanh ([115.73.239.77])
        by mx.google.com with ESMTPSA id pd7sm5770787pac.33.2014.09.20.20.55.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Sep 2014 20:55:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 21 Sep 2014 10:55:08 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1433062.XhRCATRB3s@al>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257339>

This patch fixes two problems with using :(glob) (or even "*.c"
without ":(glob)").

The first one is we forgot to turn on the 'recursive' flag in struct
pathspec. Without that, tree_entry_interesting() will not mark
potential directories "interesting" so that it can confirm whether
those directories have anything matching the pathspec.

The marking directories interesting has a side effect that we need to
walk inside a directory to realize that there's nothing interested in
there. By that time, 'archive' code has already written the (empty)
directory down. That means lots of empty directories in the result
archive.

This problem is fixed by lazily writing directories down when we know
they are actually needed. There is a theoretical bug in this
implementation: we can't write empty trees/directories that match that
pathspec.

path_exists() is also made stricter in order to detect non-matching
pathspec because when this 'recursive' flag is on, we most likely
match some directories. The easiest way is not consider any
directories "matched".

Noticed-by: Peter Wu <peter@lekensteyn.nl>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Sat, Sep 13, 2014 at 5:52 PM, Peter Wu <peter@lekensteyn.nl> wrote:
 > By the
 > way, the glob pattern is treated as a 'nullglob'. If you specify a g=
lob pattern
 > that matches nothing, an empty archive is created. Perhaps an error =
message
 > should be raised for that as it is unlikely that a user wants that?

 If you do "git archive HEAD non-existent-path", you get an error.
 There's no reason why glob is an exception. Fixed in this version.

 archive.c           | 97 +++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 t/t5000-tar-tree.sh | 14 ++++++++
 2 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/archive.c b/archive.c
index 952a659..94a9981 100644
--- a/archive.c
+++ b/archive.c
@@ -5,6 +5,7 @@
 #include "archive.h"
 #include "parse-options.h"
 #include "unpack-trees.h"
+#include "dir.h"
=20
 static char const * const archive_usage[] =3D {
 	N_("git archive [options] <tree-ish> [<path>...]"),
@@ -98,9 +99,19 @@ static void setup_archive_check(struct git_attr_chec=
k *check)
 	check[1].attr =3D attr_export_subst;
 }
=20
+struct directory {
+	struct directory *up;
+	unsigned char sha1[20];
+	int baselen, len;
+	unsigned mode;
+	int stage;
+	char path[FLEX_ARRAY];
+};
+
 struct archiver_context {
 	struct archiver_args *args;
 	write_archive_entry_fn_t write_entry;
+	struct directory *bottom;
 };
=20
 static int write_archive_entry(const unsigned char *sha1, const char *=
base,
@@ -146,6 +157,65 @@ static int write_archive_entry(const unsigned char=
 *sha1, const char *base,
 	return write_entry(args, sha1, path.buf, path.len, mode);
 }
=20
+static void queue_directory(const unsigned char *sha1,
+		const char *base, int baselen, const char *filename,
+		unsigned mode, int stage, struct archiver_context *c)
+{
+	struct directory *d;
+	d =3D xmallocz(sizeof(*d) + baselen + 1 + strlen(filename));
+	d->up	   =3D c->bottom;
+	d->baselen =3D baselen;
+	d->mode	   =3D mode;
+	d->stage   =3D stage;
+	c->bottom  =3D d;
+	d->len =3D sprintf(d->path, "%.*s%s/", baselen, base, filename);
+	hashcpy(d->sha1, sha1);
+}
+
+static int write_directory(struct archiver_context *c)
+{
+	struct directory *d =3D c->bottom;
+	int ret;
+
+	if (!d)
+		return 0;
+	c->bottom =3D d->up;
+	d->path[d->len - 1] =3D '\0'; /* no trailing slash */
+	ret =3D
+		write_directory(c) ||
+		write_archive_entry(d->sha1, d->path, d->baselen,
+				    d->path + d->baselen, d->mode,
+				    d->stage, c) !=3D READ_TREE_RECURSIVE;
+	free(d);
+	return ret ? -1 : 0;
+}
+
+static int queue_or_write_archive_entry(const unsigned char *sha1,
+		const char *base, int baselen, const char *filename,
+		unsigned mode, int stage, void *context)
+{
+	struct archiver_context *c =3D context;
+
+	while (c->bottom &&
+	       !(baselen >=3D c->bottom->len &&
+		 !strncmp(base, c->bottom->path, c->bottom->len))) {
+		struct directory *next =3D c->bottom->up;
+		free(c->bottom);
+		c->bottom =3D next;
+	}
+
+	if (S_ISDIR(mode)) {
+		queue_directory(sha1, base, baselen, filename,
+				mode, stage, c);
+		return READ_TREE_RECURSIVE;
+	}
+
+	if (write_directory(c))
+		return -1;
+	return write_archive_entry(sha1, base, baselen, filename, mode,
+				   stage, context);
+}
+
 int write_archive_entries(struct archiver_args *args,
 		write_archive_entry_fn_t write_entry)
 {
@@ -167,6 +237,7 @@ int write_archive_entries(struct archiver_args *arg=
s,
 			return err;
 	}
=20
+	memset(&context, 0, sizeof(context));
 	context.args =3D args;
 	context.write_entry =3D write_entry;
=20
@@ -187,9 +258,17 @@ int write_archive_entries(struct archiver_args *ar=
gs,
 	}
=20
 	err =3D read_tree_recursive(args->tree, "", 0, 0, &args->pathspec,
-				  write_archive_entry, &context);
+				  args->pathspec.has_wildcard ?
+				  queue_or_write_archive_entry :
+				  write_archive_entry,
+				  &context);
 	if (err =3D=3D READ_TREE_RECURSIVE)
 		err =3D 0;
+	while (context.bottom) {
+		struct directory *next =3D context.bottom->up;
+		free(context.bottom);
+		context.bottom =3D next;
+	}
 	return err;
 }
=20
@@ -211,7 +290,16 @@ static int reject_entry(const unsigned char *sha1,=
 const char *base,
 			int baselen, const char *filename, unsigned mode,
 			int stage, void *context)
 {
-	return -1;
+	int ret =3D -1;
+	if (S_ISDIR(mode)) {
+		struct strbuf sb =3D STRBUF_INIT;
+		strbuf_addstr(&sb, base);
+		strbuf_addstr(&sb, filename);
+		if (!match_pathspec(context, sb.buf, sb.len, 0, NULL, 1))
+			ret =3D READ_TREE_RECURSIVE;
+		strbuf_release(&sb);
+	}
+	return ret;
 }
=20
 static int path_exists(struct tree *tree, const char *path)
@@ -221,7 +309,9 @@ static int path_exists(struct tree *tree, const cha=
r *path)
 	int ret;
=20
 	parse_pathspec(&pathspec, 0, 0, "", paths);
-	ret =3D read_tree_recursive(tree, "", 0, 0, &pathspec, reject_entry, =
NULL);
+	pathspec.recursive =3D 1;
+	ret =3D read_tree_recursive(tree, "", 0, 0, &pathspec,
+				  reject_entry, &pathspec);
 	free_pathspec(&pathspec);
 	return ret !=3D 0;
 }
@@ -237,6 +327,7 @@ static void parse_pathspec_arg(const char **pathspe=
c,
 	parse_pathspec(&ar_args->pathspec, 0,
 		       PATHSPEC_PREFER_FULL,
 		       "", pathspec);
+	ar_args->pathspec.recursive =3D 1;
 	if (pathspec) {
 		while (*pathspec) {
 			if (**pathspec && !path_exists(ar_args->tree, *pathspec))
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7b8babd..d01bbdc 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -305,4 +305,18 @@ test_expect_success GZIP 'remote tar.gz can be dis=
abled' '
 		>remote.tar.gz
 '
=20
+test_expect_success 'archive and :(glob)' '
+	git archive -v HEAD -- ":(glob)**/sh" >/dev/null 2>actual &&
+	cat >expect <<EOF &&
+a/
+a/bin/
+a/bin/sh
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'catch non-matching pathspec' '
+	test_must_fail git archive -v HEAD -- "*.abc" >/dev/null
+'
+
 test_done
--=20
2.1.0.rc0.78.gc0d8480
