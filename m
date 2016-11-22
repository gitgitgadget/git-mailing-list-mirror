Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582EB1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 19:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934273AbcKVTuT (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 14:50:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:46270 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934262AbcKVTuS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 14:50:18 -0500
Received: (qmail 14202 invoked by uid 109); 22 Nov 2016 19:50:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 19:50:17 +0000
Received: (qmail 31599 invoked by uid 111); 22 Nov 2016 19:50:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 14:50:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Nov 2016 14:50:15 -0500
Date:   Tue, 22 Nov 2016 14:50:15 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
Message-ID: <20161122195015.rztaixpz7zvdxb4u@sigill.intra.peff.net>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
 <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
 <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
 <alpine.DEB.2.20.1611221712480.3746@virtualbox>
 <xmqqshqjqw3z.fsf@gitster.mtv.corp.google.com>
 <xmqqzikrpbz2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzikrpbz2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 11:10:25AM -0800, Junio C Hamano wrote:

> Archive & Upload-archive:
> 
> "cd Documentation && git archive --remote=origin" immediately hits
> "BUG: setup_git_env called without repository" if your Git is built
> with b1ef400eec ("setup_git_env: avoid blind fall-back to ".git"",
> 2016-10-20), which will not be part of the upcoming release.  And
> 'origin' will probably not be understood from the local config.

Yeah, I think "cd Documentation && git archive --remote" has always been
broken. It doesn't barf until b1ef400eec, but yes, v2.11-rc2 breaks
finding "origin" in the local config.

I agree that doing the "gently" setup will fix the config problem, but
there's more to do to make it work with b1ef400eec outside of a repo.
It looks like read_remotes_file() and read_branches_file() in remote.c
need to learn to silently return when we are not in a git repository (or
alternatively, remote_get_1() should learn not to call them in such a
case).

I doubt this is a critical case (it only kicks in if you are outside a
repo _and_ your name looks like a remote name and not a URL, _and_ it is
not defined by your config, and the result is that we die("BUG") rather
than reporting "you don't have such a remote"). But any time it is
possible to hit a die("BUG"), we should be fixing it.

> I think we can do the "gently" thing there, as we may be retrieving
> a remote archive outside a local repository.  We'd need to tweak
> "output" with prefix to compensate for the case in which the command
> is run from a subdirectory, and probably we need to futz with the
> setup_prefix parameter to write_archive(), as a local caller now
> will know if we are in nongit situation.

Makes sense. I think OPT_FILENAME() would handle "output", but yeah, it
looks like write_archive() already tries to be clever about the setup.

> On the upload-archive side that serves "--remote" request, there is
> enter_repo() so we should be covered OK.

Right, that has to run in a repo, and enter_repo() should handle it.

> Mailinfo:
> 
> We may want a "gently" thing there to pick up local configuration.
> i18n.commitencoding and mailinfo.scissors in local repository would
> be ignored otherwise.

Yeah, agreed.

> Verify-pack:
> 
> This calls git_config() but these days farms out its operation to
> "index-pack", so we should be OK.  We may even want to lose the call
> to git_config() which does not affect anything.

I'd be slightly worried that there is a core.* config option that
affects us in a subtle way (e.g., some portability flag for how we do
run_command()). I don't think there is one now, but it seems like a
potential maintenance pitfall. IOW, I think I'd generally prefer to err
on the side of having everything do a gentle setup and load at least the
default config, to avoid surprises.

I don't think it's a high priority, though.

So what do you want to do for v2.11? I think there are minor regressions
in stripspace, archive, and mailinfo with respect to reading
.git/config. The right solution in each case is to do a gentle repo
setup. We have patches for stripspace already, but not yet for the other
two. They _should_ be fairly trivial, but we are getting awfully close
to the release. Do you want to do another round of -rc3? Ship with the
minor regressions and fix them up in v2.11.1? Last-minute revert the
original config topic that introduced the regressions (I'm biased
against that as the author, but I also think it's dangerous; it's a big
enough topic that it might introduce new problems)?

-Peff
