Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FA4520986
	for <e@80x24.org>; Fri, 21 Oct 2016 10:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbcJUKmO (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 06:42:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:60562 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754253AbcJUKmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 06:42:13 -0400
Received: (qmail 17457 invoked by uid 109); 21 Oct 2016 10:42:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 10:42:12 +0000
Received: (qmail 1890 invoked by uid 111); 21 Oct 2016 10:42:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 06:42:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 06:42:10 -0400
Date:   Fri, 21 Oct 2016 06:42:10 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: [PATCH 1/3] test-lib: handle TEST_OUTPUT_DIRECTORY with spaces
Message-ID: <20161021104210.lvmet65avogogiqo@sigill.intra.peff.net>
References: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are careful in test_done to handle a results directory
with a space in it, but the "--tee" code path does not.
Doing:

  export TEST_OUTPUT_DIRECTORY='/tmp/path with spaces'
  ./t000-init.sh --tee

results in errors. Let's consistently double-quote our path
variables so that this works.

Signed-off-by: Jeff King <peff@peff.net>
---
I imagine nobody cares much about this, but I just happened to notice it
while writing the rest of the patches (and it's obviously quite easy to
fix).

 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 11562bde10..33cbbb7806 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -58,8 +58,8 @@ done,*)
 	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
 	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
 	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
-	 echo $? > $BASE.exit) | tee $BASE.out
-	test "$(cat $BASE.exit)" = 0
+	 echo $? >"$BASE.exit") | tee "$BASE.out"
+	test "$(cat "$BASE.exit")" = 0
 	exit
 	;;
 esac
-- 
2.10.1.776.ge0e381e

