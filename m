From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Commit ID in exported Tar Ball
Date: Wed, 23 May 2007 00:26:58 +0200
Message-ID: <46536E32.6000202@lsrfire.ath.cx>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <46502EF7.6000708@lsrfire.ath.cx> <20070521060231.GI3141@spearce.org> <4651F908.2000608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 23 00:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqcp2-0002JY-Ks
	for gcvg-git@gmane.org; Wed, 23 May 2007 00:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757233AbXEVW1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 May 2007 18:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756821AbXEVW1N
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 18:27:13 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:60903
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757233AbXEVW1L (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2007 18:27:11 -0400
Received: from [10.0.1.201] (p508e4968.dip.t-dialin.net [80.142.73.104])
	by neapel230.server4you.de (Postfix) with ESMTP id 115882F007;
	Wed, 23 May 2007 00:27:07 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <4651F908.2000608@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48129>

[I'm quoting myself in full because I somehow sent my reply to everyone
but Shawn.  A patch can be found at the end.]

Ren=E9 Scharfe schrieb:
> Shawn O. Pearce schrieb:
>> Ren?? Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>>> Shawn O. Pearce schrieb:
>>>> git-describe is more human-friendly than a SHA-1...
>>> Yes, and the Makefile does even more than that: it adds a version
>>> file, a spec file and another version file for git-gui.
>>>=20
>>> The first two are probably useful for most projects that actually
>>> do versioned releases.  We could have a simple parser that reads
>>> a template, replaces @@VERSION@@ with a git-describe output
>>> string and adds the result as a synthetic file to the archive.
>>> It's not exactly trivial -- e.g., how to specify git-describe
>>> options, template file and synthetic name, all in one command
>>> line parameter? -- but it's doable.
>> Maybe something just as simple as allowing the user to specify a=20
>> shell script in-tree that we unpack and run for them?  That script=20
>> prints to stdout the content of the file to include.
>=20
> I doubt executing a shell script is simple. :-D  You'd possibly get=20
> different results on different platforms (dare I mention Windows?).
>=20
> The template system I mentioned would be a kind of scripting language
>  itself, but in this case we define its syntax and can guarantee=20
> consistency everywhere git runs.  And since it would only have four=20
> types of tokens (@@VERSION@@, @@COMMITID@@, @@@@ and string literals)
> it could be fast and simple.
>=20
> We could implement it as a checkout converter, preferably one that is
> only applied by git-archive.  Then we'd rename git.spec.in to
> git.spec, assign the "specfile" attribute to it and let git-archive
> replace the string @@VERSION@@ with git-describe's output.
> git-checkout would not expand the special strings, so you can simply
> edit and version the file as you can do with git.spec.in now.
> Michael would have a file containing only @@COMMITID@@ to solve his
> original problem.  Make sense?
>=20
>> So now we're also really talking about, what should git-archive do
>> for a subproject?  Sometimes you really do want to repackage and
>> redistribute the subproject as part of the superproject's tarball.
>> Sometimes you don't.  I think in the case of git.git and=20
>> git-gui.git we want to include the subproject.  ;-)
>=20
> Oh, yes, subprojects.  git-archive currently exports them as empty=20
> directories.  Using tar's append command you could simply build the=20
> project+subproject archive in the Makefile.  That wouldn't work well=20
> with gitweb, though.  Perhaps a --include-subproject=3D<path> option =
is
>  needed?

