From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: how to git-archive ignore some files?
Date: Sun, 08 Jun 2008 18:42:33 +0200
Message-ID: <484C0BF9.1090909@lsrfire.ath.cx>
References: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br>	<BAYC1-PASMTP023026B88005E512F95384AED60@CEZ.ICE>	<4820CC35.3090202@lsrfire.ath.cx>	<7vk5i7gk6e.fsf@gitster.siamese.dyndns.org>	<4826CE0B.8080109@lsrfire.ath.cx>	<7vwsm06cdd.fsf@gitster.siamese.dyndns.org> <m3prrr50gc.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Victor Bogado da Silva Lins <victor@bogado.net>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 18:44:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Nzq-0006W5-5v
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 18:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672AbYFHQmg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 12:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755660AbYFHQmg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 12:42:36 -0400
Received: from india601.server4you.de ([85.25.151.105]:59363 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621AbYFHQmf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 12:42:35 -0400
Received: from [10.0.1.200] (p57B7EC0B.dip.t-dialin.net [87.183.236.11])
	by india601.server4you.de (Postfix) with ESMTPSA id 5B63A2F8068;
	Sun,  8 Jun 2008 18:42:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <m3prrr50gc.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84293>

Jakub Narebski schrieb:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>
>>> Another idea: would it make sense to have an attribute for that ins=
tead
>>> (or in addition to the command line parameter)?  I.e. files marked
>>> export-ignore would not end up in the archive.  I suspect the set o=
f
>>> files to ignore doesn't change from archive to archive one creates.
>> That sounds extremely sensible.
>>
>> Should/does git-archive read .gitattributes from the tree being expo=
rted?
>=20
> If I understand and remember correctly, current implementation of
> gitattributes, and current tools (git-check-attr), use and can use
> only working directory version of .gitattributes, in part because of
> chicken-and-egg problem (attributes effect checkout) IIRC.
>=20
> It would be nice if git-archive read and use .gitattribues from
> a tree being exported; this would for example make `export-subs`
> work even for bare repositories.  This would be needed for
> `export-ignore`.

git-archive uses the routines from attr.c, and this is where the abilit=
y
to read attributes from git trees should be added.  It's independent fr=
om
ignoring files when creating archives.  Maybe it would be a good idea t=
o
add this feature; in the meantime users need to resort to adding their
attributes to $GIT_DIR/info/attributes.

Anyway, here's a patch to add export-ignore support to git-archive.
=46iles and directories with this attribute are not added to archives.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/gitattributes.txt |    6 ++++++
 archive-tar.c                   |    2 ++
 archive-zip.c                   |    2 ++
 archive.c                       |   13 +++++++++++++
 archive.h                       |    1 +
 t/t5000-tar-tree.sh             |    9 +++++++++
 6 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 471754e..6e67990 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -502,6 +502,12 @@ frotz	unspecified
 Creating an archive
 ~~~~~~~~~~~~~~~~~~~
=20
+`export-ignore`
+^^^^^^^^^^^^^^^
+
+Files and directories with the attribute `export-ignore` won't be adde=
d to
+archive files.
+
 `export-subst`
 ^^^^^^^^^^^^^^
=20
diff --git a/archive-tar.c b/archive-tar.c
index d7598f9..99db58f 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -247,6 +247,8 @@ static int write_tar_entry(const unsigned char *sha=
1,
 	strbuf_grow(&path, PATH_MAX);
 	strbuf_add(&path, base, baselen);
 	strbuf_addstr(&path, filename);
+	if (is_archive_path_ignored(path.buf + base_len))
+		return 0;
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		strbuf_addch(&path, '/');
 		buffer =3D NULL;
diff --git a/archive-zip.c b/archive-zip.c
index 18c0f87..5742762 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -176,6 +176,8 @@ static int write_zip_entry(const unsigned char *sha=
1,
 	crc =3D crc32(0, NULL, 0);
=20
 	path =3D construct_path(base, baselen, filename, S_ISDIR(mode), &path=
len);
+	if (is_archive_path_ignored(path + base_len))
+		return 0;
 	if (verbose)
 		fprintf(stderr, "%s\n", path);
 	if (pathlen > 0xffff) {
diff --git a/archive.c b/archive.c
index 7a32c19..6502b76 100644
--- a/archive.c
+++ b/archive.c
@@ -82,3 +82,16 @@ void *sha1_file_to_archive(const char *path, const u=
nsigned char *sha1,
 	return buffer;
 }
=20
+int is_archive_path_ignored(const char *path)
+{
+	static struct git_attr *attr_export_ignore;
+	struct git_attr_check check[1];
+
+	if (!attr_export_ignore)
+		attr_export_ignore =3D git_attr("export-ignore", 13);
+
+	check[0].attr =3D attr_export_ignore;
+	if (git_checkattr(path, ARRAY_SIZE(check), check))
+		return 0;
+	return ATTR_TRUE(check[0].value);
+}
diff --git a/archive.h b/archive.h
index 5791e65..ddf004a 100644
--- a/archive.h
+++ b/archive.h
@@ -44,5 +44,6 @@ extern int write_zip_archive(struct archiver_args *);
 extern void *parse_extra_zip_args(int argc, const char **argv);
=20
 extern void *sha1_file_to_archive(const char *path, const unsigned cha=
r *sha1, unsigned int mode, enum object_type *type, unsigned long *size=
, const struct commit *commit);
+extern int is_archive_path_ignored(const char *path);
=20
 #endif	/* ARCHIVE_H */
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 9b0baac..3f1e25d 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -45,6 +45,11 @@ test_expect_success \
      (cd a && find .) | sort >a.lst'
=20
 test_expect_success \
+    'add ignored file' \
+    'echo ignore me >a/ignored &&
+     echo ignored export-ignore >.gitattributes'
+
+test_expect_success \
     'add files to repository' \
     'find a -type f | xargs git update-index --add &&
      find a -type l | xargs git update-index --add &&
@@ -54,6 +59,10 @@ test_expect_success \
      git commit-tree $treeid </dev/null)'
=20
 test_expect_success \
+    'remove ignored file' \
+    'rm a/ignored'
+
+test_expect_success \
     'git archive' \
     'git archive HEAD >b.tar'
=20
