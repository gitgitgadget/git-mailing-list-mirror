Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54FBC1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 23:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfGaXM7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 19:12:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:57752 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725793AbfGaXM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 19:12:59 -0400
Received: (qmail 21720 invoked by uid 109); 31 Jul 2019 23:12:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 23:12:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22965 invoked by uid 111); 31 Jul 2019 23:14:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 19:14:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 19:12:57 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] config: work around bug with includeif:onbranch
 and early config
Message-ID: <20190731231257.GB1933@sigill.intra.peff.net>
References: <pull.300.git.gitgitgadget@gmail.com>
 <pull.300.v2.git.gitgitgadget@gmail.com>
 <ea1a746113b85bde5319c410f68fe3dc75f8a328.1564603600.git.gitgitgadget@gmail.com>
 <20190731220204.GA1933@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1908010004130.21907@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1908010004130.21907@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 01, 2019 at 12:13:19AM +0200, Johannes Schindelin wrote:

> > This gets tricky, because some commands are intentionally avoiding the
> > normal lookup procedure (e.g., clone or init, and probably things like
> > upload-pack that want to enter another repo). So I think it is OK as
> > long as the early-config code is explicitly saying "and please look at
> > the refs in this specific direectory now", and it doesn't affect other
> > possible code paths that might look at refs. I _think_ that's what
> > you're suggesting above, but I just want to make sure (not that it
> > matters either way for this patch).
> 
> I think we already have the `git clone` problem with
> `includeif.gitdir:`. AFAICT we _will_ discover a Git directory when
> cloning inside an existing Git worktree.

Yeah, I could well believe that. I think it's hard for the config code
to say what's the right think to do here. If I'm running "git clone"
from inside another repository, should I respect, say, an alias defined
in that repository's config? Probably. But should I find that alias
behind "includeif.gitdir"? I dunno. Maybe?

So I'm not 100% sure the current behavior is buggy. And mostly I'd be
happy to ignore it until somebody comes up with a compelling
(real-world) example either way.

> And as you say, there was no use case, and I would even contend that
> there still is no use case. In the cover letter, I tried to concoct
> something (using a branch-dependent pager) that sounds _really_
> far-fetched to even me.

Yeah. I'd be totally fine if we left it with your fix here and nobody
ever found time to work on this. :)

> > > -	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
> > > +	const char *refname = !the_repository || !the_repository->gitdir ?
> > > +		NULL : resolve_ref_unsafe("HEAD", 0, NULL, &flags);
> >
> > I think the_repository is always non-NULL.
> 
> No, it totally can be `NULL`. I know because my first version of the
> patch did not have that extra check, and `git help -a` would segfault
> outside a Git worktree when I had an `includeif.onbranch:` in my
> `~/.gitconfig`.

Hrm. But common-main calls initialize_the_repository(), which points it
at &the_repo. And I can't find any other assignments. So how does it
become NULL? And is every caller of have_git_dir() at risk of
segfaulting?

Ah, I see. I think it is that trace2 reads the configuration very early.
I think we ought to do this:

diff --git a/common-main.c b/common-main.c
index 582a7b1886..89fd415e55 100644
--- a/common-main.c
+++ b/common-main.c
@@ -39,14 +39,14 @@ int main(int argc, const char **argv)
 
 	git_resolve_executable_dir(argv[0]);
 
+	initialize_the_repository();
+
 	trace2_initialize();
 	trace2_cmd_start(argv);
 	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
 
 	git_setup_gettext();
 
-	initialize_the_repository();
-
 	attr_start();
 
 	result = cmd_main(argc, argv);

or possibly even move the trace2 bits to the very end of that function.
The point of common-main is to do very basic setup. Doing tentative repo
discovery and config reading there at all is surprising to me, to say
the least. But I think we can at least make sure the library code is
initialized first.

> > The way similar sites check this is withV
> > "!startup_info->have_repository" or have_git_dir(). The early-config
> > code uses the latter, so we should probably match it here.
> 
> Quite frankly, I'd rather not. At this point, it is not important
> whether or not we discovered a Git directory, but whether or not we have
> populated a dereference'able `the_repository`. Those are two different
> things.

What I'm concerned about it is whether there are cases where
the_repository->gitdir is NULL, but we _could_ still look up refs. I.e.,
why is the rest of the config code using have_git_dir(), and why is this
code path special?

Again, I _think_ we might be able to get rid of have_git_dir() now. Back
when it was introduced get_git_dir() did lazy setup, and these days it
looks like it's just peeking at the_repository->gitdir. But it makes
sense to me for this fix to be consistent with the surrounding code, and
then to investigate have_git_dir() separately.

> >   Side note: I suspect there are some cleanup opportunities. IIRC, I had
> >   to add have_git_dir() to cover some cases where $GIT_DIR was set but
> >   we hadn't explicitly done a setup step, but there's been a lot of
> >   refactoring and cleanup in the initialization code since then. I'm not
> >   sure if it's still necessary.
> 
> Yeah, well, I am not necessarily certain that we always ask the right
> questions, such as asking whether we found a startup repository when we
> need, in fact, to know whether `the_repository->refs` would cause a
> segmentation fault because we would dereference a `NULL` pointer ;-)

If there are cases where startup_info->have_repository is non-zero but
we'd segfault, then I think that's a bug that is going to affect more
spots than this, and we need to investigate and fix. But I don't think
that is the case. We should only be setting it after calling
set_git_dir(), and poking at the current sites which set that leads me
to believe this is true.

-Peff
