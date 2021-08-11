Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ADCC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C258161058
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhHKUlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 16:41:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:44668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231796AbhHKUlS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 16:41:18 -0400
Received: (qmail 22964 invoked by uid 109); 11 Aug 2021 20:40:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Aug 2021 20:40:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14571 invoked by uid 111); 11 Aug 2021 20:40:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Aug 2021 16:40:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Aug 2021 16:40:53 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
Message-ID: <YRQ11bYH5lV9D24D@coredump.intra.peff.net>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
 <20210811045727.2381-7-felipe.contreras@gmail.com>
 <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com>
 <xmqqzgto9dkd.fsf@gitster.g>
 <YRQfx+Njj1WxOnyG@coredump.intra.peff.net>
 <162871314612.7067.6886805754107701040.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162871314612.7067.6886805754107701040.git@grubix.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 10:19:06PM +0200, Michael J Gruber wrote:

> > > It is a good example that illustrates that the proposed organization
> > > may not help learning or using the system for operations that also
> > > apply to other things like commit and working tree (in other words,
> > > "git stage --grep" may not be such a good idea for the same reason
> > > as "git stage --diff").  But if it were limited to operations that
> > > apply only to the index (e.g. "git add" and "git rm"), it may be an
> > > improvement (I think we added "git stage" synonym exactly for that
> > > reason, already).
> > 
> > One thing I find off-putting about "git stage --diff" is that to me,
> > "stage" reads as a verb. So it is like "git add --diff", which seems
> > out-of-place; there are two verbs in a row.
> > 
> > I do not mind the term "staging area", but using "the stage" as a noun
> > is simply confusing to me in this context.
> 
> I think this exemplifies what I meant by discussing things in order. The
> concept "staging area" works in teaching and explaining things. But
> that does not imply that a "stage command" is the best way to convey
> that concept in the UI.

Yeah, I agree very much that saying "the term staging area makes sense"
does not imply that the "stage command" is a good idea.

> I mean, so much of git is about operating on or comparing between three
> different types of "sources": the working tree, the index, a treeish. A
> lot of confusion comes from the fact that we hide this behind different
> commands to act on them and different ways to specify these conceptual
> items:
> - You specify a treeish as an argument to a command.
> - You specify the index as an option (--cached, --staged) or by choosing
>   the right command.
> - You specify the working tree as an option (--worktree) or by choosing
>   the right command (checkout vs. reset) or number of options (diff).
> 
> Newer commands like "restore" try to help but fail badly when e.g. "restore
> --staged" means you overwrite what is staged with something from a
> treeish.

Agreed. At one point[1] I half-proposed a "git put" command that would
move changes between those three places (and giving a concrete name for
the index and working tree so they could be specified as sources or
destinations).

I do still like it as a conceptual model, but IIRC it gets hairy in some
of the details (e.g., "checkout -p HEAD" is still using the index as an
intermediary).

> I still think it's very worthwhile to fantasize about a git which has
> only verb-like commands (such as diff, add, checkout, checkin) and a
> consistent way of specifying the objects to act upon (possibly amended
> by "git pluralnoun" being synonymous to "git ls noun" or similar
> convenience shortcuts).

I don't really disagree with anything in your post, but I do think a
pure-verb world would be tricky in some ways. Or at least verbose. We
have "git branch --delete". But "git delete" seems a little too
open-ended. The concept of that verb is meaningful only in the context
or a particular noun. We could call it "git delete-branch", but that
doesn't really seem to make the world a better place. :)

-Peff
