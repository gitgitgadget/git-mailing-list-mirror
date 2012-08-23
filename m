From: mhagger@alum.mit.edu
Subject: [PATCH 01/17] t5500: add tests of error output for missing refs
Date: Thu, 23 Aug 2012 10:10:26 +0200
Message-ID: <1345709442-16046-2-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:11:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4SVn-0007IJ-B0
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933677Ab2HWILX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:11:23 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:43497 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933186Ab2HWIK7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:10:59 -0400
X-AuditID: 1207440e-b7f036d0000008b5-d8-5035e59239eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 86.3D.02229.295E5305; Thu, 23 Aug 2012 04:10:58 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkV1030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:10:57 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixO6iqDvpqWmAwbp/NhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujKbz+5gK
	VvJU7Lh/nr2BcQJXFyMnh4SAicTqx29ZIWwxiQv31rOB2EIClxkl/kwR6WLkArLPMkmc67vM
	DpJgE5CSeNnYA2aLCKhJTGw7xAJiMwukSHQ872YEsYUFPCT+nZ8OVMPBwSKgKrF6kTVImFfA
	RaJ9xilGiF2KEj++r2EGsTkFXCUWfN/ECLHXReJj403mCYy8CxgZVjHKJeaU5urmJmbmFKcm
	6xYnJ+blpRbpGuvlZpbopaaUbmKEBA/fDsb29TKHGAU4GJV4eF+YmwYIsSaWFVfmHmKU5GBS
	EuX99wgoxJeUn1KZkVicEV9UmpNafIhRgoNZSYQ3fB5QjjclsbIqtSgfJiXNwaIkzqu2RN1P
	SCA9sSQ1OzW1ILUIJivDwaEkwZv2BKhRsCg1PbUiLTOnBCHNxMEJIrhANvAAbVgFUshbXJCY
	W5yZDlF0ilFRSpy3GSQhAJLIKM2DGwCL81eM4kD/CPNOBqniAaYIuO5XQIOZgAarXTUGGVyS
	iJCSamB0jrmqpevbUFW3VqI740LKRG+xeT1Sqm4iH0/HbNv2dMv2JodDjsZ5Tsufd2xK5jnY
	ZC79NUOgVvW4lGTPBWM2paPraqYniy67Lnf5gJl8vu5mIfuD323OnX14boHKsS2ev8veGG0u
	eZWwvd9ZrDms/+q27rcf10jceWSSy/x8/dwkgaL3tpJKLMUZiYZazEXFiQAK5y2X 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204116>

From: Michael Haggerty <mhagger@alum.mit.edu>

If "git fetch-pack" is called with reference names that do not exist
on the remote, then it should emit an error message

    error: no such remote ref refs/heads/xyzzy

This is currently broken if *only* missing references are passed to
"git fetch-pack".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5500-fetch-pack.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e80a2af..3cc3346 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -397,4 +397,34 @@ test_expect_success 'test duplicate refs from stdin' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set up tests of missing reference' '
+	cat >expect-error <<-\EOF
+	error: no such remote ref refs/heads/xyzzy
+	EOF
+'
+
+test_expect_failure 'test lonely missing ref' '
+	(
+	cd client &&
+	test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy
+	) >/dev/null 2>error-m &&
+	test_cmp expect-error error-m
+'
+
+test_expect_success 'test missing ref after existing' '
+	(
+	cd client &&
+	test_must_fail git fetch-pack --no-progress .. refs/heads/A refs/heads/xyzzy
+	) >/dev/null 2>error-em &&
+	test_cmp expect-error error-em
+'
+
+test_expect_success 'test missing ref before existing' '
+	(
+	cd client &&
+	test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy refs/heads/A
+	) >/dev/null 2>error-me &&
+	test_cmp expect-error error-me
+'
+
 test_done
-- 
1.7.11.3
