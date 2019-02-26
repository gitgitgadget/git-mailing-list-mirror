Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0707820248
	for <e@80x24.org>; Tue, 26 Feb 2019 17:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfBZRfp (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 12:35:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:58684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726353AbfBZRfp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 12:35:45 -0500
Received: (qmail 973 invoked by uid 109); 26 Feb 2019 17:35:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Feb 2019 17:35:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30694 invoked by uid 111); 26 Feb 2019 17:35:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Feb 2019 12:35:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2019 12:35:43 -0500
Date:   Tue, 26 Feb 2019 12:35:43 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
Message-ID: <20190226173542.GC19606@sigill.intra.peff.net>
References: <pull.152.git.gitgitgadget@gmail.com>
 <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
 <87sgwav8cp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgwav8cp.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 05:10:30PM +0100, Ævar Arnfjörð Bjarmason wrote:

> But 4 years after this was added in a136f6d8ff ("test-lib.sh: support -x
> option for shell-tracing", 2014-10-10) we got -x, and then with "-i -v -x":
> 
>     expecting success:
>             test_path_is_dir .git &&
>             test_path_is_file doesnotexist &&
>             test_path_is_file .git/config
> 
>     + test_path_is_dir .git
>     + test -d .git
>     + test_path_is_file doesnotexist
>     + test -f doesnotexist
>     + echo File doesnotexist doesn't exist.
>     File doesnotexist doesn't exist.
>     + false
>     error: last command exited with $?=1
>     not ok 1 - check files
> 
> But by just using "test -d/-e": the much shorter:
> 
>     + test -d .git
>     + test -f doesnotexist
>     error: last command exited with $?=1
>     not ok 1 - check files
> 
> So I wonder if these days we shouldn't do this the other way around and
> get rid of these. Every test_* wrapper we add adds a bit of cognitive
> overload when you have to remember Git's specific shellscript dialect.

I don't have a strong opinion, but I do agree that with "-x" it's nicer
without the wrappers. I typically re-run with just "-v" on a failure,
and only turn to "-x" if the verbose output isn't helpful. However, with
the rise of multi-platform CI jobs which try to collect as much
information as possible in the initial run, I do find myself looking at
"-x" more often.

As Gábor notes, you can't run every script with "-x". But I find it's
pretty consistent these days (and totally so if you have a recent bash).
I dunno. Maybe people on other platforms (who might not have bash) would
care more.

I had a vague notion that there was some reason (portability?) that we
preferred to have the wrappers. But as your patch shows, they really are
just calling "test" and nothing else.

>      test_must_be_empty () {
>     +	# We don't want to remove this as noted in ec10b018e7 ("tests:
>     +	# use 'test_must_be_empty' instead of '! test -s'",
>     +	# 2018-08-19)
>      	test_path_is_file "$1" &&
>      	if test -s "$1"
>      	then

You'd still want it to become "test -f" though, right?

-Peff
