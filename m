Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71DD1F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 19:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfHNTbL (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 15:31:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:43710 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726951AbfHNTbL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 15:31:11 -0400
Received: (qmail 20790 invoked by uid 109); 14 Aug 2019 19:31:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Aug 2019 19:31:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19338 invoked by uid 111); 14 Aug 2019 19:32:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Aug 2019 15:32:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Aug 2019 15:31:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Paolo Pettinato (ppettina)" <ppettina@cisco.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git fetch bug in git 2.21+ "Could not access submodule '%s'"
Message-ID: <20190814193110.GA31218@sigill.intra.peff.net>
References: <951a0ac4-592f-d71c-df6a-53a806249f7b@cisco.com>
 <20190814153607.GB12093@sigill.intra.peff.net>
 <xmqqpnl766pj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnl766pj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 14, 2019 at 09:40:40AM -0700, Junio C Hamano wrote:

> > but it feels odd to me. Even if the submodule is not currently checked
> > out, we'd presumably still want to do the recursive fetch as long as we
> > have a repo under $GIT_DIR/modules?
> 
> ... which means that we are not interested in "is it populated?" but
> in "have we done 'git submodule init' to show interest in it?".  But
> since we are walking the in-core index and picking only the gitlink
> entries in it in the early part of this loop, we know ce cannot be
> anything but a submodule at this point, so we will not be in the "we
> are interesteed in the submodule, but the current HEAD and index is
> at a commit that does not have it, hence $GIT_DIR/modules/ is the
> only place that knows about it" situation.  If we are interested in
> it enough to have a repository stashed under $GIT_DIR/modules/, we
> should have a submodule there, shouldn't we?

Yeah, as I was writing the above I too was wondering whether this was a
case that could even happen. So it may be that the two ways of asking
the question end up the same in practice.

> What I do not quite get is that repo_submodule_init(), which is
> called by get_submodule_repo_for(), looks into $GIT_DIR/modules/,
> according to the in-code comment of that function.  So "we cannot
> get the repo for it, which is an error condition, but we will
> complain only for non-empty directory" logic feels iffy.

Right. This whole non-empty directory thing _feels_ like a hack that was
added to paper over the fact that get_submodule_repo_for() does not
distinguish between "nope, this module is not active" and "an error
occurred".

Given that any real errors there would come from
read_and_verify_repository_format(), which generates its own error
messages, I wonder if we should simply quietly ignore any entries for
which get_submodule_repo_for() returns NULL. I suppose that would impact
our exit code, though (i.e., a real broken submodule would not cause the
outer fetch to exit with a non-zero code).

Probably that could be dealt with by having get_submodule_repo_for()
return a tristate enum: a working struct, an error, or ENOENT. Actually,
I guess we could set errno. ;)

It's not clear to me, though, that the rest of the functions are
distinguishing between "broken repo at submodule path" and "no such
submodule". For instance, get_submodule_repo_for() itself will happily
hit a fallback path if repo_submodule_init() returns an error. That
would really only want to trigger on this ENOENT-equivalent case.

> Stepping back even a bit more, "an empty directory is normal" makes
> some sense.  If the user or the build system created a non-directory
> at a path where a populated submodule would sit, that would not be
> good.  If the user or the build system created a random file in the
> unpopulated empty directory, in which the working tree files of the
> submodule would be created once the submodule getspopulated, that
> would be equally bad, wouldn't it?  Why is the user mucking with
> that directory in the first place, and isn't the flagging of the
> situation as an error, done with 26f80ccf ("submodule: migrate
> get_next_submodule to use repository structs", 2018-11-28), a
> bugfix?  If not, why not?

I agree that the user putting things in that directory is kind of weird.
It just seems odd that fetch, which doesn't at all care about the
working tree, would be the thing to complain about it.

-Peff
