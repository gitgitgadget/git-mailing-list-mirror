Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE60C61DA3
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 05:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCFFip (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 00:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCFFin (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 00:38:43 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B96C2699
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 21:38:39 -0800 (PST)
Received: (qmail 2821 invoked by uid 109); 6 Mar 2023 05:38:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Mar 2023 05:38:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26152 invoked by uid 111); 6 Mar 2023 05:38:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Mar 2023 00:38:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Mar 2023 00:38:37 -0500
From:   Jeff King <peff@peff.net>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Henry <git@drmikehenry.com>
Subject: Re: [RFC/PATCH] bundle: turn on --all-progress-implied by default
Message-ID: <ZAV8XW34CjUy5RyF@coredump.intra.peff.net>
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
 <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
 <xmqqv8jhcvrq.fsf@gitster.g>
 <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
 <xmqqpm9pcu6t.fsf@gitster.g>
 <ZAKexHiit5vOmv7M@coredump.intra.peff.net>
 <ZAKi8MzGWk5PZUJk@coredump.intra.peff.net>
 <ZAMb8LSpm2gOrpeY@coredump.intra.peff.net>
 <ZAMjkffYmp+DNmr+@coredump.intra.peff.net>
 <robbat2-20230306T033734-620860556Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <robbat2-20230306T033734-620860556Z@orbis-terrarum.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 03:44:11AM +0000, Robin H. Johnson wrote:

> > diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> > index 7d40994991e..978c5b17ba5 100755
> > --- a/t/t6020-bundle-misc.sh
> > +++ b/t/t6020-bundle-misc.sh
> > @@ -606,4 +606,10 @@ test_expect_success 'verify catches unreachable, broken prerequisites' '
> >  	)
> >  '
> >  
> > +test_expect_success 'bundle progress includes write phase' '
> > +	GIT_PROGRESS_DELAY=0 \
> > +		git bundle create --progress out.bundle --all 2>err &&
> > +	grep 'Writing' err
> > +'
> > +
> >  test_done
> 
> Suggestion: How about adding a test for --quiet that ensures no other
> output?

I had sort of assumed that we had those already, from the earlier work,
but it looks like we don't. Squashing this in would do it, I think (we
need test_terminal since otherwise we'd be quiet anyway):

diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 978c5b17ba5..7bbb351b7be 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -10,6 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 for cmd in create verify list-heads unbundle
 do
@@ -612,4 +613,10 @@ test_expect_success 'bundle progress includes write phase' '
 	grep 'Writing' err
 '
 
+test_expect_success TTY '--quiet disables all bundle progress' '
+	test_terminal env GIT_PROGRESS_DELAY=0 \
+		git bundle --quiet create out.bundle --all 2>err &&
+	test_must_be_empty err
+'
+
 test_done
