From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 3/5] Fix GIT_CEILING_DIRECTORIES on Windows
Date: Sat,  7 Feb 2009 16:08:29 +0100
Message-ID: <1234019311-6449-4-git-send-email-j6t@kdbg.org>
References: <498CAF73.6050409@lsrfire.ath.cx>
 <1234019311-6449-1-git-send-email-j6t@kdbg.org>
 <1234019311-6449-2-git-send-email-j6t@kdbg.org>
 <1234019311-6449-3-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Sat Feb 07 16:17:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVow1-0006Xl-2w
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 16:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbZBGPPn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 10:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbZBGPPj
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 10:15:39 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:39636 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbZBGPPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 10:15:33 -0500
Received: from localhost.localdomain (unknown [93.83.142.38])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id ACD7B10A78D;
	Sat,  7 Feb 2009 16:08:32 +0100 (CET)
X-Mailer: git-send-email 1.6.1.297.g9b01e
In-Reply-To: <1234019311-6449-3-git-send-email-j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108860>

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

Using git with GIT_CEILING_DIRECTORIES crashed on Windows due to a fail=
ed
assertion in normalize_absolute_path(): This function expects absolute
paths to start with a slash, while on Windows they can start with a dri=
ve
letter or a backslash.

This fixes it by using the alternative, normalize_path_copy() instead,
which can handle Windows-style paths just fine.

Secondly, the portability macro PATH_SEP is used instead of expecting
colons to be used as path list delimiter.

The test script t1504 is also changed to help MSYS's bash recognize som=
e
program arguments as path list. (MSYS's bash must translate POSIX-style
path lists to Windows-style path lists, and the heuristic did not catch
some cases.)

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
	I have adjusted the patch to fit into the series.
	I modified the commit message to pretend that the goal was
	to fix a feature instead of the test case ;) Hope that is
	fine with you.

	-- Hannes

 path.c                  |   11 ++++++-----
 t/t1504-ceiling-dirs.sh |    6 +++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/path.c b/path.c
index d0a3519..dc3807a 100644
--- a/path.c
+++ b/path.c
@@ -524,15 +524,16 @@ int longest_ancestor_length(const char *path, con=
st char *prefix_list)
 		return -1;
=20
 	for (colon =3D ceil =3D prefix_list; *colon; ceil =3D colon+1) {
-		for (colon =3D ceil; *colon && *colon !=3D ':'; colon++);
+		for (colon =3D ceil; *colon && *colon !=3D PATH_SEP; colon++);
 		len =3D colon - ceil;
 		if (len =3D=3D 0 || len > PATH_MAX || !is_absolute_path(ceil))
 			continue;
 		strlcpy(buf, ceil, len+1);
-		len =3D normalize_absolute_path(buf, buf);
-		/* Strip "trailing slashes" from "/". */
-		if (len =3D=3D 1)
-			len =3D 0;
+		if (normalize_path_copy(buf, buf) < 0)
+			continue;
+		len =3D strlen(buf);
+		if (len > 0 && buf[len-1] =3D=3D '/')
+			buf[--len] =3D '\0';
=20
 		if (!strncmp(path, buf, len) &&
 		    path[len] =3D=3D '/' &&
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index 91b704a..e377d48 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -93,13 +93,13 @@ GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/subdi"
 test_prefix subdir_ceil_at_subdi_slash "sub/dir/"
=20
=20
-GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub"
+GIT_CEILING_DIRECTORIES=3D"/foo:$TRASH_ROOT/sub"
 test_fail second_of_two
=20
-GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/sub:bar"
+GIT_CEILING_DIRECTORIES=3D"$TRASH_ROOT/sub:/bar"
 test_fail first_of_two
=20
-GIT_CEILING_DIRECTORIES=3D"foo:$TRASH_ROOT/sub:bar"
+GIT_CEILING_DIRECTORIES=3D"/foo:$TRASH_ROOT/sub:/bar"
 test_fail second_of_three
=20
=20
--=20
1.6.1.297.g9b01e
