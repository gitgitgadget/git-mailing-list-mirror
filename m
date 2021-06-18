Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD58C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A091A61260
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhFRQee (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:34:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:60312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235336AbhFRQed (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 12:34:33 -0400
Received: (qmail 27641 invoked by uid 109); 18 Jun 2021 16:32:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Jun 2021 16:32:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17208 invoked by uid 111); 18 Jun 2021 16:32:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Jun 2021 12:32:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Jun 2021 12:32:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t: use portable wrapper for readlink(1)
Message-ID: <YMzKlrmHFZdx2ti9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not all systems have a readlink program available for use by the shell.
This causes t3210 to fail on at least AIX. Let's provide a perl
one-liner to do the same thing, and use it there.

I also updated calls in t9802. Nobody reported failure there, but it's
the same issue. Presumably nobody actually tests with p4 on AIX in the
first place (if it is even available there).

I left the use of readlink in the "--valgrind" setup in test-lib.sh, as
valgrind isn't available on exotic platforms anyway (and I didn't want
to increase dependencies between test-lib.sh and test-lib-functions.sh).

There's one other curious case. Commit d2addc3b96 (t7800: readlink may
not be available, 2016-05-31) fixed a similar case. We can't use our
wrapper function there, though, as it's inside a sub-script triggered by
Git. It uses a slightly different technique ("ls" piped to "sed"). I
chose not to use that here as it gives confusing "ls -l" output if the
file is unexpectedly not a symlink (which is OK for its limited use, but
potentially confusing for general use within the test suite). The perl
version emits the empty string.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This is a re-post that doesn't seem to have made it into "seen"; the
original[1] was buried in a thread, but Ævar reported there that it
fixes t3210 on his AIX build.

[1] https://lore.kernel.org/git/YLk0Zm2J6VOA%2Flks@coredump.intra.peff.net/

 t/t3210-pack-refs.sh       | 2 +-
 t/t9802-git-p4-filetype.sh | 4 ++--
 t/test-lib-functions.sh    | 6 ++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 3b7cdc56ec..577f32dc71 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -253,7 +253,7 @@ test_expect_success SYMLINKS 'pack symlinked packed-refs' '
 	git for-each-ref >all-refs-packed &&
 	test_cmp all-refs-before all-refs-packed &&
 	test -h .git/packed-refs &&
-	test "$(readlink .git/packed-refs)" = "my-deviant-packed-refs"
+	test "$(test_readlink .git/packed-refs)" = "my-deviant-packed-refs"
 '
 
 test_done
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 94edebe272..19073c6e9f 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -263,7 +263,7 @@ test_expect_success SYMLINKS 'ensure p4 symlink parsed correctly' '
 	(
 		cd "$git" &&
 		test -L symlink &&
-		test $(readlink symlink) = symlink-target
+		test $(test_readlink symlink) = symlink-target
 	)
 '
 
@@ -329,7 +329,7 @@ test_expect_success SYMLINKS 'empty symlink target' '
 	git p4 clone --dest="$git" //depot@all &&
 	(
 		cd "$git" &&
-		test $(readlink empty-symlink) = target2
+		test $(test_readlink empty-symlink) = target2
 	)
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f0448daa74..b2810478a2 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1708,3 +1708,9 @@ test_region () {
 
 	return 0
 }
+
+# Print the destination of symlink(s) provided as arguments. Basically
+# the same as the readlink command, but it's not available everywhere.
+test_readlink () {
+	perl -le 'print readlink($_) for @ARGV' "$@"
+}
-- 
2.32.0.352.gff02c21e72
