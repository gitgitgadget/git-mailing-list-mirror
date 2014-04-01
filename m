From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/22] commit_lock_file(): don't work with a fixed-length buffer
Date: Tue,  1 Apr 2014 17:58:24 +0200
Message-ID: <1396367910-7299-17-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV15i-0005F5-9t
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbaDAP7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:04 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54276 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751888AbaDAP7B (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:59:01 -0400
X-AuditID: 12074412-f79d46d000002e58-1f-533ae244c021
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A1.4C.11864.442EA335; Tue,  1 Apr 2014 11:59:00 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbK027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:59 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqOvyyCrY4PJ3PYuuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3x5dwXtoIdvBWvr7WyNjBO4O5i5OCQEDCR+LtRqYuRE8gUk7hwbz1bFyMXh5DAZUaJ
	pinXGSGcY0wSG9c3sYNUsQnoSizqaWYCsUUE1CQmth1iAbGZBVIkXv3dBWYLCwRIfPu0kg1k
	AYuAqsSW1WYgYV4BF4k9j7eyQSyTk5jyewHYSE6g+KUHe1hBbCEBZ4nTbxYzT2DkXcDIsIpR
	LjGnNFc3NzEzpzg1Wbc4OTEvL7VI10wvN7NELzWldBMjJKCEdjCuPyl3iFGAg1GJh/fAeatg
	IdbEsuLK3EOMkhxMSqK8P+4ChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwzroJlONNSaysSi3K
	h0lJc7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQkuCVfwjUKFiUmp5akZaZU4KQZuLgBBnO
	JSVSnJqXklqUWFqSEQ+Ki/hiYGSApHiA9iqCtPMWFyTmAkUhWk8xKkqJ87I8AEoIgCQySvPg
	xsLSxCtGcaAvhXl1Qdp5gCkGrvsV0GAmoMHc68AGlyQipKQaGBt5v9Z2vttQoLnr0Roh45Ot
	n57ErC59YOuvsVVxwW3f0tRZpn1TAysXXu1h0Lo98dSdXI+7PI7+02wf22Wvfd4jv97S0ZJd
	9+Sh2Gu3lqxe2L+BVeqky92XHi0PXvPvzNGVVntSc+t8gE+8rCL7Y4sZf9U33xOQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245595>

Allocate temporary space to hold result_file instead of storing it in
a fixed-length buffer.  This removes the last arbitrary path-length
limitation, so remove the path length check in lock_file().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 0ade314..c1ca5b1 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -181,11 +181,6 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		resolve_symlink(&lk->lock_filename);
 	strbuf_addstr(&lk->lock_filename, ".lock");
 
-	if (lk->lock_filename.len >= PATH_MAX) {
-		error("%s: path too long", lk->lock_filename.buf);
-		strbuf_setlen(&lk->lock_filename, 0);
-		return -1;
-	}
 	lk->fd = open(lk->lock_filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
 		if (adjust_shared_perm(lk->lock_filename.buf)) {
@@ -273,17 +268,19 @@ int close_lock_file(struct lock_file *lk)
 
 int commit_lock_file(struct lock_file *lk)
 {
-	char result_file[PATH_MAX];
+	char *result_file;
 	size_t path_len = lk->lock_filename.len - LOCK_SUFFIX_LEN;
+	int err = 0;
 
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
-	memcpy(result_file, lk->lock_filename.buf, path_len);
-	result_file[path_len] = '\0';
+	result_file = xmemdupz(lk->lock_filename.buf, path_len);
 	if (rename(lk->lock_filename.buf, result_file))
-		return -1;
-	strbuf_setlen(&lk->lock_filename, 0);
-	return 0;
+		err = -1;
+	else
+		strbuf_setlen(&lk->lock_filename, 0);
+	free(result_file);
+	return err;
 }
 
 int hold_locked_index(struct lock_file *lk, int die_on_error)
-- 
1.9.0
