X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/17] lock_ref_sha1_basic(): on SCLD_VANISHED, retry
Date: Mon,  6 Jan 2014 14:45:28 +0100
Message-ID: <1389015935-21936-11-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
NNTP-Posting-Date: Mon, 6 Jan 2014 13:46:44 +0000 (UTC)
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
X-AuditID: 1207440d-b7f4c6d000004a16-0d-52cab3b26623
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqLtp86kgg7ZeTYuuK91MFg29V5gt
	3t5cwmhxe8V8Zovd0xawObB6/H3/gclj56y77B4XLyl7PJ54gtXj8ya5ANYobpukxJKy4Mz0
	PH27BO6MHS+eMRe08FbcfHaGpYHxMFcXIyeHhICJxOpvJ1kgbDGJC/fWs3UxcnEICVxmlGi+
	9JkJwjnGJHH/ym8mkCo2AV2JRT3NYLaIgJrExLZDLCBFzAKLGSW6pn1j7GLk4BAW8JA41m7W
	xcjOwSKgKvHUBaSaV8BV4uayXywgBRICChKrrwuBhDmBwtOmHWYDsYUEXCTWHHrEMoGRdwEj
	wypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MkHDi3cH4f53MIUYBDkYlHl6P
	ZyeDhFgTy4orcw8xSnIwKYnycq4+FSTEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhJdrAVCONyWx
	siq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBa7IJqFGwKDU9tSItM6cEIc3E
	wQkiuEA28ABtUAAp5C0uSMwtzkyHKDrFqCglzisIjF0hAZBERmke3ABY5L9iFAf6R5jXBqSd
	B5g04LpfAQ1mAhocGgc2uCQRISXVwOhfc8ok0NWi96Vv6KRX+awpR1MvpLDk86dr+7rzHuVp
	Wix12rfOaZZWZOZpnjfnnx5t/WM8+92OgpzEG4rfVD7mL3geK5/FHuqh5n1qA8fXstz/v1Ss
	dC5dKY/eaOe1zrQpzJnjjcmH0qtb0hffVl5xWclzre+NX3uuOc8+3DL/7fvos+Fu 
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1W0AVq-00065n-B1 for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:38
 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754629AbaAFNqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jan 2014
 08:46:32 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50604 "EHLO
 alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1754400AbaAFNq1 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6
 Jan 2014 08:46:27 -0500
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33]) by
 alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id
 9F.A9.18966.2B3BAC25; Mon,  6 Jan 2014 08:46:26 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de
 [87.162.84.87]) (authenticated bits=0) (User authenticated as
 mhagger@ALUM.MIT.EDU) by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id
 s06DjfPB021935 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
 Mon, 6 Jan 2014 08:46:25 -0500
Sender: git-owner@vger.kernel.org

If safe_create_leading_directories() fails because a file along the
path unexpectedly vanished, try again (up to 3 times).

This can occur if another process is deleting directories at the same
time as we are trying to make them.  For example, "git pack-refs
--all" tries to delete the loose refs and any empty directories that
are left behind.  If a pack-refs process is running, then it might
delete a directory that we need to put a new loose reference in.

If safe_create_leading_directories() thinks this might have happened,
then take its advice and try again (maximum three attempts).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 3926136..6eb8a02 100644
--- a/refs.c
+++ b/refs.c
@@ -2039,6 +2039,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int missing = 0;
+	int attempts = 3;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
@@ -2093,7 +2094,15 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
 		lock->force_write = 1;
 
-	if (safe_create_leading_directories(ref_file)) {
+ retry:
+	switch (safe_create_leading_directories(ref_file)) {
+	case SCLD_OK:
+		break; /* success */
+	case SCLD_VANISHED:
+		if (--attempts > 0)
+			goto retry;
+		/* fall through */
+	default:
 		last_errno = errno;
 		error("unable to create directory for %s", ref_file);
 		goto error_return;
-- 
1.8.5.2
