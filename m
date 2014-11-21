From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH v3] Improve the filemode trustability check
Date: Fri, 21 Nov 2014 10:34:54 +0100
Message-ID: <546F073E.5050605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 10:35:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrkcR-0007U9-3O
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 10:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758482AbaKUJfD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Nov 2014 04:35:03 -0500
Received: from mout.web.de ([212.227.17.11]:53340 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758476AbaKUJfA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 04:35:00 -0500
Received: from birne.local ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M5Oct-1Y9qjl2yrf-00zUbh; Fri, 21 Nov 2014 10:34:58
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:rD4/iHNZJVi/qDV8MZkA2YUHKq0LuKRrlzxFu9rOOmb1mDcZ1hB
 vVNP51H6YtBS84/a4OVEp8ZQHBOPWkmLby/U+gwDhrOyFUTxKwqTyncD5soBNR9icCF8VlI
 rjs+a7J6CGMWnA1gYQQwCqICWQhsm1uuaiZSc44ptsWCBTxrrY3N6P1SgqhOuWQyW9hmsoW
 KgM7NhLKtdVPhZw1FrzPQ==
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

Thanks for the review, I never paid attention to the re-init.
The following works for me:

 builtin/init-db.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index aab44d2..2619ca5 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -256,6 +256,8 @@ static int create_default_files(const char *templat=
e_path)
 				!lstat(path, &st2) &&
 				st1.st_mode !=3D st2.st_mode &&
 				!chmod(path, st1.st_mode));
+		if (filemode && !reinit && (st1.st_mode & S_IXUSR))
+			filemode =3D 0;
 	}
 	git_config_set("core.filemode", filemode ? "true" : "false");
=20
--=20
2.0.0.GIT
