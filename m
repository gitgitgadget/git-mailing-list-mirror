Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C172C636CC
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 00:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBQAkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 19:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBQAkc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 19:40:32 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CD85381A
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 16:40:30 -0800 (PST)
Received: (qmail 896 invoked by uid 109); 17 Feb 2023 00:40:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Feb 2023 00:40:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14517 invoked by uid 111); 17 Feb 2023 00:40:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Feb 2023 19:40:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Feb 2023 19:40:29 -0500
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares Bernardino <matheus.tavb@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: [PATCH 2/1] t0066: drop setup of "dir5"
Message-ID: <Y+7M/VLcDRDCXX27@coredump.intra.peff.net>
References: <9bb10b607e46f867a3f8f5c71abf13c990d1ecfe.1676572031.git.me@ttaylorr.com>
 <Y+560+/G4pelldXF@coredump.intra.peff.net>
 <Y+6L9R9HkkUc7PkX@nand.local>
 <Y+6Mcnng0u6sz+C6@nand.local>
 <CAGdrTFhHBU2BNYdYr7LbOS7i1LOHGjWLw_d5ZJAXxvTKyLiFCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGdrTFhHBU2BNYdYr7LbOS7i1LOHGjWLw_d5ZJAXxvTKyLiFCA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 09:16:50PM -0300, Matheus Tavares Bernardino wrote:

> Oh, it's been some time. But yes, dir5 is vestigial and should indeed
> be removed. It was created back when I wanted to make dir-iterator
> detect and avoid recursive symlinks (see this [1] earlier version of
> the patch, where there was a test grepping for dir5 at the output).
> But this idea ended up being discarded and I must have forgotten to
> remove the dir5.

Thanks! It's not super-important, but while we're thinking about it, it
probably makes sense to do this cleanup (I prepared it on top of
Taylor's patch, since it would otherwise conflict textually):

-- >8 --
Subject: t0066: drop setup of "dir5"

The symlink setup in t0066 makes several directories with links, dir4
through dir6. But ever since dir5 was introduced in fa1da7d2ee
(dir-iterator: add flags parameter to dir_iterator_begin, 2019-07-10),
it has never actually been used. It was left over from an earlier
iteration of the patch which tried to handle recursive symlinks
specially, as seen in:

  https://lore.kernel.org/git/20190502144829.4394-7-matheus.bernardino@usp.br/

It's not hurting any of the existing tests to be there, but the extra
setup is confusing to anybody trying to read and understand the tests.
Let's drop the extra directory, and we'll rename "dir6" to "dir5" so
nobody wonders whether the gap in naming is important.

Helped-by: Matheus Tavares Bernardino <matheus.tavb@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0066-dir-iterator.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 4ed3136b00..7d0a0da8c0 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -106,13 +106,7 @@ test_expect_success SYMLINKS 'setup dirs with symlinks' '
 	ln -s d dir4/a/e &&
 	ln -s ../b dir4/a/f &&
 
-	mkdir -p dir5/a/b &&
-	mkdir -p dir5/a/c &&
-	ln -s ../c dir5/a/b/d &&
-	ln -s ../ dir5/a/b/e &&
-	ln -s ../../ dir5/a/b/f &&
-
-	ln -s dir4 dir6
+	ln -s dir4 dir5
 '
 
 test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default' '
@@ -132,7 +126,7 @@ test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default
 '
 
 test_expect_success SYMLINKS 'dir-iterator does not resolve top-level symlinks' '
-	test_must_fail test-tool dir-iterator ./dir6 >out &&
+	test_must_fail test-tool dir-iterator ./dir5 >out &&
 
 	grep "ENOTDIR" out
 '
-- 
2.39.2.920.gf3beb43ccf