OK, so here's a first shot at the mentioned parser.  It only understand=
s
@@COMMITID@@ and @@@@, but it's easily extendible.  The internals of
git-describe would need to be converted to library functions, preferabl=
y
offering every piece of version info separately (see thread "[PATCH]
Make sure an autogenerated version has at least four parts" for why).

Before doing that, we should determine if this is the way to, though.

Ren=E9


 Documentation/gitattributes.txt |   19 ++++++-
 archive-tar.c                   |    5 ++-
 archive-zip.c                   |    5 ++-
 cache.h                         |    1 +
 convert.c                       |  112 +++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index d3ac9c7..84c414c 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -72,7 +72,7 @@ EFFECTS
 -------
=20
 Certain operations by git can be influenced by assigning
-particular attributes to a path.  Currently, three operations
+particular attributes to a path.  Currently, four operations
 are attributes-aware.
=20
 Checking-out and checking-in
@@ -374,6 +374,23 @@ frotz	unspecified
 ----------------------------------------------------------------
=20
=20
+Creating an archive
+~~~~~~~~~~~~~~~~~~~
+
+
+`specfile`
+^^^^^^^^^^
+
+If the attribute `specfile` is set for a file then git will expand
+several placeholders when adding this file to an archive.  The
+expansion depends on the availability of a commit ID, i.e. if
+`git-archive` has been given a tree instead of a commit or a tag
+then no replacement will be done.
+
+`@@COMMITID@@`:: is replaced by the commit hash.
+`@@@@`:: is replaced by `@@`.
+
+
 GIT
 ---
 Part of the gitlink:git[7] suite
diff --git a/archive-tar.c b/archive-tar.c
index 66fe3e3..eba24cb 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -17,6 +17,7 @@ static unsigned long offset;
 static time_t archive_time;
 static int tar_umask =3D 002;
 static int verbose;
+static const unsigned char *commit_sha1;
=20
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
@@ -285,7 +286,8 @@ static int write_tar_entry(const unsigned char *sha=
1,
 		buffer =3D NULL;
 		size =3D 0;
 	} else {
-		buffer =3D convert_sha1_file(path.buf, sha1, mode, &type, &size);
+		buffer =3D sha1_file_to_archive(path.buf, sha1, mode, &type,
+		                              &size, commit_sha1);
 		if (!buffer)
 			die("cannot read %s", sha1_to_hex(sha1));
 	}
@@ -304,6 +306,7 @@ int write_tar_archive(struct archiver_args *args)
=20
 	archive_time =3D args->time;
 	verbose =3D args->verbose;
+	commit_sha1 =3D args->commit_sha1;
=20
 	if (args->commit_sha1)
 		write_global_extended_header(args->commit_sha1);
diff --git a/archive-zip.c b/archive-zip.c
index 444e162..93a5ab3 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -12,6 +12,7 @@
 static int verbose;
 static int zip_date;
 static int zip_time;
+static const unsigned char *commit_sha1;
=20
 static unsigned char *zip_dir;
 static unsigned int zip_dir_size;
@@ -195,7 +196,8 @@ static int write_zip_entry(const unsigned char *sha=
1,
 		if (S_ISREG(mode) && zlib_compression_level !=3D 0)
 			method =3D 8;
 		result =3D 0;
-		buffer =3D convert_sha1_file(path, sha1, mode, &type, &size);
+		buffer =3D sha1_file_to_archive(path, sha1, mode, &type, &size,
+		                              commit_sha1);
 		if (!buffer)
 			die("cannot read %s", sha1_to_hex(sha1));
 		crc =3D crc32(crc, buffer, size);
@@ -316,6 +318,7 @@ int write_zip_archive(struct archiver_args *args)
 	zip_dir =3D xmalloc(ZIP_DIRECTORY_MIN_SIZE);
 	zip_dir_size =3D ZIP_DIRECTORY_MIN_SIZE;
 	verbose =3D args->verbose;
+	commit_sha1 =3D args->commit_sha1;
=20
 	if (args->base && plen > 0 && args->base[plen - 1] =3D=3D '/') {
 		char *base =3D xstrdup(args->base);
diff --git a/cache.h b/cache.h
index cd875bc..0484904 100644
--- a/cache.h
+++ b/cache.h
@@ -550,6 +550,7 @@ extern void trace_argv_printf(const char **argv, in=
t count, const char *format,
 extern char *convert_to_git(const char *path, const char *src, unsigne=
d long *sizep);
 extern char *convert_to_working_tree(const char *path, const char *src=
, unsigned long *sizep);
 extern void *convert_sha1_file(const char *path, const unsigned char *=
sha1, unsigned int mode, enum object_type *type, unsigned long *size);
+extern void *sha1_file_to_archive(const char *path, const unsigned cha=
r *sha1, unsigned int mode, enum object_type *type, unsigned long *size=
, const unsigned char *commit_sha1);
=20
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned=
 char *, int);
diff --git a/convert.c b/convert.c
index 4b26b1a..1cdaec5 100644
--- a/convert.c
+++ b/convert.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "attr.h"
 #include "run-command.h"
+#include "strbuf.h"
=20
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -667,3 +668,114 @@ void *convert_sha1_file(const char *path, const u=
nsigned char *sha1,
 	}
 	return buffer;
 }
+
+static void strbuf_append(struct strbuf *sb, const void *s, size_t len=
)
+{
+	if (sb->alloc < sb->len + len) {
+		sb->alloc =3D (sb->len + len) * 3 / 2 + 16;
+		sb->buf =3D xrealloc(sb->buf, sb->alloc);
+	}
+	memcpy(sb->buf + sb->len, s, len);
+	sb->len +=3D len;
+}
+
+static unsigned int match_keyword(const char *data, unsigned int datal=
en,
+                                  const char *keyword)
+{
+	unsigned int keylen =3D strlen(keyword);
+	if (keylen > datalen)
+		return 0;
+	if (memcmp(data, keyword, keylen))
+		return 0;
+	return keylen;
+}
+
+static void *convert_to_archive(const char *path, const void *src,
+                                unsigned long *sizep,
+                                const unsigned char *commit_sha1)
+{
+	static struct git_attr *attr_specfile;
+	struct git_attr_check check[1];
+	const char *p =3D src;
+	unsigned long srcsize =3D *sizep;
+	int at_signs =3D 0;
+	struct strbuf dst;
+	unsigned int match;
+	int replaced_something =3D 0;
+
+	if (!commit_sha1)
+		return NULL;
+
+        if (!attr_specfile)
+                attr_specfile =3D git_attr("specfile", 8);
+
+	check[0].attr =3D attr_specfile;
+	if (git_checkattr(path, ARRAY_SIZE(check), check))
+		return NULL;
+	if (!ATTR_TRUE(check[0].value))
+		return NULL;
+
+	dst.alloc =3D srcsize + 128;
+	dst.buf =3D xmalloc(dst.alloc);
+	dst.len =3D dst.eof =3D 0;
+
+	while (srcsize > 0) {
+		if ((at_signs =3D=3D 0 || at_signs =3D=3D 1) && *p =3D=3D '@') {
+			at_signs++;
+			p++;
+			srcsize--;
+			continue;
+		}
+		if (at_signs =3D=3D 1) {
+			at_signs =3D 0;
+			strbuf_append(&dst, "@", 1);
+		}
+		if (at_signs =3D=3D 0) {
+			strbuf_append(&dst, p, 1);
+			p++;
+			srcsize--;
+			continue;
+		}
+
+		if ((match =3D match_keyword(p, srcsize, "@@")))
+			strbuf_append(&dst, "@@", 2);
+		else if ((match =3D match_keyword(p, srcsize, "COMMITID@@")))
+			strbuf_append(&dst, sha1_to_hex(commit_sha1), 40);
+		else
+			strbuf_append(&dst, "@@", 2);
+		at_signs =3D 0;
+		p +=3D match;
+		srcsize -=3D match;
+		replaced_something =3D 1;
+	}
+
+	if (!replaced_something) {
+		free(dst.buf);
+		return NULL;
+	}
+
+	*sizep =3D dst.len;
+	return dst.buf;
+}
+
+void *sha1_file_to_archive(const char *path, const unsigned char *sha1=
,
+                           unsigned int mode, enum object_type *type,
+                           unsigned long *size,
+                           const unsigned char *commit_sha1)
+{
+	void *buffer =3D read_sha1_file(sha1, type, size);
+	if (S_ISREG(mode) && buffer) {
+		void *converted =3D convert_to_working_tree(path, buffer, size);
+		if (converted) {
+			free(buffer);
+			buffer =3D converted;
+		}
+
+		converted =3D convert_to_archive(path, buffer, size, commit_sha1);
+		if (converted) {
+			free(buffer);
+			buffer =3D converted;
+		}
+	}
+	return buffer;
+}
