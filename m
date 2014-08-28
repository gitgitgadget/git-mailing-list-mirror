From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Relative submodule URLs
Date: Thu, 28 Aug 2014 13:44:18 -0400
Message-ID: <53FF6A72.50605@xiplink.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>	<20140818205505.GA20185@google.com> <CAHd499DVf4N3Y6m5qoiy-WQGX4K54umefRzehZMsrxiWbaiZ=g@mail.gmail.com> <53F76907.1090904@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Robert Dailey <rcdailey.lists@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:44:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN3k8-0004hA-4k
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 19:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbaH1RoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 13:44:12 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:40193 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbaH1RoL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 13:44:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp26.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 51D3880147;
	Thu, 28 Aug 2014 13:44:10 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp26.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id E151C8010F;
	Thu, 28 Aug 2014 13:44:09 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Thu, 28 Aug 2014 17:44:10 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53F76907.1090904@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256108>

Sorry for dropping out of the conversation; the last few days were a bit hectic.

Regarding recursive branching, I agree that a super-repo's branch names are
not necessarily appropriate for its submodules, and that Heiko's "simple
workflow" is a workable base to build upon.  More thought is needed here, but
that's for another day.

Regarding remote.default, Robert please understand that the feature doesn't
exist, and the idea is to only serve as a fallback when the current methods
for remote selection end up resorting to the hardcoded "origin" name.  More
thought is also needed here, but not today.

Both Heiko and Robert took issue with this statement of mine:

On 14-08-22 12:00 PM, Marc Branchaud wrote:
> A branch should fork the entire repo, including its submodules.  The
> implication is that if you want to push that branch somewhere, that
> somewhere needs to be able to accept the forks of the submodules *even
> if those submodules aren't changed in your branch* because at the very
> least the branch ref has to exist in the submodules' repositories.

Heiko said: "It should be easy to work on a repository that is forked in its
entirety, but it should also be possible (and properly supported) to only
fork some submodules."

You're right, I overstated it when I said that the branch ref has to exist in
the unchanged submodules.  The super-repo branch records which submodules it
updates, and when pushing the branch somewhere only those submodules' changes
need to be pushed.

Robert asked: "How will this impact *creating* branches? What about forking?
Do you expect submodule forking & branching to be automatic as well? ... This
seems difficult to do, especially the forking part since you would need an
API for this (Github, Atlassian Stash, etc), unless you are thinking of
something clever like local/relative forks."

I meant "fork" in the local-branch sense:  The branch represents a topic in
the repository, and it should encompass the entire repository including its
submodules (just like the branch encompasses all the files in the repository,
even though the branch's commits only change a subset of those files).  I
think you're talking about "fork" in the sense of setting up a mirror of a
repository.  I agree that there aren't really any tools for automatically
doing that with repositories that contain relative-path submodules.  I think
"git clone" could learn to do it, though.


Heiko also said this:
> On Fri, Aug 22, 2014 at 12:00:07PM -0400, Marc Branchaud wrote:
>> With relative-path submodules, the push's target repo *must* also have the
>> submodules in their proper places, so that they can get updated.
>> Furthermore, if you clone a repo that has relative-path submodules you
>> *must* also clone the submodules.
>
> That is not true. You can have relative submodules and just clone/fetch
> some from a different remote. Its just a question of how to
> specifiy/transport this information.

I meant that more as a general guideline than some kind of physical law.
Sure, it's possible to scatter the submodules across all sorts of hosts, but
it's not a good idea.  When it comes to relative-path submodules, pushing and
fetching submodule changes in the super-repo should just involve the one
remote host (whatever way that's determined).  This keeps things tractable,
because otherwise your branch's changes are scattered among many different
hosts and you end up considering weird things like "this part of the branch's
changes are on host A but this other part are on host B, so let's record that
somewhere, oh but what if host B is down when I'm trying to fetch, but I know
that host C has the changes too so why don't I just fetch what I want from
there".

It's a nightmare.  It's infinitely better to treat a repository and its
relative-path submodules as an atomic unit, so that any remote that hosts the
repository also hosts the submodules.  When pushing a branch with submodule
changes, expect to find those submodules on the target remote and update
them.  Regardless of how the target remote is determined.  Same thing for
fetching.  It's just so much simpler to work this way.

So please, let's not try to specify submodule remotes per-branch or make that
info pushable.  It's enough for a branch's local configuration to say that it
tracks fetch/pull refs on different remotes.  The rest should flow from that.

		M.
