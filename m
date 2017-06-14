Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D43020401
	for <e@80x24.org>; Wed, 14 Jun 2017 09:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbdFNJSj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:18:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:39829 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdFNJSi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 05:18:38 -0400
Received: (qmail 12984 invoked by uid 109); 14 Jun 2017 09:18:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 09:18:32 +0000
Received: (qmail 9610 invoked by uid 111); 14 Jun 2017 09:18:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 05:18:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 05:18:30 -0400
Date:   Wed, 14 Jun 2017 05:18:30 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] b9c8e7f2fb6e breaks git bisect visualize
Message-ID: <20170614091830.et7bmoxmcmgosun3@sigill.intra.peff.net>
References: <20170614000630.44uctc5y7dyyleqy@sunbase.org>
 <5a3f6af6-f936-50e7-5fca-c41b3aeefdce@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a3f6af6-f936-50e7-5fca-c41b3aeefdce@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 10:36:43AM +0200, Michael Haggerty wrote:

> The code for `git log --bisect` is questionable. It calls
> `for_each_ref_in_submodule()` with prefix "refs/bisect/bad", which is
> the actual name (not a prefix) of the reference that it is interested
> in. So the callback is called with the empty string as path, and that in
> turn is passed to a variety of functions, like `ref_excluded()`,
> `get_reference()`, `add_rev_cmdline()`, and `add_pending_oid()`. I'm not
> sure whom to ping; the code in question was introduced eons ago:
> 
>     ad3f9a71a8 Add '--bisect' revision machinery argument, 2009-10-27
> 
> It seems to me that we should add a `for_each_fullref_in_submodule()`
> and call that instead. I'll submit a patch doing that, though I'm not
> certain that no new problems will arise from the callbacks getting full
> rather than trimmed reference names (also for "refs/bisect/good").

I doubt that would be a problem. The current values are nonsensical (an
empty string for bad, and "-$sha1" for good. They're mostly used in the
cmdline and pending lists. It would affect things like --exclude or
--source. I doubt anybody cares, but if they do IMHO the full names
would be a vast improvement.

Another option would be for this code to ask for:

  for_each_ref_in("refs/bisect", ...);

and then match the various names in the callback. That gives sane short
names ("bad" and "good-$sha1"). But I think the full names are a much
better outcome. Some code (though note code I'd expect to use with
--bisect) assumes that the contents of the "name" field for pending
objects can be used to look up the object again. That's definitely not
true of the nonsense we produce now, but it would also not be true of
"bad" (because we don't DWIM refs/bisect).

> Another possible orthogonal "fix" is to make the refs side tolerate
> being asked to trim a refname down to the empty string, while still
> refusing to trim even more than that. I'll also submit a patch to that
> effect.

Even though the resulting "name" is silly, it does seem possible that
some caller would want to ask for all of refs/foo, even if it didn't
know if that was a single ref or a hierarchy. I do agree that any such
caller should probably be using for_each_fullref_in, though.

> Either of the patches fix the issue that was reported and pass the whole
> test suite (except for t1308, which seems to be broken in master for
> unrelated reasons).

It's broken if you use autoconf. See the patch I posted a few hours ago:

  http://public-inbox.org/git/20170614053018.pbeftfyz2md4o73h@sigill.intra.peff.net/

-Peff
