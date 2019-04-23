Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80A51F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 04:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfDWEeW (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 00:34:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:37720 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727486AbfDWEeW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 00:34:22 -0400
Received: (qmail 17843 invoked by uid 109); 23 Apr 2019 04:34:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 04:34:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5872 invoked by uid 111); 23 Apr 2019 04:34:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 23 Apr 2019 00:34:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Apr 2019 00:34:20 -0400
Date:   Tue, 23 Apr 2019 00:34:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] t/perf: depend on perl JSON only when using --codespeed
Message-ID: <20190423043419.GA11689@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 05eb1c37ed (perf/aggregate: implement codespeed JSON output,
2018-01-05) added a dependency on the perl JSON module to show output
from aggregate.perl, but we only need it when the user asks for
--codespeed output. While the module is pretty common, it's not part of
the base system, and this dependency can get in the way of producing the
default human-readable output.

Let's bump the "use" down to a "require" in the code path that needs it,
which will be interpreted at run-time instead of compile-time. People
not using "--codespeed" won't even load the module, and anybody using it
should see the same results (including the same perl error if they don't
have it).

Note that this skips the importing step, so we'll have to fully qualify
our function call. We could accomplish the same thing in other ways.
E.g., calling JSON->import() ourselves, or wrapping "use JSON" in an
eval. Since there's only one such call, this seems like the
least-magical way of doing it.

Signed-off-by: Jeff King <peff@peff.net>
---
This bites me occasionally when running perf tests on many-core work
machines where I can't just "apt-get install libjson-perl". So I finally
decided look into it. :)

 t/perf/aggregate.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 494907a892..76dd48f890 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -3,7 +3,6 @@
 use lib '../../perl/build/lib';
 use strict;
 use warnings;
-use JSON;
 use Getopt::Long;
 use Git;
 
@@ -342,7 +341,8 @@ sub print_codespeed_results {
 		}
 	}
 
-	print to_json(\@data, {utf8 => 1, pretty => 1, canonical => 1}), "\n";
+	require JSON;
+	print JSON::to_json(\@data, {utf8 => 1, pretty => 1, canonical => 1}), "\n";
 }
 
 binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
-- 
2.21.0.1182.g3590c06d32
