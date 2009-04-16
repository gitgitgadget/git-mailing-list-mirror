From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] archive: do not read .gitattributes in working directory
Date: Wed, 15 Apr 2009 19:28:36 -0700
Message-ID: <1239848917-14399-5-git-send-email-gitster@pobox.com>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com>
 <1239848917-14399-2-git-send-email-gitster@pobox.com>
 <1239848917-14399-3-git-send-email-gitster@pobox.com>
 <1239848917-14399-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 04:31:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuHNf-0000r0-Ig
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 04:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbZDPC25 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 22:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757034AbZDPC2z
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 22:28:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756362AbZDPC2y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 22:28:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 425C1AA3C2;
	Wed, 15 Apr 2009 22:28:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4AC6DAA3BE; Wed,
 15 Apr 2009 22:28:51 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc0.6.g08087
In-Reply-To: <1239848917-14399-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5483F928-2A2E-11DE-B1F5-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116664>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The old behaviour still remains with --fix-attributes, and it is always=
 on
for the legacy "git tar-tree".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-archive.txt |    5 ++++-
 archive.c                     |   22 ++++++++++++++++++++++
 archive.h                     |    1 +
 builtin-tar-tree.c            |    8 ++++++++
 4 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index c1adf59..fd882bf 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git archive' --format=3D<fmt> [--list] [--prefix=3D<prefix>/] [<extra=
>]
-	      [--output=3D<file>]
+	      [--output=3D<file>] [--fix-attributes]
 	      [--remote=3D<repo> [--exec=3D<git-upload-archive>]] <tree-ish>
 	      [path...]
=20
@@ -51,6 +51,9 @@ OPTIONS
 --output=3D<file>::
 	Write the archive to <file> instead of stdout.
=20
+--fix-attributes::
+	Look for attributes in .gitattributes in working directory too.
+
 <extra>::
 	This can be any options that the archiver backend understands.
 	See next section.
diff --git a/archive.c b/archive.c
index 96b62d4..0ce628b 100644
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
@@ -265,6 +285,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 			"prepend prefix to each pathname in the archive"),
 		OPT_STRING(0, "output", &output, "file",
 			"write the archive to this file"),
+		OPT_BOOLEAN(0, "fix-attributes", &worktree_attributes, "read .gitatt=
ributes in working directory"),
 		OPT__VERBOSE(&verbose),
 		OPT__COMPR('0', &compression_level, "store only", 0),
 		OPT__COMPR('1', &compression_level, "compress faster", 1),
@@ -324,6 +345,7 @@ static int parse_archive_args(int argc, const char =
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
index 0713bca..760ea9d 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -36,6 +36,14 @@ int cmd_tar_tree(int argc, const char **argv, const =
char *prefix)
 		argv++;
 		argc--;
 	}
+	if (2 <=3D argc && !strcmp(argv[1], "--fix-attributes")) {
+		argv++;
+		argc--;
+	}
+
+	/* tar-tree defaults to fix-attributes as before */
+	nargv[nargc++] =3D "--fix-attributes";
+
 	switch (argc) {
 	default:
 		usage(tar_tree_usage);
--=20
1.6.3.rc0.6.g08087
