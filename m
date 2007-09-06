From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/3] archive: rename attribute specfile to export-subst
Date: Thu, 06 Sep 2007 18:51:11 +0200
Message-ID: <46E02FFF.8090902@lsrfire.ath.cx>
References: <46DC4D45.4030208@lsrfire.ath.cx>	<7vtzqb8fw2.fsf@gitster.siamese.dyndns.org> <46DCF0EF.9020604@op5.se>	<Pine.LNX.4.64.0709041139140.28586@racer.site>	<46DDE69C.1080908@lsrfire.ath.cx> <7vzm02klip.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 18:51:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKZg-0001bG-Et
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 18:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbXIFQvS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 12:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbXIFQvS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 12:51:18 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:49303
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752601AbXIFQvR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 12:51:17 -0400
Received: from [10.0.1.201] (p508EEF61.dip.t-dialin.net [80.142.239.97])
	by neapel230.server4you.de (Postfix) with ESMTP id 8D2AE873B5;
	Thu,  6 Sep 2007 18:51:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vzm02klip.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57906>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>>> Maybe we should not so much name it by purpose, but by function.  H=
ow=20
>>> about "substformat" for the attribute name, and replacing any=20
>>> $Format:blablub$ inside those files with something a la=20
>>> --pretty=3Dformat:blablub?
>> I like the $Format:...$ notation.  How about naming the attribute
>> "template", as that's what a thus marked file is?
>=20
> Sounds good, although I suspect "template" might confuse newbies
> that checkout may apply the substitution as well.  How about
> something with "export" in it?  export-subst, perhaps?

Well, including "export" in the name makes sense, yes.  I can't come up
with a better name, let's take this.

--- snip! ---
As suggested by Junio and Johannes, change the name of the former
attribute specfile to export-subst to indicate its function rather
than purpose and to make clear that it is not applied to working tree
files.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 Documentation/gitattributes.txt |    6 +++---
 builtin-archive.c               |   14 +++++++-------
 t/t5000-tar-tree.sh             |   18 +++++++++---------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 37b3be8..d0e951e 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -424,10 +424,10 @@ frotz	unspecified
 Creating an archive
 ~~~~~~~~~~~~~~~~~~~
=20
-`specfile`
-^^^^^^^^^^
+`export-subst`
+^^^^^^^^^^^^^^
=20
-If the attribute `specfile` is set for a file then git will expand
+If the attribute `export-subst` is set for a file then git will expand
 several placeholders when adding this file to an archive.  The
 expansion depends on the availability of a commit ID, i.e. if
 gitlink:git-archive[1] has been given a tree instead of a commit or a
diff --git a/builtin-archive.c b/builtin-archive.c
index a8a0f01..af14837 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -81,8 +81,8 @@ static int run_remote_archiver(const char *remote, in=
t argc,
 	return !!rv;
 }
=20
-static void *format_specfile(const struct commit *commit, const char *=
format,
-                             unsigned long *sizep)
+static void *format_subst(const struct commit *commit, const char *for=
mat,
+                          unsigned long *sizep)
 {
 	unsigned long len =3D *sizep, result_len =3D 0;
 	const char *a =3D format;
@@ -131,22 +131,22 @@ static void *convert_to_archive(const char *path,
                                 const void *src, unsigned long *sizep,
                                 const struct commit *commit)
 {
-	static struct git_attr *attr_specfile;
+	static struct git_attr *attr_export_subst;
 	struct git_attr_check check[1];
=20
 	if (!commit)
 		return NULL;
=20
-        if (!attr_specfile)
-                attr_specfile =3D git_attr("specfile", 8);
+        if (!attr_export_subst)
+                attr_export_subst =3D git_attr("export-subst", 12);
=20
-	check[0].attr =3D attr_specfile;
+	check[0].attr =3D attr_export_subst;
 	if (git_checkattr(path, ARRAY_SIZE(check), check))
 		return NULL;
 	if (!ATTR_TRUE(check[0].value))
 		return NULL;
=20
-	return format_specfile(commit, src, sizep);
+	return format_subst(commit, src, sizep);
 }
=20
 void *sha1_file_to_archive(const char *path, const unsigned char *sha1=
,
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 6e89e07..42e28ab 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -28,7 +28,7 @@ commit id embedding:
 TAR=3D${TAR:-tar}
 UNZIP=3D${UNZIP:-unzip}
=20
-SPECFILEFORMAT=3D%H%n
+SUBSTFORMAT=3D%H%n
=20
 test_expect_success \
     'populate workdir' \
@@ -36,7 +36,7 @@ test_expect_success \
      echo simple textfile >a/a &&
      mkdir a/bin &&
      cp /bin/sh a/bin &&
-     printf "A\$Format:%s\$O" "$SPECFILEFORMAT" >a/specfile &&
+     printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile &&
      ln -s a a/l1 &&
      (p=3Dlong_path_to_a_file && cd a &&
       for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
@@ -108,20 +108,20 @@ test_expect_success \
     'diff -r a c/prefix/a'
=20
 test_expect_success \
-    'create an archive with a specfile' \
-    'echo specfile specfile >a/.gitattributes &&
+    'create an archive with a substfile' \
+    'echo substfile export-subst >a/.gitattributes &&
      git archive HEAD >f.tar &&
      rm a/.gitattributes'
=20
 test_expect_success \
-    'extract specfile' \
+    'extract substfile' \
     '(mkdir f && cd f && $TAR xf -) <f.tar'
=20
 test_expect_success \
-     'validate specfile contents' \
-     'git log --max-count=3D1 "--pretty=3Dformat:A${SPECFILEFORMAT}O" =
HEAD \
-      >f/a/specfile.expected &&
-      diff f/a/specfile.expected f/a/specfile'
+     'validate substfile contents' \
+     'git log --max-count=3D1 "--pretty=3Dformat:A${SUBSTFORMAT}O" HEA=
D \
+      >f/a/substfile.expected &&
+      diff f/a/substfile.expected f/a/substfile'
=20
 test_expect_success \
     'git archive --format=3Dzip' \
