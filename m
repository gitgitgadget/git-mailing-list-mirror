Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E00C202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 09:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbdJYJxh (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 05:53:37 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54855 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932315AbdJYJxd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2017 05:53:33 -0400
X-AuditID: 1207440c-7e5ff7000000143e-9c-59f05f1a1721
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FA.56.05182.A1F50F95; Wed, 25 Oct 2017 05:53:31 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC93E.dip0.t-ipconnect.de [87.188.201.62])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9P9rPQZ025997
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 25 Oct 2017 05:53:28 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] t1409: check that `packed-refs` is not rewritten unnecessarily
Date:   Wed, 25 Oct 2017 11:53:20 +0200
Message-Id: <7d8bafad7491e4040ad4364bdc22b05d9b1d540d.1508924577.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1508924577.git.mhagger@alum.mit.edu>
References: <cover.1508924577.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixO6iqCsd/yHS4FanuEXXlW4mi4beK8wW
        t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlissmJTUnsyy1SN8ugSvj3SbTgkOq
        FX/3djM2MC6Q72Lk5JAQMJF42/CEvYuRi0NIYAeTxMWtN9ggnJNMEmuuTGECqWIT0JVY1NMM
        ZosIqElMbDvEAmIzC6RIdDzvZuxi5OAQFgiWePzGFCTMIqAq8eHREzYQm1cgSuJH5wQ2iGXy
        Euce3GYGsTkFLCS+77zECGILCZhLXDqwinUCI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmp
        RbqGermZJXqpKaWbGCEhwrOD8ds6mUOMAhyMSjy8GTPfRwqxJpYVV+YeYpTkYFIS5Q33+BAp
        xJeUn1KZkVicEV9UmpNafIhRgoNZSYS3PRYox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKa
        nZpakFoEk5Xh4FCS4K2IA2oULEpNT61Iy8wpQUgzcXCCDOcBGl4PUsNbXJCYW5yZDpE/xWjM
        0XHz7h8mjmczXzcwC7Hk5eelSonzZoGUCoCUZpTmwU2DxfkrRnGg54R5TUCqeIApAm7eK6BV
        TECrmlTBVpUkIqSkGhjnld9vl3dfrJzz+fXL7qCd1z6Vu+yYE6ikJ1Cz1WWrbgzTh05em/1L
        vZKdm7JCy2vYMybWpux8dvFcYYLbeZ29za9+OYuW3L2rVfbputfhA2/32xpaLLr/7x7DXabN
        W6/bO7WcYq6quyBjdnrLxhxXl+1mAhevLXBuObnoUdu5jZaLz3QZ1GcpsRRnJBpqMRcVJwIA
        0N4BUs4CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to rewrite the `packed-refs` file except for the case
that we are deleting a reference that has a packed version. Verify
that `packed-refs` is not rewritten when it shouldn't be.

In fact, two of these tests fail:

* A new (empty) `packed-refs` file is created when deleting any loose
  reference and no `packed-refs` file previously existed.

* The `packed-refs` file is rewritten unnecessarily when deleting a
  loose reference that has no packed counterpart.

