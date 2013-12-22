From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/5] safe_create_leading_directories(): fix a mkdir/rmdir race
Date: Sun, 22 Dec 2013 08:14:10 +0100
Message-ID: <1387696451-32224-5-git-send-email-mhagger@alum.mit.edu>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 22 08:15:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VudFq-0006b7-SY
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 08:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab3LVHPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 02:15:03 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64389 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752543Ab3LVHOl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Dec 2013 02:14:41 -0500
X-AuditID: 12074412-b7fc96d0000023d5-48-52b691615404
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FB.60.09173.16196B25; Sun, 22 Dec 2013 02:14:41 -0500 (EST)
Received: from michael.fritz.box (p57A25B75.dip0.t-ipconnect.de [87.162.91.117])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBM7ERFO023935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 22 Dec 2013 02:14:40 -0500
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqJs4cVuQwdZjohZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3RvGYNS8ET3opZh6eyNDBe
	5+pi5OSQEDCRePftGBOELSZx4d56NhBbSOAyo8SWS6ldjFxA9gkmiTNH5rCDJNgEdCUW9TSD
	NYgIqElMbDvEAmIzCzhIbP7cyAhiCwv4Sez8cQksziKgKvHteQ9zFyMHB6+Ai8Tn1dkQuxQk
	9l06CTaGU8BVYuqXjawQe10kdrx6xDSBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0z
	vdzMEr3UlNJNjJBAEdrBuP6k3CFGAQ5GJR7eDLFtQUKsiWXFlbmHGCU5mJREebknAIX4kvJT
	KjMSizPii0pzUosPMUpwMCuJ8K5xBcrxpiRWVqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1I
	LYLJynBwKEnweoMMFSxKTU+tSMvMKUFIM3FwgggukA08QBtSQQp5iwsSc4sz0yGKTjEqSonz
	RoEkBEASGaV5cANgMf2KURzoH2HeDJAqHmA6gOt+BTSYCWiw8dpNIINLEhFSUg2MYQGfYo/8
	eyRv9mbR5F6loxq9U17q7tIrWZTx6zjL+vvrZuW5bLhRzOxhtetfz/8fZTcvL0wxdA0JPjp1
	omNabe+So5u32/wyFl4YXvZldVxj+Nt17LfFjI56blqcrlAntvuG2IG7yX8PL1zbuv9hqP3s
	vyyLpXy1clin7+A8LBl2tJf3Z5FIpBJLcUaioRZzUXEiAJpd6czEAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239637>

It could be that some other process is trying to clean up empty
directories at the same time that safe_create_leading_directories() is
attempting to create them.  In this case, it could happen that
directory "a/b" was present at the end of one iteration of the loop
(either it was already present or we just created it ourselves), but
by the time we try to create directory "a/b/c", directory "a/b" has
been deleted.  In fact, directory "a" might also have been deleted.

So, if a call to mkdir() fails with ENOENT, then try checking/making
all directories again from the beginning.  Attempt up to three times
before giving up.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index dcfd35a..abcb56b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -108,6 +108,7 @@ int mkdir_in_gitdir(const char *path)
 int safe_create_leading_directories(char *path)
 {
 	char *next_component = path + offset_1st_component(path);
+	int attempts = 3;
 	int retval = 0;
 
 	while (!retval && next_component) {
@@ -132,6 +133,16 @@ int safe_create_leading_directories(char *path)
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
 				; /* somebody created it since we checked */
+			} else if (errno == ENOENT && --attempts) {
+				/*
+				 * Either mkdir() failed bacause
+				 * somebody just pruned the containing
+				 * directory, or stat() failed because
+				 * the file that was in our way was
+				 * just removed.  Either way, try
+				 * again from the beginning:
+				 */
+				next_component = path + offset_1st_component(path);
 			} else {
 				retval = -1;
 			}
-- 
1.8.5.1
