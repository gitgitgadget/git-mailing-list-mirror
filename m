From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/3] mmap(win32): avoid expensive fstat() call
Date: Fri, 22 Apr 2016 16:31:32 +0200 (CEST)
Message-ID: <54698524fa95e2f83167ca78205749f855bfaee6.1461335463.git.johannes.schindelin@gmx.de>
References: <cover.1461335463.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Sven Strickroth <email@cs-ware.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 16:32:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atc7k-0006bQ-U9
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbcDVObj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:31:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:51309 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754192AbcDVObi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:31:38 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MFdDB-1azKcr2nUz-00Ec2E; Fri, 22 Apr 2016 16:31:32
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1461335463.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:paaFp/qBmhGuKfvSCfV4H6vOpYkfB44OJA//pc7AAlzV+n56Ix3
 Zlrbo7ovYi1H86UPRRvbEwPeaBwCdx25A5+UENEYSt/znWlguh7vQaLnX82X+ZxaglME7dl
 cDz/gxy2+gEExBtrLY6/PLgC50U/H6I7k7UGPGilvBv+/wrsJHutSRKNFFZB5Jx5KtWxUA0
 HvpufhcBszQYcBslp+sTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:avceGcTz21g=:5cLVBYzCMU63pjCf+fDGlN
 nM3PA6eW6k9gKOsiSmByI1wyh6j/Z1mPg3LUIXD4CnNf9fpEF1TzO6dbkajVr28RiV5lKobU7
 VVSUUW9NBky3HFHdDYtkwURZ27KCf29pU23vGme6DCcXtC3kl1PphNu2Uxb59FWQSD8DXtcYX
 k/0Vm/omUNYGfTpwSXBovMevETyTU0/Va0n5AWM8XEArQLigaZpI6zcOcvUhRCr+6foml/9nd
 QbHbqIiechKnJk6ZNfztLS0lmZxNVv8dwZEkNwTj4gjjsjnFl1npSwQMnenvNxMNglFd+s1uk
 VMI+jS9s9ei5+6xvlYcamf6YwPFsAI+GOBO/J6lFkg2/qjAE9XcjWLsRhia2D435hgn7YBGaE
 FavwvWnKsqVswJ10nPDrasf9D+1z7Ke2n6jrYbbm6DS554S2P5zS0Uj0xnv+dTsJmXE7tsczB
 HJQIEAkiQHWk0rhgwoyeJ61EIB+Ucn4q5WQD77NG5/MhbJI3hzPIixM3FMbICsbJK3v0XO2UV
 QsBdaWEPEalzt418LQZI/yiW2zJmzU+7FMflQsTa72dyZXBayTr2IsXw215GSvEP8X4qy9Cm1
 Jo+NHuHWNwPyGzaasUGDEYf40rejmUAYvxbH5Asm4JSeG73s5p6Dv1HKSlkIFuEpOAA2ahlPf
 TOcconk15C/NzOTyIhpAI/KFlizgza1TJ+EqUouXDwQlQX2c0596LsEhYERxemiy9rzvaepUJ
 ZadkAH9WQdOD31bjL1Q9CXGFIJHN3iNabL88LhCVeacqKRZmc9/w3nwf2t6o2rCmKQPGgzox 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292209>

On Windows, we have to emulate the fstat() call to fill out information
that takes extra effort to obtain, such as the file permissions/type.

If all we want is the file size, we can use the much cheaper
GetFileSizeEx() function (available since Windows XP).

Suggested by Philip Kelley.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32mmap.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/compat/win32mmap.c b/compat/win32mmap.c
index b836169..519d51f 100644
--- a/compat/win32mmap.c
+++ b/compat/win32mmap.c
@@ -2,26 +2,24 @@
 
 void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
 {
-	HANDLE hmap;
+	HANDLE osfhandle, hmap;
 	void *temp;
-	off_t len;
-	struct stat st;
+	LARGE_INTEGER len;
 	uint64_t o = offset;
 	uint32_t l = o & 0xFFFFFFFF;
 	uint32_t h = (o >> 32) & 0xFFFFFFFF;
 
-	if (!fstat(fd, &st))
-		len = st.st_size;
-	else
+	osfhandle = (HANDLE)_get_osfhandle(fd);
+	if (!GetFileSizeEx(osfhandle, &len))
 		die("mmap: could not determine filesize");
 
-	if ((length + offset) > len)
-		length = xsize_t(len - offset);
+	if ((length + offset) > len.QuadPart)
+		length = xsize_t(len.QuadPart - offset);
 
 	if (!(flags & MAP_PRIVATE))
 		die("Invalid usage of mmap when built with USE_WIN32_MMAP");
 
-	hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
+	hmap = CreateFileMapping(osfhandle, NULL,
 		prot == PROT_READ ? PAGE_READONLY : PAGE_WRITECOPY, 0, 0, NULL);
 
 	if (!hmap) {
-- 
2.8.1.306.gff998f2
