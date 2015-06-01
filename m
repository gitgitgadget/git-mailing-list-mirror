From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/3] read_loose_refs(): treat NULL_SHA1 loose references as broken
Date: Mon,  1 Jun 2015 17:53:51 +0200
Message-ID: <1433174031-5471-4-git-send-email-mhagger@alum.mit.edu>
References: <1433174031-5471-1-git-send-email-mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 17:54:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzS2m-0002xa-4W
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 17:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbbFAPyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 11:54:12 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60341 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751479AbbFAPyG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 11:54:06 -0400
X-AuditID: 1207440e-f79fc6d000000caf-af-556c801bb756
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id D9.18.03247.B108C655; Mon,  1 Jun 2015 11:54:03 -0400 (EDT)
Received: from michael.fritz.box (p4FC96750.dip0.t-ipconnect.de [79.201.103.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t51FrsEq010505
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 1 Jun 2015 11:54:02 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433174031-5471-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqCvdkBNqsPSEusWZvnCLrivdTBYN
	vVeYLW6vmM9s8aOlh9li8+Z2Fgc2j7/vPzB5LNhU6tF05iizx7PePYweFy8pe3zeJBfAFsVt
	k5RYUhacmZ6nb5fAnbFt523Wgo28FXvmFjYwnuPqYuTkkBAwkbj+8DULhC0mceHeerYuRi4O
	IYHLjBJbX6+Eco4zScyc3wJWxSagK7Gop5kJxBYRUJOY2HYILM4ssJlRovNhEIgtLBAkcbpp
	LSuIzSKgKtH2ZgdYDa+As8S7O1sYIbbJSZw//pMZxOYUcJFYsukLWFwIqOb2yo9sExh5FzAy
	rGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdbLzSzRS00p3cQICTG+HYzt62UOMQpwMCrx8Ap0
	ZocKsSaWFVfmHmKU5GBSEuV1rswJFeJLyk+pzEgszogvKs1JLT7EKMHBrCTCa1UBlONNSays
	Si3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfDOrgNqFCxKTU+tSMvMKUFIM3Fw
	ggznkhIpTs1LSS1KLC3JiAdFRnwxMDZAUjxAe6NB2nmLCxJzgaIQracYdTl+XGpczCTEkpef
	lyolztsEUiQAUpRRmge3ApZQXjGKA30szPsfpIoHmIzgJr0CWsIEtKRdAGxJSSJCSqqBUXNy
	3/wJ3PU1VR07vi84UxRcFL5M916WAOPUVXeZvS5NOmmS/vj8yl23V52c+tFcRNNP33xep64e
	w87yL0yb194/Od323b5jcjP3pX6ub1vb9NPxgfHL2Y4HJkgcXhNwb95Ek98b+2wX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270431>

NULL_SHA1 is never a valid value for a reference. If a loose reference
has that value, mark it as broken.

Why check NULL_SHA1 and not the nearly 2^160 other SHA-1s that are
also invalid in a given repository? Because (a) it is cheap to test
for NULL_SHA1, and (b) NULL_SHA1 is often used as a "SHA-1 is invalid"
value inside of Git client source code (not only ours!), and
accidentally writing it to a loose reference file would be an easy
mistake to make.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                         | 7 +++++++
 t/t6301-for-each-ref-errors.sh | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 47e4e53..c28fde1 100644
--- a/refs.c
+++ b/refs.c
@@ -1321,6 +1321,13 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
+
+			if (!(flag & REF_ISBROKEN) && is_null_sha1(sha1)) {
+				/* NULL_SHA1 is never a valid reference value. */
+				hashclr(sha1);
+				flag |= REF_ISBROKEN;
+			}
+
 			if (check_refname_format(refname.buf,
 						 REFNAME_ALLOW_ONELEVEL)) {
 				hashclr(sha1);
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index b9af9a9..f737cce 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -23,7 +23,7 @@ test_expect_success 'Broken refs are reported correctly' '
 	test_cmp broken-err err
 '
 
-test_expect_failure 'NULL_SHA1 refs are reported correctly' '
+test_expect_success 'NULL_SHA1 refs are reported correctly' '
 	r=refs/heads/zeros &&
 	echo $ZEROS >.git/$r &&
 	test_when_finished "rm -f .git/$r" &&
-- 
2.1.4
