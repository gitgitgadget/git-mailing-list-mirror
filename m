From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Relative submodule URLs
Date: Fri, 22 Aug 2014 12:00:07 -0400
Message-ID: <53F76907.1090904@xiplink.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>	<20140818205505.GA20185@google.com> <CAHd499DVf4N3Y6m5qoiy-WQGX4K54umefRzehZMsrxiWbaiZ=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Robert Dailey <rcdailey.lists@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 18:06:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKrMb-00067t-6k
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 18:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbaHVQGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 12:06:42 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:46762 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbaHVQGk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 12:06:40 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Aug 2014 12:06:40 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp31.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 4C9BB3800F3;
	Fri, 22 Aug 2014 11:59:59 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp31.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CEF1638008C;
	Fri, 22 Aug 2014 11:59:58 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Fri, 22 Aug 2014 15:59:59 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CAHd499DVf4N3Y6m5qoiy-WQGX4K54umefRzehZMsrxiWbaiZ=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255683>

On 14-08-19 12:07 PM, Robert Dailey wrote:
> On Mon, Aug 18, 2014 at 3:55 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Thanks for reporting.  The remote used is the default remote that "git
>> fetch" without further arguments would use:
>>
>>         get_default_remote () {
>>                 curr_branch=$(git symbolic-ref -q HEAD)
>>                 curr_branch="${curr_branch#refs/heads/}"
>>                 origin=$(git config --get "branch.$curr_branch.remote")
>>                 echo ${origin:-origin}
>>         }
>>
>> The documentation is wrong.  git-fetch(1) doesn't provide a name for
>> this thing.  Any ideas for wording?
> 
> I guess a good start would be to call it the "tracked remote" instead
> of "remote origin". The word "tracked" here makes it very obvious that
> if I have a remote tracking branch setup, it will use the remote
> portion of that configuration.
> 
> The real question is, how will `git submodule update` function if a
> tracking remote is not configured? Will it fail with some useful error
> message? I don't like the idea of it defaulting to "self remote" mode,
> where it will be relative to my repo directory. That seems like it
> would fail is subtle ways in a worst-case scenario (if I did by
> happenstance have a bare repository cloned up one directory level for
> other reasons).
> 
>> Currently there isn't, short of reconfiguring the remote used by
>> default by "git fetch".
> 
> I wish there was a way to specify the remote on a per-branch basis
> separately from the tracking branch. I read a while back that someone
> proposed some changes to git to support decentralized tracking
> (concept of an upstream tracking branch and a separate one for origin,
> i think). If that were implemented, then relative submodules could
> utilize the 'upstream' remote by default for each branch, which would
> provide more predictable default behavior. Right now most people on my
> team would not be aware that if they tracked a branch on their fork,
> they would subsequently need to fork the submodules to that same
> remote.
> 
>>> Various co-workers use the remote named "central" instead of
>>> "upstream" and "fork" instead of "origin" (because that just makes
>>> more sense to them and it's perfectly valid).
>>>
>>> However if relative submodules require 'origin' to exist AND also
>>> represent the upstream repository (in triangle workflow), then this
>>> breaks on several levels.
>>
>> Can you explain further?  In a triangle workflow, "git fetch" will
>> pull from the 'origin' remote by default and will push to the remote
>> named in the '[remote] pushdefault' setting (see "remote.pushdefault"
>> in git-config(1)).  So you can do
>>
>>         [remote]
>>                 pushDefault = whereishouldpush
>>
>> and then 'git fetch' and 'git fetch --recurse-submodules' will fetch
>> from "origin" and 'git push' will push to the whereishouldpush remote.
> 
> I didn't know about this option, seems useful.
> 
> A common workflow that we use on my team is to set the tracking branch
> to 'upstream' for convenient pulls with rebase. This means a feature
> branch of mine can track its parent branch on 'upstream', so that when
> other pull requests get merged in on the remote repo branch, I can
> just do `git pull` and my feature branch rebases onto the latest of
> that parent branch.
> 
> Cases like these would work with relative submodules because
> 'upstream' is the tracked remote (and most of the time we don't want
> to fork submodules). However sometimes I like to track the same pushed
> branch on origin (my fork), especially when it is up for pull request.
> In these cases, my submodule update will fail because I didn't fork my
> submodules when I changed my tracking branch. Is this correct?
> 
> "breaks on several levels" was basically my way of saying that various
> workflow choices will break when you introduce submodules. One of the
> beautiful things about Git is that it allows everyone to choose their
> own workflow. But submodules seem to prevent that to some degree. I
> think addressing relative submodule usability issues is the best
> approach for the long term as they feel more sustainable and scalable.
> It's an absolute pain to move a submodule URL, I think we've all
> experienced it. It's even harder for me because I'm the go-to at work
> for help with Git. Most people that aren't advanced with Git will not
> know what to do without a ton of reading & such.
> 
>> It might make sense to introduce a new
>>
>>         [remote]
>>                 default = whereishouldfetch
>>
>> setting to allow the name "origin" above to be replaced, too.  Is that
>> what you mean?

A couple of years ago I started to work on such a thing ([1] [2] [3]), mainly
because when we tried to change to relative submodules we got bitten when
someone used clone's -o option so that his super-repo had no "origin" remote
*and* his was checked out on a detached HEAD.  So get_default_remote() failed
for him.

I didn't have time to complete the work -- it ended up being quite involved.
 But Junio did come up with an excellent transition plan [4] for adopting a
default remote setting.

[1] (v0) http://thread.gmane.org/gmane.comp.version-control.git/200145
[2] (v1) http://thread.gmane.org/gmane.comp.version-control.git/201065
[3] (v2) http://thread.gmane.org/gmane.comp.version-control.git/201306
[4] http://article.gmane.org/gmane.comp.version-control.git/201332

> I think you're on the right path. However I'd suggest something like
> the following:
> 
> [submodule]
>     remote = <remote_for_relative_submodules> (e.g. `upstream`)

I think remote.default would be more generally useful, especially when
working with detached checkouts.

(For the record, I would also be happy if clone got rid of its -o option and
"origin" became the sacred, reserved remote name (perhaps translated into
other languages as needed) that clone always uses no matter what.)

> [branch.<name>]
>     submoduleRemote = <remote_for_relative_submodule>

If I understand correctly, you want this so that your branch can be a fork of
only the super-repo while the submodules are not forked and so they should
keep tracking their original repo.

To me this seems to be going in the opposite direction of having branches
recursively apply to submodules, which I think most of us want.

A branch should fork the entire repo, including its submodules.  The
implication is that if you want to push that branch somewhere, that somewhere
needs to be able to accept the forks of the submodules *even if those
submodules aren't changed in your branch* because at the very least the
branch ref has to exist in the submodules' repositories.

With absolute-path submodules, the push is a simple as creating the branch
ref in the submodules' "home" repositories -- even if the main "somewhere"
you're pushing to isn't one of those repositories.

With relative-path submodules, the push's target repo *must* also have the
submodules in their proper places, so that they can get updated.
Furthermore, if you clone a repo that has relative-path submodules you *must*
also clone the submodules.

Robert, I think what you'll say to this is that you still want your branch to
track the latest submodules updates from their "home" repository. (BTW, I'm
confused with how you're using the terms "upstream" and "origin".  I'll use
"home" to refer to the repository where everything starts from, and "fork"
for the repository that your branch tracks.)  Well, you get the updates you
want when your branch tracks a ref in the "home" repository.  But when your
branch starts tracking a ref in another "fork" repository then you'll get the
submodule updates in that ref's history from that "fork" repository.

Once your branch is tracking the "fork" repository, if you do a pull you
won't get any submodule updates because the fork's branch hasn't changed.
You need to fetch (recursively) from the "home" repo to get the submodule
updates (assuming one of the "home" repo's branches has updated its
submodules).  Then, with your branch checked out in the super-repo, if you
check out the latest refs in your submodules git will tell you that you have
uncommitted changes in your branch.  The correct way to get submodule updates
into your branch is to commit them.  Even though you're doing a pull/rebase,
there's nothing to rebase onto in the "fork" repository that has the updated
submodules.

		M.
