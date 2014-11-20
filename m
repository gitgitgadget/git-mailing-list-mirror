From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v2] Improve the filemode trustability check
Date: Thu, 20 Nov 2014 12:49:03 +0100
Message-ID: <546DD52F.90302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 20 12:49:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrQEf-0007nZ-H4
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 12:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbaKTLtM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2014 06:49:12 -0500
Received: from mout.web.de ([212.227.15.4]:64848 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbaKTLtL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 06:49:11 -0500
Received: from birne.local ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MeScR-1Xb7Mp1A9H-00QFOd; Thu, 20 Nov 2014 12:49:08
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:IpvVPTX9KmVsP0uwaCoaSnmrHGP2soLqTVfWO8BPGHphvHvOAbh
 3eM96jvmu7efHVC3nWMh7fzEktGjcveJ9JV0p+0wSoam9Q0ogQVUyiVa9r7pUiuvRp4CJZb
 6877ZFDd1Snn55ux+UfX/3PrzYIU277Qki1KtB5dZFahrc/0Cw4FwNU3jviMrAb+JzQi8ha
 Ek52TTk4u/VpDUM6pMGkQ==
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
should be false, but this is currently not done.

Detect when ".git/config" has the user executable bit set after
creat(".git/config", 0666) and set core.filemode to false.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since V1:
- Improved commit msg (hopefully)
- Simplified the patch
 builtin/init-db.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index aab44d2..195a88b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -252,7 +252,8 @@ static int create_default_files(const char *templat=
e_path)
 	filemode =3D TEST_FILEMODE;
 	if (TEST_FILEMODE && !lstat(path, &st1)) {
 		struct stat st2;
-		filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
+		filemode =3D (!(st1.st_mode & S_IXUSR) &&
+				!chmod(path, st1.st_mode ^ S_IXUSR) &&
 				!lstat(path, &st2) &&
 				st1.st_mode !=3D st2.st_mode &&
 				!chmod(path, st1.st_mode));
--=20
2.0.0.GIT
