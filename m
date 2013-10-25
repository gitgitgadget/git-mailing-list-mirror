From: Jeff King <peff@peff.net>
Subject: [PATCH v2 18/19] t: add basic bitmap functionality tests
Date: Fri, 25 Oct 2013 02:04:38 -0400
Message-ID: <20131025060438.GP23098@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 25 08:04:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZaVn-00073P-Ul
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 08:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab3JYGEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 02:04:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:55330 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751182Ab3JYGEl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 02:04:41 -0400
Received: (qmail 3606 invoked by uid 102); 25 Oct 2013 06:04:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 01:04:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 02:04:38 -0400
Content-Disposition: inline
In-Reply-To: <20131025055521.GD11810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236677>

Now that we can read and write bitmaps, we can exercise them
with some basic functionality tests. These tests aren't
particularly useful for seeing the benefit, as the test
repo is too small for it to make a difference. However, we
can at least check that using bitmaps does not break anything.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5310-pack-bitmaps.sh | 114 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 t/t5310-pack-bitmaps.sh

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
new file mode 100755
index 0000000..0868725
--- /dev/null
+++ b/t/t5310-pack-bitmaps.sh
@@ -0,0 +1,114 @@
+#!/bin/sh
+
+test_description='exercise basic bitmap functionality'
+. ./test-lib.sh
+
+test_expect_success 'setup repo with moderate-sized history' '
+	for i in $(test_seq 1 10); do
+		test_commit $i
+	done &&
+	git checkout -b other HEAD~5 &&
+	for i in `test_seq 1 10`; do
+		test_commit side-$i
+	done &&
+	git checkout master &&
+	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
+	git tag tagged-blob $blob &&
+	git config pack.writebitmaps true
+'
+
+test_expect_success 'full repack creates bitmaps' '
+	git repack -ad &&
+	ls .git/objects/pack/ | grep bitmap >output &&
+	test_line_count = 1 output
+'
+
+test_expect_success 'rev-list --test-bitmap verifies bitmaps' '
+	git rev-list --test-bitmap HEAD
+'
+
+rev_list_tests() {
+	state=$1
+
+	test_expect_success "counting commits via bitmap ($state)" '
+		git rev-list --count HEAD >expect &&
+		git rev-list --use-bitmap-index --count HEAD >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "counting partial commits via bitmap ($state)" '
+		git rev-list --count HEAD~5..HEAD >expect &&
+		git rev-list --use-bitmap-index --count HEAD~5..HEAD >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "counting non-linear history ($state)" '
+		git rev-list --count other...master >expect &&
+		git rev-list --use-bitmap-index --count other...master >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "enumerate --objects ($state)" '
+		git rev-list --objects --use-bitmap-index HEAD >tmp &&
+		cut -d" " -f1 <tmp >tmp2 &&
+		sort <tmp2 >actual &&
+		git rev-list --objects HEAD >tmp &&
+		cut -d" " -f1 <tmp >tmp2 &&
+		sort <tmp2 >expect &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "bitmap --objects handles non-commit objects ($state)" '
+		git rev-list --objects --use-bitmap-index HEAD tagged-blob >actual &&
+		grep $blob actual
+	'
+}
+
+rev_list_tests 'full bitmap'
+
+test_expect_success 'clone from bitmapped repository' '
+	git clone --no-local --bare . clone.git &&
+	git rev-parse HEAD >expect &&
+	git --git-dir=clone.git rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup further non-bitmapped commits' '
+	for i in `test_seq 1 10`; do
+		test_commit further-$i
+	done
+'
+
+rev_list_tests 'partial bitmap'
+
+test_expect_success 'fetch (partial bitmap)' '
+	git --git-dir=clone.git fetch origin master:master &&
+	git rev-parse HEAD >expect &&
+	git --git-dir=clone.git rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'incremental repack cannot create bitmaps' '
+	test_commit more-1 &&
+	test_must_fail git repack -d
+'
+
+test_expect_success 'incremental repack can disable bitmaps' '
+	test_commit more-2 &&
+	git repack -d --no-write-bitmap-index
+'
+
+test_expect_success 'full repack, reusing previous bitmaps' '
+	git repack -ad &&
+	ls .git/objects/pack/ | grep bitmap >output &&
+	test_line_count = 1 output
+'
+
+test_expect_success 'fetch (full bitmap)' '
+	git --git-dir=clone.git fetch origin master:master &&
+	git rev-parse HEAD >expect &&
+	git --git-dir=clone.git rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.4.1.898.g8bf8a41.dirty
