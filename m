Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A80EE7D0AF
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 22:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjIUWZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 18:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjIUWZX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 18:25:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9F37292
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:40:22 -0700 (PDT)
Received: (qmail 27697 invoked by uid 109); 21 Sep 2023 21:40:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Sep 2023 21:40:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10718 invoked by uid 111); 21 Sep 2023 21:40:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Sep 2023 17:40:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Sep 2023 17:40:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] attr: attr.allowInvalidSource config to allow invalid
 revision
Message-ID: <20230921214021.GB302338@coredump.intra.peff.net>
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
 <xmqqfs38akx5.fsf@gitster.g>
 <20230921041545.GA2338791@coredump.intra.peff.net>
 <xmqq1qer7vrv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qer7vrv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2023 at 01:52:52AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In an empty repository, "git log" will die anyway. So I think the more
> > interesting case is "I have a repository with stuff in it, but HEAD
> > points to an unborn branch". So:
> >
> >   git --attr-source=HEAD diff foo^ foo
> 
> This still looks like a made-up example.  Who in the right mind
> would specify HEAD when both of the revs involved in the operation
> are from branch 'foo'?  The history of HEAD may not have anything
> common with the operand of the operation 'foo' (or its parent), or
> worse, it may not even exist.

I think it's unlikely for a user to write that. But if you are running a
server full of bare repositories that does diffs, you might end up with
a script that sticks "--attr-source=HEAD" at the beginning of every
command.

It is true that HEAD may not be related. But that is what we use if you
are in a non-bare repository and run "git diff foo^ foo".

Arguably:

  git --attr-source=$to diff $from $to

is a better default for this command. But something like "git log -p" is
trickier, as you have many commits to show. You can try to use the tip
of the traversal, but there may be multiple. Using the attributes from
the destination of each commit is the most likely to avoid divergence
between the attributes and the code, but it may also not be what people
want. Using the modern attributes from the working tree often makes
showing historical commits much nicer.

So I dunno. I could see arguments in both directions, but I think in
general people have been OK with pulling attributes from the working
tree. And --attr-source=HEAD is the bare equivalent.

> But your "in this repository we never trust attributes from working
> tree, take it instead from this file or from this blob" example does
> make a lot more sense as a use case.

I don't know that it was my example. :) But yes, if you do
"--attr-source=$to", you're overriding even the non-bare case. That may
be what you want for some cases, but as above, I think it's hard to
apply consistently (or even what you'd want for the general case).

> > And there you really are saying "if there are attributes in HEAD, use
> > them; otherwise, don't worry about it". This is exactly what we do with
> > mailmap.blob: in a bare repository it is set to HEAD by default, but if
> > HEAD does not resolve, we just ignore it (just like a HEAD that does not
> > contain a .mailmap file). And those match the non-bare cases, where we'd
> > read those files from the working tree instead.
> 
> "HEAD" -> "HEAD:.mailmap" if I recall correctly.

True, yeah. We can't do that here because attributes are spread across
the tree. So all my mentions of attr.blob would really be attr.tree.

> And if HEAD does not resolve, we pretend as if HEAD is an empty
> tree-ish (hence HEAD:.mailmap is missing).  It becomes very tempting
> to do the same for the attribute sources and treat unborn HEAD as if
> it specifies an empty tree-ish, without any configuration or an
> extra option.
> 
> Such a change would be an end-user observable behaviour change, but
> nobody sane would be running "git --attr-source=HEAD diff HEAD^ HEAD"
> to check and detect an unborn HEAD for its error exit code, so I do
> not think it is a horribly wrong thing to do.

Yeah, that is basically what I am proposing. It sounds from the
discussion here that there are two interesting cases:

  1. You want to use --attr-source=HEAD because you are trying to make a
     bare repo behave like a non-bare one. You probably want the "don't
     complain if it is missing" behavior.

  2. You are trying to use the attributes from one side of the diff to
     override the worktree ones (because the two trees are unrelated).
     In which case it does not really matter if --attr-source complains,
     because the diff will likewise complain if the tree cannot be
     resolved.

Just trying to play devil's advocate, though, I guess you could run a
non-diff operation like say:

  git --attr-source=my-branch check-attr foo

and then you probably _do_ want to know if that source was ignored or
typo'd.

> But again, as you said, --attr-source=<tree-ish> does not sound like
> a good fit for bare-repository hosted environment and a tentative
> hack waiting for a proper attr.blob support, or something like that,
> to appear.

I think folks mentioned mailmap.blob in the original discussion for
--attr-source. I don't remember why the patch went with --attr-source
there. Maybe John can speak to that.

-Peff
