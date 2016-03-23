From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/21] resolve_missing_loose_ref(): simplify semantics
Date: Wed, 23 Mar 2016 11:04:23 +0100
Message-ID: <d40fad11431993f44a53e845f21af3a1add6f7d0.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:06:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiff0-0002WM-8V
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbcCWKE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:04:59 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56297 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754155AbcCWKE5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:04:57 -0400
X-AuditID: 1207440d-6a3ff7000000068f-2d-56f26a4862dd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id CB.5F.01679.84A62F65; Wed, 23 Mar 2016 06:04:56 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1B018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:04:55 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqOuR9SnMoGeWlkXXlW4mi4beK8wW
	t1fMZ7bonvKW0eJHSw+zxcyr1g5sHn/ff2Dy2DnrLrvHs949jB4XLyl77F+6jc3j8ya5ALYo
	bpukxJKy4Mz0PH27BO6MxrOKBSv4K97tZm9gfMbdxcjBISFgInFniUMXIxeHkMBWRomFp++z
	QzgnmSS+vVnN3MXIycEmoCuxqKeZCcQWEVCTmNh2iAWkiFlgAaPExsWLwYqEBdwk5q6ayAZi
	swioSsx9tw0szisQJfFm80pGEFtCQEliw4MLYIM4BSwkTp5cChYXEjCX2P5gLdMERp4FjAyr
	GOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3MUJCiXcH4/91MocYBTgYlXh4i859
	DBNiTSwrrsw9xCjJwaQkyns+6FOYEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeGRlAOd6UxMqq
	1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO82kEbBotT01Iq0zJwShDQTByfI
	cC4pkeLUvJTUosTSkox4UPjHFwMjACTFA7R3Gtje4oLEXKAoROspRkUpcV4NkIQASCKjNA9u
	LCxBvGIUB/pSmJczE6iKB5hc4LpfAQ1mAhq80AdscEkiQkqqgZHZp3DD9/N7cv+fyqx7ZG35
	Law4dldq50G22rM2n9U4CzbskLh6VP/TpB198Sp6BxhsdvlVdDfpvp2Yw3DrfXRF8ofHRjk6
	vWt2uJouES8Sfz39dvbZY4tfLvrm5GBpkTZhY8uMHHcLIZlo1W22J2u0ar+fcfkn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289613>

Make resolve_missing_loose_ref() only responsible for looking up a
packed reference, without worrying about whether we want to read or
write the reference and without setting errno on failure. Move the other
logic to the caller.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9676ec2..c0cf6fd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1368,11 +1368,9 @@ static struct ref_entry *get_packed_ref(const char *refname)
 }
 
 /*
- * A loose ref file doesn't exist; check for a packed ref.  The
- * options are forwarded from resolve_safe_unsafe().
+ * A loose ref file doesn't exist; check for a packed ref.
  */
 static int resolve_missing_loose_ref(const char *refname,
-				     int resolve_flags,
 				     unsigned char *sha1,
 				     int *flags)
 {
@@ -1389,14 +1387,8 @@ static int resolve_missing_loose_ref(const char *refname,
 			*flags |= REF_ISPACKED;
 		return 0;
 	}
-	/* The reference is not a packed reference, either. */
-	if (resolve_flags & RESOLVE_REF_READING) {
-		errno = ENOENT;
-		return -1;
-	} else {
-		hashclr(sha1);
-		return 0;
-	}
+	/* refname is not a packed reference. */
+	return -1;
 }
 
 /* This function needs to return a meaningful errno on failure */
@@ -1461,9 +1453,13 @@ static const char *resolve_ref_1(const char *refname,
 		if (lstat(path, &st) < 0) {
 			if (errno != ENOENT)
 				return NULL;
-			if (resolve_missing_loose_ref(refname, resolve_flags,
-						      sha1, flags))
-				return NULL;
+			if (resolve_missing_loose_ref(refname, sha1, flags)) {
+				if (resolve_flags & RESOLVE_REF_READING) {
+					errno = ENOENT;
+					return NULL;
+				}
+				hashclr(sha1);
+			}
 			if (bad_name) {
 				hashclr(sha1);
 				if (flags)
-- 
2.8.0.rc3
