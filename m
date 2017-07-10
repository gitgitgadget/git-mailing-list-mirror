Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A75C20357
	for <e@80x24.org>; Mon, 10 Jul 2017 13:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbdGJNYi (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 09:24:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:35384 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753864AbdGJNYi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 09:24:38 -0400
Received: (qmail 17810 invoked by uid 109); 10 Jul 2017 13:24:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 13:24:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5042 invoked by uid 111); 10 Jul 2017 13:24:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 09:24:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 09:24:35 -0400
Date:   Mon, 10 Jul 2017 09:24:35 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] test-lib: set ASAN_OPTIONS variable before we run git
Message-ID: <20170710132435.ncebevyvv2uwtzxp@sigill.intra.peff.net>
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We turn off ASan's leak detection by default in the test
suite because it's too noisy. But we don't do so until
part-way through test-lib. This is before we've run any
tests, but after we do our initial "./git" to see if the
binary has even been built.

When built with clang, this seems to work fine. However,
using "gcc -fsanitize=address", the leak checker seems to
complain more aggressively:

  $ ./git
  ...
  ==5352==ERROR: LeakSanitizer: detected memory leaks
  Direct leak of 2 byte(s) in 1 object(s) allocated from:
      #0 0x7f120e7afcf8 in malloc (/usr/lib/x86_64-linux-gnu/libasan.so.3+0xc1cf8)
      #1 0x559fc2a3ce41 in do_xmalloc /home/peff/compile/git/wrapper.c:60
      #2 0x559fc2a3cf1a in do_xmallocz /home/peff/compile/git/wrapper.c:100
      #3 0x559fc2a3d0ad in xmallocz /home/peff/compile/git/wrapper.c:108
      #4 0x559fc2a3d0ad in xmemdupz /home/peff/compile/git/wrapper.c:124
      #5 0x559fc2a3d0ad in xstrndup /home/peff/compile/git/wrapper.c:130
      #6 0x559fc274535a in main /home/peff/compile/git/common-main.c:39
      #7 0x7f120dabd2b0 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x202b0)

This is a leak in the sense that we never free it, but it's
in a global that is meant to last the whole program. So it's
not really interesting or in need of fixing. And at any
rate, mentioning leaks outside of the test_expect blocks is
certainly unwelcome, as it pollutes stderr.

Let's bump the setting of ASAN_OPTIONS higher in test-lib.sh
to catch our initial "can we even run git?" test.  While
we're at it, we can add a comment to make it a bit less
inscrutable.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2306574dc..961194a50 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -36,6 +36,14 @@ then
 fi
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 
+# If we were built with ASAN, it may complain about leaks
+# of program-lifetime variables. Disable it by default to lower
+# the noise level. This needs to happen at the start of the script,
+# before we even do our "did we build git yet" check (since we don't
+# want that one to complain to stderr).
+: ${ASAN_OPTIONS=detect_leaks=0}
+export ASAN_OPTIONS
+
 ################################################################
 # It appears that people try to run tests without building...
 "$GIT_BUILD_DIR/git" >/dev/null
@@ -148,9 +156,6 @@ else
 	}
 fi
 
-: ${ASAN_OPTIONS=detect_leaks=0}
-export ASAN_OPTIONS
-
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
 unset CDPATH
-- 
2.13.2.1071.gcd8104b61

