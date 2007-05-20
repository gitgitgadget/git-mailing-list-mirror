From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Commit ID in exported Tar Ball
Date: Sun, 20 May 2007 02:15:41 +0200
Message-ID: <464F932D.6040509@lsrfire.ath.cx>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de>	<200705171857.22891.johan@herland.net>	<20070517171150.GL5272@planck.djpig.de>	<464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 02:15:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpZ5W-0004IC-03
	for gcvg-git@gmane.org; Sun, 20 May 2007 02:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759182AbXETAPu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 20:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758928AbXETAPu
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 20:15:50 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59087
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757170AbXETAPt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2007 20:15:49 -0400
Received: from [10.0.1.201] (p508e6ddb.dip.t-dialin.net [80.142.109.219])
	by neapel230.server4you.de (Postfix) with ESMTP id 28C382600B;
	Sun, 20 May 2007 02:15:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <7vd50wv88t.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47786>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Something like the following patch?  Since we're already embedding
>> the commit ID in a comment, we might as well offer creating a
>> synthetic file for it, too, if that solves a user's problem that
>> might be difficult to work around otherwise.
>=20
> Are you detecting and erroring out if the named file already exists
> in the tree being archived?
>=20
> Should we?  Maybe we should just replace with warning?

Currently the commit ID file is appended to the archive, so if there is
a name conflict, we keep both files.  unzip offers a choice between
renaming, overwriting and keeping the first extracted version when the
second one is about to be extracted.  tar has a -k option: with -k you
get the first version, without -k you get the second one.

To avoid confusion, we should disallow a name that already comes from
the tree.  Only I can't see an easy way to implement this.  Perhaps a
check using get_tree_entry is enough -- it doesn't take pathspecs into
account, though.  That means we would disallow all names in the tree,
even if a pathspec excludes the chosen commit ID file name.

Before I roll my own path existence checker with pathspec support, is
there something like that already implemented?  I suspect it's hiding i=
n
the diff code, but I don't dare go near it. ;-)

> Also should we silently ignore the request if the tree-ish is not a
> commit-ish, or error out?

As Angry said, erroring out is better.  It's also easy to do.

 Documentation/git-archive.txt |    4 ++++
 archive-tar.c                 |    7 +++++++
 archive-zip.c                 |    7 +++++++
 archive.h                     |    1 +
 builtin-archive.c             |   32 ++++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index 721e035..7016d1e 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -43,6 +43,10 @@ OPTIONS
 --prefix=3D<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
=20
+--commit-id-file=3D<filename>::
+	Adds a file to the archive containing the commit ID.  This option
+	is can only be used if <tree-ish> references a commit or tag.
+
 <extra>::
 	This can be any options that the archiver backend understand.
 	See next section.
diff --git a/archive-tar.c b/archive-tar.c
index 33e7657..555850a 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -319,6 +319,13 @@ int write_tar_archive(struct archiver_args *args)
 	}
 	read_tree_recursive(args->tree, args->base, plen, 0,
 			    args->pathspec, write_tar_entry);
+	if (args->commit_sha1 && args->commit_sha1_file) {
+		unsigned char fake_sha1[20];
+		pretend_sha1_file(sha1_to_hex(args->commit_sha1), 40,
+		                  OBJ_BLOB, fake_sha1);
+		write_tar_entry(fake_sha1, args->base, plen,
+		                args->commit_sha1_file, 0100666, 0);
+	}
 	write_trailer();
=20
 	return 0;
diff --git a/archive-zip.c b/archive-zip.c
index 3cbf6bb..88c5dfa 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -328,6 +328,13 @@ int write_zip_archive(struct archiver_args *args)
 	}
 	read_tree_recursive(args->tree, args->base, plen, 0,
 			    args->pathspec, write_zip_entry);
+	if (args->commit_sha1 && args->commit_sha1_file) {
+		unsigned char fake_sha1[20];
+		pretend_sha1_file(sha1_to_hex(args->commit_sha1), 40,
+		                  OBJ_BLOB, fake_sha1);
+		write_zip_entry(fake_sha1, args->base, plen,
+		                args->commit_sha1_file, 0100666, 0);
+	}
 	write_zip_trailer(args->commit_sha1);
=20
 	free(zip_dir);
diff --git a/archive.h b/archive.h
index 6838dc7..020f82f 100644
--- a/archive.h
+++ b/archive.h
@@ -8,6 +8,7 @@ struct archiver_args {
 	const char *base;
 	struct tree *tree;
 	const unsigned char *commit_sha1;
+	const char *commit_sha1_file;
 	time_t time;
 	const char **pathspec;
 	unsigned int verbose : 1;
diff --git a/builtin-archive.c b/builtin-archive.c
index 7f4e409..6bb0781 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -151,6 +151,7 @@ int parse_archive_args(int argc, const char **argv,=
 struct archiver *ar)
 	int extra_argc =3D 0;
 	const char *format =3D "tar";
 	const char *base =3D "";
+	const char *commit_sha1_file =3D NULL;
 	int verbose =3D 0;
 	int i;
=20
@@ -174,6 +175,10 @@ int parse_archive_args(int argc, const char **argv=
, struct archiver *ar)
 			base =3D arg + 9;
 			continue;
 		}
+		if (!prefixcmp(arg, "--commit-id-file=3D")) {
+			commit_sha1_file =3D arg + 17;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -192,6 +197,11 @@ int parse_archive_args(int argc, const char **argv=
, struct archiver *ar)
 		usage(archive_usage);
 	if (init_archiver(format, ar) < 0)
 		die("Unknown archive format '%s'", format);
+	if (commit_sha1_file) {
+		size_t namelen =3D strlen(commit_sha1_file);
+		if (namelen =3D=3D 0 || commit_sha1_file[namelen - 1] =3D=3D '/')
+			die("Invalid commit ID file name: %s", commit_sha1_file);
+	}
=20
 	if (extra_argc) {
 		if (!ar->parse_extra)
@@ -201,6 +211,7 @@ int parse_archive_args(int argc, const char **argv,=
 struct archiver *ar)
 	}
 	ar->args.verbose =3D verbose;
 	ar->args.base =3D base;
+	ar->args.commit_sha1_file =3D commit_sha1_file;
=20
 	return i;
 }
@@ -236,6 +247,20 @@ static const char *extract_remote_arg(int *ac, con=
st char **av)
 	return remote;
 }
=20
+static int is_path_in_spec(struct tree *tree, const char **pathspec,
+                           const char *path)
+{
+	unsigned char sha1[20];
+	unsigned int mode;
+
+	if (get_tree_entry(tree->object.sha1, path, sha1, &mode))
+		return 0;
+	if (!pathspec)
+		return 1;
+	/* TODO: the actual pathspec check */
+	return 1;
+}
+
 int cmd_archive(int argc, const char **argv, const char *prefix)
 {
 	struct archiver ar;
@@ -257,5 +282,12 @@ int cmd_archive(int argc, const char **argv, const=
 char *prefix)
 	parse_treeish_arg(argv, &ar.args, prefix);
 	parse_pathspec_arg(argv + 1, &ar.args);
=20
+	if (ar.args.commit_sha1_file) {
+		if (is_path_in_spec(ar.args.tree, ar.args.pathspec, ar.args.commit_s=
ha1_file))
+			die("Commit ID file name already exists in archive.");
+		if (!ar.args.commit_sha1)
+			die("Need a commit to use --commit-id-file, and not a tree.");
+	}
+
 	return ar.write_archive(&ar.args);
 }
