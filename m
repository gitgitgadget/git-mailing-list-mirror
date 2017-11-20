Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35795202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbdKTU1W (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:27:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:35022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752499AbdKTU1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:27:21 -0500
Received: (qmail 3932 invoked by uid 109); 20 Nov 2017 20:27:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 20:27:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15819 invoked by uid 111); 20 Nov 2017 20:27:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 15:27:37 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 15:27:19 -0500
Date:   Mon, 20 Nov 2017 15:27:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] t/perf/lib-pack: use fast-import checkpoint to create
 packs
Message-ID: <20171120202719.x2vjrwoieg3wph73@sigill.intra.peff.net>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently use fast-import only to create a large number
of objects, and then run O(n) invocations of pack-objects to
turn them into packs.

We can do this faster by just asking fast-import to
checkpoint and create a pack for each (after telling it
not to turn loose tiny packs).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/lib-pack.sh | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/t/perf/lib-pack.sh b/t/perf/lib-pack.sh
index 501bb7b272..d3865db286 100644
--- a/t/perf/lib-pack.sh
+++ b/t/perf/lib-pack.sh
@@ -9,15 +9,10 @@ create_packs () {
 			print "data <<EOF";
 			print "$_";
 			print "EOF";
+			print "checkpoint"
 		}
 	' "$@" |
-	git fast-import &&
-
-	git cat-file --batch-all-objects --batch-check='%(objectname)' |
-	while read sha1
-	do
-		echo $sha1 | git pack-objects .git/objects/pack/pack
-	done
+	git fast-import
 }
 
 # create a large number of packs, disabling any gc which might
@@ -25,5 +20,6 @@ create_packs () {
 setup_many_packs () {
 	git config gc.auto 0 &&
 	git config gc.autopacklimit 0 &&
+	git config fastimport.unpacklimit 0 &&
 	create_packs 500
 }
-- 
2.15.0.494.g79a8547723

