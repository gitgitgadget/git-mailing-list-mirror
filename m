Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4C3A20401
	for <e@80x24.org>; Wed, 21 Jun 2017 19:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbdFUT3C (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:29:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:47888 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751028AbdFUT3B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:29:01 -0400
Received: (qmail 6317 invoked by uid 109); 21 Jun 2017 19:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 19:29:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26728 invoked by uid 111); 21 Jun 2017 19:29:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 15:29:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 15:28:59 -0400
Date:   Wed, 21 Jun 2017 15:28:59 -0400
From:   Jeff King <peff@peff.net>
To:     Christian =?utf-8?B?UsO2c2No?= <christian@croesch.de>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] add--interactive: quote commentChar regex
Message-ID: <20170621192859.udejhkl66ylsbg24@sigill.intra.peff.net>
References: <20170621192315.3umx4lszvzwjffnb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170621192315.3umx4lszvzwjffnb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since c9d961647 (i18n: add--interactive: mark
edit_hunk_manually message for translation, 2016-12-14),
when the user asks to edit a hunk manually, we respect
core.commentChar in generating the edit instructions.
However, when we then strip out comment lines, we use a
simple regex like:

  /^$commentChar/

If your chosen comment character is a regex metacharacter,
then that will behave in a confusing manner ("$", for
instance, would only eliminate blank lines, not actual
comment lines).

We can fix that by telling perl not to respect
metacharacters.

Reported-by: Christian Rösch <christian@croesch.de>
Signed-off-by: Jeff King <peff@peff.net>
---
I did this on the current master. It also applies cleanly on top of
'maint'. The fix applies back as far as c9d961647, but t3701 grew some
new tests in the interim, so there's a minor conflict applying it there.

 git-add--interactive.perl  | 2 +-
 t/t3701-add-interactive.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index fc722fe8a..0e8543c86 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1081,7 +1081,7 @@ EOF2
 
 	open $fh, '<', $hunkfile
 		or die sprintf(__("failed to open hunk edit file for reading: %s"), $!);
-	my @newtext = grep { !/^$comment_line_char/ } <$fh>;
+	my @newtext = grep { !/^\Q$comment_line_char\E/ } <$fh>;
 	close $fh;
 	unlink $hunkfile;
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 2ecb43a61..2f3e7cea6 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -477,4 +477,12 @@ test_expect_success 'add -p does not expand argument lists' '
 	! grep not-changed trace.out
 '
 
+test_expect_success 'hunk-editing handles custom comment char' '
+	git reset --hard &&
+	echo change >>file &&
+	test_config core.commentChar "\$" &&
+	echo e | GIT_EDITOR=true git add -p &&
+	git diff --exit-code
+'
+
 test_done
-- 
2.13.1.792.g159074dab
