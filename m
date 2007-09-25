From: Andreas Ericsson <ae@op5.se>
Subject: Re: Workflow question
Date: Tue, 25 Sep 2007 21:09:00 +0200
Message-ID: <46F95CCC.4080209@op5.se>
References: <46F93A99.5080707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 21:09:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaFmc-0004KB-FN
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 21:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbXIYTJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 15:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbXIYTJP
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 15:09:15 -0400
Received: from mail.op5.se ([193.201.96.20]:44212 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbXIYTJO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 15:09:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id ED69E194485;
	Tue, 25 Sep 2007 21:09:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wVcHSBz6lIpE; Tue, 25 Sep 2007 21:09:02 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id B39BB1943F7;
	Tue, 25 Sep 2007 21:09:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <46F93A99.5080707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59152>

Russ Brown wrote:
> Hi,
> 
> I've been trying to think of a git workflow that we could use to replace
> our current svn/svk setup without simply using git in exactly the same
> way that we use svn/svk.
> 
> Basically, we develop, maintain and enhance a website. On the central
> repo is trunk which represents live, and any number of project branches.
> Developers don't use local branches: they check out the project branches
> they're working on and commit to those. Developers merge from trunk to
> project branch from time to time to keep them current, and when a
> project rolls out the branch is merged to trunk.
> 
> In addition to the obvious advantages that git would give us (such as
> properly tracking that code author as opposed to the person who did the
> merge), I'm wanting to gain the following benefits:
> 
>  * The repository is very large (multiple gigabytes) and mirroring using
> svk obviously takes a lot of time and space, so I'm keen to bring that
> down, most likely by the developer not needing to mirror branches he
> doesn't care about, or by being able to throw away branches he's done with.
>  * The repository is full of revisions that fail review (or break
> things) and are fixed by subsequent revisions. We'd much rather be able
> to have the developer fix his revisions before they get committed
> 'upstream' (whatever that ends up meaning).
> 
> I asked earlier about the email-based model that git itself uses, and
> while it appears to work very well for a widely-dispersed open-source
> project, I think it will be too cumbersome and slow for a fast-paced
> internal development team who make a number of live releases every day.
> 

We came to the same conclusion at our workplace. Email works great, but
it's faster and better to just walk over to your colleague and ask what
he/she thinks about something.

> So, I've been thinking and have come up with this, which I'd appreciate
> comments about:
> 
>  1. On a server we stick a git repository which contains the master
> branch, which represents what trunk did (i.e. the live platform). This
> branch contains the full history for the live platform.

A must-have for any more-than-two-developers setup, so so far so good ;-)

>  2. On the same server we clone that repo to create a second repository
> which is the developer area. In this we track master from the live repo,
> and also create project branches.

This isn't necessary. Branches in git are very nearly zero-cost, so having
them in the same repo as the master branch won't hurt a bit. You can add
an update-hook on the mothership repo to restrict access to the master
branch if you like, but creating two separate repos will likely give
more headache than it's worth.

>  3. Developers clone this developer repo, but I'd like them to be able
> to decide which branches they actually want to clone from that
> repository rather than simply cloning them all. Is this possible?

Yes, although I'd actually recommend you to clone the full repo anyway.
Since the various branches are likely to share quite a lot of history
the added overhead of a few extra branches will most likely be negligible.
git makes even very large codebases appear small and unobtrusive. The
linux kernel history since 2.6.12 contains 554853 objects and compresses
down to 178MiB.

I think KDE is the largest repo imported to git so far. I've forgotten
the exact numbers, but everyone was very impressed, and quite surprised,
at the vast difference between SVN and git storage requirements.


>  4. Developers create a local branch of the project they
> are working on and commit to that.
>  5. Once they think they're done, they publish their branch to the
> development repo and request for comments.

Using topic-branches is a much better strategy, usually, since that
allows each feature to be evaluated and improved on on its own, rather
than having to merge *all* of a particular developers changes just to
get desirable feature X. Note that cherry-pick provides ways of doing
that anyways, but in a much less elegant way, and your integrator/
release engineer will likely tear his hair out on a daily basis without
topic branches.

>  6. If all is not well, the developer creates a new local branch and
> moves good revisions from his previous one to the new one, modifying
> things as he goes, and republishes his new branch.
>  7. If all is well, their works gets merged or rebased onto the main
> project branch, and once that's ready it gets pushed to the master and
> rolled to live. The developer's individual branches get deleted from the
> dev repo since they're no longer required.

Topic branches would work the same, basically, except they can be pushed up
for review a lot faster.

If all the pushing gets cumbersome, it also makes it easy to send the patches
out as emails for discussion. It's usually easier to let git handle the
actual code transmissions, but discussing patches in emails works quite
well if it's intended for a wider audience.

>  8. From time to time the master branch gets merged to the project
> branches. Developer's local branches can be rebased against the project
> branch as they please.
> 

criss-cross merging can turn kinda nasty though, as you may have a hard time
finding *the* common point when you run into that rogue merge with conflict
markers everywhere (it happens for everyone sooner or later).

I'd suggest you rebase the developer/topic branches onto master with regular
intervals instead.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
