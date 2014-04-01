From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/22] t3204: test deleting references when lock files already exist
Date: Tue,  1 Apr 2014 17:58:09 +0200
Message-ID: <1396367910-7299-2-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV15Q-00037f-BO
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbaDAP6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:58:45 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56966 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751816AbaDAP6i (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:38 -0400
X-AuditID: 1207440d-f79d86d0000043db-99-533ae22d7f05
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C9.07.17371.D22EA335; Tue,  1 Apr 2014 11:58:37 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWb5027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:36 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqKv7yCrY4ESblEXXlW4mi4beK8wW
	t1fMZ7b4dfgJu8WPlh5mB1aPv+8/MHnsnHWX3eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M642/6CuWCjYMWHi5+YGhhn83UxcnJICJhIvJm3kgnCFpO4cG89WxcjF4eQwGVGiV8N
	v5ggnGNMEsvuX2MBqWIT0JVY1NMM1iEioCYxse0QWJxZIEXi1d9dYLawQIjE176prF2MHBws
	AqoSTzergYR5BZwl5uzYwwaxTE5iyu8F7CA2p4CLxKUHe1hBbCGgmtNvFjNPYORdwMiwilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkpHh3MP5fJ3OIUYCDUYmH9+B5q2Ah
	1sSy4srcQ4ySHExKorw/7gKF+JLyUyozEosz4otKc1KLDzFKcDArifDOugmU401JrKxKLcqH
	SUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8F57ANQoWJSanlqRlplTgpBm4uAEGc4l
	JVKcmpeSWpRYWpIRD4qM+GJgbICkeID2rgRp5y0uSMwFikK0nmJUlBLnDXkIlBAASWSU5sGN
	hSWKV4ziQF8K824CaecBJhm47ldAg5mABnOvAxtckoiQkmpgLJS1vXFp08O2Y2ZT5bY0m7+e
	k81xIsE8VPqmgUaxZmjN5Bc3is7m+RQIRbkd3m99qlfq2N305VHqDSsvpl3sL2j6V/JNc/46
	h7/OlQpzV/pXaFyUULq75kaGQdiye7O5QtoV7S7myTFu3MF2KlH91YL9S14dPicz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245592>

When deleting a reference, it might be that another process already
holds the lock on the loose reference file and/or the packed-refs
file.  In those cases, there is no alternative but for the delete to
fail.  Verify that in such cases the reference values are left
unchanged.

But in fact, when the packed-refs file lock cannot be acquired, the
loose reference file is deleted anyway, potentially leaving the
reference with a changed value (its packed value, which might even
point at an object that has been garbage collected).  Thus one of the
new tests is marked test_expect_failure.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t3204-branch-locks.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 t/t3204-branch-locks.sh

diff --git a/t/t3204-branch-locks.sh b/t/t3204-branch-locks.sh
new file mode 100755
index 0000000..cc4e2c1
--- /dev/null
+++ b/t/t3204-branch-locks.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='git branch lock tests'
+
+. ./test-lib.sh
+
+test_expect_success 'prepare a trivial repository' '
+	git commit --allow-empty -m "Initial" &&
+	git commit --allow-empty -m "First"
+'
+
+test_expect_success 'delete a ref while loose ref file is locked' '
+	git branch b1 master &&
+	git for-each-ref >expected1 &&
+	# Simulate another process holding the loose file lock:
+	: >.git/refs/heads/b1.lock &&
+	test_must_fail git branch -D b1 &&
+	rm .git/refs/heads/b1.lock &&
+	# Delete failed; reference values should be unchanged:
+	git for-each-ref >actual1 &&
+	test_cmp expected1 actual1
+'
+
+test_expect_failure 'delete a ref while packed-refs file is locked' '
+	git branch b2 master &&
+	# Pack current value of b2:
+	git pack-refs --all &&
+	# Overwrite packed value with a loose value:
+	git branch -f b2 master^ &&
+	git for-each-ref >expected2 &&
+	# Simulate another process holding the packed-refs file lock:
+	: >.git/packed-refs.lock &&
+	test_must_fail git branch -D b2 &&
+	rm .git/packed-refs.lock &&
+	# Delete failed; reference values should be unchanged:
+	git for-each-ref >actual2 &&
+	test_cmp expected2 actual2
+'
+
+test_done
-- 
1.9.0
