Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7A6C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 10:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjBWKsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjBWKsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 05:48:04 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E7B15572
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 02:48:02 -0800 (PST)
Received: (qmail 24706 invoked by uid 109); 23 Feb 2023 10:48:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 10:48:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20062 invoked by uid 111); 23 Feb 2023 10:48:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 05:48:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 05:48:01 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/16] http test bug potpourri
Message-ID: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So all I wanted to do was this one-liner:

diff --git a/t/t5559-http-fetch-smart-http2.sh b/t/t5559-http-fetch-smart-http2.sh
index 9eece71c2c..54aa9d3bff 100755
--- a/t/t5559-http-fetch-smart-http2.sh
+++ b/t/t5559-http-fetch-smart-http2.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
 
 HTTP_PROTO=HTTP/2
+LIB_HTTPD_SSL=1
 . ./t5551-http-fetch-smart.sh

but somehow I'm 16 patches deep. Let me back up.

I got bit once again by the "oops, HTTP/2 tests in t5559 are sometimes
flaky" bug. One thing that came up in earlier discussion is that HTTP/2
over TLS should be much more reliable, because it doesn't have to go
through the funny HTTP-upgrade path.

Hence the patch above, which is also patch 16 here. And it does make the
consistent failure of t5551.30 go away. And it even makes --stress work
longer before a racy failure, though it still fails for me pretty
consistently within a few dozen runs.

But in doing so, I found out all sorts of neat things, like:

  - when I tested with HTTP/2 and TLS before, I was accidentally not
    using HTTP/2!

  - we even have a test that should detect which version is used, but
    it's a silent noop unless you set GIT_TEST_PROTOCOL_VERSION=0, which
    clearly nobody does

  - it turns out there are a bunch of tests which are skipped (some of
    which even fail!) unless you set that variable

So this series fixes the broken tests, adapts them to work with both v0
and v2 Git protocol, makes them work with HTTP/2 when needed, sprinkles
in a couple other fixes, and then finally does that one-liner.

I'm actually not sure if the final patch is a good idea or not, but
certainly all of the fixes leading up to it are worth doing.

  [01/16]: t5541: run "used receive-pack service" test earlier
  [02/16]: t5541: stop marking "used receive-pack service" test as v0 only
  [03/16]: t5541: simplify and move "no empty path components" test
  [04/16]: t5551: drop redundant grep for Accept-Language
  [05/16]: t5551: lower-case headers in expected curl trace
  [06/16]: t5551: handle HTTP/2 when checking curl trace
  [07/16]: t5551: stop forcing clone to run with v0 protocol
  [08/16]: t5551: handle v2 protocol when checking curl trace
  [09/16]: t5551: handle v2 protocol in upload-pack service test
  [10/16]: t5551: simplify expected cookie file
  [11/16]: t5551: handle v2 protocol in cookie test
  [12/16]: t5551: drop curl trace lines without headers
  [13/16]: t/lib-httpd: respect $HTTPD_PROTO in expect_askpass()
  [14/16]: t/lib-httpd: enable HTTP/2 "h2" protocol, not just h2c
  [15/16]: t5559: fix test failures with LIB_HTTPD_SSL
  [16/16]: t5559: make SSL/TLS the default

 t/lib-httpd.sh                    |   6 +-
 t/lib-httpd/apache.conf           |   2 +-
 t/t5541-http-push-smart.sh        |  57 +++-------
 t/t5551-http-fetch-smart.sh       | 170 ++++++++++++++++++------------
 t/t5559-http-fetch-smart-http2.sh |   1 +
 5 files changed, 122 insertions(+), 114 deletions(-)

-Peff
