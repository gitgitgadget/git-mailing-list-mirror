From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Sat, 05 Feb 2011 02:18:44 +0100
Message-ID: <201102050218.44325.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 02:19:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlWnx-0003u3-7a
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 02:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878Ab1BEBTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 20:19:00 -0500
Received: from smtp.getmail.no ([84.208.15.66]:57410 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795Ab1BEBSt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 20:18:49 -0500
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG400KKGEBAV730@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 05 Feb 2011 02:18:46 +0100 (MET)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 278221EF014C_D4CA576B	for <git@vger.kernel.org>; Sat,
 05 Feb 2011 01:18:46 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id AA1761EF0150_D4CA574F	for <git@vger.kernel.org>; Sat,
 05 Feb 2011 01:18:44 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG400C6NEB8Q610@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 05 Feb 2011 02:18:44 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166070>

On Friday 04 February 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > - Remote heads have moved into refs/remotes/$remote/heads/*, hence
> > invalidating shorthand remote head names, like "origin/master". We
> > should change the lookup code, so that a shorthand ref of the form
> > "$remote/$head" where "$remote" happens to match a configured remote
> > is eventually expanded into lookup for
> > "refs/remotes/$remote/heads/$head" [3].
> 
> Keeping 'origin/next' usable is a _must_, _if_ we were to go this route.

Of course.

> > - All fetch refspecs should be given explicitly.
> 
> What do you mean by this?

Today, when you fetch from a remote, the config typically says

[remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = ...

But this fetch refspec does not tell the full story. In addition to mapping 
origin's refs/heads/* into refs/remotes/origin/*, it also fetches origin's  
HEAD into refs/remotes/origin/HEAD, and anything in origin's refs/tags/* 
that happen to point to a fetched object is fetched into refs/tags/* (aka. 
auto-following tags). These other fetches are not explicitly specified in 
the config, but "magically" happen anyway. Instead of having such implicit 
refspecs, I'd rather have all fetch refspecs listed explicitly in the 
config, like this (for replicating current layout):

[remote "origin"]
        fetch = +HEAD:refs/remotes/origin/HEAD
        fetch = +refs/heads/*:refs/remotes/origin/*
        fetch = ~refs/tags/*:refs/tags/*
        url = ...

or this (in the proposed new layout):

[remote "origin"]
        fetch = +HEAD:refs/remotes/origin/HEAD
        fetch = +refs/heads/*:refs/remotes/origin/heads*
        fetch = +refs/tags/*:refs/remotes/origin/tags/*
        url = ...

> > Sub-proposal: While we are changing the default refspecs, we should
> > also consider whether we want to keep the auto-following behavior that
> > Git currently does for tags (don't fetch tags that refer to objects
> > not otherwise fetched by another refspec). If we simply make an
> > explicit "+refs/tags/*:refs/remotes/$remote/tags/*" refspec, we will
> > lose the auto- following behavior. If we do want to keep the
> > auto-following behavior, we could for example add a "~" prefix to the
> > refspec to trigger auto-following behavior (i.e. this refspec only
> > applies to refs that happen to point at objects fetched by way of a
> > different refspec). See
> > http://thread.gmane.org/gmane.comp.version-control.git/160503/focus=160
> > 795 for more details.
> 
> You seem to envision "auto-follow" to slurp remote tags in
> remotes/origin/$tag namespace. What should "git fetch --tags $from_there"
> do?

I would propose that "git fetch --tags $from_there" follows these steps:

1. Enumerate the (implicit or explicit) fetch refspecs for the given remote.

2. Map "refs/tags/*" through the refspecs to find where the remote tags 
should be stored in the local repo.

3. If the matching refspec starts with "~" (auto-following), disregard the 
"~" (since --tags disables auto-following).

4. Slurp remote tags into the location found in step #2.

Since we map through the refspec, the remote tags end up where the user 
expect to find them: in refs/tags/* for old-style remotes, or in 
refs/remotes/$from_there/tags/* for new-style remotes.

> For some reason, many people seem to be enthused about splitting the tag
> namespace, but I am not sure if that is a good thing in general. 
> Branches are moving pointers for people to flip around in their local
> repositories, and it makes sense to say "My master is a bit ahead of the
> public one", but what would we gain by making it _easier_ to add and
> exchange many tags with the same name (e.g. refs/remotes/*/tags/v1.7.4
> vs refs/tags/v1.7.4), other than the extra confusion?

First, I should state that making tags into moving pointers is not something 
I support, nor is it part of this proposal. Tags should still very much 
refuse to be moved (except when forced).

Having said that, there are real situations where users encounter collisions 
in the shared tag namespace. A rare (but plausible) scenario arise when two 
developers create (and publish) conflicting tags in their repos. A more 
common scenario that I have encountered at $dayjob, is where two parallel 
(semi-related) projects are developed in separate repos (with different 
versioning because of separate release schedules), and I need to interface 
with both repos from a single local repo. Each of the remote repos have 
their own "v1.0" tag, but my repo can only hold one such tag. Which of those 
tags end up "winning" in my local repo depends on my fetch order.

Git already has code to discover ambiguous ref names, and we have powerful 
tools for inspecting the history and diffs between local and remote 
branches. But because we conflate tags into a single namespace, we cannot 
easily use these tools when circumstances conspire to produce conflicting 
tags.

Putting remote tags into separate namespaces allows us to use the same tools 
that we use on remote branches, to discover and inspect conflicting tags 
when (if only rarely) they do happen.

Another advantage of splitting tags into separate namespaces is that the 
"source" or "domain" of a tag becomes slightly less foggy: Consider a tag 
"foo" that may exist as refs/remotes/origin/tags/foo (remote/public) and/or 
as refs/tags/foo (local/private). If it exists only locally, it may be a 
hint that this is a "private" tag (not intended for public consumption). If 
it exists only remotely, it's obviously a public tag. If it exists both 
locally and remotely (without conflict), it may indicate that this is a 
public tag that was originally created in this repo.

> While you are talking about drastic reorganization (and rewriting the ref
> code to support it), another possible Sub-proposal we may want to
> consider is to allow "next" and "next/foo" at the same time.

Interesting. I haven't followed this discussion lately (if there has been 
any), but I guess we need to find a new way to organize loose refs that 
doesn't cause file vs. directory problems. Obviously, the packed-refs format 
should have no inherent problem with these refs, but I guess we can't drop 
loose ref support completely.

One sort-of-workaround could be to detect when "next" vs. "next/foo" 
happens, and simply force one of them to be a packed ref.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
