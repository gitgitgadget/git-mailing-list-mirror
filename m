From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Mon, 6 Feb 2012 14:45:12 +0100
Message-ID: <201202061445.13203.jnareb@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <EAF9D593-4E0C-4C95-A048-3F6AC8ADD866@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 14:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuOsi-0002bB-HL
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 14:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab2BFNpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 08:45:12 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42805 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab2BFNpL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 08:45:11 -0500
Received: by eaah12 with SMTP id h12so2461768eaa.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 05:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=W5PtlbG3Zyj6oyfdqKGoUJ15lkeBc7Isf0MLbPRL9fQ=;
        b=bdcYkT6r4PUw2QG+DlzmTfIqNeD5JPPF5CmmmupjAo2KhYpiNFp1xY2gmj254M9auy
         VuAmkPAfM/TaSzUm0wQzYdiOEamTMllpW1imuIHs7An+NlnSDE5Bn3q7lC2yVD9ka+hK
         REDTq/U7d3AqC+hlxyw2kOlq+4HfwtFrPKDGw=
Received: by 10.213.29.205 with SMTP id r13mr1409608ebc.5.1328535909944;
        Mon, 06 Feb 2012 05:45:09 -0800 (PST)
Received: from [192.168.1.13] (abvv240.neoplus.adsl.tpnet.pl. [83.8.219.240])
        by mx.google.com with ESMTPS id a58sm61160860eeb.8.2012.02.06.05.45.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 05:45:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <EAF9D593-4E0C-4C95-A048-3F6AC8ADD866@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190070>

On Mon, 6 Feb 2012, Steven Michalske wrote:

> See inlined responses below.

Is this comment necessary at all?
 
> On Feb 4, 2012, at 11:45 AM, Jakub Narebski wrote:
> 
> > So people would like for git to warn them about rewriting history before 
> > they attempt a push and it turns out to not fast-forward.
> > 
> 
> I like this idea and I encounter this issue with my co-workers new to git.
> It scares them thinking they broke the repository.

It is true that while this feature would be useful also for "power
users", it would be most helpful for newbies (users new to git).

So I am afraid that implementing it with example hooks that must be
turned on explicitly might be not enough...
 
> > In Mercurial 2.1 there are three available phases: 'public' for
> > published commits, 'draft' for local un-published commits and
> > 'secret' for local un-published commits which are not meant to
> > be published.
> > 
> > The phase of a changeset is always equal to or higher than the phase
> > of it's descendants, according to the following order:
> > 
> >      public < draft < secret
> 
> Let's not limit ourselves to just three levels.  They are a great start
> but I propose the following. 

As we don't have any implementation, I'd rather we don't multiply entities.
I was even thinking about limiting to just 'public' and 'draft' "phases".
 
> published - The commits that are on a public repository that if are
>       rewritten will invoke uprisings. general rule here would be
>       to revert or patch, no rewrites. 
> based - The commits that the core developers have work based upon.
>       (not just the commits in their repo.) 
> 	general rule is notify your fellow developers before a rewrite.
> shared - The commits that are known to your fellow core developers.
> 	These commits are known, but have not had work based off of them.
> 	Minimal risk to rewrite. 

All these are very fairly nuanced, with minuscule differences between
them.  I'd rather not multiply entities, especially not introduce such
hard to guess what it about from their name.

In Mercurial phases share hierarchy of traits:
http://mercurial.selenic.com/wiki/Phases
 
           |        traits       |
           .......................  
           | immutable | shared  |
 ----------+-----------+---------+
 public    | x         | x       | ^
 draft     |           | x       | ^
 secret    |           |         | ^
	
The names of those traits probably should be changed in Git.

Those traits are boolean in Mercurial, but I think we can implement
what you would like to have to change them to tristate: 'deny' (unless
forced, i.e. the same as true), 'warn', 'ignore' (i.e. the same as false).

I think that it would be nice to be able to tune "severity" of trait
on per-remote and/or per-branch basis.  This way you would get warned
before rewriting commits that were pushed to your group repository,
and prevented from rewriting commits that are present in projects public
repository.

Nevertheless I think it is something better left for later, and added
only if it turns out to be really needed.

> local - The commits that are local only, no one else has a copy.
> 	Commits your willing to share, but have not been yet shared,
> 	either from actions of you, or a fetch from others. 

That's Mercurial's 'draft' phase.

> restricted or private - The commits that you do not want shared.
> 	Manually added, think of a branch tip marked as restricted
> 	automatically promotes commits to the branch as restricted. 

That's Mercurial 'secret' phase.

 
> Maybe make these like nice levels, but as two components,
> publicity 0-100 and rewritability 0-100 
> 	Published is publicity 100 and rewritability 0
> 	Restricted is publicity 0 and rewritability 100
> 	Based publicity 75 and rewritability 25
> 	Shared publicity 50 and rewritability 50
> 	Local publicity 25 and rewritability 75
> 	Restricted publicity 0 and rewritability 100

Continuous traits are IMHO a bad idea.  You would have to quantize them
and turn them on into specific behavior: ignore, warn, deny.

For example WTF does 25 "publicity" (bad name) or "rewritability" actually
means in term of git behavior, eh?
 
> Other option are flags stating if the commit is published, based,
> shared, or restricted.  You could have a published and based commit
> that is more opposed to rewrite than a public commit. 
> 
> Call security on a published restricted commit ;-)

Please note that while "phases" look like they are trait of individual
commits, they are in fact artifact of revision walking.  The idea is
that ancestors of 'private' commit can be 'private', 'draft' or 'public',
that ancestors of 'draft' commit are 'draft' or 'public', and that _all_
ancestors of 'public' commit are 'public'.
 
> Commits are by default local.

This 'by default' needs to be specified further, because for example
all commits in freshly cloned repository should be in 'public' phase
by default.  

Also, don't say 'commits are local', 'commits are published'; use "phases"
nomenclature (at least until we invent something so much better that it
is worth breaking consistency with Mercurial terminology).
> 
> Commits are published when they are pushed or fetched and merged to
> a publishing branch of a repository. 

BTW. I am not sure if pushing to remote repository updates (or can update)
any remote-tracking branches...

> 	On fetch/merge a post merge hook should send back a note to
> 	the remote repository that the commits were published. 

I think this is unnecessary in the "best practices" scenario, where each
user has separate private repository where he/she does his/her work, and
one's own public repository, where people fetch from.  He/she can push
to some shared repository, and that has to be supported too.

Though there is mothership/ sattellite situation, where you can pull and
push only from one direction.  There we might want for some way to notify
that some commits were fetched and should now be considered 'public'.
Though I am not sure if it is really necessary.
 
> Restricted commits/branches/tags should not be made public, error out and
> require clearing of the attribute or a --force-restricted option that
> automatically removes the restricted attribute.  They are at least promoted
> to shared, if not published.   

Or just skip them (silently or not) if we push using globbing refspec, and
glob matches some refs marked as 'private'.
 
> Based is only used in situations where you have developers sharing amongst
> their repositories, and you want a rule that is less restrictive than
> no rewrites.  

Multiplying entities.
 
> Shared is what we have now when a commit is in a remote repository without
> the no rewrite options. e.g. receive.denyNonFastForwards. 

Multiplying entities.
 
[...]
> > Using the nomenclature from Mercurial 
> >      public < draft < secret
> 
> public -> publicity 100, rewritability 0
> draft -> publicity ?, rewritability 50
> secret -> publicity 0, rewritability 100

That doesn't really help, at all.

-- 
Jakub Narebski
Poland
