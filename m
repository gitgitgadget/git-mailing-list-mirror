From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 3/9] tests: new test for orderfile options
Date: Thu, 24 Apr 2014 12:30:57 +0300
Message-ID: <1398331809-11309-3-git-send-email-mst@redhat.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 12:21:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdGmS-00006F-2p
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 12:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbaDXKUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 06:20:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36928 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755258AbaDXKTE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 06:19:04 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3OAIg2N001985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 24 Apr 2014 06:18:45 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s3O9UC6S030111;
	Thu, 24 Apr 2014 05:30:12 -0400
Content-Disposition: inline
In-Reply-To: <1398331809-11309-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246961>

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
index 0000000..0404f50
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
+	as="a a a a a a a a" && # eight a
+	test_write_lines $as >foo &&
+	test_write_lines $as >bar &&
+	git add foo bar &&
+	git commit -a -m initial &&
+	test_write_lines $as b >foo &&
+	test_write_lines $as b >bar &&
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
