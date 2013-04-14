From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 30/33] pack_one_ref(): use write_packed_entry() to do the writing
Date: Sun, 14 Apr 2013 14:54:45 +0200
Message-ID: <1365944088-10588-31-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTe-0004tF-1Q
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab3DNM4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:56:06 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:53354 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752111Ab3DNM4E (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:56:04 -0400
X-AuditID: 12074413-b7f226d000000902-62-516aa763f683
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 52.E6.02306.367AA615; Sun, 14 Apr 2013 08:56:04 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkR007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:56:02 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqJuyPCvQoHMho0XXlW4mi4beK8wW
	Kx/fZba4vWI+s8WPlh5mB1aPv+8/MHm0v3/H7PGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGc87TnAUrBbvOLJXO0GxlnCXYycHBICJhL7Zk9nhrDFJC7cW8/WxcjFISRwmVHi24en
	jBDOWSaJA0sms4BUsQnoSizqaWbqYuTgEBHIlti9Vh4kzCzgILH5cyMjiC0sEChxZsNmJhCb
	RUBV4tniHWCtvAKuEqtnLGCBWKYgcXz7NrB6TqD49OfH2EFsIQEXiVmbZ7NOYORdwMiwilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXXC83s0QvNaV0EyMkoIR3MO46KXeIUYCDUYmH9wVjVqAQ
	a2JZcWXuIUZJDiYlUV7FZUAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIryOrUA53pTEyqrUonyY
	lDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE7+ulQI2CRanpqRVpmTklCGkmDk4QwQWy
	gQdogxbIdt7igsTc4sx0iKJTjIpS4rwfQSYIgCQySvPgBsBi/xWjONA/whDH8wDTBlz3K6DB
	TECDffamgwwuSURISTUwusdO9P/P3JkqMCMsfscHh0bme/YS1pdvr1WbF7JXcw/j/AIu52+H
	JGPf/DpTvVL14HvFucd0z66zK9i94fO042KPUpM9N+72X6Pz9rJbsvPEKo135QsmnWg2ixTl
	kXAsmrz6jbqnsdFrUWWBV7Hnjvkt6l+94f3PxvfLc449Lfc59vC59Je4cCWW4oxE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221114>

Change pack_refs() to work with a file descriptor instead of a FILE*
(making the file-locking code less awkward) and use
write_packed_entry() to do the writing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Please checked that I am using the file-locking API correctly; I'm not
that familiar with it.

 refs.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 6397e29..923d34f 100644
--- a/refs.c
+++ b/refs.c
@@ -1998,7 +1998,7 @@ struct ref_to_prune {
 struct pack_refs_cb_data {
 	unsigned int flags;
 	struct ref_to_prune *ref_to_prune;
-	FILE *refs_file;
+	int fd;
 };
 
 static int pack_one_ref(struct ref_entry *entry, void *cb_data)
@@ -2017,15 +2017,13 @@ static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 	    !(entry->flag & REF_ISPACKED))
 		return 0;
 
-	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(entry->u.value.sha1),
-		entry->name);
-
 	peel_status = peel_entry(entry, 1);
-	if (peel_status == PEEL_PEELED)
-		fprintf(cb->refs_file, "^%s\n", sha1_to_hex(entry->u.value.peeled));
-	else if (peel_status != PEEL_NON_TAG)
+	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
 		die("internal error peeling reference %s (%s)",
 		    entry->name, sha1_to_hex(entry->u.value.sha1));
+	write_packed_entry(cb->fd, entry->name, entry->u.value.sha1,
+			   peel_status == PEEL_PEELED ?
+			   entry->u.value.peeled : NULL);
 
 	/* If the ref was already packed, there is no need to prune it. */
 	if ((cb->flags & PACK_REFS_PRUNE) && !(entry->flag & REF_ISPACKED)) {
@@ -2094,32 +2092,17 @@ static struct lock_file packlock;
 
 int pack_refs(unsigned int flags)
 {
-	int fd;
 	struct pack_refs_cb_data cbdata;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"),
-				       LOCK_DIE_ON_ERROR);
-	cbdata.refs_file = fdopen(fd, "w");
-	if (!cbdata.refs_file)
-		die_errno("unable to create ref-pack file structure");
+	cbdata.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"),
+					      LOCK_DIE_ON_ERROR);
 
-	/* perhaps other traits later as well */
-	fprintf(cbdata.refs_file, "# pack-refs with: peeled fully-peeled \n");
+	write_or_die(cbdata.fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
 
 	do_for_each_entry(NULL, "", pack_one_ref, &cbdata);
-	if (ferror(cbdata.refs_file))
-		die("failed to write ref-pack file");
-	if (fflush(cbdata.refs_file) || fsync(fd) || fclose(cbdata.refs_file))
-		die_errno("failed to write ref-pack file");
-	/*
-	 * Since the lock file was fdopen()'ed and then fclose()'ed above,
-	 * assign -1 to the lock file descriptor so that commit_lock_file()
-	 * won't try to close() it.
-	 */
-	packlock.fd = -1;
 	if (commit_lock_file(&packlock) < 0)
 		die_errno("unable to overwrite old ref-pack file");
 	prune_refs(cbdata.ref_to_prune);
-- 
1.8.2.1
