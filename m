From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH]     Allow git mv FileA fILEa when core.ignorecase = true
Date: Fri, 4 Mar 2011 22:40:38 +0100
Message-ID: <201103042240.38969.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 22:41:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvck6-0004lj-Ix
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 22:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760226Ab1CDVkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 16:40:53 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:56941 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760219Ab1CDVkw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 16:40:52 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id C148819A16EA6
	for <git@vger.kernel.org>; Fri,  4 Mar 2011 22:40:40 +0100 (CET)
Received: from [213.64.3.195] (helo=maxi.localnet)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Pvcjo-0006H6-00; Fri, 04 Mar 2011 22:40:40 +0100
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX18UyGmfAT99jF/kJIs6DNQN3cYPrARBH+D2K7z1
	9tjYzH6P3U3K0KtsfEZpVJVSXxrbso7bt6JNaFgH7eA7At6Oa7
	SCaWYrZcg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168468>

    The typical use case is when a file "FileA" should be renamed into =
fILEa
    and we are on a case insenstive file system (system core.ignorecase=
 =3D true).
    Source and destination are the same file, it can be accessed under =
both names.
    This makes git think that the destination file exists.
    Unless used with --forced, git will refuse the "git mv FileA fILEa"=
=2E
    This change will allow "git mv FileA fILEa", when core.ignorecase =3D=
 true
    and source and destination filenames only differ in case and the fi=
le length
    is identical.
    On Linux/Unix/Mac OS X the mv is allowed when the inode of the sour=
ce and
    destination are equal.
    On  this allows renames of M=C3=84RCHEN into M=C3=A4rchen on Mac OS=
 X.
    (As a side effect, a file can be renamed to a name which is already
    hard-linked to the same inode)

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 builtin/mv.c  |   20 +++++++++++++++-----
 t/t7001-mv.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 93e8995..e0aad62 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -62,7 +62,7 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 	};
 	const char **source, **destination, **dest_path;
 	enum update_mode { BOTH =3D 0, WORKING_DIRECTORY, INDEX } *modes;
-	struct stat st;
+	struct stat st, st_dst;
 	struct string_list src_for_dst =3D STRING_LIST_INIT_NODUP;
=20
 	git_config(git_default_config, NULL);
@@ -164,15 +164,25 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 			}
 		} else if (cache_name_pos(src, length) < 0)
 			bad =3D "not under version control";
-		else if (lstat(dst, &st) =3D=3D 0) {
+		else if (lstat(dst, &st_dst) =3D=3D 0) {
+			int allow_force =3D force;
 			bad =3D "destination exists";
-			if (force) {
+			/* Allow when src and dst have the same inode (Mac OS X) */
+			/* Allow when ignore_case and same file length (Windows) */
+			if (((st_dst.st_ino) && (st_dst.st_ino =3D=3D st.st_ino)) ||
+					((ignore_case) && !strcasecmp(src, dst) &&
+					 (st.st_size =3D=3D st_dst.st_size))) {
+				allow_force =3D 1;
+				bad =3D NULL;
+			}
+			if (allow_force) {
 				/*
 				 * only files can overwrite each other:
 				 * check both source and destination
 				 */
-				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
-					warning("%s; will overwrite!", bad);
+				if (S_ISREG(st_dst.st_mode) || S_ISLNK(st_dst.st_mode)) {
+					if (bad)
+						warning("%s; will overwrite!", bad);
 					bad =3D NULL;
 				} else
 					bad =3D "Cannot overwrite";
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index a845b15..d0e73ee 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -255,4 +255,33 @@ test_expect_success SYMLINKS 'git mv should overwr=
ite file with a symlink' '
=20
 rm -f moved symlink
=20
+touch x
+if ln x y 2>/dev/null; then
+	hardlinks=3D1
+fi
+rm -f x y
+
+if test "$(git config --bool core.ignorecase)" =3D true -o "$hardlinks=
"; then
+	test_expect_success 'git mv FileA fILEa' '
+
+		rm -fr .git * &&
+		git init &&
+		echo FileA > FileA &&
+		git add FileA &&
+		git commit -m add FileA &&
+		{
+			if ! test -f fILEa; then
+				ln FileA fILEa
+			fi
+		} &&
+		git mv FileA fILEa &&
+		git commit -m "mv FileA fILEa" &&
+		rm -f FileA fILEa &&
+		git reset --hard &&
+		test "$(echo *)" =3D fILEa
+	'
+else
+	say "Neither ignorecase nor hardlinks, skipping git mv FileA fILEa"
+fi
+
 test_done
--=20
1.7.4
