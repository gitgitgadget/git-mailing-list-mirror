From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/17] safe_create_leading_directories(): add explicit "slash" pointer
Date: Sat, 18 Jan 2014 23:48:47 +0100
Message-ID: <1390085341-2553-4-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eiG-0005CE-0w
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbaARWtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:49 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47715 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751696AbaARWtd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:33 -0500
X-AuditID: 1207440d-b7f4c6d000004a16-69-52db04fc968b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id FC.7E.18966.CF40BD25; Sat, 18 Jan 2014 17:49:32 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN8u030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:31 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqPuH5XaQweKzUhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ1x7vYhxoKZ3BVdnTvZGhj7
	OboYOTkkBEwk9jUuYYGwxSQu3FvP1sXIxSEkcJlR4vmrhVDOCSaJL4c+sYNUsQnoSizqaWYC
	sUUE1CQmth0C62YWcJDY/LmREcQWFoiUOLirAayGRUBVYvK3RWA1vALOEpPOXgOKcwBtU5BY
	fV0IJMwp4CJxZP4FsHIhoJKbr5+wT2DkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10gv
	N7NELzWldBMjJFR4dzD+XydziFGAg1GJh/cA0+0gIdbEsuLK3EOMkhxMSqK8yiAhvqT8lMqM
	xOKM+KLSnNTiQ4wSHMxKIrzBG24FCfGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQW
	wWRlODiUJHi9gTEhJFiUmp5akZaZU4KQZuLgBBFcIBt4QDaAFPIWFyTmFmemQxSdYlSUEucN
	B0kIgCQySvPgBsCi+hWjONA/wrxSIFU8wIQA1/0KaDAT0GCR2Jsgg0sSEVJSDYzqS5zEygI0
	PW7o/NTatCntrOOq/+IPH4ss7p39+EXFll2zri2N3fG5to3tUcq3ycp202elcs/4ckAgo+L/
	jPP2Kj3acrLTlLfUT1l/oaLvprmNv9OyOaqqX/6t3M9407Xb8dK6vTMOziibVhZRq9p7Zq/b
	v0Xfd0p3LT10aMNMhpdXI/9seOPKq8RSnJFoqMVcVJwIAKttwf7FAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240660>

Keep track of the position of the slash character independently of
"pos", thereby making the purpose of each variable clearer and
working towards other upcoming changes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d8647c7..88b8d8c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -111,19 +111,21 @@ int safe_create_leading_directories(char *path)
 
 	while (pos) {
 		struct stat st;
+		char *slash = strchr(pos, '/');
 
-		pos = strchr(pos, '/');
-		if (!pos)
+		if (!slash)
 			break;
-		while (*++pos == '/')
-			;
+		while (*(slash + 1) == '/')
+			slash++;
+		pos = slash + 1;
 		if (!*pos)
 			break;
-		*--pos = '\0';
+
+		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
 			if (!S_ISDIR(st.st_mode)) {
-				*pos = '/';
+				*slash = '/';
 				return -3;
 			}
 		} else if (mkdir(path, 0777)) {
@@ -131,14 +133,14 @@ int safe_create_leading_directories(char *path)
 			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
 				; /* somebody created it since we checked */
 			} else {
-				*pos = '/';
+				*slash = '/';
 				return -1;
 			}
 		} else if (adjust_shared_perm(path)) {
-			*pos = '/';
+			*slash = '/';
 			return -2;
 		}
-		*pos++ = '/';
+		*slash = '/';
 	}
 	return 0;
 }
-- 
1.8.5.2
