From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/22] resolve_symlink(): use a strbuf internally
Date: Tue,  1 Apr 2014 17:58:23 +0200
Message-ID: <1396367910-7299-16-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 18:00:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV16a-0002ve-1q
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 18:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbaDAP7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:52 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56293 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751887AbaDAP67 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:59 -0400
X-AuditID: 12074413-f79076d000002d17-eb-533ae2437007
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.58.11543.342EA335; Tue,  1 Apr 2014 11:58:59 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbJ027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:57 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqOv8yCrY4FYzr0XXlW4mi4beK8wW
	t1fMZ7b4dfgJu8WPlh5mB1aPv+8/MHnsnHWX3eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M7Ydukye0EzX8XSXbINjG3cXYycHBICJhKbelYxQthiEhfurWfrYuTiEBK4zCjR3fmN
	GcI5xiTRd3AOG0gVm4CuxKKeZiYQW0RATWJi2yEWEJtZIEXi1d9dYLawgKPEs++TWUFsFgFV
	iUMXXoP18gq4SNzZcpUdYpucxJTfC8BsTqD4pQd7wOqFBJwlTr9ZzDyBkXcBI8MqRrnEnNJc
	3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3UlNJNjJCQEt7BuOuk3CFGAQ5GJR7eA+etgoVYE8uK
	K3MPMUpyMCmJ8v64CxTiS8pPqcxILM6ILyrNSS0+xCjBwawkwjvrJlCONyWxsiq1KB8mJc3B
	oiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBG/UQqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1
	LyW1KLG0JCMeFBnxxcDYAEnxAO2dDtLOW1yQmAsUhWg9xagoJc4bApIQAElklObBjYUlileM
	4kBfCvMuBqniASYZuO5XQIOZgAZzrwMbXJKIkJJqYGy5W3f13Admo09+6nPfROlUTuTYpM19
	4Mrxt8dfbiy8xLxm9q7X/nHae3MNtReU3XuzKDonlnPCFq3j95l3r7eZ/ZdVRNQq67OQ++qH
	s/LuHAnJ67Mw1l2+YPO5WSkPa57vnbHPt2ZpiaXIo29Nsbd6PSdvX/HihumlXoaN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245608>

This removes another place where the path name is arbitrarily limited.

This gets rid of a warning

    %s: symlink too long

even though strbuf_readlink() in fact still limits the length of what
it can handle to something like 2*PATH_MAX.  But (1) the limit is now
much longer, and (2) strbuf_readlink() doesn't return enough
information to distinguish this problem from other symlink-reading
problems, so just let it go.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 931ebbd..0ade314 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -128,30 +128,25 @@ static void trim_last_path_elm(struct strbuf *path)
 static void resolve_symlink(struct strbuf *path)
 {
 	int depth = MAXDEPTH;
+	struct strbuf link;
+
+	strbuf_init(&link, path->len);
 
 	while (depth--) {
-		char link[PATH_MAX];
-		int link_len = readlink(path->buf, link, sizeof(link));
-		if (link_len < 0) {
-			/* not a symlink anymore */
-			return;
-		}
-		if (link_len >= sizeof(link)) {
-			warning("%s: symlink too long", path->buf);
-			return;
-		}
-		/* readlink() never null-terminates */
-		link[link_len] = '\0';
+		if (strbuf_readlink(&link, path->buf, path->len) < 0)
+			break;
 
-		if (is_absolute_path(link))
+		if (is_absolute_path(link.buf))
 			/* an absolute path replaces the whole path: */
 			strbuf_setlen(path, 0);
 		else
 			/* a relative path replaces the last element of path: */
 			trim_last_path_elm(path);
 
-		strbuf_add(path, link, link_len);
+		strbuf_addbuf(path, &link);
 	}
+
+	strbuf_release(&link);
 }
 
 /* We append ".lock" to the filename to derive the lockfile name: */
-- 
1.9.0
