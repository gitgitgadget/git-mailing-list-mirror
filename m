From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH] Improve the filemode trustability check
Date: Wed, 19 Nov 2014 16:10:48 +0100
Message-ID: <546CB2F8.7040501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 16:10:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xr6uF-0002VZ-IF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 16:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbaKSPKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Nov 2014 10:10:51 -0500
Received: from mout.web.de ([212.227.17.11]:58636 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512AbaKSPKu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 10:10:50 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Ldn2d-1YI9z12aCx-00ixuQ; Wed, 19 Nov 2014 16:10:48
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:YjSj02LvWWp1mWfYaIuCGvTNRA3jg080CXfQjaHWrf2q+TMX0XD
 s1H4VqPTVil88nmoUsiLdFI5ujZ8AeEZ2m35rpnekOviY8f9ZBsZew4vaNoo5XbGW340j9i
 M4MAOp3qRh8PAvNfCgorD5TauU79WBtHu7b7xLRD0ZdpzqBxC9vPQSqxdSCdbd+gjcqRa7G
 j3B4w9/Kb6lHIPBVGXOvQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some file systems do not support the executable bit:
a) The user executable bit is always 0, e.g. VFAT mounted with -onoexec
b) The user executable bit is always 1, e.g. cifs mounted with -ofile_m=
ode=3D0755
c) There are system where user executable bit is 1 even if it should be=
 0
   like b), but the file mode can be maintained locally. chmod -x chang=
es the
   file mode from 0766 to 0666, until the file system is unmounted and
   remounted and the file mode is 0766 again.
   This been observed when a Windows machine with NTFS exports a share =
to
   Mac OS X via smb or afp.

Case a) and b) are handled by the current code.
Case c) qualifies as "non trustable executable bit" and core.filemode
should be false, but this is not done.

Solution:
Detect when ".git/config" has the user executable bit set after
creat(".git/config", 0666) and set core.filemode to false.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

This should go on top of "mh/config-flip-xbit-back-after-checking"

Michael, thanks for the test case.
And no, I havent seen any systems with behaving like d)

 builtin/init-db.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index aab44d2..9b50dde 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -252,10 +252,10 @@ static int create_default_files(const char *templ=
ate_path)
 	filemode =3D TEST_FILEMODE;
 	if (TEST_FILEMODE && !lstat(path, &st1)) {
 		struct stat st2;
-		filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
+		filemode =3D (!chmod(path, st1.st_mode | S_IXUSR) &&
 				!lstat(path, &st2) &&
 				st1.st_mode !=3D st2.st_mode &&
-				!chmod(path, st1.st_mode));
+				!chmod(path, st1.st_mode & (~S_IXUSR)));
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
=20
--=20
1.9.1.dirty
