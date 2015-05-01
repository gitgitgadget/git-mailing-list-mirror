From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/18] t1404: new tests of D/F conflicts within ref transactions
Date: Fri,  1 May 2015 14:25:41 +0200
Message-ID: <1430483158-14349-2-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1P-0000qr-It
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbbEAM0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:20 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55396 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753697AbbEAM0R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:17 -0400
X-AuditID: 12074413-f79f26d0000030e7-ec-554370e1ea27
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 97.EC.12519.1E073455; Fri,  1 May 2015 08:26:09 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Ze004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:08 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPuwwDnU4OJEY4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ2xfs4Cp4JZCxYwlH5kbGLdIdTFyckgImEi8nXOZEcIWk7hwbz1bFyMXh5DAZUaJP7Ou
	sUM4J5gkdr86wwZSxSagK7Gop5kJxBYRUJOY2HaIBaSIWaCDUeLC8m3sIAlhgQCJd+sWs4DY
	LAKqEjN/HWQFsXkFXCSuLX/JCrFOTuL88Z/MXYwcHJwCrhJfpiaChIWASu5//8o2gZF3ASPD
	Kka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQkBLewbjrpNwhRgEORiUeXo6T
	TqFCrIllxZW5hxglOZiURHltE5xDhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw3lMHyvGmJFZW
	pRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHgT84EaBYtS01Mr0jJzShDSTByc
	IMO5pESKU/NSUosSS0sy4kGxEV8MjA6QFA/Q3mUg7bzFBYm5QFGI1lOMilLivD0gCQGQREZp
	HtxYWKJ4xSgO9KUwLyswbQjxAJMMXPcroMFMQIPP33IAGVySiJCSamBcX7nyUIDi3S2bphZc
	+njjwGIRt0MvVI4XzP687EYp/zF5v8f5Jl63Zp9hZXpW9EOZ/5rtuXcLrld0c5Zv2nLBftfF
	G4EbJBZtPfpLPf3lDOmbddfO/7x99dX37ZtWZFkn+i+wetiW+kV+Mvf+/As8OovO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268118>

Add some tests of D/F conflicts (as in, the type of directory vs. file
conflict that exists between references "refs/foo" and "refs/foo/bar")
in the context of reference transactions.

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
index 0000000..2fc2ac6
--- /dev/null
+++ b/t/t1404-update-ref-df-conflicts.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+
+test_description='Test git update-ref with D/F conflicts'
+. ./test-lib.sh
+
+test_update_rejected() {
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
+	git commit --allow-empty -m Initial
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
