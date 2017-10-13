Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B5120437
	for <e@80x24.org>; Fri, 13 Oct 2017 17:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbdJMR0G (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 13:26:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:52386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752870AbdJMR0E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 13:26:04 -0400
Received: (qmail 31482 invoked by uid 109); 13 Oct 2017 17:26:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 17:26:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27305 invoked by uid 111); 13 Oct 2017 17:26:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 13:26:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 13:26:02 -0400
Date:   Fri, 13 Oct 2017 13:26:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 4/4] tag: respect color.ui config
Message-ID: <20171013172601.spqiyuutxs4fmlgz@sigill.intra.peff.net>
References: <20171013172020.adc2fkddgp3g2ses@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013172020.adc2fkddgp3g2ses@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 11b087adfd (ref-filter: consult want_color() before
emitting colors, 2017-07-13), we expect that setting
"color.ui" to "always" will enable color tag formats even
without a tty.  As that commit was built on top of
136c8c8b8f (color: check color.ui in git_default_config(),
2017-07-13) from the same series, we didn't need to touch
tag's config parsing at all.

However, since we reverted 136c8c8b8f, we now need to
explicitly call git_color_default_config() to make this
work.

Let's do so, and also restore the test dropped in 0c88bf5050
(provide --color option for all ref-filter users,
2017-10-03). That commit swapped out our "color.ui=always"
test for "--color" in preparation for "always" going away.
But since it is here to stay, we should test both cases.

Note that for-each-ref also lost its color.ui support as
part of reverting 136c8c8b8f. But as a plumbing command, it
should _not_ respect the color.ui config. Since it also
gained a --color option in 0c88bf5050, that's the correct
way to ask it for color. We'll continue to test that, and
confirm that "color.ui" is not respected.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c           | 2 +-
 t/t6300-for-each-ref.sh | 5 +++++
 t/t7004-tag.sh          | 6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 695cb0778e..b38329b593 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -158,7 +158,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
-	return git_default_config(var, value, cb);
+	return git_color_default_config(var, value, cb);
 }
 
 static void write_tag_body(int fd, const struct object_id *oid)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 416ff7d0b8..3aa534933e 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -442,6 +442,11 @@ test_expect_success '--color can override tty check' '
 	test_cmp expected.color actual
 '
 
+test_expect_success 'color.ui=always does not override tty check' '
+	git -c color.ui=always for-each-ref --format="$color_format" >actual &&
+	test_cmp expected.bare actual
+'
+
 cat >expected <<\EOF
 heads/master
 tags/master
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 4e62c505fc..a9af2de996 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1918,6 +1918,12 @@ test_expect_success '--color overrides auto-color' '
 	test_cmp expect.color actual
 '
 
+test_expect_success 'color.ui=always overrides auto-color' '
+	git -c color.ui=always tag $color_args >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect.color actual
+'
+
 test_expect_success 'setup --merged test tags' '
 	git tag mergetest-1 HEAD~2 &&
 	git tag mergetest-2 HEAD~1 &&
-- 
2.15.0.rc1.395.ga4290b5804
