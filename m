From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/3] read_loose_refs(): treat NULL_SHA1 loose references as broken
Date: Tue,  2 Jun 2015 17:57:27 +0200
Message-ID: <1433260647-18181-4-git-send-email-mhagger@alum.mit.edu>
References: <1433260647-18181-1-git-send-email-mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:57:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzoZf-0004QF-0l
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 17:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbbFBP5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 11:57:50 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:44640 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932693AbbFBP5q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 11:57:46 -0400
X-AuditID: 1207440e-f79fc6d000000caf-45-556dd2777eaa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id C2.1D.03247.772DD655; Tue,  2 Jun 2015 11:57:43 -0400 (EDT)
Received: from michael.fritz.box (p4FC966E3.dip0.t-ipconnect.de [79.201.102.227])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t52FvbBX010977
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 2 Jun 2015 11:57:42 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433260647-18181-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqFt+KTfUoGmTvsWZvnCLrivdTBYN
	vVeYLW6vmM9s8aOlh9li8+Z2Fgc2j7/vPzB5LNhU6tF05iizx7PePYweFy8pe3zeJBfAFsVt
	k5RYUhacmZ6nb5fAnXFn2kOWgo28Ff+u7WRtYDzH1cXIySEhYCJx8U0vM4QtJnHh3nq2LkYu
	DiGBy4wS0/5+hHJOMElM7PvLAlLFJqArsainmQnEFhFQk5jYdggsziywmVGi82EQiC0sECqx
	ed1LoKkcHCwCqhIPestAwrwCLhL/p71nhFgmJ3H++E+wxZwCrhK9l7rARgoB1bw9/4NlAiPv
	AkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSmlmxghIca3g7F9vcwhRgEORiUe
	XoZPOaFCrIllxZW5hxglOZiURHlvHM8NFeJLyk+pzEgszogvKs1JLT7EKMHBrCTCK7gBKMeb
	klhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuB9eAGoUbAoNT21Ii0zpwQh
	zcTBCTKcS0qkODUvJbUosbQkIx4UGfHFwNgASfEA7X0B0s5bXJCYCxSFaD3FqMvx41LjYiYh
	lrz8vFQpcd7/IEUCIEUZpXlwK2AJ5RWjONDHwrwyF4GqeIDJCG7SK6AlTEBL2gVyQJaUJCKk
	pBoY02XXLjsi/G35hdef3tt+rji91/R99MMn/OyyAu1blIPWvr/uMd/m0Ky3U7gjmwPVHs69
	0vbOkIVn4b7Je9NW3KmtSTt2Zb5c6BcjwR0huzZn5PNvnPXt7gQBL5YPJZFm0vkb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270557>

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
index 72d2397..cdb67a0 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -24,7 +24,7 @@ test_expect_success 'Broken refs are reported correctly' '
 	test_cmp broken-err err
 '
 
-test_expect_failure 'NULL_SHA1 refs are reported correctly' '
+test_expect_success 'NULL_SHA1 refs are reported correctly' '
 	r=refs/heads/zeros &&
 	echo $ZEROS >.git/$r &&
 	test_when_finished "rm -f .git/$r" &&
-- 
2.1.4
