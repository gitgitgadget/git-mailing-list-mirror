Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54770C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 08:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3497D20716
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 08:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgC0IDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:03:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:53264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726027AbgC0IDC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 04:03:02 -0400
Received: (qmail 9373 invoked by uid 109); 27 Mar 2020 08:03:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Mar 2020 08:03:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23019 invoked by uid 111); 27 Mar 2020 08:12:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2020 04:12:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Mar 2020 04:03:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] test-lib-functions: make packetize() more efficient
Message-ID: <20200327080300.GA605934@coredump.intra.peff.net>
References: <20200327080210.GA604725@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327080210.GA604725@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The packetize() function takes its input on stdin, and requires 4
separate sub-processes to format a simple string. We can do much better
by getting the length via the shell's "${#packet}" construct. The one
caveat is that the shell can't put a NUL into a variable, so we'll have
to continue to provide the stdin form for a few calls.

There are a few other cleanups here in the touched code:

 - the stdin form of packetize() had an extra stray "%s" when printing
   the packet

 - the converted calls in t5562 can be made simpler by redirecting
   output as a block, rather than repeated appending

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5562-http-backend-content-length.sh | 19 ++++++++++++-------
 t/test-lib-functions.sh                | 23 ++++++++++++++++-------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 4a110b307e..3f4ac71f83 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -53,15 +53,20 @@ test_expect_success 'setup' '
 	test_commit c1 &&
 	hash_head=$(git rev-parse HEAD) &&
 	hash_prev=$(git rev-parse HEAD~1) &&
-	printf "want %s" "$hash_head" | packetize >fetch_body &&
-	printf 0000 >>fetch_body &&
-	printf "have %s" "$hash_prev" | packetize >>fetch_body &&
-	printf done | packetize >>fetch_body &&
+	{
+		packetize "want $hash_head" &&
+		printf 0000 &&
+		packetize "have $hash_prev" &&
+		packetize "done"
+	} >fetch_body &&
 	test_copy_bytes 10 <fetch_body >fetch_body.trunc &&
 	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
-	printf "%s %s refs/heads/newbranch\\0report-status\\n" "$ZERO_OID" "$hash_next" | packetize >push_body &&
-	printf 0000 >>push_body &&
-	echo "$hash_next" | git pack-objects --stdout >>push_body &&
+	{
+		printf "%s %s refs/heads/newbranch\\0report-status\\n" \
+			"$ZERO_OID" "$hash_next" | packetize &&
+		printf 0000 &&
+		echo "$hash_next" | git pack-objects --stdout
+	} >push_body &&
 	test_copy_bytes 10 <push_body >push_body.trunc &&
 	: >empty_body
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 352c213d52..216918a58c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1362,14 +1362,23 @@ nongit () {
 	)
 } 7>&2 2>&4
 
-# convert stdin to pktline representation; note that empty input becomes an
-# empty packet, not a flush packet (for that you can just print 0000 yourself).
+# convert function arguments or stdin (if not arguments given) to pktline
+# representation. If multiple arguments are given, they are separated by
+# whitespace and put in a single packet. Note that data containing NULs must be
+# given on stdin, and that empty input becomes an empty packet, not a flush
+# packet (for that you can just print 0000 yourself).
 packetize() {
-	cat >packetize.tmp &&
-	len=$(wc -c <packetize.tmp) &&
-	printf '%04x%s' "$(($len + 4))" &&
-	cat packetize.tmp &&
-	rm -f packetize.tmp
+	if test $# -gt 0
+	then
+		packet="$*"
+		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
+	else
+		cat >packetize.tmp &&
+		len=$(wc -c <packetize.tmp) &&
+		printf '%04x' "$(($len + 4))" &&
+		cat packetize.tmp &&
+		rm -f packetize.tmp
+	fi
 }
 
 # Parse the input as a series of pktlines, writing the result to stdout.
-- 
2.26.0.581.g322f77c0ee

