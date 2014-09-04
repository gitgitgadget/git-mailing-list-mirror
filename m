From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] archive: support filtering paths with glob
Date: Thu,  4 Sep 2014 20:37:52 +0700
Message-ID: <1409837872-20837-1-git-send-email-pclouds@gmail.com>
References: <7752133.8a4hJ4krff@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peter@lekensteyn.nl,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 15:38:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPXEd-0005eq-8h
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 15:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbaIDNhz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2014 09:37:55 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35004 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaIDNhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 09:37:54 -0400
Received: by mail-pa0-f47.google.com with SMTP id hz1so19930591pad.20
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7qtDWKvKg26sLPalHGCWLklb6MiHuVm1SN2woKCmaH8=;
        b=la4l1Nddau3ryB0zi3fvGjz4oOugnRV2TpHhliBxhgONLC+hscQYs7VCBIw4xOXhR9
         X9ycN3427Aobb80mCMwUiDVvehBKE0LEJte6tWphkp8sRNLrNvoI0GRzSxHLlK2DW5G2
         aUJdnr8JKj1yvFt/GujREjjgAz36JmsL7sDkyii22m8ZFHwIy61JDIaD0j6lNEyD8R5g
         YbJgp1i2hWHV1L1KQ1mIvIqdMTXD9DNrvJTqP0lAbKl1Db7QyiB28mkONBlnawoRbJom
         CwSc6ol/0mLtBQhpS5fPqnl5iweAixDpKeMp3jC7SHX/sd9LLvr8QjruoOaCLOniScmK
         UCPg==
X-Received: by 10.70.46.100 with SMTP id u4mr8838281pdm.29.1409837871472;
        Thu, 04 Sep 2014 06:37:51 -0700 (PDT)
Received: from lanh ([115.73.224.164])
        by mx.google.com with ESMTPSA id ja3sm1730069pbd.73.2014.09.04.06.37.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Sep 2014 06:37:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Sep 2014 20:38:02 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <7752133.8a4hJ4krff@al>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256441>

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

Noticed-by: Peter Wu <peter@lekensteyn.nl>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Similar approach could probably be used for teaching ls-tree about pat=
hspec..

 archive.c           | 82 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 t/t5000-tar-tree.sh | 10 +++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 3fc0fb2..9e62bf4 100644
--- a/archive.c
+++ b/archive.c
@@ -98,9 +98,19 @@ static void setup_archive_check(struct git_attr_chec=
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
@@ -146,6 +156,65 @@ static int write_archive_entry(const unsigned char=
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
@@ -167,6 +236,7 @@ int write_archive_entries(struct archiver_args *arg=
s,
 			return err;
 	}
=20
+	memset(&context, 0, sizeof(context));
 	context.args =3D args;
 	context.write_entry =3D write_entry;
=20
@@ -187,9 +257,17 @@ int write_archive_entries(struct archiver_args *ar=
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
@@ -221,6 +299,7 @@ static int path_exists(struct tree *tree, const cha=
r *path)
 	int ret;
=20
 	parse_pathspec(&pathspec, 0, 0, "", paths);
+	pathspec.recursive =3D 1;
 	ret =3D read_tree_recursive(tree, "", 0, 0, &pathspec, reject_entry, =
NULL);
 	free_pathspec(&pathspec);
 	return ret !=3D 0;
@@ -237,6 +316,7 @@ static void parse_pathspec_arg(const char **pathspe=
c,
 	parse_pathspec(&ar_args->pathspec, 0,
 		       PATHSPEC_PREFER_FULL,
 		       "", pathspec);
+	ar_args->pathspec.recursive =3D 1;
 	if (pathspec) {
 		while (*pathspec) {
 			if (**pathspec && !path_exists(ar_args->tree, *pathspec))
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7b8babd..ade7a7f 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -305,4 +305,14 @@ test_expect_success GZIP 'remote tar.gz can be dis=
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
 test_done
--=20
2.1.0.rc0.78.gc0d8480
