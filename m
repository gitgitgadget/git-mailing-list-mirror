Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B7DC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7043560E94
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhJEUc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:32:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:33348 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhJEUc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 16:32:28 -0400
Received: (qmail 17626 invoked by uid 109); 5 Oct 2021 20:30:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Oct 2021 20:30:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6449 invoked by uid 111); 5 Oct 2021 20:30:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Oct 2021 16:30:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Oct 2021 16:30:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] t1006: clean up broken objects
Message-ID: <YVy17IsgNNyl4Dvh@coredump.intra.peff.net>
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few of the tests create intentionally broken objects with broken
types. Let's clean them up after we're done with them, so that later
tests don't get confused (we hadn't noticed because this only affects
tests which use --batch-all-objects, but I'm about to add more).

Signed-off-by: Jeff King <peff@peff.net>
---
I was puzzled why the existing --batch-all-objects tests didn't get
confused by this, but it's because they operate in a sub-repo. My new
tests _could_ do that, too, but this seemed like confusion waiting to
happen.

 t/t1006-cat-file.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 18b3779ccb..c77db35728 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -331,6 +331,11 @@ test_expect_success "Size of broken object is correct" '
 	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
 	test_cmp expect actual
 '
+
+test_expect_success 'clean up broken object' '
+	rm .git/objects/$(test_oid_to_path $bogus_sha1)
+'
+
 bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
 bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
@@ -348,6 +353,10 @@ test_expect_success "Size of large broken object is correct when type is large"
 	test_cmp expect actual
 '
 
+test_expect_success 'clean up broken object' '
+	rm .git/objects/$(test_oid_to_path $bogus_sha1)
+'
+
 # Tests for git cat-file --follow-symlinks
 test_expect_success 'prep for symlink tests' '
 	echo_without_newline "$hello_content" >morx &&
-- 
2.33.0.1231.g45ae28b974

