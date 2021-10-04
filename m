Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E43AC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 08:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C18261130
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 08:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhJDIdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 04:33:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:60260 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhJDIdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 04:33:25 -0400
Received: (qmail 8788 invoked by uid 109); 4 Oct 2021 08:31:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Oct 2021 08:31:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12251 invoked by uid 111); 4 Oct 2021 08:31:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Oct 2021 04:31:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Oct 2021 04:31:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Subject: Re: [PATCH] p3400: stop using tac(1)
Message-ID: <YVq752xjzYz+LTq6@coredump.intra.peff.net>
References: <85831cc2-307f-1be8-9bb3-c44028ad07fa@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85831cc2-307f-1be8-9bb3-c44028ad07fa@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 02, 2021 at 07:44:14PM +0200, René Scharfe wrote:

> b3dfeebb92 (rebase: avoid computing unnecessary patch IDs, 2016-07-29)
> added a perf test that calls tac(1) from GNU core utilities.  Support
> systems without it by reversing the generated list using sort -nr
> instead.  sort(1) with options -n and -r is already used in other tests.

Cute fix. With regular seq(1), this whole thing can become:

  seq 1000 -1 1

without the extra process, but our test_seq doesn't understand non-1
increments (nor comparisons besides -le). It wouldn't be that hard to
teach it, but given that this is the first time we've wanted it, it may
not be worth the effort.

-Peff

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d733..76c8c0f2f6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1149,15 +1149,22 @@ test_cmp_fspath () {
 
 test_seq () {
 	case $# in
-	1)	set 1 "$@" ;;
-	2)	;;
-	*)	BUG "not 1 or 2 parameters to test_seq" ;;
+	1)	set 1 1 "$1" ;;
+	2)	set "$1" 1 "$2" ;;
+	3)	;;
+	*)	BUG "not 1, 2, or 3 parameters to test_seq" ;;
 	esac
+	if test "$1" -lt "$3"
+	then
+		test_seq_cmp__=-le
+	else
+		test_seq_cmp__=-ge
+	fi
 	test_seq_counter__=$1
-	while test "$test_seq_counter__" -le "$2"
+	while test "$test_seq_counter__" $test_seq_cmp__ "$3"
 	do
 		echo "$test_seq_counter__"
-		test_seq_counter__=$(( $test_seq_counter__ + 1 ))
+		test_seq_counter__=$(( $test_seq_counter__ + $2 ))
 	done
 }
 
