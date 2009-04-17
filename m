From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 4/5] archive: do not read .gitattributes in working directory
Date: Sat, 18 Apr 2009 00:18:05 +0200
Message-ID: <49E9001D.9020209@lsrfire.ath.cx>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:20:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuwQ4-0000iT-3B
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762212AbZDQWSN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2009 18:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762149AbZDQWSM
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:18:12 -0400
Received: from india601.server4you.de ([85.25.151.105]:46217 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762010AbZDQWSK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 18:18:10 -0400
Received: from [10.0.1.101] (p57B7DF1E.dip.t-dialin.net [87.183.223.30])
	by india601.server4you.de (Postfix) with ESMTPSA id 7D4AC2F8044;
	Sat, 18 Apr 2009 00:18:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116797>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The old behaviour still remains with --worktree-attributes, and it is
always on for the legacy "git tar-tree".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Changes:

   s/--fix-attributes/--worktree-attributes/g

   Don't make tar-tree silently ignore --worktree-attributes; its
   behaviour should not be changed any more.

 Documentation/git-archive.txt |    5 ++++-
 archive.c                     |   23 +++++++++++++++++++++++
 archive.h                     |    1 +
 builtin-tar-tree.c            |    9 ++++++++-
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index c1adf59..bc132c8 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git archive' --format=3D<fmt> [--list] [--prefix=3D<prefix>/] [<extra=
>]
-	      [--output=3D<file>]
+	      [--output=3D<file>] [--worktree-attributes]
 	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish>
 	      [path...]
=20
@@ -51,6 +51,9 @@ OPTIONS
 --output=3D<file>::
 	Write the archive to <file> instead of stdout.
=20
+--worktree-attributes::
+	Look for attributes in .gitattributes in working directory too.
+
 <extra>::
 	This can be any options that the archiver backend understands.
 	See next section.
diff --git a/archive.c b/archive.c
index 96b62d4..b2b90d3 100644
--- a/archive.c
+++ b/archive.c
@@ -4,6 +4,7 @@
 #include "attr.h"
 #include "archive.h"
 #include "parse-options.h"
+#include "unpack-trees.h"
=20
 static char const * const archive_usage[] =3D {
 	"git archive [options] <tree-ish> [path...]",
@@ -150,6 +151,8 @@ int write_archive_entries(struct archiver_args *arg=
s,
 		write_archive_entry_fn_t write_entry)
 {
 	struct archiver_context context;
+	struct unpack_trees_options opts;
+	struct tree_desc t;
 	int err;
=20
 	if (args->baselen > 0 && args->base[args->baselen - 1] =3D=3D '/') {
@@ -168,6 +171,22 @@ int write_archive_entries(struct archiver_args *ar=
gs,
 	context.args =3D args;
 	context.write_entry =3D write_entry;
=20
+	/*
+	 * Setup index and instruct attr to read index only
+	 */
+	if (!args->worktree_attributes) {
+		memset(&opts, 0, sizeof(opts));
+		opts.index_only =3D 1;
+		opts.head_idx =3D -1;
+		opts.src_index =3D &the_index;
+		opts.dst_index =3D &the_index;
+		opts.fn =3D oneway_merge;
+		init_tree_desc(&t, args->tree->buffer, args->tree->size);
+		if (unpack_trees(1, &t, &opts))
+			return -1;
+		git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
+	}
+
 	err =3D  read_tree_recursive(args->tree, args->base, args->baselen, 0=
,
 			args->pathspec, write_archive_entry, &context);
 	if (err =3D=3D READ_TREE_RECURSIVE)
@@ -258,6 +277,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 	int verbose =3D 0;
 	int i;
 	int list =3D 0;
+	int worktree_attributes =3D 0;
 	struct option opts[] =3D {
 		OPT_GROUP(""),
 		OPT_STRING(0, "format", &format, "fmt", "archive format"),
@@ -265,6 +285,8 @@ static int parse_archive_args(int argc, const char =
**argv,
 			"prepend prefix to each pathname in the archive"),
 		OPT_STRING(0, "output", &output, "file",
 			"write the archive to this file"),
+		OPT_BOOLEAN(0, "worktree-attributes", &worktree_attributes,
+			"read .gitattributes in working directory"),
 		OPT__VERBOSE(&verbose),
 		OPT__COMPR('0', &compression_level, "store only", 0),
 		OPT__COMPR('1', &compression_level, "compress faster", 1),
@@ -324,6 +346,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 	args->verbose =3D verbose;
 	args->base =3D base;
 	args->baselen =3D strlen(base);
+	args->worktree_attributes =3D worktree_attributes;
=20
 	return argc;
 }
diff --git a/archive.h b/archive.h
index 0b15b35..038ac35 100644
--- a/archive.h
+++ b/archive.h
@@ -10,6 +10,7 @@ struct archiver_args {
 	time_t time;
 	const char **pathspec;
 	unsigned int verbose : 1;
+	unsigned int worktree_attributes : 1;
 	int compression_level;
 };
=20
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 0713bca..1a5a2ed 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -24,7 +24,7 @@ int cmd_tar_tree(int argc, const char **argv, const c=
har *prefix)
 	 * 	git archive --format-tar --prefix=3Dbasedir tree-ish
 	 */
 	int i;
-	const char **nargv =3D xcalloc(sizeof(*nargv), argc + 2);
+	const char **nargv =3D xcalloc(sizeof(*nargv), argc + 3);
 	char *basedir_arg;
 	int nargc =3D 0;
=20
@@ -36,6 +36,13 @@ int cmd_tar_tree(int argc, const char **argv, const =
char *prefix)
 		argv++;
 		argc--;
 	}
+
+	/*
+	 * Because it's just a compatibility wrapper, tar-tree supports only
+	 * the old behaviour of reading attributes from the work tree.
+	 */
+	nargv[nargc++] =3D "--worktree-attributes";
+
 	switch (argc) {
 	default:
 		usage(tar_tree_usage);
--=20
1.6.3.rc0
