From: D Herring <dherring@tentpost.com>
Subject: Re: idea: git "came from" tags
Date: Tue, 19 Jan 2010 00:02:11 -0500
Message-ID: <hj3ecj$836$1@ger.gmane.org>
References: <hj0nl9$uds$2@ger.gmane.org> <4B542EB2.5030407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 06:05:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX6H1-0007UG-7A
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 06:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817Ab0ASFCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 00:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803Ab0ASFCk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 00:02:40 -0500
Received: from lo.gmane.org ([80.91.229.12]:60403 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab0ASFCj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 00:02:39 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NX6Ec-000708-9J
	for git@vger.kernel.org; Tue, 19 Jan 2010 06:02:34 +0100
Received: from c-71-232-15-233.hsd1.ma.comcast.net ([71.232.15.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 06:02:34 +0100
Received: from dherring by c-71-232-15-233.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 06:02:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-71-232-15-233.hsd1.ma.comcast.net
User-Agent: Thunderbird 2.0.0.21 (X11/20090329)
In-Reply-To: <4B542EB2.5030407@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137424>

Michael J Gruber wrote:
> D Herring venit, vidit, dixit 18.01.2010 05:22:
>> Actors:
>> - public "upstream" repository
>> - public "local" repository
>> - end users tracking both
>>
>> Situation:
>> - local starts by tracking upstream
>> - local makes changes, commits, and sends upstream
>> - users now tracking local ahead of upstream
> 
> Here I have to ask why. If users choose to track a volatile branch then
> they have to live with rebasing or hard resets. If they want something
> stable then they should track upstream.

I'm maintaining the "local" repository in a distribution of upstream 
libraries.  I'm trying to avoid both volatile branches and unnecessary 
clutter.  Here, both upstream and local are stable; they are just 
maintained by different teams.  Upstream often accepts patches; but 
they may tweak things, use a different version control system, etc. 
and so the commit objects differ.


>> - upstream makes modified commits
>> - local satisfied, wants to reset master to upstream/master
>>
>> Problem:
>> - A merge will perpetually leave two parallel branches.  Even though
>> there are no longer any diffs, local/master cannot use the same
>> objects as upstream/master.
> 
> If there are no diffs then, in fact, it can share most objects since
> most trees will be the same, only a few commit objects will differ.

But once I have a local diff, the local tree must always use different 
git objects, even though the file contents are the same...


>> - A hard reset lets local/master return to sharing objects with
>> upstream/master; but this may break pulls or cause other problems for
>> users.
>>
>> Proposed solution:
>> - Local adds a "came from" tag to upstream/master, leaves a tag on the
>> head of local/master, and does a hard reset from local/master to
>> upstream/master.  When a user tracking local/master does a pull, their
>> client detects a non-fast-forward, finds the came-from tag, and treats
>> it as a fast-forward.
>>
>> Basically, this is a protocol to glue a "strategy ours" merge onto an
>> existing tree.  This way local can cleanly track upstream, with no
>> added complexity in the nominal (no local changes) case.
> 
> But doesn't that mean that users completely trust you about what they
> should consider a fast forward, i.e. when they should do a hard reset?
> So, this is completely equivalent to following one of your branches with
> +f, i.e. having a public a branch which they pull from no matter what,
> and having a private branch which pushes to the public one in case of
> fast-forwards as well as in the case when you would use your special tag.

This almost works, but it destroys some history preserved by a proper 
merge or this proposed extension.  For example, suppose there are 
three commits between the user's last fetch and this merge/forced 
update; a proper merge will download them, but a forced update will 
not.  This becomes important when a release tarball is based on one of 
these missing commits.

If local uses merge objects to track this properly, it creates a 
parallel branch that is simply nuisance clutter.  Normally, the 
nuisance is limited to a visual distraction in gitk; but it can be 
significant if a user is trying to track both local and upstream. 
When there are and have been no local changes, local is following 
upstream; so the user can freely follow either until a local change is 
made.  When there are no but have been local changes that were merged, 
the user must pick a branch even thought the contents are the same.

I could be obsessing over a minor detail; but the proposed change 
doesn't seem drastic.


To reiterate,
Given
A - C - E - ... - Z
  \   \
   - B + D
where A-Z are commit objects and the contents of merge D are identical 
to C, it would be nice to have a protocol that tags D for posterity 
and allows D->E to be a fast forward, without requiring cooperation 
from the source of E to Z.

Later,
Daniel
