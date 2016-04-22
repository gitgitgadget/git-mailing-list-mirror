From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/3] win32mmap: set errno appropriately
Date: Fri, 22 Apr 2016 16:31:22 +0200 (CEST)
Message-ID: <ff12776a7f76c0e924222a0a04b0ae6f571b571c.1461335463.git.johannes.schindelin@gmx.de>
References: <cover.1461335463.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Sven Strickroth <email@cs-ware.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 16:31:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atc7K-0006JT-Be
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015AbcDVOba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:31:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:64296 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961AbcDVOb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:31:29 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LynHb-1bpmnM2OZj-016Bd3; Fri, 22 Apr 2016 16:31:23
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1461335463.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:fZY4VoCaad9720wjXWVJH411y8y8E5ozP0CnjqlRiWRy1Wyh9F3
 7PBxd7Vx/JddkH4KD0EjyIt1ZJuQSicvcZOFE4u3aKJY7xM7UWRaIb0HXmR4edR6yOf/7Ha
 VTV2modHw2S416aJnpE/VJc1iIyo9N0MvFg/46WoyAYy7V6RvXw/qkloHwThynW5MDff0Uj
 WyOvN+2AYDLlkS7lgdoNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g2xDu7HxZS8=:Ig806JIexZIY/MearSrXfs
 Cs/eTldGoSQZd+kv1iAmjk4beGdVCtrPt73t/xCBJ12kLOaZ6EKITD8ilbUKYJ/Hq9nk3Zg9N
 5WhwuKFl5CNqObyn6EVZfJu58I8Zd1PLM1F1AvDhVAAaw7ST+j/uFQeZwI/uH4vvY35P9Q79C
 vhJJg3R34ips9UZAqOZBJoFsaCVilW0ndAlfWrJ1bDZR2qYctaRKw6gWfVZ/G06j6Wo33dWFp
 sn7t4JU7Yjg/YPG/+IiRJ7gWNlROUzt367qrhhsAXUe8sWm97vwympzGMbYU1svatCyvmvk1I
 pFSiaot9Bjgm5HLshf5Aps1BazKCNVlS8KPDwqU0tcp6WKZsFcp6iS13efZW7uciyip9+3Kvq
 g033iXEK1QcSD1lydOhTENV3bfOz0jyDYRvJT78LS9f+FKJNfKgiFAKWojJakJV6wEC/YLuQT
 wSlAziFAPEI5zvU1aKEGNHCM7BmDgGc1rGreX7ToSKiK0KZoivE/UiPvDNbZXiqUVmI7CVOP/
 JIdP0tsXdZwmjV5onMipeRON3141ptaYF1YwS8NcTTYYWYve0/sGXsNwYMmg/DkMO9sLY3Y2/
 vXJx2MZUIyh/bsCl6QjGuXLNjHVixsEd+dEUQnOBiDrMNq9w2hujF9Uz6EvJwVCKY3NovzGKZ
 0QT05nHKWHSxGyUNx5Ehm91zSr49q9jHW7Taor04L/xSnq6ZY4IKdx3iPF05dUwbunDLH6aOj
 ex4SYyi/27UXH6fdMdGOxhuBcax4cb7ElCgw3Lb8P/SZRh2GiFTKxTclzhN0vsSXGr2ucOBL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292206>

It is not really helpful when a `git fetch` fails with the message:

	fatal: mmap failed: No error

In the particular instance encountered by a colleague of yours truly,
the Win32 error code was ERROR_COMMITMENT_LIMIT which means that the
page file is not big enough.

Let's make the message

	fatal: mmap failed: File too large

instead, which is only marginally better, but which can be associated
with the appropriate work-around: setting `core.packedGitWindowSize` to
a relatively small value.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32mmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/compat/win32mmap.c b/compat/win32mmap.c
index 80a8c9a..3a39f0f 100644
--- a/compat/win32mmap.c
+++ b/compat/win32mmap.c
@@ -24,15 +24,21 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 	hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
 		PAGE_WRITECOPY, 0, 0, NULL);
 
-	if (!hmap)
+	if (!hmap) {
+		errno = EINVAL;
 		return MAP_FAILED;
+	}
 
 	temp = MapViewOfFileEx(hmap, FILE_MAP_COPY, h, l, length, start);
 
 	if (!CloseHandle(hmap))
 		warning("unable to close file mapping handle");
 
-	return temp ? temp : MAP_FAILED;
+	if (temp)
+		return temp;
+
+	errno = GetLastError() == ERROR_COMMITMENT_LIMIT ? EFBIG : EINVAL;
+	return MAP_FAILED;
 }
 
 int git_munmap(void *start, size_t length)
-- 
2.8.1.306.gff998f2
