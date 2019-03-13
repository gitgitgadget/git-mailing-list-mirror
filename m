Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 073DF20248
	for <e@80x24.org>; Wed, 13 Mar 2019 15:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfCMPee (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 11:34:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:48866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725883AbfCMPee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 11:34:34 -0400
Received: (qmail 15916 invoked by uid 109); 13 Mar 2019 15:34:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Mar 2019 15:34:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11496 invoked by uid 111); 13 Mar 2019 15:33:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 11:33:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 11:33:17 -0400
Date:   Wed, 13 Mar 2019 11:33:17 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] get_oid: cope with a possibly stale loose object
 cache
Message-ID: <20190313153317.GB24101@sigill.intra.peff.net>
References: <pull.161.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.161.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 03:16:30AM -0700, Johannes Schindelin via GitGitGadget wrote:

> Over at the companion PR for Git for Windows
> [https://github.com/git-for-windows/git/pull/2121], I discussed this with
> Peff (who introduced the loose object cache), and he pointed out that my
> original solution was a bit too specific for the interactive rebase. He
> suggested the current method of re-reading upon a missing object instead,
> and explained patiently that this does not affect the code path for which
> the loose object cache was introduced originally: to help with performance
> issues on NFS when Git tries to find the same missing objects over and over
> again.
> 
> The regression test still reflects what I need this fix for, and I would
> rather keep it as-is (even if the fix is not about the interactive rebase
> per se), as it really tests for the functionality that I really need to
> continue to work.

The case you found is the only way I can think of to trigger this
deterministically. So I think it is quite a good test case. :)

Just to rehash a bit from that PR: I believe that this bug has been
present in the way the test checks for it since we started caching in
the sha1-abbreviation code in cc817ca3ef (sha1_name: cache readdir(3)
results in find_short_object_filename(), 2017-06-22).

But the more fundamental issue, that we do not do the usual
reprepare_packed_git() thing upon failing to find an object, goes back
forever. It's just much less common to hit that race than the one with
normal object access, because we tend to resolve objects quickly at the
beginning of a program and then spend a long time walking the graph. But
it is still possible, especially in a long-running program that resolves
names not just at the beginning. Like rebase.

  Actually, I guess one could probably construct a similar case with
  a long-running "cat-file --batch", feeding it one name, then doing a
  complete repack, and then feeding it another name. I guess I could
  think of another case. ;)

> My only concern is that this might cause some performance regressions that
> neither Peff nor I could think of, where get_oid() may run repeatedly into
> missing objects by design, and where we should not blow away and recreate
> the loose object cache all the time.

This only affects get_oid_short(), which is already pretty expensive,
because it has to disambiguate them. The usual path we care about being
fast is the 40-hex sha1 parser, which should be able to do its job
without doing anything but parsing the string. We've already run into
speed issues there with the object/refname ambiguity checks, and callers
can disable that with a flag.

So I'd say:

  - if you want to think about callers which might be sensitive to this
    change, the ones setting warn_on_object_refname_ambiguity might be
    good candidates.

  - anything except 40-hex sha1 is already pretty expensive (ref
    lookups, disambiguation, etc), so as long as we're not touching that
    path, I'm not incredibly worried.

    I did wonder for a minute whether the 40-hex sha1 resolution would
    want this similar reprepare_packed_git() handling. But it doesn't
    verify the object at all, and just passes back the oid whether it
    exists or not (and it's up to the caller to then use
    OBJECT_INFO_QUICK to access the object data if it chooses).

That's my opinion, of course. I think your intent was to solicit other
thoughts, so I'd be curious to hear if anybody disagrees. :)

> Johannes Schindelin (4):
>   rebase -i: demonstrate obscure loose object cache bug
>   sequencer: improve error message when an OID could not be parsed
>   sequencer: move stale comment into correct location
>   get_oid(): when an object was not found, try harder

The patches themselves look good to me. Thanks for pushing our
discussion forward.

-Peff
