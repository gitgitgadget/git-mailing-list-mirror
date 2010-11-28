From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] get_sha1: support relative path ":path" syntax
Date: Sun, 28 Nov 2010 10:37:32 +0700
Message-ID: <1290915452-6339-1-git-send-email-pclouds@gmail.com>
References: <7v4obimr5l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	srabbelier@gmail.com, tfransosi@gmail.com,
	Jonathan Niedier <jrnieder@gmail.com>,
	Matthieu.Moy@grenoble-inp.fr
X-From: git-owner@vger.kernel.org Sun Nov 28 04:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMYBT-000304-8r
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 04:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286Ab0K1Diz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Nov 2010 22:38:55 -0500
Received: from mail-pv0-f194.google.com ([74.125.83.194]:45494 "EHLO
	mail-pv0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab0K1Diy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 22:38:54 -0500
Received: by pva18 with SMTP id 18so724795pva.1
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 19:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ngm9n9J+/JOT3A8pulEfx/Ud9EnkAIsOIRnz+AwK5dM=;
        b=QWPbwSTv+LEPKtk3bjP42iRF2chaOXBfPaLf9//ip06YdTxo+1Lq89EXRBpbj+QpMo
         TZB+D3L1MbzK91k88PHy505AQpn7eyVjwfhiWIJjccbY9EdNWNZAUx7enWY5rXryLpEo
         m21XF+aJN+7Yc4kmOgIzjoJ8Joc0U4l0KYrCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OsE6TjggV0hC5QQImxeqXFyeB1ritJ1JODSjBeJe0RxTi0QmZ4jIE9R8bBpX57st1z
         Zl8QMTnT8cZcdWAN3Dy9O+chz5cF4lcpN/FDXuTXDfzmABgiD1bscegEDo2r8mwzHs0e
         Fmwj41GlEG8pObXnGSWd9lijcJNe8aNPycUOo=
Received: by 10.142.12.2 with SMTP id 2mr3577258wfl.241.1290915533700;
        Sat, 27 Nov 2010 19:38:53 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id e14sm5209403wfg.8.2010.11.27.19.38.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 19:38:52 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 28 Nov 2010 10:37:39 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <7v4obimr5l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162332>

Currently :path and ref:path can be used to refer to a specific object
in index or ref respectively. "path" component is absolute path. This
patch allows "path" to be written as "./path" or "../path", which is
relative to user's original cwd.

This does not work in commands for which startup_info is NULL
(i.e. non-builtin ones, it seems none of them needs this anyway).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Updated the message when startup_info =3D=3D NULL

 Documentation/revisions.txt    |    4 ++
 sha1_name.c                    |   37 ++++++++++++++++++++++--
 t/t1506-rev-parse-diagnosis.sh |   62 ++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 3d4b79c..8b519d7 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -121,6 +121,10 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DI=
R/packed-refs` file.
   ':path' (with an empty part before the colon, e.g. `:README`)
   is a special case of the syntax described next: content
   recorded in the index at the given path.
+  A path starting with './' or '../' is relative to current working di=
rectory.
+  The given path will be converted to be relative to working tree's ro=
ot directory.
+  This is most useful to address a blob or tree from a commit or tree =
that has
+  the same tree structure with the working tree.
=20
 * A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path (e.g. `:0:README`); this names a blob obje=
ct in the
diff --git a/sha1_name.c b/sha1_name.c
index 484081d..f918faf 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1046,6 +1046,23 @@ int get_sha1_with_mode_1(const char *name, unsig=
ned char *sha1, unsigned *mode,
 	return ret;
 }
=20
+static char *resolve_relative_path(const char *rel)
+{
+	if (prefixcmp(rel, "./") && prefixcmp(rel, "../"))
+		return NULL;
+
+	if (!startup_info)
+		die("BUG: startup_info struct is not initialized.");
+
+	if (!is_inside_work_tree())
+		die("relative path syntax can't be used outside working tree.");
+
+	/* die() inside prefix_path() if resolved path is outside worktree */
+	return prefix_path(startup_info->prefix,
+			   startup_info->prefix ? strlen(startup_info->prefix) : 0,
+			   rel);
+}
+
 int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			    struct object_context *oc,
 			    int gently, const char *prefix)
@@ -1060,25 +1077,31 @@ int get_sha1_with_context_1(const char *name, u=
nsigned char *sha1,
 	if (!ret)
 		return ret;
 	/* sha1:path --> object name of path in ent sha1
-	 * :path -> object name of path in index
+	 * :path -> object name of absolute path in index
+	 * :./path -> object name of path relative to cwd in index
 	 * :[0-3]:path -> object name of path in index at stage
 	 * :/foo -> recent commit matching foo
 	 */
 	if (name[0] =3D=3D ':') {
 		int stage =3D 0;
 		struct cache_entry *ce;
+		char *new_path =3D NULL;
 		int pos;
 		if (namelen > 2 && name[1] =3D=3D '/')
 			return get_sha1_oneline(name + 2, sha1);
 		if (namelen < 3 ||
 		    name[2] !=3D ':' ||
-		    name[1] < '0' || '3' < name[1])
+		    name[1] < '0' || '3' < name[1]) {
 			cp =3D name + 1;
+			new_path =3D resolve_relative_path(cp);
+			if (new_path)
+				cp =3D new_path;
+		}
 		else {
 			stage =3D name[1] - '0';
 			cp =3D name + 3;
 		}
-		namelen =3D namelen - (cp - name);
+		namelen =3D strlen(cp);
=20
 		strncpy(oc->path, cp,
 			sizeof(oc->path));
@@ -1096,12 +1119,14 @@ int get_sha1_with_context_1(const char *name, u=
nsigned char *sha1,
 				break;
 			if (ce_stage(ce) =3D=3D stage) {
 				hashcpy(sha1, ce->sha1);
+				free(new_path);
 				return 0;
 			}
 			pos++;
 		}
 		if (!gently)
 			diagnose_invalid_index_path(stage, prefix, cp);
+		free(new_path);
 		return -1;
 	}
 	for (cp =3D name, bracket_depth =3D 0; *cp; cp++) {
@@ -1122,6 +1147,11 @@ int get_sha1_with_context_1(const char *name, un=
signed char *sha1,
 		}
 		if (!get_sha1_1(name, cp-name, tree_sha1)) {
 			const char *filename =3D cp+1;
+			char *new_filename =3D NULL;
+
+			new_filename =3D resolve_relative_path(filename);
+			if (new_filename)
+				filename =3D new_filename;
 			ret =3D get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
 			if (!gently) {
 				diagnose_invalid_sha1_path(prefix, filename,
@@ -1133,6 +1163,7 @@ int get_sha1_with_context_1(const char *name, uns=
igned char *sha1,
 				sizeof(oc->path));
 			oc->path[sizeof(oc->path)-1] =3D '\0';
=20
+			free(new_filename);
 			return ret;
 		} else {
 			if (!gently)
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnos=
is.sh
index 0eeeb0e..f7a4076 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -31,6 +31,43 @@ test_expect_success 'correct file objects' '
 	 test $HASH_file =3D $(git rev-parse :0:file.txt) )
 '
=20
+test_expect_success 'correct relative file objects (0)' '
+	git rev-parse :file.txt >expected &&
+	git rev-parse :./file.txt >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'correct relative file objects (1)' '
+	git rev-parse HEAD:file.txt >expected &&
+	git rev-parse HEAD:./file.txt >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'correct relative file objects (2)' '
+	(
+		cd subdir &&
+		git rev-parse HEAD:../file.txt >result &&
+		test_cmp ../expected result
+	)
+'
+
+test_expect_success 'correct relative file objects (3)' '
+	(
+		cd subdir &&
+		git rev-parse HEAD:../subdir/../file.txt >result &&
+		test_cmp ../expected result
+	)
+'
+
+test_expect_success 'correct relative file objects (4)' '
+	git rev-parse HEAD:subdir/file.txt >expected &&
+	(
+		cd subdir &&
+		git rev-parse HEAD:./file.txt >result &&
+		test_cmp ../expected result
+	)
+'
+
 test_expect_success 'incorrect revision id' '
 	test_must_fail git rev-parse foobar:file.txt 2>error &&
 	grep "Invalid object name '"'"'foobar'"'"'." error &&
@@ -75,4 +112,29 @@ test_expect_success 'invalid @{n} reference' '
 	grep "fatal: Log for [^ ]* only has [0-9][0-9]* entries." error
 '
=20
+test_expect_success 'relative path not found' '
+	(
+		cd subdir &&
+		test_must_fail git rev-parse HEAD:./nonexistent.txt 2>error &&
+		grep subdir/nonexistent.txt error
+	)
+'
+
+test_expect_success 'relative path outside worktree' '
+	test_must_fail git rev-parse HEAD:../file.txt >output 2>error &&
+	test -z "$(cat output)" &&
+	grep "outside repository" error
+'
+
+test_expect_success 'relative path when cwd is outside worktree' '
+	test_must_fail git --git-dir=3D.git --work-tree=3Dsubdir rev-parse HE=
AD:./file.txt >output 2>error &&
+	test -z "$(cat output)" &&
+	grep "relative path syntax can.t be used outside working tree." error
+'
+
+test_expect_success 'relative path when startup_info is NULL' '
+	test_must_fail test-match-trees HEAD:./file.txt HEAD:./file.txt 2>err=
or &&
+	grep "Relative path syntax is not supported in this command" error
+'
+
 test_done
--=20
1.7.3.2.316.gda8b3
