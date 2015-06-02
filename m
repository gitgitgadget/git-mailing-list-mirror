From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/3] t6301: new tests of for-each-ref error handling
Date: Tue,  2 Jun 2015 17:57:25 +0200
Message-ID: <1433260647-18181-2-git-send-email-mhagger@alum.mit.edu>
References: <1433260647-18181-1-git-send-email-mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:58:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzoZd-0004QF-IL
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 17:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbbFBP5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 11:57:46 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42312 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932691AbbFBP5n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 11:57:43 -0400
X-AuditID: 12074413-f79386d000000d23-d1-556dd2752d3a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E5.F6.03363.572DD655; Tue,  2 Jun 2015 11:57:41 -0400 (EDT)
Received: from michael.fritz.box (p4FC966E3.dip0.t-ipconnect.de [79.201.102.227])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t52FvbBV010977
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 2 Jun 2015 11:57:39 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433260647-18181-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqFt6KTfU4PAlNoszfeEWXVe6mSwa
	eq8wW9xeMZ/Z4kdLD7PF5s3tLA5sHn/ff2DyWLCp1KPpzFFmj2e9exg9Ll5S9vi8SS6ALYrb
	JimxpCw4Mz1P3y6BO6P56D72gs/iFS8fvmVpYHwk3MXIwSEhYCIx+XdwFyMnkCkmceHeerYu
	Ri4OIYHLjBI/z3QxQjgnmCROnzrABlLFJqArsainmQnEFhFQk5jYdogFxGYW2Mwo0fkwCMQW
	FnCXWH/yNCuIzSKgKrHk5nmwel4BF4mNWw+zQWyTkzh//CcziM0p4CrRe6kLrEYIqObt+R8s
	Exh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfLzSzRS00p3cQICTHhHYy7TsodYhTg
	YFTi4WX4lBMqxJpYVlyZe4hRkoNJSZT3xvHcUCG+pPyUyozE4oz4otKc1OJDjBIczEoivIIb
	gHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQnecxeBGgWLUtNTK9Iy
	c0oQ0kwcnCDDuaREilPzUlKLEktLMuJBkRFfDIwNkBQP0N65IO28xQWJuUBRiNZTjLocPy41
	LmYSYsnLz0uVEuctASkSACnKKM2DWwFLKK8YxYE+FuaVAaniASYjuEmvgJYwAS1pF8gBWVKS
	iJCSamA05ZGKWfZUYYX/nTXvdu3o29PW6639xu2gz57Azf4BJubOYd3zJVrelu2+tFSJ/4Gn
	yPyTaqbXznie52mJ2XG2pOnWXI6o594ORvYWbSc2pd32WlulFbFtk4+8yZyli/we 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270558>

Add tests that for-each-ref correctly reports broken loose reference
files and references that point at missing objects. In fact, two of
these tests fail, because (1) NULL_SHA1 is not recognized as an
invalid reference value, and (2) for-each-ref doesn't respect
REF_ISBROKEN. Fixes to come.

Note that when for-each-ref is run with a --format option that doesn't
require the object to be looked up, then we should still notice if a
loose reference file is corrupt or contains NULL_SHA1, but we don't
notice if it points at a missing object because we don't do an object
lookup. This is OK.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Notes (discussion):
    Note that a reference that points at NULL_SHA1 is reported as "broken"
    rather than "missing". This is because NULL_SHA1 is manifestly bogus,
    whereas we have no systematic basis for rejecting any other
    40-character hexadecimal string without doing an object lookup.

 t/t6301-for-each-ref-errors.sh | 56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100755 t/t6301-for-each-ref-errors.sh

diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
new file mode 100755
index 0000000..cf25244
--- /dev/null
+++ b/t/t6301-for-each-ref-errors.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description='for-each-ref errors for broken refs'
+
+. ./test-lib.sh
+
+ZEROS=$_z40
+MISSING=abababababababababababababababababababab
+
+test_expect_success setup '
+	git commit --allow-empty -m "Initial" &&
+	git tag testtag &&
+	git for-each-ref >full-list &&
+	git for-each-ref --format="%(objectname) %(refname)" >brief-list
+'
+
+test_expect_failure 'Broken refs are reported correctly' '
+	r=refs/heads/bogus &&
+	: >.git/$r &&
+	test_when_finished "rm -f .git/$r" &&
+	echo "warning: ignoring broken ref $r" >broken-err &&
+	git for-each-ref >out 2>err &&
+	test_cmp full-list out &&
+	test_cmp broken-err err
+'
+
+test_expect_failure 'NULL_SHA1 refs are reported correctly' '
+	r=refs/heads/zeros &&
+	echo $ZEROS >.git/$r &&
+	test_when_finished "rm -f .git/$r" &&
+	echo "warning: ignoring broken ref $r" >zeros-err &&
+	git for-each-ref >out 2>err &&
+	test_cmp full-list out &&
+	test_cmp zeros-err err &&
+	git for-each-ref --format="%(objectname) %(refname)" >brief-out 2>brief-err &&
+	test_cmp brief-list brief-out &&
+	test_cmp zeros-err brief-err
+'
+
+test_expect_success 'Missing objects are reported correctly' '
+	r=refs/heads/missing &&
+	echo $MISSING >.git/$r &&
+	test_when_finished "rm -f .git/$r" &&
+	echo "fatal: missing object $MISSING for $r" >missing-err &&
+	test_must_fail git for-each-ref 2>err &&
+	test_cmp missing-err err &&
+	(
+		cat brief-list &&
+		echo "$MISSING $r"
+	) | sort -k 2 >missing-brief-expected &&
+	git for-each-ref --format="%(objectname) %(refname)" >brief-out 2>brief-err &&
+	test_cmp missing-brief-expected brief-out &&
+	test_must_be_empty brief-err
+'
+
+test_done
-- 
2.1.4
