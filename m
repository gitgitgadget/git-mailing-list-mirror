From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list
Date: Wed, 8 Jun 2005 19:31:19 +1000
Message-ID: <2cfc403205060802315ba2433a@mail.gmail.com>
References: <20050607091523.14051.qmail@blackcubes.dyndns.org>
	 <20050607094947.GC2676@pasky.ji.cz>
	 <2cfc403205060702594da21fb1@mail.gmail.com>
	 <20050608085834.GC7916@pasky.ji.cz>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 11:28:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dfwqs-0004jS-93
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 11:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVFHJbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 05:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVFHJbs
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 05:31:48 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:35227 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262152AbVFHJbV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 05:31:21 -0400
Received: by rproxy.gmail.com with SMTP id i8so221868rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 02:31:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VsxVqkJyBWMq+jnIHq3x5lDUm1pEI18z/5mfCzXqkj07IkP03I/1qv5LQnQ+GCt0Vf5RsA1nK84EbfGeY2R88mglExowUzwhrOZu58yFqd1VsJdoXprFrJyCkh9Zwp3C8R6uLe9OgRMifoZsqBVzcoc4QFhO5MjNSq+AnmOORfo=
Received: by 10.38.104.24 with SMTP id b24mr3580550rnc;
        Wed, 08 Jun 2005 02:31:19 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 8 Jun 2005 02:31:19 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050608085834.GC7916@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/8/05, Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Tue, Jun 07, 2005 at 11:59:36AM CEST, I got a letter
> where Jon Seymour <jon.seymour@gmail.com> told me that...
> > On 6/7/05, Petr Baudis <pasky@ucw.cz> wrote:
> > > I'd prefer just --wrt-author and --exclude-author to take an argument on
> > > their own.
> >
> > The reason I don't want to do this is that it doesn't really make
> > sense in the context of the change to specify one author for
> > --wrt-author and another for --exclude-author. In normal use --author
> > defaults to GIT_AUTHOR_EMAIL or the locally derived user@host.domain.
> > The  intention is simply to override this default derivation.
> 
> Hmm, then why not make it --wrt-author[=AUTHOR] ? Similar to the
> --pretty option. BTW, can it do multiple author excludes now? The
> commandline would look especially horrifying in that case now, I guess.
> 

No, it doesn't. I can see a use for multiple ^ arguments, but the use
case for multiple --stop-at-author arguments doesn't strike me as
being particularly useful. Multiple ^'s helps you prune the graph at
places you already know about --stop-at-author allows you to prune the
tree with respect to one author. It is particularly useful if you are
the author concerned because you have some recollection of being of
what you did last. I am not sure it is that useful to prune the tree
with respect to multiple authors - the results would be somewhat
unpredictable, I would think.

> I'd prefer --stop-at-author from the choices you offer in your other
> mail.
> 

Ok, unless I Linus or the list disagree I will modify my patch to be
--stop-at-author.

> > > (Note that I don't endorse this patch and the --wrt-author behaviour in
> > > particular seems strange. I don't have enough time to comment on it
> > > sensibly now, though. I'm just focusing on style here since I'd like to
> > > still be able to read git's source code few weeks from now on.)
> >
> > The rationale for the change is as follows:
> >
> > During parallel development, one is aware of ones own
> > changes...everyone else changes haven't happened yet as far as you are
> > concerned. Only when they appear in a future merge that incorporates
> > one's own changes do the other changes appear in your own workspace.
> >
> > As far as you are concerned, these changes occurred after you made
> > your own - your changes were not dependent on those changes, only on
> > those that came before. So the linearisation reflects that perceived
> > ordering of changes.
> >
> > --wrt-author helps to reconstruct the merge-history from the
> > perspective of each individual committer.
> 
> Yes, such motivation makes sense. But is the author field the right one?
> If you are integrating a lot of other people's patches in particular, I
> think it makes no sense whatsoever - you already reviewed and
> consciously applied them, but your option will regard them as something
> alien and merged from outside, right?
> 
> And, after all, the other branches might be _quite_ long-lived. I think
> it would be confusing for the user if the commit graph looked like
> 
>   a1 -- a2 -- a3 -- a4 -- a5 -- a6 -- a7 -- a8 -- a9 -- a10
>      \           /           /     \                 /
>       - b1 -- b2 -- b3 -- b4 -- b5 -- b6 -- b7 -- b8 -- b9
> 
> If your patch first chooses b1, it then shows all of it, completely
> ignoring a2, right? I can't see how that would be right - the subsequent
> merges from a should be shown.

No, that's not the intent of --wrt-author when specified without
--stop-at-author.

--wrt-author doesn't cause any commits to be ignored ... it simply
changes the order
in which they are displayed by altering the order in which parents are visited.

I'll get it wrong if I do it by hand so I'll create a test case and
show you what the default merge order would be, the --wrt-author
--author=a and the --wrt-author --author=b cases.

Stay tuned...

jon.
