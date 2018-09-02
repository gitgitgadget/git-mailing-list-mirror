Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 184441F404
	for <e@80x24.org>; Sun,  2 Sep 2018 05:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeIBKGh (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 06:06:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:36520 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725834AbeIBKGh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 06:06:37 -0400
Received: (qmail 8266 invoked by uid 109); 2 Sep 2018 05:52:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 02 Sep 2018 05:52:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16495 invoked by uid 111); 2 Sep 2018 05:52:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 02 Sep 2018 01:52:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Sep 2018 01:51:59 -0400
Date:   Sun, 2 Sep 2018 01:51:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH 2/4] t5310: test delta reuse with bitmaps
Message-ID: <20180902055159.GB21324@sigill.intra.peff.net>
References: <20180901074145.GA24023@sigill.intra.peff.net>
 <20180901074813.GB25461@sigill.intra.peff.net>
 <20180901080316.GA25852@sigill.intra.peff.net>
 <87va7parmi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va7parmi.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 01, 2018 at 10:29:25PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Anyway. Not that exciting, and kind of obviously dumb in retrospect. But
> > I think it was worth analyzing to see what went wrong. If there's an
> > immediate lesson, it is probably: add tests even for changes that aren't
> > really user-visible to make sure the code is exercised.
> 
> Test-wise, isn't the problem rather that that we didn't have something
> like what's described in t/README as "Running tests with special setups"
> for bitmaps? I.e. stuff like GIT_TEST_SPLIT_INDEX=<bool>, or running it
> with GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all to stress the fsmonitor
> code.

I'm a little skeptical of that as a general approach, for two reasons:

 - the test suite is filled with toy examples, so they often don't
   trigger the interesting cases

 - the tests are often looking for very particular outcomes or
   repository state; munging that state is going to confuse them

> So we could add some option to the test suite to e.g. run a custom
> command before every "git push" or "git fetch", and then just do a gc
> with a repack/commit graph write/midx write etc. in that codepath, along
> with (in the case of stuff like midx) setting any neede config knobs to
> turn it on.

We can try that out with something like this:

diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 42dc4da5a1..f40e0b7a04 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -30,6 +30,14 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	/*
+	 * This environment variable hackery is necessary because repack in a
+	 * partial clone might actually try to fetch, spawning an infinite
+	 * recursion.
+	 */
+	system("test -z \"$SUPPRESS_BITMAP_MAGIC\" && "
+	       "SUPPRESS_BITMAP_MAGIC=1 git repack -adb >/dev/null 2>&1");
+
 	packet_trace_identity("upload-pack");
 	read_replace_refs = 0;
 

It actually _does_ find the bug in question (which I wasn't at all sure
it would). But it also turns up several other unrelated test failures.

And it's only triggering in some limited cases (fetches). If we tried to
get better coverage of bitmaps in general, I'm not sure where we would
slip in such a repack command. But I think you'd get even more false
positives.

> Of course the utility of that sort of thing is limited unless we have
> some dedicated smoke testers or CI capacity to run the various
> combinations of those options. But FWIW when I build our own in-house
> git I build the package with:

Yes, it also gets really expensive. That can be helped with more CI
machines, but even neglecting cost, I'm not sure our CI workflow is that
great right now (for example, I still haven't figured out the simple
feature of: if I push up a commit that fails, I'd like to get an email).

> So if there was a "test bitmaps everywhere" mode that would have been
> caught during the build, unless I've misunderstood how this particular
> bug manifests, but then again, it happened on just a plain git.git after
> repack, so wasn't any bitmap + push pretty much all that was needed?, I
> haven't read your patches in any detail.

The test patch describes the minimal scenario you need. Which would be
pretty common on any decent sized repo, but rare on toy ones (though as
I said above, there are a few cases in the test suite big enough to
trigger this).

-Peff
