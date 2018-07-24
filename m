Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD3B1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 09:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbeGXKuk (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 06:50:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:57218 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388196AbeGXKuk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 06:50:40 -0400
Received: (qmail 8395 invoked by uid 109); 24 Jul 2018 09:45:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 09:45:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25826 invoked by uid 111); 24 Jul 2018 09:45:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 05:45:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 05:45:01 -0400
Date:   Tue, 24 Jul 2018 05:45:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20]
 linear-assignment: a function to solve least-cost assignment problems
Message-ID: <20180724094501.GA3578@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet>
 <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet>
 <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com>
 <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1807202049540.71@tvgsbejvaqbjf.bet>
 <xmqq1sbxbt0e.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1807212347330.71@tvgsbejvaqbjf.bet>
 <20180723012552.GA26886@sigill.intra.peff.net>
 <xmqqlga11jwp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlga11jwp.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 06:50:46PM -0700, Junio C Hamano wrote:

> 	Side Note: there are a few workflow elements I do want to
> 	keep using but they currently *lose* the mapping info.  An
> 	obvious one is
> 
> 	  $ git checkout -b to/pic master &&
> 	  ... review in MUA and then ...
> 	  $ git am -s mbox &&
> 	  ... review in tree, attempt to build, tweak, etc.
>           $ git format-patch --stdout master..to/pic >P &&
>           $ edit P &&
>           $ git reset --hard master &&
>           $ git am P
> 
> 	which is far more versatile and efficient when doing certain
> 	transformations on the series than running "rebase -i" and
> 	reopening and editing the target files of the patches one by
> 	one in each step.  But because format-patch does not
> 	generate Message-Id header of the original one out of the
> 	commit, the post-applypatch hook run by "am" at the end of
> 	the steps would not have a chance to record that for the
> 	newly created commit.
> 
> 	For this one, I think I can use "format-patch --notes=amlog"
> 	to produce the patch file and then teach post-applypatch
> 	script to pay attention to the Notes annotation without
> 	changing anything else to record the message id of the
> 	original.

Yes. I wonder if it would make sense to teach format-patch/am a
micro-format to automatically handle this case. I.e., some
machine-readable way of passing the notes in the email message.
Of course it's easy to design a format that covers the relatively
restricted form of these amlog notes, and much harder to cover the
general case.

>       Other workflow elements that lose the notes need
> 	to be identified and either a fix implemented or a
> 	workaround found for each of them.  For example, I suspect
> 	there is no workaround for "cherry-pick" and it would take a
> 	real fix.

I think the existing notes.rewriteRef is probably a good match here. I
can definitely think of notes you wouldn't want to cherry-pick, but I'm
having trouble coming up with an example that should survive a rebase
but not a cherry-pick.

> And these (incomplete) reverse mapping entries get in the way to
> maintain and correct the forward mapping.  When a commit that got
> unreachable gets expired, I want "git notes prune" to remove notes
> on them, and I do not want to even think about what should happen to
> the entries in the notes tree that abuse the mechanism to map blobs
> that are otherwise *not* even reachable from the main history.

Right, I think the notes tree is a poor distribution method for that
reason.

> > Though personally, I do not know if there is much point in pushing it
> > out, given that receivers can reverse the mapping themselves.
> 
> Before this thread, I was planning to construct and publish the
> reverse mapping at the end of the day, but do so on a separate notes
> ref (see above---the hacky abuse gets in the way of maintaining and
> debugging the forward mapping, but a separate notes-ref that only
> contains hacks is less worrysome).  But I have changed my mind and
> decided not to generate or publish one.  It is sort of similar to
> the way the pack .idx is constructed only by the receiver [*1*].

Yes, the pack .idx was the same mental model I had when writing my
earlier message.

> > Or is there some argument that there is information in the reverse map
> > that _cannot_ be generated from the forward map?
> 
> I know there is no information loss (after all I was the only one
> who ran that experimental hack), but there is one objection that is
> still possible, even though I admit that is a weak argument.

I wondered if you might have a case like this (building as we go):

 - message-id M becomes commit X
   - we write the forward map X->M
   - we write the reverse map M->X
 - during a rewrite (e.g., --amend), commit X becomes commit Y
   - we write the forward map Y->M
   - we write the reverse map M->Y

The difference between that result and an inverted map created at the
end is that we know that M->Y is the final result. Whereas by looking at
the inverted map, we do not know which of M->X and M->Y is correct. In
fact they are _both_ correct. But only one of X and Y would eventually
get merged (both may make it into the repo's of people fetching from you
if we imagine that X is on "pu" and you push between the two steps).

So I think the inverted mapping is not actually one-to-one, and in
either case you'd want to retain all possible matches (pruning only when
a commit is eventually dropped from the forward mapping, which rewritten
things from "pu" would eventually do). And in that case it does not
matter if you generate it incrementally or all at once.

> If a plumbing "diff-{files,tree,index}" family had a sibling
> "diff-notes" to compare two notes-shaped trees while pretending that
> the object-name fan-out did not exist (i.e. instead, the trees being
> compared is without a subtree and full of 40-hex filenames), then it
> would be less cumbersome to incrementally update the reverse mapping
> by reading forward mapping with something like:
> 
> 	git diff-notes --raw amlog@{1} amlog
> 
> to learn the commits whose notes have changed.  But without such a
> plumbing, it is cumbersome to do so correctly.  "git diff-tree -r"
> could serve as a rough substitute, until the note tree grows and get
> rebalanced by reorganizing the fan-out, and on the day it happens
> the reverse mapper needs to read and discard ghost changes that are
> only due to tree reorganizing [*2*].

Yeah. My "log" hackery was trying to do that incremental comparison, but
it did not handle the multiple-commit case (nor did it handle
deletions). I agree an end-point diff is sufficient (and more
efficient).

-Peff
