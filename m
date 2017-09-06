Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F938208CD
	for <e@80x24.org>; Wed,  6 Sep 2017 11:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbdIFLxS (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 07:53:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:58456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752767AbdIFLxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 07:53:18 -0400
Received: (qmail 13924 invoked by uid 109); 6 Sep 2017 11:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 11:53:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21277 invoked by uid 111); 6 Sep 2017 11:53:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Sep 2017 07:53:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Sep 2017 07:53:10 -0400
Date:   Wed, 6 Sep 2017 07:53:10 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] rev-parse: don't trim bisect refnames
Message-ID: <20170906115310.kxgjrnmrehm5m32q@sigill.intra.peff.net>
References: <CA+55aFxW3qcETiMrNk5SqZU+_jtM2Rxeb3mhF=J=c0ChdGm1tg@mail.gmail.com>
 <20170905215056.4wihyd6hrtvk52yd@sigill.intra.peff.net>
 <CA+55aFywhyELmbhAorgTjJZeuNxE-+j2qSP=3d3vqQXNM6p54A@mail.gmail.com>
 <20170905220300.isxbt5y5fd2scd6b@sigill.intra.peff.net>
 <CA+55aFw==7bqv0dH=cQruXbGjMw-WNrRMreMsYy_4NcrbiWSEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFw==7bqv0dH=cQruXbGjMw-WNrRMreMsYy_4NcrbiWSEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 03:13:41PM -0700, Linus Torvalds wrote:

> On Tue, Sep 5, 2017 at 3:03 PM, Jeff King <peff@peff.net> wrote:
> >
> > This probably fixes it:
> 
> Yup. Thanks.

Thanks for confirming. Here it is with a commit message and test.

-- >8 --
Subject: [PATCH] rev-parse: don't trim bisect refnames

Using for_each_ref_in() with a full refname has always been
a questionable practice, but it became an error with
b9c8e7f2fb (prefix_ref_iterator: don't trim too much,
2017-05-22), making "git rev-parse --bisect" pretty reliably
show a BUG.

Commit 03df567fbf (for_each_bisect_ref(): don't trim
refnames, 2017-06-18) fixed this case for revision.c, but
rev-parse handles this option on its own. We can use the
same solution here (and piggy-back on its test).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c        |  4 ++--
 t/t6002-rev-list-bisect.sh | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2bd28d3c08..9f24004c0a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -757,8 +757,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_ref_in("refs/bisect/bad", show_reference, NULL);
-				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
+				for_each_fullref_in("refs/bisect/bad", show_reference, NULL, 0);
+				for_each_fullref_in("refs/bisect/good", anti_reference, NULL, 0);
 				continue;
 			}
 			if (opt_with_value(arg, "--branches", &arg)) {
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index 534903bbd2..a661408038 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -236,17 +236,31 @@ test_sequence "--bisect"
 #
 #
 
-test_expect_success '--bisect can default to good/bad refs' '
+test_expect_success 'set up fake --bisect refs' '
 	git update-ref refs/bisect/bad c3 &&
 	good=$(git rev-parse b1) &&
 	git update-ref refs/bisect/good-$good $good &&
 	good=$(git rev-parse c1) &&
-	git update-ref refs/bisect/good-$good $good &&
+	git update-ref refs/bisect/good-$good $good
+'
 
+test_expect_success 'rev-list --bisect can default to good/bad refs' '
 	# the only thing between c3 and c1 is c2
 	git rev-parse c2 >expect &&
 	git rev-list --bisect >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-parse --bisect can default to good/bad refs' '
+	git rev-parse c3 ^b1 ^c1 >expect &&
+	git rev-parse --bisect >actual &&
+
+	# output order depends on the refnames, which in turn depends on
+	# the exact sha1s. We just want to make sure we have the same set
+	# of lines in any order.
+	sort <expect >expect.sorted &&
+	sort <actual >actual.sorted &&
+	test_cmp expect.sorted actual.sorted
+'
+
 test_done
-- 
2.14.1.757.g8fad538cea