Both problems will be fixed in the next commit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1409-avoid-packing-refs.sh | 118 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100755 t/t1409-avoid-packing-refs.sh

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
new file mode 100755
index 0000000000..a2397c7b71
--- /dev/null
+++ b/t/t1409-avoid-packing-refs.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+
+test_description='avoid rewriting packed-refs unnecessarily'
+
+. ./test-lib.sh
+
+# Add an identifying mark to the packed-refs file header line. This
+# shouldn't upset readers, and it should be omitted if the file is
+# ever rewritten.
+mark_packed_refs () {
+	sed -e "s/^\(#.*\)/\1 t1409 /" <.git/packed-refs >.git/packed-refs.new &&
+	mv .git/packed-refs.new .git/packed-refs
+}
+
+# Verify that the packed-refs file is still marked.
+check_packed_refs_marked () {
+	grep -q '^#.* t1409 ' .git/packed-refs
+}
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m "Commit A" &&
+	A=$(git rev-parse HEAD) &&
+	git commit --allow-empty -m "Commit B" &&
+	B=$(git rev-parse HEAD) &&
+	git commit --allow-empty -m "Commit C" &&
+	C=$(git rev-parse HEAD)
+'
+
+test_expect_failure 'do not create packed-refs file gratuitously' '
+	test_must_fail test -f .git/packed-refs &&
+	git update-ref refs/heads/foo $A &&
+	test_must_fail test -f .git/packed-refs &&
+	git update-ref refs/heads/foo $B &&
+	test_must_fail test -f .git/packed-refs &&
+	git update-ref refs/heads/foo $C $B &&
+	test_must_fail test -f .git/packed-refs &&
+	git update-ref -d refs/heads/foo &&
+	test_must_fail test -f .git/packed-refs
+'
+
+test_expect_success 'check that marking the packed-refs file works' '
+	git for-each-ref >expected &&
+	git pack-refs --all &&
+	mark_packed_refs &&
+	check_packed_refs_marked &&
+	git for-each-ref >actual &&
+	test_cmp expected actual &&
+	git pack-refs --all &&
+	test_must_fail check_packed_refs_marked &&
+	git for-each-ref >actual2 &&
+	test_cmp expected actual2
+'
+
+test_expect_success 'leave packed-refs untouched on update of packed' '
+	git update-ref refs/heads/packed-update $A &&
+	git pack-refs --all &&
+	mark_packed_refs &&
+	git update-ref refs/heads/packed-update $B &&
+	check_packed_refs_marked
+'
+
+test_expect_success 'leave packed-refs untouched on checked update of packed' '
+	git update-ref refs/heads/packed-checked-update $A &&
+	git pack-refs --all &&
+	mark_packed_refs &&
+	git update-ref refs/heads/packed-checked-update $B $A &&
+	check_packed_refs_marked
+'
+
+test_expect_success 'leave packed-refs untouched on verify of packed' '
+	git update-ref refs/heads/packed-verify $A &&
+	git pack-refs --all &&
+	mark_packed_refs &&
+	echo "verify refs/heads/packed-verify $A" | git update-ref --stdin &&
+	check_packed_refs_marked
+'
+
+test_expect_success 'touch packed-refs on delete of packed' '
+	git update-ref refs/heads/packed-delete $A &&
+	git pack-refs --all &&
+	mark_packed_refs &&
+	git update-ref -d refs/heads/packed-delete &&
+	test_must_fail check_packed_refs_marked
+'
+
+test_expect_success 'leave packed-refs untouched on update of loose' '
+	git pack-refs --all &&
+	git update-ref refs/heads/loose-update $A &&
+	mark_packed_refs &&
+	git update-ref refs/heads/loose-update $B &&
+	check_packed_refs_marked
+'
+
+test_expect_success 'leave packed-refs untouched on checked update of loose' '
+	git pack-refs --all &&
+	git update-ref refs/heads/loose-checked-update $A &&
+	mark_packed_refs &&
+	git update-ref refs/heads/loose-checked-update $B $A &&
+	check_packed_refs_marked
+'
+
+test_expect_success 'leave packed-refs untouched on verify of loose' '
+	git pack-refs --all &&
+	git update-ref refs/heads/loose-verify $A &&
+	mark_packed_refs &&
+	echo "verify refs/heads/loose-verify $A" | git update-ref --stdin &&
+	check_packed_refs_marked
+'
+
+test_expect_failure 'leave packed-refs untouched on delete of loose' '
+	git pack-refs --all &&
+	git update-ref refs/heads/loose-delete $A &&
+	mark_packed_refs &&
+	git update-ref -d refs/heads/loose-delete &&
+	check_packed_refs_marked
+'
+
+test_done
-- 
2.14.1

