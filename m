From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/3] prune-packed: fix a possible buffer overflow
Date: Tue, 17 Dec 2013 14:43:56 +0100
Message-ID: <1387287838-25779-2-git-send-email-mhagger@alum.mit.edu>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 14:44:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsuwq-0003YA-T8
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 14:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab3LQNo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 08:44:28 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48096 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753207Ab3LQNo1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 08:44:27 -0500
X-AuditID: 12074412-b7fc96d0000023d5-ac-52b0553acbed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.A7.09173.A3550B25; Tue, 17 Dec 2013 08:44:26 -0500 (EST)
Received: from michael.fritz.box (p57A24733.dip0.t-ipconnect.de [87.162.71.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBHDiIKt024888
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Dec 2013 08:44:25 -0500
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqGsVuiHI4OouTYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7omjqbreAiX8W5xp/MDYzb
	uLsYOTgkBEwkGu6GdzFyApliEhfurWfrYuTiEBK4zChx8O4uRgjnOJPE0SWLWEGq2AR0JRb1
	NDOB2CICahIT2w6xgNjMAg4Smz83MoLYwgKOEh+nLmUGsVkEVCVWr7rABmLzCrhIPHg5mQVi
	m4LEvksnweZwCrhK/LjzEcwWAqpp/DSPdQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealF
	umZ6uZkleqkppZsYIaEitINx/Um5Q4wCHIxKPLwbZqwPEmJNLCuuzD3EKMnBpCTKe9ZlQ5AQ
	X1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4HgUA53pTEyqrUonyYlDQHi5I478/F6n5CAumJJanZ
	qakFqUUwWRkODiUJ3sgQoEbBotT01Iq0zJwShDQTByeI4ALZwAO04WYwyIbigsTc4sx0iKJT
	jIpS4rzFIBMEQBIZpXlwA2BR/YpRHOgfYd5YkCoeYEKA634FNJgJaPDzNetABpckIqSkGhhn
	CR/0eLr2gdPJuLAar6hJrb2P5gWr/Xwg//QDv5PKmp2yyhnSs93DJ871DXro013NIXh13rF8
	zRn2Vb22/s9mca8/8r6uT2W/IM+Kl933pwSujGLxr7bYaSvse6HpV0f1pGuRP+VT5xm2vVF6
	Ytf3Y0/N3A/enAy2Prmbp1lEvkifX2ComaXEUpyRaKjFXFScCADoShStxQIAAA== 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239383>

The pathname character array might hold:

    strlen(pathname) -- the pathname argument
    '/'              -- a slash, if not already present in pathname
    %02x/            -- the first two characters of the SHA-1 plus slash
    38 characters    -- the last 38 characters of the SHA-1
    NUL              -- terminator
    ---------------------
    strlen(pathname) + 43

(Actually, the NUL character is not written explicitly to pathname;
rather, the code relies on pathname being initialized to zeros and the
zero following the pathname still being there after the other
characters are written to the array.)

But the old pathname variable was PATH_MAX characters long, whereas
the check was (len > PATH_MAX - 42).  So there might have been one
byte too many stored in pathname.  This would have resulted in it's
not being NUL-terminated.

So, increase the size of the pathname variable by one byte to avoid
this possibility.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/prune-packed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index fa6ce42..81bc786 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -37,7 +37,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 void prune_packed_objects(int opts)
 {
 	int i;
-	static char pathname[PATH_MAX];
+	static char pathname[PATH_MAX + 1];
 	const char *dir = get_object_directory();
 	int len = strlen(dir);
 
@@ -45,7 +45,7 @@ void prune_packed_objects(int opts)
 		progress = start_progress_delay("Removing duplicate objects",
 			256, 95, 2);
 
-	if (len > PATH_MAX - 42)
+	if (len + 42 > PATH_MAX)
 		die("impossible object directory");
 	memcpy(pathname, dir, len);
 	if (len && pathname[len-1] != '/')
-- 
1.8.5.1
