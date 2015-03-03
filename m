From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 3/7] lock_ref_sha1_basic(): do not set force_write for missing references
Date: Tue,  3 Mar 2015 12:43:13 +0100
Message-ID: <1425382997-24984-4-git-send-email-mhagger@alum.mit.edu>
References: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:43:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSlEg-0003kG-3R
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 12:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300AbbCCLnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 06:43:35 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61125 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755934AbbCCLnd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 06:43:33 -0500
X-AuditID: 1207440f-f792a6d000001284-ff-54f59e658ed4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A8.4F.04740.56E95F45; Tue,  3 Mar 2015 06:43:33 -0500 (EST)
Received: from michael.fritz.box (p5DDB193E.dip0.t-ipconnect.de [93.219.25.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t23BhJqG016748
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Mar 2015 06:43:30 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqJs672uIwdyDXBZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvxo6WG26O37xGqxeXM7i8WZN42MDpwef99/YPLYOesuu8eCTaUe
	z3r3MHpcvKTssfiBl8fnTXIB7FHcNkmJJWXBmel5+nYJ3Bl/Dp5hLmjgr9jw5yZrA+Nv7i5G
	Tg4JAROJU39uMUHYYhIX7q1n62Lk4hASuMwo8ebHP7CEkMAxJomrH0tBbDYBXYlFPc1gcREB
	NYmJbYdYQGxmgR9MEodW1ILYwgIxEl2/WhhBbBYBVYn/K1vA6nkFXCQ+PrwGtUxO4vzxn8wg
	NqeAq8TKtVtZuxg5gHa5SNz6UDGBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0TvdzM
	Er3UlNJNjJBA5N/B2LVe5hCjAAejEg/vBPavIUKsiWXFlbmHGCU5mJREeeVnA4X4kvJTKjMS
	izPii0pzUosPMUpwMCuJ8DLPBcrxpiRWVqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphakFsFk
	ZTg4lCR4J4E0ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIPiIr4YGBkgKR6gvT/n
	gOwtLkjMBYpCtJ5iVJQS55UFmSsAksgozYMbC0svrxjFgb4U5o0HqeIBpia47ldAg5mABt9S
	/AIyuCQRISXVwLggJs+Lp35RI4eO373eiBIzuSvbpI7Xs4v4JhodWPt79bqAk9zL/u6fxuJi
	qOssoacetjf+4B3Tb7rKK+8yrIx/uuhnwBmOy25H7tsFaRlmJfrITlFmYZBkaTS7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264652>

If a reference is missing, its SHA-1 will be null_sha1, which can't
possibly match a new value that ref_transaction_commit() is trying to
update it to. So there is no need to set force_write in this scenario.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index dd30bfa..3ed9ea6 100644
--- a/refs.c
+++ b/refs.c
@@ -2258,7 +2258,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
-	int missing = 0;
 	int attempts_remaining = 3;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
@@ -2297,13 +2296,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			orig_refname, strerror(errno));
 		goto error_return;
 	}
-	missing = is_null_sha1(lock->old_sha1);
-	/* When the ref did not exist and we are creating it,
-	 * make sure there is no existing ref that is packed
-	 * whose name begins with our refname, nor a ref whose
-	 * name is a proper prefix of our refname.
+	/*
+	 * If the ref did not exist and we are creating it, make sure
+	 * there is no existing packed ref whose name begins with our
+	 * refname, nor a packed ref whose name is a proper prefix of
+	 * our refname.
 	 */
-	if (missing &&
+	if (is_null_sha1(lock->old_sha1) &&
 	     !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
 		last_errno = ENOTDIR;
 		goto error_return;
@@ -2319,8 +2318,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	lock->ref_name = xstrdup(refname);
 	lock->orig_ref_name = xstrdup(orig_refname);
 	ref_file = git_path("%s", refname);
-	if (missing)
-		lock->force_write = 1;
 	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
 		lock->force_write = 1;
 
-- 
2.1.4
