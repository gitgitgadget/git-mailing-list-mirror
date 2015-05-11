From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/18] t1404: new tests of ref D/F conflicts within transactions
Date: Mon, 11 May 2015 17:25:03 +0200
Message-ID: <1431357920-25090-2-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:25:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrpaV-0002S7-Mg
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbbEKPZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:25:43 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61531 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751963AbbEKPZh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:37 -0400
X-AuditID: 12074414-f797f6d000004084-17-5550c9e9ea53
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 21.94.16516.9E9C0555; Mon, 11 May 2015 11:25:29 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnD002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:28 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqPvyZECowacT1hZdV7qZLBp6rzBb
	3F4xn9niR0sPs8Xmze0sFmfeNDI6sHn8ff+ByWPBplKPZ717GD0uXlL2WPzAy+PzJrkAtihu
	m6TEkrLgzPQ8fbsE7oxvZ4sKHitUzD1f0MC4U6qLkZNDQsBEYvKXvWwQtpjEhXvrgWwuDiGB
	y4wSXza8ZYFwjjNJHDi5BqyKTUBXYlFPMxOILSKgJjGx7RBYEbPALkaJe0unsoAkhAWCJSY9
	mwLWwCKgKtHaeZwVxOYVcJGYdvcIE8Q6OYnzx38yg9icAq4SS69eBusVAqppenyPZQIj7wJG
	hlWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsYISEmsoPxyEm5Q4wCHIxKPLwG
	F/xDhVgTy4orcw8xSnIwKYny/tobECrEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhFd5DVCONyWx
	siq1KB8mJc3BoiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mCt/EEUKNgUWp6akVaZk4JQpqJ
	gxNkOJeUSHFqXkpqUWJpSUY8KDLii4GxAZLiAdq7G6Sdt7ggMRcoCtF6ilFRSpx3IUhCACSR
	UZoHNxaWOF4xigN9Kcz7EaSKB5h04LpfAQ1mAhrsGAc2uCQRISXVwFi38fnai9PE5mrmTtzp
	w7OCvzvldvkasauzv09slBKI8J/kemQCm0PtDl6Op1vtpko6ON2rXeVx8sT8NjnDvuJni/zy
	ll4peTZB5RV/GqO/xWXfJLfVGarc05ewxq8tc66+nvt05oyrEqddutW4/r07JCbJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268780>

Add some tests of reference D/F conflicts (by which I mean the fact
that references like "refs/foo" and "refs/foo/bar" are not allowed to
coexist) in the context of reference transactions.

The test of creating two conflicting references in the same
transaction fails, leaving the transaction half-completed. This will
be fixed later in this patch series.

Please note that the error messages emitted in the case of conflicts
are not very user-friendly. In particular, when the conflicts involve
loose references, then the errors are reported as

    error: there are still refs under 'refs/foo'
    fatal: Cannot lock the ref 'refs/foo'.

or

    error: unable to resolve reference refs/foo/bar: Not a directory
    fatal: Cannot lock the ref 'refs/foo/bar'.

This is because lock_ref_sha1_basic() fails while trying to lock the
new reference, before it even gets to the is_refname_available()
check. This situation will also be improved later in this patch
series.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1404-update-ref-df-conflicts.sh | 107 +++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100755 t/t1404-update-ref-df-conflicts.sh

diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
new file mode 100755
index 0000000..ed1b93e
--- /dev/null
+++ b/t/t1404-update-ref-df-conflicts.sh
@@ -0,1 +1,107 @@
+#!/bin/sh
+
+test_description='Test git update-ref with D/F conflicts'
+. ./test-lib.sh
+
+test_update_rejected () {
+	prefix="$1" &&
+	before="$2" &&
+	pack="$3" &&
+	create="$4" &&
+	error="$5" &&
+	printf "create $prefix/%s $C\n" $before |
+	git update-ref --stdin &&
+	git for-each-ref $prefix >unchanged &&
+	if $pack
+	then
+		git pack-refs --all
+	fi &&
+	printf "create $prefix/%s $C\n" $create >input &&
+	test_must_fail git update-ref --stdin <input 2>output.err &&
+	grep -F "$error" output.err &&
+	git for-each-ref $prefix >actual &&
+	test_cmp unchanged actual
+}
+
+Q="'"
+
+test_expect_success 'setup' '
+
+	git commit --allow-empty -m Initial &&
+	C=$(git rev-parse HEAD)
+
+'
+
+test_expect_success 'existing loose ref is a simple prefix of new' '
+
+	prefix=refs/1l &&
+	test_update_rejected $prefix "a c e" false "b c/x d" \
+		"unable to resolve reference $prefix/c/x: Not a directory"
+
+'
+
+test_expect_success 'existing packed ref is a simple prefix of new' '
+
+	prefix=refs/1p &&
+	test_update_rejected $prefix "a c e" true "b c/x d" \
+		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x$Q"
+
+'
+
+test_expect_success 'existing loose ref is a deeper prefix of new' '
+
+	prefix=refs/2l &&
+	test_update_rejected $prefix "a c e" false "b c/x/y d" \
+		"unable to resolve reference $prefix/c/x/y: Not a directory"
+
+'
+
+test_expect_success 'existing packed ref is a deeper prefix of new' '
+
+	prefix=refs/2p &&
+	test_update_rejected $prefix "a c e" true "b c/x/y d" \
+		"$Q$prefix/c$Q exists; cannot create $Q$prefix/c/x/y$Q"
+
+'
+
+test_expect_success 'new ref is a simple prefix of existing loose' '
+
+	prefix=refs/3l &&
+	test_update_rejected $prefix "a c/x e" false "b c d" \
+		"there are still refs under $Q$prefix/c$Q"
+
+'
+
+test_expect_success 'new ref is a simple prefix of existing packed' '
+
+	prefix=refs/3p &&
+	test_update_rejected $prefix "a c/x e" true "b c d" \
+		"$Q$prefix/c/x$Q exists; cannot create $Q$prefix/c$Q"
+
+'
+
+test_expect_success 'new ref is a deeper prefix of existing loose' '
+
+	prefix=refs/4l &&
+	test_update_rejected $prefix "a c/x/y e" false "b c d" \
+		"there are still refs under $Q$prefix/c$Q"
+
+'
+
+test_expect_success 'new ref is a deeper prefix of existing packed' '
+
+	prefix=refs/4p &&
+	test_update_rejected $prefix "a c/x/y e" true "b c d" \
+		"$Q$prefix/c/x/y$Q exists; cannot create $Q$prefix/c$Q"
+
+'
+
+test_expect_failure 'one new ref is a simple prefix of another' '
+
+	prefix=refs/5 &&
+	test_update_rejected $prefix "a e" false "b c c/x d" \
+		"cannot process $Q$prefix/c$Q and $Q$prefix/c/x$Q at the same time"
+
+'
+
+test_done
-- 
2.1.4
