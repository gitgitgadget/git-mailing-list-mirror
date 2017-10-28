Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4F87202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 09:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbdJ1JQM (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 05:16:12 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:51717 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751189AbdJ1JQL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 05:16:11 -0400
X-AuditID: 12074414-0d3ff70000006ddf-0e-59f44ada5f95
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id CA.4D.28127.ADA44F95; Sat, 28 Oct 2017 05:16:10 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE7F1.dip0.t-ipconnect.de [84.170.231.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9S9G5TF015456
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 28 Oct 2017 05:16:09 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/2] t1409: check that `packed-refs` is not rewritten unnecessarily
Date:   Sat, 28 Oct 2017 11:16:01 +0200
Message-Id: <aac0252b94120fcfc6ae9c09531f76a252d423cc.1509181545.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509181545.git.mhagger@alum.mit.edu>
References: <cover.1509181545.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqHvL60ukwYSVChZdV7qZLBp6rzBb
        3F4xn9niR0sPs8WZN42MDqwef99/YPJ41ruH0ePiJWWPxQ+8PD5vkgtgjeKySUnNySxLLdK3
        S+DKeLfJtOCQasXfvd2MDYwL5LsYOTkkBEwkPlxdz9TFyMUhJLCDSeLjwzuMEM4pJon7nRfY
        QarYBHQlFvU0M4HYIgJqEhPbDrGAFDEL9DJKPFr8ihEkISwQJrHxxFawBhYBVYkN9z+DNfAK
        REn07PjKBLFOXuLcg9vMIDangIXEurb5LCC2kIC5ROP8YywTGHkWMDKsYpRLzCnN1c1NzMwp
        Tk3WLU5OzMtLLdK10MvNLNFLTSndxAgJHJEdjEdOyh1iFOBgVOLhlcj9HCnEmlhWXJl7iFGS
        g0lJlHff+U+RQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR485y/RArxpiRWVqUW5cOkpDlYlMR5
        vy1W9xMSSE8sSc1OTS1ILYLJynBwKEnwTvMEahQsSk1PrUjLzClBSDNxcIIM5wEafgCkhre4
        IDG3ODMdIn+K0Zij4+bdP0wcz2a+bmAWYsnLz0uVEufdC1IqAFKaUZoHNw0W/a8YxYGeE+a9
        ClLFA0wccPNeAa1iAlqlIQm2qiQRISXVwNiovOXY842N3cpqm4KMql2EflRuSjy3rSNhmauW
        7spTXEcWtt1cpMDxkufcDYbof1taTpfkf5q/714315qDvV53Ujz2nn6yePaSvTvmfeZXefM/
        LqOGszE7/rZeyvtNQcoZKY9PMTlVKRve5dg083Ot14qze550BHT0F1064iahmZ3WkKSaz6LE
        UpyRaKjFXFScCAA9ri2d2QIAAA==
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

