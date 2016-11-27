Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA4B31FBB0
	for <e@80x24.org>; Sun, 27 Nov 2016 06:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbcK0Ges (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 01:34:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:47499 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbcK0Ger (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 01:34:47 -0500
Received: (qmail 30626 invoked by uid 109); 27 Nov 2016 06:34:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 27 Nov 2016 06:34:46 +0000
Received: (qmail 26887 invoked by uid 111); 27 Nov 2016 06:35:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 27 Nov 2016 01:35:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2016 01:34:45 -0500
Date:   Sun, 27 Nov 2016 01:34:45 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Armin Kunaschik <megabreit@googlemail.com>
Subject: [PATCH] t7610: clean up foo.* tmpdir
Message-ID: <20161127063444.qzuzyab55gmofhfl@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[resend; the original subject with foo.XXXXXX was bounced by vger for
being too sexy]

-- >8 --
Subject: [PATCH] t7610: clean up foo.XXXXXX tmpdir

The lazy prereq for MKTEMP uses "mktemp -t" to see if
mergetool's internal mktemp call will be able to run. But
unlike the call inside mergetool, we do not ever bother to
clean up the result, and the /tmp of git developers will
slowly fill up with "foo.XXXXXX" directories as they run the
test suite over and over.  Let's clean up the directory
after we've verified its creation.

Note that we don't use test_when_finished here, and instead
just make rmdir part of the &&-chain. We should only remove
something that we're confident we just created. A failure in
the middle of the chain either means there's nothing to
clean up, or we are very confused and should err on the side
of caution.

Signed-off-by: Jeff King <peff@peff.net>
---
This has been happening since c578a09bd (t7610: test for mktemp before
test execution, 2016-07-02). I have noticed the foo.* directories
building in /tmp, but I never bothered to track it down before.  I just
assumed from the name it was one of my personal hacky scripts. :)

It does make me wonder if test-lib.sh ought to just set $TMPDIR inside
the trash directory so that any cruft we fail to cleanup is contained.

 t/t7610-mergetool.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 6d9f21511..63d36fb28 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -591,7 +591,8 @@ test_expect_success 'filenames seen by tools start with ./' '
 
 test_lazy_prereq MKTEMP '
 	tempdir=$(mktemp -d -t foo.XXXXXX) &&
-	test -d "$tempdir"
+	test -d "$tempdir" &&
+	rmdir "$tempdir"
 '
 
 test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToTemp' '
-- 
2.11.0.rc3.315.gde8259a
