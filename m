From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] get_sha1: support relative path ":path" syntax
Date: Mon, 15 Nov 2010 10:56:09 +0700
Message-ID: <1289793369-10653-1-git-send-email-pclouds@gmail.com>
References: <AANLkTimJKQ=xc7az+FEM+18aTxQ5zQ24q7pfChnSwt6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Matthieu.Moy@grenoble-inp.fr,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, tfransosi@gmail.com,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 04:57:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHqCP-00067M-Fu
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 04:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496Ab0KOD5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 22:57:41 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56892 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757479Ab0KOD5k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 22:57:40 -0500
Received: by iwn10 with SMTP id 10so6205739iwn.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 19:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=X6Xcr54lgY+cnBG61uEHtZ3UgKPni2msAT71aR3urRU=;
        b=SJasEIr90kWe12x7wW5KgDdqIqfBIImiRIshh7aokH/zP3zkpIL6Xrd7Z+bh7ZAWrR
         hFaAeFjyIXe7TwPf7AseTV3VHxIUZ5FRHMq4D4zm6VytXP8TT8OS8lCb6BQBNZLRUdT4
         QE4wisucCUXOBJ/Y8T7UVvBnEjxJGyLtwNuWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WeYvD1CIVFmiXaU+V584JtJiBlIl+Wc8Nop7Oq2gZ3mRIJJ6owzZQBF+92kbXsmOXq
         +jLVMo58/jviAZODI888QmI1MPaim32m5+DY41pyz3y876PxWqnc/rMjOEtc3rq/Q0Lb
         UV1APOFZdbUVAIXrHDqVFINK8uocA1f7/jUYE=
Received: by 10.42.171.7 with SMTP id h7mr4050425icz.350.1289793453920;
        Sun, 14 Nov 2010 19:57:33 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id 8sm6998418iba.22.2010.11.14.19.57.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 19:57:32 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 10:56:16 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <AANLkTimJKQ=xc7az+FEM+18aTxQ5zQ24q7pfChnSwt6f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161471>

Currently :path and ref:path can be used to refer to a specific object
in index or ref respectively. "path" component is absolute path. This
patch allows "path" to be written as "./path" or "../path", which is
relative to user's original cwd.

This does not work in commands for which startup_info is NULL
(i.e. non-builtin ones).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Fixed the error messages in resolve_relative_path()

 sha1_name.c                    |   38 ++++++++++++++++++++++--
 t/t1506-rev-parse-diagnosis.sh |   62 ++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 484081d..1d227d5 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1046,6 +1046,24 @@ int get_sha1_with_mode_1(const char *name, unsig=
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
+		die("Relative path syntax is not supported in this command.\n"
+		    "Please report to git@vger.kernel.org.");
+
+	if (!is_inside_work_tree())
+		die("Relative path syntax can't be used outside working tree.");
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
@@ -1060,25 +1078,31 @@ int get_sha1_with_context_1(const char *name, u=
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
@@ -1096,12 +1120,14 @@ int get_sha1_with_context_1(const char *name, u=
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
@@ -1122,6 +1148,11 @@ int get_sha1_with_context_1(const char *name, un=
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
@@ -1133,6 +1164,7 @@ int get_sha1_with_context_1(const char *name, uns=
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
1.7.3.2.210.g045198
