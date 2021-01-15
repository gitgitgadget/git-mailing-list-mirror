Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0746FC433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBB0236FB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 09:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbhAOJtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 04:49:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:57070 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbhAOJtR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 04:49:17 -0500
Received: (qmail 32575 invoked by uid 109); 15 Jan 2021 09:48:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Jan 2021 09:48:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25999 invoked by uid 111); 15 Jan 2021 09:48:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Jan 2021 04:48:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Jan 2021 04:48:45 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/6] tests: use "test_might_fail ok=sigpipe grep" when
 appropriate
Message-ID: <YAFk/evY0GLr62dt@coredump.intra.peff.net>
References: <20191115040909.GA21654@sigill.intra.peff.net>
 <20210114233515.31298-5-avarab@gmail.com>
 <87r1mm4l4v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1mm4l4v.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 10:14:40AM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Fri, Jan 15 2021, Ævar Arnfjörð Bjarmason wrote:
> 
> >  test_expect_success 'cherry picks did not become git merge commits' '
> >  	bad_cherries=$(git rev-list --parents --all --grep=Cherry |
> > -		grep " .* " | cut -f1 -d" ") &&
> > +		test_might_fail ok=sigpipe grep grep " .* " | cut -f1 -d" ") &&
> > [...]
> > -		grep " .* " | cut -f1 -d" ") &&
> > +		test_might_fail ok=sigpipe grep grep " .* " | cut -f1 -d" ") &&
> 
> So, "grep grep" is an obvious typo there. Oops. The test still passes
> because it's fragile to begin with, we're just checking that we get no
> output, so "grep this string is not here" would also pass.

This is a good example of why tests are often better written to check
for an expected outcome, rather than lack of an unexpected one.

That does often make tests more verbose and brittle, though (in this
case, I guess we'd presumably have to validate the whole "rev-list"
output. So it may not be practical.

I do wonder if this test needs these pipes at all. It looks like we are
looking for merge commits. Maybe "rev-list --merges" would be a bit
simpler these days? I.e.:

diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 4f6c06ecb2..20dd62c5c4 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -17,22 +17,19 @@ test_expect_success 'load svn dump' "
 	"
 
 test_expect_success 'all svn merges became git merge commits' '
-	unmarked=$(git rev-list --parents --all --grep=Merge |
-		grep -v " .* " | cut -f1 -d" ") &&
-	[ -z "$unmarked" ]
-	'
+	git rev-list --all --no-merges --grep=Merge >actual &&
+	test_must_be_empty actual
+'
 
 test_expect_success 'cherry picks did not become git merge commits' '
-	bad_cherries=$(git rev-list --parents --all --grep=Cherry |
-		grep " .* " | cut -f1 -d" ") &&
-	[ -z "$bad_cherries" ]
-	'
+	git rev-list --all --merges --grep=Cherry >actual &&
+	test_must_be_empty actual
+'
 
 test_expect_success 'svn non-merge merge commits did not become git merge commits' '
-	bad_non_merges=$(git rev-list --parents --all --grep=non-merge |
-		grep " .* " | cut -f1 -d" ") &&
-	[ -z "$bad_non_merges" ]
-	'
+	git rev-list --all --merges --grep=non-merge >actual &&
+	test_must_be_empty actual
+'
 
 test_expect_success 'commit made to merged branch is reachable from the merge' '
 	before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2") &&

-Peff
