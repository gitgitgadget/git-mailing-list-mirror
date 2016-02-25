From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/20] try_remove_empty_parents(): don't accommodate consecutive slashes
Date: Thu, 25 Feb 2016 14:16:14 +0100
Message-ID: <c9ae141d685e6ab835838252b726c5da519cb0fd.1456405699.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:17:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvnG-00043N-6N
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760565AbcBYNQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:16:57 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:65125 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760498AbcBYNQ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:16:56 -0500
X-AuditID: 12074413-f03ff7000000516b-32-56cefec70cda
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 12.F0.20843.7CEFEC65; Thu, 25 Feb 2016 08:16:55 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPrt024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:53 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqHv837kwg9l9shbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8bcPTuYChrZK2Ys6WdsYFzL2sXIySEhYCLxdO8m
	IJuLQ0hgK6PE5dVN7CAJIYETTBIvjnmD2GwCuhKLepqZQGwRATWJiW2HWEAamAUeMUp07d/O
	CJIQFoiWaH7yiRnEZhFQlZjwbiMbiM0rECWxpXkJ1DY5iZYfu8FsTgELiYsnpzNDLDOXWHVj
	D/sERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MUJCTHgH466TcocY
	BTgYlXh4I36fDRNiTSwrrsw9xCjJwaQkyrvn+bkwIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
	K/4C5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzMwFgSEixKTU+t
	SMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFQHwxMApAUjxAexVB2nmLCxJzgaIQracYdTkW
	/Li9lkmIJS8/L1VKnHc5yHECIEUZpXlwK2AJ5RWjONDHwryaIKN4gMkIbtIroCVMQEtmbgBb
	UpKIkJJqYKz4usuud7dqj2yzzlKOz299u9ed8fy6ueTS6md2BuKCrErnzhxeePv73u2OSfuq
	Yk/uOv/p/LKpBtuD9Jsz07mzbJdvjox6t5XztPEWy3PyjsvU9Vs9Gt+ee+h+JTfv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287379>

"refname" has already been checked by check_refname_format(), so it
cannot have consecutive slashes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1fcbb6f..46dcc23 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2212,15 +2212,14 @@ static void try_remove_empty_parents(const char *refname)
 	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
-		/* tolerate duplicate slashes; see check_refname_format() */
-		while (*p == '/')
+		if (*p == '/')
 			p++;
 	}
 	q = buf.buf + buf.len;
 	while (1) {
 		while (q > p && *q != '/')
 			q--;
-		while (q > p && *(q-1) == '/')
+		if (q > p && *(q-1) == '/')
 			q--;
 		if (q == p)
 			break;
-- 
2.7.0
