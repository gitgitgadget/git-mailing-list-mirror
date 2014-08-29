From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Relative submodule URLs
Date: Fri, 29 Aug 2014 11:09:20 -0400
Message-ID: <540097A0.9040003@xiplink.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com> <20140818205505.GA20185@google.com> <CAHd499DVf4N3Y6m5qoiy-WQGX4K54umefRzehZMsrxiWbaiZ=g@mail.gmail.com> <53F76907.1090904@xiplink.com> <53FF6A72.50605@xiplink.com> <20140828193533.GA20040@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Robert Dailey <rcdailey.lists@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 17:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNNng-0001b9-FM
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 17:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbaH2PJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 11:09:11 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:57550 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbaH2PJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 11:09:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp20.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 1A87018010A;
	Fri, 29 Aug 2014 11:09:09 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp20.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A20001800EB;
	Fri, 29 Aug 2014 11:09:08 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Fri, 29 Aug 2014 15:09:09 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140828193533.GA20040@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256147>

On 14-08-28 03:35 PM, Heiko Voigt wrote:
> On Thu, Aug 28, 2014 at 01:44:18PM -0400, Marc Branchaud wrote:
>> Heiko also said this:
>>> On Fri, Aug 22, 2014 at 12:00:07PM -0400, Marc Branchaud wrote:
>>>> With relative-path submodules, the push's target repo *must* also have the
>>>> submodules in their proper places, so that they can get updated.
>>>> Furthermore, if you clone a repo that has relative-path submodules you
>>>> *must* also clone the submodules.
>>>
>>> That is not true. You can have relative submodules and just clone/fetch
>>> some from a different remote. Its just a question of how to
>>> specifiy/transport this information.
>>
>> I meant that more as a general guideline than some kind of physical law.
>> Sure, it's possible to scatter the submodules across all sorts of hosts, but
>> it's not a good idea.  When it comes to relative-path submodules, pushing and
>> fetching submodule changes in the super-repo should just involve the one
>> remote host (whatever way that's determined).  This keeps things tractable,
>> because otherwise your branch's changes are scattered among many different
>> hosts and you end up considering weird things like "this part of the branch's
>> changes are on host A but this other part are on host B, so let's record that
>> somewhere, oh but what if host B is down when I'm trying to fetch, but I know
>> that host C has the changes too so why don't I just fetch what I want from
>> there".
>>
>> It's a nightmare.  It's infinitely better to treat a repository and its
>> relative-path submodules as an atomic unit, so that any remote that hosts the
>> repository also hosts the submodules.  When pushing a branch with submodule
>> changes, expect to find those submodules on the target remote and update
>> them.  Regardless of how the target remote is determined.  Same thing for
>> fetching.  It's just so much simpler to work this way.
> 
> You are right, its simpler. But I would not say "better". Depending on
> your project it might be "better" to just fork some submodules.

I think we need a clear definition of "fork" here.  Are you concerned that
there's are copies of the submodule repositories that are "unused" in the
branch?  (Indeed, yes, you are, as I see below.)

>> So please, let's not try to specify submodule remotes per-branch or make that
>> info pushable.  It's enough for a branch's local configuration to say that it
>> tracks fetch/pull refs on different remotes.  The rest should flow from that.
> 
> Why not? Git is all about flexibility. Of course if you organise your
> submodules in chaos you will get chaos. But consider this:
> 
> You have this big project which consists of submodule (e.g. like Android
> with hundreds of submodules). Now you want to develop on something that
> involves just a subset of submodules, lets say two submodules.
> 
> Now if someone just wants to publish a small change to some submodules
> you are demanding to setup a mirror of *all* submodules that are in this
> big project. That might not even be feasible depending on the projects
> size and the remote quota. Not to speak about having to first create a
> fork of hundreds of repositories. So in this situation we should support
> just referring some submodules to other places.

I feel that this scenario is something of a straw-man.  At the very least,
the developer already has a clone of all the submodules.  Disk space is cheap.

(If the developer doesn't need all the submodules then I suggest that the
super-project is badly organized and should use intermediate submodules to
make it easier for developers to focus on isolated areas.  That being said, I
can appreciate that repository hygiene is more art than science, and that a
large and/or long-lived project could end up with some pretty funky
configurations.)

> Regarding transporting this information. If you ask someone to try out
> your change it should be as simple as possible. It should be enough to
> say. clone from there and checkout that branch (once recursive checkout
> and fetch for submodules is in place). So here we need a way to
> transport this configuration for a fork.

You're assuming that the super-project is organized in such a way that
submodule-reliant code changes can live in isolation from the rest of the
project.  That's a bit like saying you can try out a change in gitk without
having the rest of git.  The super-project exists as a complete thing, and I
don't believe there are many projects where it would make sense to only try
out a change in isolation.  I'm not familiar with the Android project, but
I'd be mighty impressed if changes to any arbitrary subset of its submodules
could be thoroughly tested without a full Android system.

So I don't believe the scenario you're suggesting is at all simple.  The
person trying out the change can't just "clone from there" because the
submodules uanffected by the branch aren't there.  At the very least this
person needs to start with "origin" clones of the super-project and all of
its required submodules, not just the ones changed in the branch.  Then the
person can add the "fork" host as a remote and fetch the branch.

But it's still not that simple.  Because now you're expecting that the branch
somehow has information that overrides some submodules' URLs stored in
.git/config.  Coding that might be easy, I don't know, but as you say the
override information needs to be stored somewhere transportable and
branchable, like maybe a .gitmodules-fork file or something.  Because
obviously different branches will have different submodule overrides.

And that makes it even more complicated!  If the remote-overriding
information is stored as part of the branch then in fact that branch can't
just be merged and pushed to the "origin" host, because the submodules there
must not have their remotes overridden.  So now the branch has to be changed
in order to remove the overrides.  Users have to remember to do that, or
they'll break the origin's submodules.  But when the branch changes suddenly
whatever people reviewed in the "fork" isn't what gets pushed back to the
"origin".

> Yes for a small project where its feasible to simply clone all
> submodules you can just say: please fork everything. But for bigger
> projects thats not necessarily an option. So we should at least give the
> users that option. Then its a matter of policy how you work with a
> project.

OK, but even if we want to eventually do both perhaps it would be wiser to
start with the simple fork-everything model.  Maybe just teach "clone
--mirror" to also create relative-path submodules in their proper locations,
so that forks become easier.

> I am not saying that everything for this should be implemented in the
> first steps but we should keep it in mind and design everything in such
> a way that it is still possible to implement such a kind of workflow
> later.

I agree with using an incremental approach, but it's important to understand
where we want to go before suggesting a first step.  I'm just trying to think
through the implications of what's been suggested.  Please set me straight if
I'm not thinking about this properly.

		M.
