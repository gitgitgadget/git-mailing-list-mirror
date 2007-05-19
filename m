From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Commit ID in exported Tar Ball
Date: Sat, 19 May 2007 22:22:58 +0200
Message-ID: <464F5CA2.3070809@lsrfire.ath.cx>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sat May 19 22:24:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpVT4-0003JV-Bw
	for gcvg-git@gmane.org; Sat, 19 May 2007 22:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764382AbXESUXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 16:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764413AbXESUXG
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 16:23:06 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:38192
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764366AbXESUXE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2007 16:23:04 -0400
Received: from [10.0.1.201] (p508E434C.dip.t-dialin.net [80.142.67.76])
	by neapel230.server4you.de (Postfix) with ESMTP id ACBB63D009;
	Sat, 19 May 2007 22:23:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20070517171150.GL5272@planck.djpig.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47772>

=46rank Lichtenheld schrieb:
> On Thu, May 17, 2007 at 06:57:22PM +0200, Johan Herland wrote:
>> Of course, it all depends on whether the $Id$ conversion is triggere=
d by=20
>> git-archive...
>=20
> Another possibility might be to add a commandline switch to git-archi=
ve
> so you can decide whether the commit id should be added as a header t=
o
> the tar file (which it already supports) or as a ordinary file (which
> should be reasonable trivial to implement). The question if whether
> it would be worth to add that feature. Don't know if there are many
> other users out there that need it.

Something like the following patch?  Since we're already embedding the
commit ID in a comment, we might as well offer creating a synthetic fil=
e
for it, too, if that solves a user's problem that might be difficult to
work around otherwise.

Ren=E9


 Documentation/git-archive.txt |    4 ++++
 archive-tar.c                 |    7 +++++++
 archive-zip.c                 |    7 +++++++
 archive.h                     |    1 +
 builtin-archive.c             |   11 +++++++++++
 5 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
index 721e035..ac31aac 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -43,6 +43,10 @@ OPTIONS
 --prefix=3D<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
=20
+--commit-id-file=3D<filename>::
+	Adds a file to the archive containing the commit ID.  This option
+	is ignored if <tree-ish> references a tree instead of a commit.
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
index 7f4e409..e58ea16 100644
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
