Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03E120899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbdHBWaV (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:30:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:56294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751172AbdHBWaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:30:21 -0400
Received: (qmail 3941 invoked by uid 109); 2 Aug 2017 22:30:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 22:30:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14158 invoked by uid 111); 2 Aug 2017 22:30:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 18:30:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 18:30:19 -0400
Date:   Wed, 2 Aug 2017 18:30:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] revision: do not fallback to default when
 rev_input_given is set
Message-ID: <20170802223018.h2uabdpmtz3gw27g@sigill.intra.peff.net>
References: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802222425.7xkoxniz2xbjlnku@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If revs->def is set (as it is in "git log") and there are no
pending objects after parsing the user's input, then we show
whatever is in "def". But if the user _did_ ask for some
input that just happened to be empty (e.g., "--glob" that
does not match anything), showing the default revision is
confusing. We should just show nothing, as that is what the
user's request yielded.

Signed-off-by: Jeff King <peff@peff.net>
---
The "!got_rev_arg" that's already in the conditional is interesting. I
wondered if it could be subsumed by the rev_input_given flag. But
digging in the history, I think it's mostly about doing reflog walks.
Usually if we see a rev arg it will result either in an object added to
the pending queue, or a fatal error. But empty reflogs are the
exception. And since my other nearby series adds a separate check for
"are we doing an empty reflog walk", I don't think it makes sense to
tangle this up the new flag I'm adding here.

 revision.c     | 2 +-
 t/t4202-log.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 08d5806b8..ba2b166cd 100644
--- a/revision.c
+++ b/revision.c
@@ -2316,7 +2316,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		opt->tweak(revs, opt);
 	if (revs->show_merge)
 		prepare_show_merge(revs);
-	if (revs->def && !revs->pending.nr && !got_rev_arg) {
+	if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {
 		struct object_id oid;
 		struct object *object;
 		struct object_context oc;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 3f3531f0a..36d120c96 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1523,6 +1523,12 @@ test_expect_success 'log diagnoses bogus HEAD' '
 	test_i18ngrep broken stderr
 '
 
+test_expect_success 'log does not default to HEAD when rev input is given' '
+	>expect &&
+	git log --branches=does-not-exist >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set up --source tests' '
 	git checkout --orphan source-a &&
 	test_commit one &&
-- 
2.14.0.rc1.586.g00244b0b6
