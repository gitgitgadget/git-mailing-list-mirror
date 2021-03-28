Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D16AC433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 09:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02056196C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 09:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhC1JHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 05:07:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:34610 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhC1JGk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 05:06:40 -0400
Received: (qmail 2370 invoked by uid 109); 28 Mar 2021 09:06:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Mar 2021 09:06:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2378 invoked by uid 111); 28 Mar 2021 09:06:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Mar 2021 05:06:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 28 Mar 2021 05:06:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] object tests: add test for unexpected objects in tags
Message-ID: <YGBHH7sAVsPpVKWd@coredump.intra.peff.net>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
 <20210308200426.21824-7-avarab@gmail.com>
 <YEdRhulqevMjlrLc@coredump.intra.peff.net>
 <87h7kwnjpp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7kwnjpp.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 28, 2021 at 03:35:46AM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> Fix a blind spot in the tests added in 0616617c7e1 (t: introduce tests
> >> for unexpected object types, 2019-04-09), there were no meaningful
> >> tests for checking how we reported on finding the incorrect object
> >> type in a tag, i.e. one that broke the "type" promise in the tag
> >> header.
> >
> > Isn't this covered by tests 16 and 17 ("traverse unexpected non-commit
> > tag", both "lone" and "seen")? And likewise the matching "non-tree" and
> > "non-blob" variants afterwards?
> 
> Barely, those tests are mainly testing that rev-list doesn't die, and
> only do a very fuzzy match on the output. E.g. checking `grep "not a
> commit" err`, not a full test_cmp that'll check what OID is reported
> etc.

I thought the "blind spot" you meant was not testing these cases. But I
guess you mean that we are not checking stderr.

So OK, but...

> > The only thing we don't seem to cover is an unexpected non-tag. I don't
> > mind adding that, but why wouldn't we just follow the template of the
> > existing tests?
> 
> I am following that template to some extent, e.g. using
> ${commit,tree,blob}. It just didn't seem worth it to refactor an earlier
> test in the file just to re-use a single hash-object invocation, those
> tests e.g. clobber the $tag variable, so bending over backwards to
> re-use anything set up in them would mean some refactoring.
> 
> I think it's much clearer just do do all the different kinds of setup in
> the new setup function.

It does not seem to make the resulting test script more clear at all to
create the same situation twice, but test stderr only in the second
case. I.e., why is the change to the test script not just:

diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 52cde097dd..4cdc87c913 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -82,12 +82,13 @@ test_expect_success 'setup unexpected non-commit tag' '
 '
 
 test_expect_success 'traverse unexpected non-commit tag (lone)' '
-	test_must_fail git rev-list --objects $tag
+	test_must_fail git rev-list --objects $tag >output 2>&1 &&
+	test_i18ngrep "is a blob, not a commit" output
 '
 
 test_expect_success 'traverse unexpected non-commit tag (seen)' '
 	test_must_fail git rev-list --objects $blob $tag >output 2>&1 &&
-	test_i18ngrep "not a commit" output
+	test_i18ngrep "is a blob, not a commit" output
 '
 
 test_expect_success 'setup unexpected non-tree tag' '

and so forth (or you can replace it with a full test_cmp if you really
prefer). That does not seem like bending over backwards to me, but
rather keeping the test script tidy and readable.

But I wonder if there is something more going on that led you to have
trouble demonstrating your problem with the existing tests. Looking at
your follow-on patch that flips the "is an X, not a Y", I am not sure
this is something that we can actually handle reliably. At least not
without further access to the object database.

Because when we call, say, lookup_blob() and find that the object is
already in memory as a non-blob, we don't know who the culprit is.
Perhaps an earlier part of the code called parse_object(), found that it
really is a blob on disk, and used that type. But it may equally have
been the case that we saw a reference to the object as a commit, called
lookup_commit() on it, and now our lookup_blob() call is unhappy,
thinking it is really a commit. In that case, one of those references is
wrong, but we don't know which.

I think a robust solution would be one of:

  - make the message more precise: "saw object X as a commit, but
    previously it was referred to as a blob". Or vice versa.

  - when we see such a mismatch, go to the object database to say "aha,
    on disk it is really a blob". That's expensive, but this is an error
    case, so we can afford to be slow. But it does produce unsatisfying
    results when it was the earlier lookup_commit() call that was wrong.
    Because we have to say "object X is really a blob, but some object
    earlier referred to it as a commit. No idea who did that, though!".

-Peff
