From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH (WIP)] Show a dirty working tree and a detached HEAD
 in status for submodule
Date: Tue, 12 Jan 2010 17:20:15 +0100
Message-ID: <4B4CA13F.6020505@web.de>
References: <4B4BA096.5000909@web.de> <7vtyusb6rv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 17:20:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUjTl-0001fa-CQ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 17:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab0ALQUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 11:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141Ab0ALQUT
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 11:20:19 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:42266 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110Ab0ALQUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 11:20:18 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6665E13BF37A3;
	Tue, 12 Jan 2010 17:20:16 +0100 (CET)
Received: from [80.128.117.138] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NUjTb-00078s-00; Tue, 12 Jan 2010 17:20:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vtyusb6rv.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+9wNFBbosAOOYUECAjho7uv8ibZMztDZ3VehKZ
	kz+eXfbgvcI8e6t5gRLHSXkgq+1oUoU029PGwdoPpvATa9Hn1N
	sLgaIy7eonZpB6QlNRyg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136734>

Am 11.01.2010 23:45, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> * It makes git show submodules as modified in the superproject when
>>   one or more of these conditions are met:
>>
>>     a) The submodule contains untracked files
>>     b) The submodule contains modified files
>>     c) The submodules HEAD is not on a local or remote branch
>>
>>   That can be seen when using either "git status", "git diff[-files]"
>>   & "git diff[-index] HEAD" (and with "git gui" & gitk).
> 
> If the submodule is checked out, _and_ if the HEAD there, either detached
> or not, does not agree with what the "other" one records (i.e. the commit
> recorded in an entry in the index, or in the tree, that you are comparing
> your work tree against), then it also should be considered modified.  I
> don't think your (a)-(c) cover this case.

Right, i did not to add the current (and unchanged) behavior to this
list, i just wrote down the new cases (and these new cases only come
into play when the submodule has been checked out).


> Also I don't understand why you want to treat (c) any specially at all.

To avoid possible loss of commits.

Before doing something like "git checkout -f" or "git reset --hard", it
is a good idea to check via "git status" if you have local changes. I
hope checkout and reset will recurse into submodules in the near future.
when they do, all commits in the submodule which are not on any branch
are lost (at least when the reflog expired). Or the remote branch the
user thinks the submodule is tracking has been deleted or rebased. You
might want to know that before e.g. committing it in the superproject.

Maybe compare it to new or modified files in a git repo: They don't
necessarily pose a problem when committing, you might be able to push
and clone the repo somewhere else and nothing breaks. But you wanna
know about these new and modifies files, in case you just forgot to add
them. So i think the HEAD of a submodule not on any branch is a bit like
a new or modified file in a regular repo, both will not show up in a
different repo than yours unless you do something about it. And a
modification is lost by a checkout or reset just as the dangling commits
will be.

Yes, this test can't provide 100% safety against loss of commits, but at
least we should try to warn if we can detect it. Does it give false
positives (saying the submodules HEAD is dangling when it shouldn't)?
I doubt it. Does it give false negatives? Yes, but we can't do anything
about that due to the distributed nature of git.


> Even if (c) is something we _should_ report, please do not call that as
> "detached" in its implementation.

Correct, that term is misleading in this context. Maybe call it
something like "The submodule contains a HEAD not on any branch"
then? Or "The submodule has a dangling HEAD"?


>> * This behavior is not configurable but activated by default. A config
>>   option is needed here.
> 
> I doubt it.
> 
> My gut feeling is that this should be _always_ on for a submodule
> directory that has been "submodule init/update".  The user is interested
> in that particular submodule, and any change to it should be reported for
> both classes of users.  Theose who meant to use the submodule read-only
> need to be able to notice that they accidentally made the submodule dirty
> before making a commit in the superproject.  Those who wanted to work in
> submodule needs to know if the state is in sync with what they expect
> before making a commit in the superproject.

Yes, me too thinks it should default to on for every initialized
submodule.

But this is a major change in behavior, so it might be a good idea to be
able to turn it off (e.g. if it breaks scripts). Maybe a config option
really isn't such a bright idea, but what about having something like a
"--no-dirty-submodules" command line option?


> That of course is provided if the unconditional check does not trigger for
> submodules that the user hasn't "submodue init"ed; I think you did that
> correctly at the beginning of your is_submodule_modified() implementation.

Yes, that's what that test is for. Will add a comment there.


> But the thing is, in a distributed environment, the submodule HEAD being
> at the tip of _some_ branch (either local or remote) you have doesn't mean
> anything to help them.  IOW, for protect others, you would need a check
> when you _push out_ (either in 'push' or on the receiving end).

This is something on my TODO list: Add a change to "git push" to assert
that all HEADs of initialized submodules lie on a /remote/ branch before
doing the push in the superproject.


> So I'd suggest dropping this condition in "status/diff" that is about
> preparing to make the next commit in your _local_ history.

I would rather have this patch merged without c) than not at all. But i
think it is a worthwhile and rather cheap test. And i would prefer to
change the default behavior of "git status" only once now and not again
later.
