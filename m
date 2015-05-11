From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/18] lock_ref_sha1_basic(): improve diagnostics for ref D/F conflicts
Date: Mon, 11 May 2015 17:25:16 +0200
Message-ID: <1431357920-25090-15-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:26:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpaw-0002iU-B0
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbbEKPZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:25:59 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56686 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752740AbbEKPZz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:55 -0400
X-AuditID: 1207440d-f79976d000005643-a4-5550ca02b985
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 66.A3.22083.20AC0555; Mon, 11 May 2015 11:25:54 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnQ002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:52 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqMt0KiDU4PYMVYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8b3qV8YC45IVVx93MrSwNgp2sXIySEhYCJxpL2JEcIWk7hwbz1bFyMX
	h5DAZUaJNYveQznHmST2H1nJBFLFJqArsainGcwWEVCTmNh2iAWkiFlgF6PEvaVTWUASwgJR
	EntnbAcq4uBgEVCVePvUDCTMK+AqcWFqAxvENjmJ88d/MoPYnEDxpVcvg7UKCbhIND2+xzKB
	kXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJAg493B+H+dzCFGAQ5G
	JR7ejkv+oUKsiWXFlbmHGCU5mJREeX/tDQgV4kvKT6nMSCzOiC8qzUktPsQowcGsJMKrvAYo
	x5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4E05CdQoWJSanlqRlplT
	gpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qN+GJgdICkeID2fj0Bsre4IDEXKArReopRUUqcNwUk
	IQCSyCjNgxsLSx2vGMWBvhTmtQSp4gGmHbjuV0CDmYAGO8aBDS5JREhJNTAyqUzJn+rycyJz
	YqhKtpvIgf9sb+6abmM+H+Cn0indo3XnQOln5RJJ4R9sn7mP60cvObZq5oOGTrebJTtfb9N1
	dSvlL5nkt2xv85TykrtOSyrjHI/LrCwWlvp6JLPDs6glSNCy/WSV4cqLD7l/MC6N 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268791>

If there is a failure to lock a reference that is likely caused by a
D/F conflict (e.g., trying to lock "refs/foo/bar" when reference
"refs/foo" already exists), invoke verify_refname_available() to try
to generate a more helpful error message.

That function might not detect an error. For example, some
non-reference file might be blocking the deletion of an
otherwise-empty directory tree, or there might be a race with another
process that just deleted the offending reference. In such cases,
generate the strerror-based error message like before.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                             | 16 ++++++++++++----
 t/t1404-update-ref-df-conflicts.sh |  8 ++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index ff9b9cf..ce993bd 100644
--- a/refs.c
+++ b/refs.c
@@ -2369,8 +2369,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		ref_file = git_path("%s", orig_refname);
 		if (remove_empty_directories(ref_file)) {
 			last_errno = errno;
-			strbuf_addf(err, "there are still refs under '%s'",
-				    orig_refname);
+
+			if (!verify_refname_available(orig_refname, extras, skip,
+						      get_loose_refs(&ref_cache), err))
+				strbuf_addf(err, "there are still refs under '%s'",
+					    orig_refname);
+
 			goto error_return;
 		}
 		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
@@ -2380,8 +2384,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	    *type_p = type;
 	if (!refname) {
 		last_errno = errno;
-		strbuf_addf(err, "unable to resolve reference %s: %s",
-			    orig_refname, strerror(errno));
+		if (last_errno != ENOTDIR ||
+		    !verify_refname_available(orig_refname, extras, skip,
+					      get_loose_refs(&ref_cache), err))
+			strbuf_addf(err, "unable to resolve reference %s: %s",
+				    orig_refname, strerror(last_errno));
+
 		goto error_return;
 	}
 	/*
diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
index b0bb7d4..348a07a 100755
--- a/t/t1404-update-ref-df-conflicts.sh
+++ b/t/t1404-update-ref-df-conflicts.sh
@@ -36,7 +36,7 @@ test_expect_success 'existing loose ref is a simple prefix of new' '
 
 	prefix=refs/1l &&
 	test_update_rejected $prefix "a c e" false "b c/x d" \
-		"unable to resolve reference $prefix/c/x: Not a directory"
+		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x$Q"
 
 '
 
@@ -52,7 +52,7 @@ test_expect_success 'existing loose ref is a deeper prefix of new' '
 
 	prefix=refs/2l &&
 	test_update_rejected $prefix "a c e" false "b c/x/y d" \
-		"unable to resolve reference $prefix/c/x/y: Not a directory"
+		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x/y$Q"
 
 '
 
@@ -68,7 +68,7 @@ test_expect_success 'new ref is a simple prefix of existing loose' '
 
 	prefix=refs/3l &&
 	test_update_rejected $prefix "a c/x e" false "b c d" \
-		"there are still refs under $Q$prefix/c$Q"
+		"$Q$prefix/c/x$Q exists; cannot create $Q$prefix/c$Q"
 
 '
 
@@ -84,7 +84,7 @@ test_expect_success 'new ref is a deeper prefix of existing loose' '
 
 	prefix=refs/4l &&
 	test_update_rejected $prefix "a c/x/y e" false "b c d" \
-		"there are still refs under $Q$prefix/c$Q"
+		"$Q$prefix/c/x/y$Q exists; cannot create $Q$prefix/c$Q"
 
 '
 
-- 
2.1.4
