From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/33] repack_without_ref(): use function get_packed_ref()
Date: Sun, 14 Apr 2013 14:54:24 +0200
Message-ID: <1365944088-10588-10-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMUM-0005jx-N8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab3DNM4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:56:53 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:60506 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751824Ab3DNMza (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:30 -0400
X-AuditID: 12074414-b7fb86d000000905-15-516aa741b827
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 65.A8.02309.147AA615; Sun, 14 Apr 2013 08:55:30 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAk6007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:28 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqOu0PCvQYH8Pk0XXlW4mi4beK8wW
	Kx/fZba4vWI+s8WPlh5mB1aPv+8/MHm0v3/H7PGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGc8vX2NpeAva8WXw3vYGxg/sHQxcnJICJhIbFo2kx3CFpO4cG89WxcjF4eQwGVGievP
	prBAOGeZJJ7O6mMDqWIT0JVY1NPM1MXIwSEikC2xe608SJhZwEFi8+dGRhBbWMBL4sH0p4wg
	JSwCqhITvseBhHkFXCUW7vjEDLFLQeL49m1g5ZxA8enPj4HdICTgIjFr82zWCYy8CxgZVjHK
	JeaU5urmJmbmFKcm6xYnJ+blpRbpWujlZpbopaaUbmKEBJTIDsYjJ+UOMQpwMCrx8DqwZAUK
	sSaWFVfmHmKU5GBSEuVVXAYU4kvKT6nMSCzOiC8qzUktPsQowcGsJMLr2AqU401JrKxKLcqH
	SUlzsCiJ835brO4nJJCeWJKanZpakFoEk5Xh4FCS4NUAGSpYlJqeWpGWmVOCkGbi4AQRXCAb
	eIA2vF0KsqG4IDG3ODMdougUo6KUOO9HkIQASCKjNA9uACz2XzGKA/0jzPsUpIoHmDbgul8B
	DWYCGuyzNx1kcEkiQkqqgXGZzt1Ddm/2sWjKHlXde3vlg0Wdr5/5zt9x0TT18aklagr3ODTu
	2SRK6KqaT1//bbXIV8PQ/M4TaeF/WvfcD374jdtmw5LOYrEsnRmJBx7r3pOY43y/tyKXW013
	rd6iaSGP9zGtXebuUqjG2zXzZPCNkDydtczC8yXjv8/6v8W+857kn27rjTZKLMUZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221128>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index cf017a5..c523978 100644
--- a/refs.c
+++ b/refs.c
@@ -1818,9 +1818,11 @@ static int repack_without_ref(const char *refname)
 {
 	struct repack_without_ref_sb data;
 	struct ref_cache *refs = get_ref_cache(NULL);
-	struct ref_dir *packed = get_packed_refs(refs);
-	if (find_ref(packed, refname) == NULL)
-		return 0;
+	struct ref_dir *packed;
+
+	if (!get_packed_ref(refname))
+		return 0; /* refname does not exist in packed refs */
+
 	data.refname = refname;
 	data.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
 	if (data.fd < 0) {
-- 
1.8.2.1
