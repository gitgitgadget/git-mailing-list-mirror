From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 4/4] read_loose_refs(): treat NULL_SHA1 loose references as broken
Date: Wed,  3 Jun 2015 15:51:59 +0200
Message-ID: <eb79f7d96ec74445f7adf62757119273280e09c9.1433339279.git.mhagger@alum.mit.edu>
References: <cover.1433339279.git.mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 15:52:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z095l-0005nx-JW
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 15:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbbFCNwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 09:52:19 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:48790 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755170AbbFCNwK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 09:52:10 -0400
X-AuditID: 12074413-f79386d000000d23-7c-556f06891279
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C1.1A.03363.9860F655; Wed,  3 Jun 2015 09:52:09 -0400 (EDT)
Received: from michael.fritz.box (p4FC96DFC.dip0.t-ipconnect.de [79.201.109.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t53Dq154005566
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Jun 2015 09:52:08 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433339279.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqNvJlh9qsHiWvsWZvnCLrivdTBYN
	vVeYLW6vmM9s8aOlh9li8+Z2Fgc2j7/vPzB5LNhU6tF05iizx7PePYweFy8pe3zeJBfAFsVt
	k5RYUhacmZ6nb5fAnTHz2mS2gi0CFZ+W3WNpYPzI08XIySEhYCKx4+VfNghbTOLCvfVANheH
	kMBlRonJT2czgiSEBE4wSXQ/Nwax2QR0JRb1NDOB2CICahIT2w6xgNjMApsZJTofBoHYwgKh
	Ep8utTGD2CwCqhLrzh4Dq+cViJL4PKuVHWKZnMT54z+Bajg4OAUsJPbc0AYxhQTMJc6flJ/A
	yLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkh4Ce9g3HVS7hCjAAej
	Eg+vQ1heqBBrYllxZe4hRkkOJiVR3jVfgEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeF++A8rx
	piRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4xVnzQ4UEi1LTUyvSMnNK
	ENJMHJwgw7mkRIpT81JSixJLSzLiQVERXwyMC5AUD9BeeZB23uKCxFygKETrKUZdjh+XGhcz
	CbHk5eelSonzPmEBKhIAKcoozYNbAUsmrxjFgT4W5k0BGcUDTERwk14BLWECWtIukAOypCQR
	ISXVwDglQObVjfdTlae0ameGC6ZW1wte+x73Jk5/U2bcBfe1+Xuer9rvJrPgi8I6q1s7Dvon
	8KUq5m/+UnIpdncY85Vwfbf/z7heXWsrmp5YKt36psqcI18+SfpDod/ZuP3ijp1s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270684>

NULL_SHA1 is used to indicate of "invalid SHA-1" throughout our code
(and the code of other git implementations), so it is vastly more
likely that a reference was set to this value due to a software bug
than that NULL_SHA1 is the legitimate SHA-1 of an actual object.
Therefore, if a loose reference has the value NULL_SHA1, consider it
to be broken.

Amusingly, each of the other 2^160-1 possible SHA-1 values is exactly
as unlikely as NULL_SHA1 to be the SHA-1 of an actual object. The
difference is that most of those other values are also very unlikely
to be written to a loose reference file by accident, whereas
accidentally writing NULL_SHA1 to a loose reference file would be an
easy mistake to make.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                         | 10 ++++++++++
 t/t6301-for-each-ref-errors.sh |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 6736424..83af13d 100644
--- a/refs.c
+++ b/refs.c
@@ -1324,6 +1324,16 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 			if (!read_ok) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
+			} else if (is_null_sha1(sha1)) {
+				/*
+				 * It is so astronomically unlikely
+				 * that NULL_SHA1 is the SHA-1 of an
+				 * actual object that we consider its
+				 * appearance in a loose reference
+				 * file to be repo corruption
+				 * (probably due to a software bug).
+				 */
+				flag |= REF_ISBROKEN;
 			}
 
 			if (check_refname_format(refname.buf,
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
