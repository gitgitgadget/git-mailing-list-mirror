From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] fsck_handle_reflog_sha1(): new function
Date: Mon,  8 Jun 2015 15:40:04 +0200
Message-ID: <1c6f5540fe974016c1547163c7b891707019154d.1433769878.git.mhagger@alum.mit.edu>
References: <cover.1433769878.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 15:40:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1xI3-0002r1-NW
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 15:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbbFHNk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 09:40:29 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:49676 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752436AbbFHNkY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 09:40:24 -0400
X-AuditID: 12074412-f79066d000000bc5-be-55759b3a30a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 56.B8.03013.A3B95755; Mon,  8 Jun 2015 09:40:10 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58De6NC022064
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 09:40:09 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433769878.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqGs1uzTU4OYUDYuuK91MFg29V5gt
	+pd3sVncXjGf2eJHSw+zA6vH3/cfmDw+fIzzeNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M76dXsVSsJi3YuHGk2wNjC+4uhg5OCQETCSWvuPpYuQEMsUkLtxbz9bFyMUhJHCZUeL4
	hi+sIAkhgRNMEvOuKoHYbAK6Eot6mplAbBEBNYmJbYdYQBqYBeYzSjxufcUIkhAWsJF4tXoz
	M4jNIqAqse1yI9ggXoEoieNbZrJCbJOTOH/8J1gNp4CFxNGmfYwQy8wlJvzexzKBkXcBI8Mq
	RrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJCAEtrBuP6k3CFGAQ5GJR7eA4tK
	QoVYE8uKK3MPMUpyMCmJ8tb3lYYK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFNng6U401JrKxK
	LcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4H04E6hRsCg1PbUiLTOnBCHNxMEJ
	MpxLSqQ4NS8ltSixtCQjHhQZ8cXA2ABJ8QDtVZ4Fsre4IDEXKArReopRUUqc9w3IXAGQREZp
	HtxYWJp4xSgO9KUwrxNIOw8wxcB1vwIazAQ0+PvXYpDBJYkIKakGxiNGuT478y8bcvBMbpV7
	JBryksU9pKfz5xX/46V1q88flfPc9GgH97wb8oknQ5/MZhNl8wu2TO1S0/mUWh+4vUazP/CC
	cBvXmVvVdhurpdwsuaxmr7B/+Fpyo8vcOKn55i+nrOv25f8xf5paX6jCyZmzz+2J 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271032>

New function, extracted from fsck_handle_reflog_ent(). The extra
is_null_sha1() test for the new reference is currently unnecessary, as
reflogs are deleted when the reference itself is deleted. But it
doesn't hurt, either.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fsck.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4e8e2ee..b1b6c60 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -451,28 +451,29 @@ static void fsck_dir(int i, char *path)
 
 static int default_refs;
 
-static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
-		const char *message, void *cb_data)
+static void fsck_handle_reflog_sha1(unsigned char *sha1)
 {
 	struct object *obj;
 
-	if (verbose)
-		fprintf(stderr, "Checking reflog %s->%s\n",
-			sha1_to_hex(osha1), sha1_to_hex(nsha1));
-
-	if (!is_null_sha1(osha1)) {
-		obj = lookup_object(osha1);
+	if (!is_null_sha1(sha1)) {
+		obj = lookup_object(sha1);
 		if (obj) {
 			obj->used = 1;
 			mark_object_reachable(obj);
 		}
 	}
-	obj = lookup_object(nsha1);
-	if (obj) {
-		obj->used = 1;
-		mark_object_reachable(obj);
-	}
+}
+
+static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
+{
+	if (verbose)
+		fprintf(stderr, "Checking reflog %s->%s\n",
+			sha1_to_hex(osha1), sha1_to_hex(nsha1));
+
+	fsck_handle_reflog_sha1(osha1);
+	fsck_handle_reflog_sha1(nsha1);
 	return 0;
 }
 
-- 
2.1.4
