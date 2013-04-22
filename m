From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 26/33] refs: use same lock_file object for both ref-packing functions
Date: Mon, 22 Apr 2013 21:52:34 +0200
Message-ID: <1366660361-21831-27-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:01:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMvz-0007GU-NL
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119Ab3DVUBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:01:38 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:63504 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755037Ab3DVUBh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:01:37 -0400
X-AuditID: 12074412-b7f216d0000008d4-6d-5175955c7475
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E1.8F.02260.C5595715; Mon, 22 Apr 2013 15:54:04 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOd008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:54:03 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqBsztTTQYN8KJYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7Y3vyOueA0d8Xtl2vZGhhX
	cXYxcnJICJhIXGnawgZhi0lcuLceyObiEBK4zChx9PZaFgjnApPEirdr2EGq2AR0JRb1NDOB
	2CICahIT2w6xgNjMAg4Smz83MoLYwgIREgt+TQOzWQRUJf5Nes/axcjOwSvgKrFSEWKXgsTx
	7dvAKjiBoqc7ToBNERJwkVhxcCrLBEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRy
	M0v0UlNKNzFCAkVoB+P6k3KHGAU4GJV4eAXcSwOFWBPLiitzDzFKcjApifJyTAEK8SXlp1Rm
	JBZnxBeV5qQWH2KU4GBWEuEVzQfK8aYkVlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2C
	ycpwcChJ8H6bDNQoWJSanlqRlplTgpBm4uAEEVwgG3iANsiDbOctLkjMLc5Mhyg6xagoJc7r
	NgkoIQCSyCjNgxsAi+lXjOJA/wjz8oG08wDTAVz3K6DBTECDMxNKQAaXJCKkpBoYq+4c+bju
	WubxW0Wc3tv+7H4usO+YavCdta+9ys/PVQk5OHdxY3P68v1nnPb1b1vk7CCyO+itE3P+h52W
	ibmNM1+kNq4Qtul7/OvaDaWmXbds14s3nP4x53Dh1Cytyob06Qfb/R+25x04ONVUZH3w5BxG
	8+AF8Q36pzbu7XK++jpnnY2MYPgODiWW4oxEQy3mouJEANWln3rEAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222076>

Use a single struct lock_file for both pack_refs() and
repack_without_ref().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index b41dd5e..850df8e 100644
--- a/refs.c
+++ b/refs.c
@@ -2091,7 +2091,7 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-static struct lock_file packed;
+static struct lock_file packlock;
 
 int pack_refs(unsigned int flags)
 {
@@ -2101,7 +2101,7 @@ int pack_refs(unsigned int flags)
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"),
+	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"),
 				       LOCK_DIE_ON_ERROR);
 	cbdata.refs_file = fdopen(fd, "w");
 	if (!cbdata.refs_file)
@@ -2120,8 +2120,8 @@ int pack_refs(unsigned int flags)
 	 * assign -1 to the lock file descriptor so that commit_lock_file()
 	 * won't try to close() it.
 	 */
-	packed.fd = -1;
-	if (commit_lock_file(&packed) < 0)
+	packlock.fd = -1;
+	if (commit_lock_file(&packlock) < 0)
 		die_errno("unable to overwrite old ref-pack file");
 	prune_refs(cbdata.ref_to_prune);
 	return 0;
@@ -2175,8 +2175,6 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-static struct lock_file packlock;
-
 static int repack_without_ref(const char *refname)
 {
 	int fd;
-- 
1.8.2.1
