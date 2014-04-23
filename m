From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 3/6] tests: new test for orderfile options
Date: Wed, 23 Apr 2014 15:14:57 +0300
Message-ID: <1398255277-26303-3-git-send-email-mst@redhat.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 14:14:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcw4H-0007Om-42
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 14:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbaDWMOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 08:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63490 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbaDWMON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 08:14:13 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3NCEDks028502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 23 Apr 2014 08:14:13 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3NCECs0018224
	for <git@vger.kernel.org>; Wed, 23 Apr 2014 08:14:12 -0400
Content-Disposition: inline
In-Reply-To: <1398255277-26303-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246821>

The test is very basic and can be extended.
Couldn't find a good existing place to put it,
so created a new file.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t4056-diff-order.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 t/t4056-diff-order.sh

diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
new file mode 100755
index 0000000..a247b7a
--- /dev/null
+++ b/t/t4056-diff-order.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='diff orderfile'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+        as="a a a a a a a a" && # eight a
+        test_write_lines $as >foo &&
+        test_write_lines $as >bar &&
+	git add foo bar &&
+	git commit -a -m initial &&
+        test_write_lines $as b >foo &&
+        test_write_lines $as b >bar &&
+	git commit -a -m first &&
+	test_write_lines bar foo >bar-then-foo &&
+	test_write_lines foo bar >foo-then-bar &&
+	git diff -Ofoo-then-bar HEAD~1..HEAD >diff-foo-then-bar &&
+	git diff -Obar-then-foo HEAD~1..HEAD >diff-bar-then-foo
+'
+
+test_diff_well_formed () {
+	grep ^+b "$1" >added
+	grep ^-b "$1" >removed
+	grep ^+++ "$1" >oldfiles
+	grep ^--- "$1" >newfiles
+	test_line_count = 2 added &&
+	test_line_count = 0 removed &&
+	test_line_count = 2 oldfiles &&
+	test_line_count = 2 newfiles
+}
+
+test_expect_success 'diff output with -O is well-formed' '
+	test_diff_well_formed diff-foo-then-bar &&
+	test_diff_well_formed diff-bar-then-foo
+'
+
+test_expect_success 'flag -O affects diff output' '
+	! test_cmp diff-foo-then-bar diff-bar-then-foo
+'
+
+test_expect_success 'orderfile is same as -O' '
+	test_config diff.orderfile foo-then-bar &&
+	git diff HEAD~1..HEAD >diff-foo-then-bar-config &&
+	test_config diff.orderfile bar-then-foo &&
+	git diff HEAD~1..HEAD >diff-bar-then-foo-config &&
+	test_cmp diff-foo-then-bar diff-foo-then-bar-config &&
+	test_cmp diff-bar-then-foo diff-bar-then-foo-config
+'
+
+test_expect_success '-O overrides orderfile' '
+	test_config diff.orderfile foo-then-bar &&
+	git diff -Obar-then-foo HEAD~1..HEAD >diff-bar-then-foo-flag &&
+	test_cmp diff-bar-then-foo diff-bar-then-foo-flag
+'
+
+test_expect_success '/dev/null is same as no orderfile' '
+	git diff -O/dev/null HEAD~1..HEAD>diff-null-orderfile &&
+	git diff HEAD~1..HEAD >diff-default &&
+	test_cmp diff-null-orderfile diff-default
+'
+
+test_done
-- 
MST
