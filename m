From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/17] safe_create_leading_directories(): always restore slash at end of loop
Date: Sat, 18 Jan 2014 23:48:50 +0100
Message-ID: <1390085341-2553-7-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:49:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4ei2-00054S-Cg
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbaARWtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:42 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42701 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709AbaARWth (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:37 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-32-52db04ff73cc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 77.A7.19161.FF40BD25; Sat, 18 Jan 2014 17:49:35 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN8x030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:35 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqPuf5XaQwdsDVhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ1xcPc+9oKbPBWT9m1nbmA8
	ztnFyMEhIWAise0UUxcjJ5ApJnHh3nq2LkYuDiGBy4wS97suMoMkhAROMEmcmB8AYrMJ6Eos
	6mkGaxARUJOY2HaIBcRmFnCQ2Py5kRHEFhZIkPhzbT4riM0ioCrx+u5kdhCbV8BZ4uLa28wQ
	exUkVl8XAglzCrhIHJl/gQlilbPEzddP2Ccw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5da
	pGusl5tZopeaUrqJERImfDsY29fLHGIU4GBU4uE9wHQ7SIg1say4MvcQoyQHk5IorzJIiC8p
	P6UyI7E4I76oNCe1+BCjBAezkghv8IZbQUK8KYmVValF+TApaQ4WJXFetSXqfkIC6Yklqdmp
	qQWpRTBZGQ4OJQleb2A8CAkWpaanVqRl5pQgpJk4OEEEF8gGHpANIIW8xQWJucWZ6RBFpxgV
	pcR55UESAiCJjNI8uAGwiH7FKA70jzBvOEgVDzAZwHW/AhrMBDRYJPYmyOCSRISUVAPjsjsH
	Xz+qWPC8+5awIc/n5ckxU9waY27t+vtfQselP+jS+tnrT+f98F29qtbChCW/SnPWq2Z9BV5D
	K9awI0dlP7PF74sMnPkq3nLytd/WJ9jvz5G2Myt2PHByfUv959un3wn197RfiZyj3reubeXt
	03osk8R2rWNXln6T+ZHvWd9NEafOUzpuSizFGYmGWsxFxYkAU0UZUsMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240655>

Always restore the slash that we scribbled over at the end of the
loop, rather than also fixing it up at each premature exit from the
loop.  This makes it harder to forget to do the cleanup as new paths
are added to the code.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9d4459f..80122b2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -108,8 +108,9 @@ int mkdir_in_gitdir(const char *path)
 int safe_create_leading_directories(char *path)
 {
 	char *next_component = path + offset_1st_component(path);
+	int ret = 0;
 
-	while (next_component) {
+	while (!ret && next_component) {
 		struct stat st;
 		char *slash = strchr(next_component, '/');
 
@@ -125,25 +126,20 @@ int safe_create_leading_directories(char *path)
 		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
-			if (!S_ISDIR(st.st_mode)) {
-				*slash = '/';
-				return -3;
-			}
+			if (!S_ISDIR(st.st_mode))
+				ret = -3;
 		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
-			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
+			    !stat(path, &st) && S_ISDIR(st.st_mode))
 				; /* somebody created it since we checked */
-			} else {
-				*slash = '/';
-				return -1;
-			}
+			else
+				ret = -1;
 		} else if (adjust_shared_perm(path)) {
-			*slash = '/';
-			return -2;
+			ret = -2;
 		}
 		*slash = '/';
 	}
-	return 0;
+	return ret;
 }
 
 int safe_create_leading_directories_const(const char *path)
-- 
1.8.5.2
