From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/3] mmap(win32): avoid copy-on-write when it is
 unnecessary
Date: Fri, 22 Apr 2016 16:31:26 +0200 (CEST)
Message-ID: <3e2a45e60e2905f52f962604cf19a0e5e39b9b1b.1461335463.git.johannes.schindelin@gmx.de>
References: <cover.1461335463.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Sven Strickroth <email@cs-ware.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 16:31:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atc7i-0006bQ-WA
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbcDVObg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:31:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:52966 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961AbcDVObd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:31:33 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MbOoG-1bCNS741gq-00ImLD; Fri, 22 Apr 2016 16:31:28
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1461335463.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:jwV5Q7wdYTFAI0WW196b+d5qfrUaHtgTw6uPnZPHYY++Ob0Hg9s
 CO66fC01+JA5c1eBpkE+Ex7l8ePOiEfJ5Ydn9j62miOyxiiB5cCK9khyrsa+zDuJT65KV33
 dGq7OHpXwoW3gJv0FoQQpUOhMEcaepfZJZePeNFfqyE6r7lK1h4b8U9gqr+M4mdJ+0gxuwY
 qrELHDx8VTtB/mCH6Retw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Txv7hpVRhEE=:FSiHCGeFG8VgeYhgbYzUmE
 Ad0vvvbseWhTpGpMXU23oHKXPnv/ckPZVDgE1dkfEtxR6kHUtwspIUxUFNsipOvOz8AJPGLhE
 YZ+aScGO07rQYKnkDoNovBKhZG481Kr/z90qKnrjUBN6jGG4s8U2DMvTdwhYaaMhm1uxaUoCJ
 Bc8oXJGPxFOnJDnyF2ODum0fvDTiQhnj/ptNTihK4I14vkOkV1+Cav/CzfCuwZRI1AFuaJEHe
 qFechvJ4cE1ODzqjQqqYRUmd/4KjWYRwFwdRVo3Oi1DK1TA1Hc5n02z16lVELQ6prWNh2gqJN
 nX3Bx8ZfFl0EPjYIk2M8t3HsPO7pjrvmp4NdxMarmnVeuFVferW9rTS/O22JVfIVTSzEKPvNn
 bwQ5TpQUyxwsiQOBn30itDRul/w8nvZp1I4RpZwvP6sfVZnHMbmBuGYBOpfdbrb4JYlN4MwmQ
 dJgYfdioRwlbkld7Y7spxgnw/5caHGUiPGPRZ70ylh/IwUnqSr6negNSaAqOLGuf+CbEIZfGs
 hzzovOGV/kTUx+Q2cnoX26OSl9kmcmok8mNu/HkZlYDp3YCltUKoJux6qonv97Nr8HJyKP6eu
 bC3bn3gEUK+LLEPWtYt90JnLpvY8sxIxUF69FfCSFZuI6yaqRth8J8PCeaGs0fhaAd8n8XrMz
 n/8Fsba7YU3xYRPhrC6KkEYSL3vURGacYXbn/UNfAC02idmAl9P99eHit9UDR9YbVuL/DNp2W
 Bps3pEhkMspTQkECf7xpSMeZhwc4bM6eZD4aNMO6DqMFm+YlnS9P3mpRj49w4rSf1ecLuvKA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292208>

Often we are mmap()ing read-only. In those cases, it is wasteful to map in
copy-on-write mode. Even worse: it can cause errors where we run out of
space in the page file.

So let's be extra careful to map files in read-only mode whenever
possible.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/win32mmap.c b/compat/win32mmap.c
index 3a39f0f..b836169 100644
--- a/compat/win32mmap.c
+++ b/compat/win32mmap.c
@@ -22,14 +22,15 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 		die("Invalid usage of mmap when built with USE_WIN32_MMAP");
 
 	hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
-		PAGE_WRITECOPY, 0, 0, NULL);
+		prot == PROT_READ ? PAGE_READONLY : PAGE_WRITECOPY, 0, 0, NULL);
 
 	if (!hmap) {
 		errno = EINVAL;
 		return MAP_FAILED;
 	}
 
-	temp = MapViewOfFileEx(hmap, FILE_MAP_COPY, h, l, length, start);
+	temp = MapViewOfFileEx(hmap, prot == PROT_READ ?
+			FILE_MAP_READ : FILE_MAP_COPY, h, l, length, start);
 
 	if (!CloseHandle(hmap))
 		warning("unable to close file mapping handle");
-- 
2.8.1.306.gff998f2
