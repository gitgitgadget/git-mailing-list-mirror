From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/33] read_raw_ref(): don't get confused by an empty directory
Date: Fri,  6 May 2016 18:13:44 +0200
Message-ID: <e167a5673e25b960dce118fb967d54da30b69def.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:14:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiOd-0007qm-KV
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758496AbcEFQO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:28 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54137 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758171AbcEFQO1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:27 -0400
X-AuditID: 12074413-473ff700000008c7-a8-572cc2e2ed8d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C1.32.02247.2E2CC275; Fri,  6 May 2016 12:14:26 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUj031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:25 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPvokE64wZr/FhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oy7F14xFdzirlgzYzJrA+NKzi5GTg4JAROJH+fX
	MnUxcnEICWxllGj5PIsdwjnOJNH2qpMVpIpNQFdiUU8zE4gtIhAh0fCqhbGLkYODWeAzo8RK
	bhBTWCBIYumnDJAKFgFVibNf+5hBbF6BKImPm3cxQeySk7g8/QEbiM0pYCFxqPc4WFxIwFyi
	Y+0N9gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5ihISX8A7GXSfl
	DjEKcDAq8fBmnNQOF2JNLCuuzD3EKMnBpCTK+71AJ1yILyk/pTIjsTgjvqg0J7X4EKMEB7OS
	CO+VfUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb9BBoEbBotT0
	1Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UPjHFwMjACTFA7RXHqSdt7ggMRcoCtF6ilGX
	48j+e2uZhFjy8vNSpcR5DUCKBECKMkrz4FbAkskrRnGgj4V5L4NU8QATEdykV0BLmICWvJ+r
	CbKkJBEhJdXAGN3x9dWzhbYhi+eclHZ7vfvCDFeLul7lugfLy0Ra6xS427OrF7pumMbq3/LL
	WKNany3qU+l1J2uxjtsGp/Wm7WRvnGdtfvav6KveXSnzVO8rOwdHb2BVvlykuE16 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293796>

Even if there is an empty directory where we look for the loose version
of a reference, check for a packed reference before giving up. This
fixes the failing test that was introduced two commits ago.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c               | 11 ++++++++++-
 t/t1404-update-ref-df-conflicts.sh |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ad9cd86..0cc116d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1477,7 +1477,16 @@ stat_ref:
 
 	/* Is it a directory? */
 	if (S_ISDIR(st.st_mode)) {
-		errno = EISDIR;
+		/*
+		 * Even though there is a directory where the loose
+		 * ref is supposed to be, there could still be a
+		 * packed ref:
+		 */
+		if (resolve_missing_loose_ref(refname, sha1, flags)) {
+			errno = EISDIR;
+			goto out;
+		}
+		ret = 0;
 		goto out;
 	}
 
diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
index 16752a9..6d869d1 100755
--- a/t/t1404-update-ref-df-conflicts.sh
+++ b/t/t1404-update-ref-df-conflicts.sh
@@ -106,7 +106,7 @@ test_expect_success 'one new ref is a simple prefix of another' '
 
 '
 
-test_expect_failure 'empty directory should not fool rev-parse' '
+test_expect_success 'empty directory should not fool rev-parse' '
 	prefix=refs/e-rev-parse &&
 	git update-ref $prefix/foo $C &&
 	git pack-refs --all &&
-- 
2.8.1
