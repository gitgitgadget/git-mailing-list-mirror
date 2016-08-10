Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A7521FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933736AbcHJSc7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:32:59 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34293 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127AbcHJScx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:32:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 4237F460BB5;
	Wed, 10 Aug 2016 10:37:53 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXf7xkPvXev4; Wed, 10 Aug 2016 10:37:50 +0100 (BST)
Received: from salo (82-70-136-246.dsl.in-addr.zen.co.uk [82.70.136.246])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 60B0A46314C;
	Wed, 10 Aug 2016 10:37:50 +0100 (BST)
Date:	Wed, 10 Aug 2016 10:37:31 +0100
From:	Richard Ipsum <richard.ipsum@codethink.co.uk>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160810093731.GA3404@salo>
References: <20160729064055.GB25331@x>
 <20160803191202.GA22881@salo>
 <20160804224058.po43kl7w26ockfie@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160804224058.po43kl7w26ockfie@x>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 12:40:58PM -1000, Josh Triplett wrote:
> On Wed, Aug 03, 2016 at 08:12:02PM +0100, Richard Ipsum wrote:
> > On Thu, Jul 28, 2016 at 11:40:55PM -0700, Josh Triplett wrote:
> > > I'd welcome any feedback, whether on the interface and workflow, the
> > > internals and collaboration, ideas on presenting diffs of patch series,
> > > or anything else.
> > 
> > One other nice thing I've noticed about this tool is the
> > way series behave like regular git branches: I specify the name
> > of the series and from then on all other commands act on that
> > series until told otherwise.
> 
> Thanks; I spent a while thinking about that part of the workflow.  I
> save the current series as a symbolic ref SHEAD, and everything operates
> on SHEAD.  (I should probably add support for running things like "git
> series log" or "git series format" on a different series, because right
> now "until told otherwise" doesn't include a way to tell it otherwise.)

Apologies for this delayed response,
I needed time to gather my thoughts,
and also to fix the perl libgit2 binding to allow me to use
your symbolic ref suggestion. :p

Though it turns out that libgit2 doesn't currently allow
me to write arbitrary data to a symbolic ref as git-symbolic-ref(1) will,
so this still needs to be fixed somehow.

> 
> One fun detail that took a couple of iterations to get right: I keep
> separate "staged" and "working" versions per-series, so even with
> outstanding changes to the cover letter, base, or series, you can always
> detach or checkout another series without losing anything.  If you
> switch back, all your staged and unstaged changes will remain staged and
> unstaged where you left them.  That solves the "checkout a different
> series with modifications to the current series" case.

Cool

> 
> > git-appraise looks as though it might also have this behaviour.
> > I think it's a nice way to do it, since you don't generally
> > perform more than one review simultaneously. So I may well
> > use this idea in git-candidate if it's okay. :)
> 
> By all means.  For a review tool like git-candidate, it seems like you'd
> want even more contextual information, to make it easier to specify
> things like "comment on file F line L".  For instance, what if you
> spawned the diff to review in an editor, with plenty of extra context
> and a file extension that'll cause most editors to recognize it as a
> patch (and specifically a git-candidate patch to allow specialized
> editor modes), and told people to add their comments after the line they
> applied to?  When the editor exits successfully, you can scan the file,
> detect the added lines, and save those as comments.  You could figure
> out the appropriate line by looking for the diff hunk headers and
> counting line numbers.

I really like this idea, the current interface for commenting is a little
tedious I find.

> 
> If you use a format-patch diff that includes the headers and commit
> message, you could also support commenting on those in the same way.
> Does the notedb format support commenting on those?

Comments in notedb are just a git note keyed on the sha of the
commit being commented on, I'm not certain what advantage a format-patch
diff provides in this case?

I've been closely following the 'patch submission process' thread,
and given the discussion there I'm having doubts over the value
of comments in git-candidate vs the mailing list. It seems to me that
git-candidate has many of the disadvantages of Github/Gitlab when it
comes to comments, for example, there is no threading.

Also the system would be less open than the mailing list, since,
as it stands currently you would require push access to the repository
to comment on anything.

It may be worth reflecting that one reason some organisations
have switched away from mailing list reviews to Github/Gitlab is that
they provide patch tracking, where the mailing list provides none,
so patches there can be 'lost'. So instead of trying to reimplement
an entire Gerrit/Github/Gitlab ui on the commandline, I wonder whether
it would be sufficient to add the minimum functionality necessary
to provide git with native patch tracking, and leave comments for the
mailing list. Ofcourse this is exactly what git-series seems to do,
so in some sense I may be advocating dropping my own work in favour of
improving git-series.

On the other hand, relying on the mailing list means that some of the
history of a series is left outside of the repository which is
anathema to the goal of git based/stored review, not least because
mail archives are centralised.
(which can obviously be problematic (as we've seen recently with gmane))

Maybe there's a better solution to this problem than git-candidate then,
maybe we can just invent some wonderful new subcommand that fetches
a mailing list archive into a git repo, for those that want that,
I don't know.

Out of interest, did you have any thoughts on Notedb itself with respect
to its suitability for git-series?

> 
> > I haven't found time to use the tool to do any serious review
> > yet, but I'll try and post some more feedback when I do.
> 
> Thanks!
> 
