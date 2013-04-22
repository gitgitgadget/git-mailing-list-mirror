From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 30/33] pack_one_ref(): use write_packed_entry() to do the writing
Date: Mon, 22 Apr 2013 21:52:38 +0200
Message-ID: <1366660361-21831-31-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoj-0005cZ-39
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190Ab3DVTyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:54:14 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:50320 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755179Ab3DVTyK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:54:10 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-27-5175956269d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 70.74.02295.26595715; Mon, 22 Apr 2013 15:54:10 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOh008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:54:09 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqJs0tTTQYMMiHouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7Y0f+VteC6WMXPWS3sDYxn
	hLoYOTkkBEwkZrd9YoSwxSQu3FvP1sXIxSEkcJlRYv2eH+wQzgUmiU0nlrODVLEJ6Eos6mlm
	ArFFBNQkJrYdYgGxmQUcJDZ/bgSbJCwQIrHt+2WwOIuAqsTzP7/AenkFXCXau18wQ2xTkDi+
	fRtYPSdQ/HTHCbB6IQEXiRUHp7JMYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXUC83
	s0QvNaV0EyMkWHh2MH5bJ3OIUYCDUYmHV8C9NFCINbGsuDL3EKMkB5OSKC/HFKAQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEV7RfKAcb0piZVVqUT5MSpqDRUmcV3WJup+QQHpiSWp2ampBahFM
	VoaDQ0mCdxXIUMGi1PTUirTMnBKENBMHJ4jgAtnAA7QhEqSQt7ggMbc4Mx2i6BSjopQ4b/Uk
	oIQASCKjNA9uACyuXzGKA/0jzDsJpJ0HmBLgul8BDWYCGpyZUAIyuCQRISXVwGi3K+fU3jy3
	iz+XNmnsdP4sfVFr4QmrOsu7t4V/m56aZtjLMqs247bX449HeaZOVIv+l7559zpxVUmP4v6u
	Vzs3vnZRdpI97xHuM5GF5eCbaq9Uc959s99Mauto3PXIwL1j7peIV46nBCvdat45GP5ysvGr
	XCf37NS7ewKm1q5n/ql3iCoc2a/EUpyRaKjFXFScCADvezjKxgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222066>

Change pack_refs() to work with a file descriptor instead of a FILE*
(making the file-locking code less awkward) and use
write_packed_entry() to do the writing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index f2d83f3..df670cb 100644
--- a/refs.c
+++ b/refs.c
@@ -2000,7 +2000,7 @@ struct ref_to_prune {
 struct pack_refs_cb_data {
 	unsigned int flags;
 	struct ref_to_prune *ref_to_prune;
-	FILE *refs_file;
+	int fd;
 };
 
 static int pack_one_ref(struct ref_entry *entry, void *cb_data)
@@ -2019,15 +2019,13 @@ static int pack_one_ref(struct ref_entry *entry, void *cb_data)
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
@@ -2096,32 +2094,17 @@ static struct lock_file packlock;
 
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
