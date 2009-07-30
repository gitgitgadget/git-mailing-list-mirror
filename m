From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Adding files to a git-archive when it is generated, and whats
 the    best way to find out what branch a commit is on?
Date: Thu, 30 Jul 2009 22:33:23 +0200
Message-ID: <4A720393.6030607@lsrfire.ath.cx>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>	 <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com> <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 22:34:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWcKA-0001Cy-PE
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 22:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbZG3Udb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jul 2009 16:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbZG3Udb
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 16:33:31 -0400
Received: from india601.server4you.de ([85.25.151.105]:41872 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZG3Uda (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 16:33:30 -0400
Received: from [10.0.1.101] (p57B7D9E4.dip.t-dialin.net [87.183.217.228])
	by india601.server4you.de (Postfix) with ESMTPSA id 08B662F806F;
	Thu, 30 Jul 2009 22:33:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124482>

demerphq schrieb:
> So then git also would benefit from support in git-archive for adding
> arbitrary files to the archive during generation?

Yes, and this has come up before.

How about the following?  It's missing documentation and a test case,
but you could try

	$ git archive --add-file extra HEAD >HEAD+extra.tar

or

	$ git archive --prefix=3Da/ --add-file extra --prefix=3Db/ HEAD >ba.ta=
r

Only the file name part (after the last slash) of the extra file is use=
d,
together with the prefix, to form the path of the archive entry.

Opening the extra files when parsing the command line arguments and clo=
sing
them after they have been written into the archive is a bit iffy, but i=
t's
impractical to report open errors after parts of the archive have alrea=
dy
been created.

Ren=E9

---
 archive.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-----
 archive.h |    3 ++
 2 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/archive.c b/archive.c
index 0bca9ca..368e7e8 100644
--- a/archive.c
+++ b/archive.c
@@ -25,6 +25,12 @@ static const struct archiver {
 	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
 };
=20
+struct extra_file {
+	char *path;
+	int fd;
+	struct extra_file *next;
+};
+
 static void format_subst(const struct commit *commit,
                          const char *src, size_t len,
                          struct strbuf *buf)
@@ -147,12 +153,29 @@ static int write_archive_entry(const unsigned cha=
r *sha1, const char *base,
 	return err;
 }
=20
+static int write_extra_file(struct extra_file *extra_file,
+			    struct archiver_args *args,
+			    write_archive_entry_fn_t write_entry)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	int err;
+
+	if (strbuf_read(&buf, extra_file->fd, 0) < 0)
+		return error("cannot read extra file: %s", extra_file->path);
+	close(extra_file->fd);
+	err =3D write_entry(args, null_sha1, extra_file->path,
+			  strlen(extra_file->path), 0100644, buf.buf, buf.len);
+	strbuf_release(&buf);
+	return err;
+}
+
 int write_archive_entries(struct archiver_args *args,
 		write_archive_entry_fn_t write_entry)
 {
 	struct archiver_context context;
 	struct unpack_trees_options opts;
 	struct tree_desc t;
+	struct extra_file *extra_file =3D args->extra_files;
 	int err;
=20
 	if (args->baselen > 0 && args->base[args->baselen - 1] =3D=3D '/') {
@@ -191,6 +214,12 @@ int write_archive_entries(struct archiver_args *ar=
gs,
 			args->pathspec, write_archive_entry, &context);
 	if (err =3D=3D READ_TREE_RECURSIVE)
 		err =3D 0;
+
+	while (!err && extra_file) {
+		err =3D write_extra_file(extra_file, args, write_entry);
+		extra_file =3D extra_file->next;
+	}
+
 	return err;
 }
=20
@@ -265,11 +294,41 @@ static void parse_treeish_arg(const char **argv,
 	{ OPTION_SET_INT, (s), NULL, (v), NULL, "", \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p) }
=20
+static int extra_files_cb(const struct option *opt, const char *arg, i=
nt unset)
+{
+	struct archiver_args *args =3D opt->value;
+	struct extra_file *e =3D xmalloc(sizeof(struct extra_file));
+	struct strbuf path =3D STRBUF_INIT;
+	const char *last_slash, *prefix =3D args->base;
+
+	e->fd =3D open(arg, O_RDONLY);
+	if (e->fd =3D=3D -1)
+		die_errno("Could not open file '%s'", arg);
+
+	if (prefix)
+		strbuf_addstr(&path, prefix);
+	last_slash =3D strrchr(arg, '/');
+	strbuf_addstr(&path, last_slash ? last_slash + 1 : arg);
+	e->path =3D strbuf_detach(&path, NULL);
+
+	e->next =3D NULL;
+
+	if (args->extra_files) {
+		struct extra_file *prev =3D args->extra_files;
+		while (prev->next)
+			prev =3D prev->next;
+		prev->next =3D e;
+	} else {
+		args->extra_files =3D e;
+	}
+
+	return 0;
+}
+
 static int parse_archive_args(int argc, const char **argv,
 		const struct archiver **ar, struct archiver_args *args)
 {
 	const char *format =3D "tar";
-	const char *base =3D NULL;
 	const char *remote =3D NULL;
 	const char *exec =3D NULL;
 	const char *output =3D NULL;
@@ -281,10 +340,13 @@ static int parse_archive_args(int argc, const cha=
r **argv,
 	struct option opts[] =3D {
 		OPT_GROUP(""),
 		OPT_STRING(0, "format", &format, "fmt", "archive format"),
-		OPT_STRING(0, "prefix", &base, "prefix",
+		OPT_STRING(0, "prefix", &args->base, "prefix",
 			"prepend prefix to each pathname in the archive"),
 		OPT_STRING(0, "output", &output, "file",
 			"write the archive to this file"),
+		{ OPTION_CALLBACK, 0, "add-file", args, "file",
+			"add file to the archive, using prefix as path",
+			PARSE_OPT_NONEG, extra_files_cb },
 		OPT_BOOLEAN(0, "worktree-attributes", &worktree_attributes,
 			"read .gitattributes in working directory"),
 		OPT__VERBOSE(&verbose),
@@ -318,8 +380,8 @@ static int parse_archive_args(int argc, const char =
**argv,
 	if (output)
 		die("Unexpected option --output");
=20
-	if (!base)
-		base =3D "";
+	if (!args->base)
+		args->base =3D "";
=20
 	if (list) {
 		for (i =3D 0; i < ARRAY_SIZE(archivers); i++)
@@ -344,8 +406,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 		}
 	}
 	args->verbose =3D verbose;
-	args->base =3D base;
-	args->baselen =3D strlen(base);
+	args->baselen =3D strlen(args->base);
 	args->worktree_attributes =3D worktree_attributes;
=20
 	return argc;
@@ -357,6 +418,7 @@ int write_archive(int argc, const char **argv, cons=
t char *prefix,
 	const struct archiver *ar =3D NULL;
 	struct archiver_args args;
=20
+	memset(&args, 0, sizeof(struct archiver_args));
 	argc =3D parse_archive_args(argc, argv, &ar, &args);
 	if (setup_prefix && prefix =3D=3D NULL)
 		prefix =3D setup_git_directory();
diff --git a/archive.h b/archive.h
index 038ac35..a88bdbb 100644
--- a/archive.h
+++ b/archive.h
@@ -1,6 +1,8 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
=20
+struct extra_file;
+
 struct archiver_args {
 	const char *base;
 	size_t baselen;
@@ -11,6 +13,7 @@ struct archiver_args {
 	const char **pathspec;
 	unsigned int verbose : 1;
 	unsigned int worktree_attributes : 1;
+	struct extra_file *extra_files;
 	int compression_level;
 };
=20
