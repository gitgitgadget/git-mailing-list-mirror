Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67235E7D0AB
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 20:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjIUUtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjIUUs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 16:48:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E913E8ED58
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 10:45:07 -0700 (PDT)
Received: (qmail 20302 invoked by uid 109); 21 Sep 2023 04:18:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Sep 2023 04:18:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3634 invoked by uid 111); 21 Sep 2023 04:18:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Sep 2023 00:18:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Sep 2023 00:18:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] test-lib: set UBSAN_OPTIONS to match ASan
Message-ID: <20230921041825.GA2814583@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a long time we have used ASAN_OPTIONS to set abort_on_error. This is
important because we want to notice detected problems even in programs
which are expected to fail. But we never did the same for UBSAN_OPTIONS.
This means that our UBSan test suite runs might silently miss some
cases.

It also causes a more visible effect, which is that t4058 complains
about unexpected "fixes" (and this is how I noticed the issue):

  $ make SANITIZE=undefined CC=gcc && (cd t && ./t4058-*)
  ...
  ok 8 - git read-tree does not segfault # TODO known breakage vanished
  ok 9 - reset --hard does not segfault # TODO known breakage vanished
  ok 10 - git diff HEAD does not segfault # TODO known breakage vanished

The tests themselves aren't that interesting. We have a known bug where
these programs segfault, and they do when compiled without sanitizers.
With UBSan, when the test runs:

  test_might_fail git read-tree --reset base

it gets:

  cache-tree.c:935:9: runtime error: member access within misaligned address 0x5a5a5a5a5a5a5a5a for type 'struct cache_entry', which requires 8 byte alignment

So that's garbage memory which would _usually_ cause us to segfault, but
UBSan catches it and complains first about the alignment. That makes
sense, but the weird thing is that UBSan then exits instead of aborting,
so our test_might_fail call considers that an acceptable outcome and the
test "passes".

Curiously, this historically seems to have aborted, because I've run
"make test" with UBSan many times (and so did our CI) and we never saw
the problem. Even more curiously, I see an abort if I use clang with
ASan and UBSan together, like:

  # this aborts!
  make SANITIZE=undefined,address CC=clang

But not with just UBSan, and not with both when used with gcc:

  # none of these do
  make SANITIZE=undefined CC=gcc
  make SANITIZE=undefined CC=clang
  make SANITIZE=undefined,address CC=gcc

Likewise moving to older versions of gcc (I tried gcc-11 and gcc-12 on
my Debian system) doesn't abort. Nor does moving around in Git's
history. Neither this test nor the relevant code have been touched in a
while, and going back to v2.41.0 produces the same outcome (even though
many UBSan CI runs have passed in the meantime).

So _something_ changed on my system (and likely will soon on other
people's, since this is stock Debian unstable), but I didn't track
it further. I don't know why it ever aborted in the past, but we
definitely should be explicit here and tell UBSan what we want to
happen.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd/apache.conf | 1 +
 t/test-lib.sh           | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index a22d138605..022276a6b9 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -92,6 +92,7 @@ PassEnv GIT_VALGRIND_OPTIONS
 PassEnv GNUPGHOME
 PassEnv ASAN_OPTIONS
 PassEnv LSAN_OPTIONS
+PassEnv UBSAN_OPTIONS
 PassEnv GIT_TRACE
 PassEnv GIT_CONFIG_NOSYSTEM
 PassEnv GIT_TEST_SIDEBAND_ALL
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5ea5d1d62a..1656c9eed0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -89,6 +89,9 @@ prepend_var LSAN_OPTIONS : $GIT_SAN_OPTIONS
 prepend_var LSAN_OPTIONS : fast_unwind_on_malloc=0
 export LSAN_OPTIONS
 
+prepend_var UBSAN_OPTIONS : $GIT_SAN_OPTIONS
+export UBSAN_OPTIONS
+
 if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 then
 	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
-- 
2.42.0.711.g968f0256ae
