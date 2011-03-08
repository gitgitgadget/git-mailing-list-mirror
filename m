From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: rsync busy non-bare git repo 'source' to quiet
Date: Tue, 08 Mar 2011 16:20:33 -0600
Message-ID: <4D76ABB1.9080001@gmail.com>
References: <il66rd$46u$1@dough.gmane.org> <20110308213959.GB5786@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 23:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px5H1-00005K-Hj
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 23:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab1CHWUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 17:20:54 -0500
Received: from lo.gmane.org ([80.91.229.12]:43968 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008Ab1CHWUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 17:20:53 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Px5Gu-0008UC-Fs
	for git@vger.kernel.org; Tue, 08 Mar 2011 23:20:52 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 23:20:52 +0100
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 23:20:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110308213959.GB5786@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168708>

On 3/8/2011 3:39 PM, Jeff King wrote:
> On Tue, Mar 08, 2011 at 03:25:00PM -0600, Neal Kreitzinger wrote:
>
>> Does anyone have an example of an rsync bash script that will make
>> a good copy of a non-bare git repo (including the working tree)
>> while the "source" git repo is busy and the "destination" git repo
>> is quiet?
>
> Don't copy the working tree. It's redundant with the repo data
> (assuming your working tree is clean), so you are probably faster to
> sync .git and then "reset --hard". And then you don't have to worry
> about fetching an inconsistent working tree state.
>
> For syncing the repo, I think you would need to do:
>
> 1. Copy the refs to a local temp space.
>
> 2. Copy the object db.
>
> 3. Install your temp refs into place.
>
> That way, for any updates in progress you will either not copy them
> (because the refs weren't in place in step 1, though you may have
> some of their objects), or if you do copy them, you are guaranteed to
> have all of the necessary objects (because git will not update the
> ref until all objects are in place).
>
> But I really have to wonder why you don't simply use git to do the
> fetch? It already does the right thing with respect to updates, and
> it will be way more efficient than rsync in the face of repacking (or
> if you really do want to use rsync, there is even an rsync transport
> for git already). It sounds like:
>
>> This would make it very easy for us to refresh our "beta" livebox
>> to emulate the current "gold" livebox using a single rsync instead
>> of a combination of rsync and git-clone/pull due to the pieces that
>> git does not replicate (ie, hooks) and the non-git components of
>> our git based change control menu system (which is written in bash
>> scripts on linux).
>
> You just don't want to do a pull in addition to an rsync. But I
> don't think this solution will be any less complex.
>
One reason is that we only have one development box.  We would have to
open up the canonical repo and development repos to git:// protocol
access.  If I use git I have to do the initial clones for creation and 
then the pulls for refreshes.  rsync will do the creation and refreshes 
via the same script.  If I use git I would have to rsync the hooks, 
config, and anything else git doesn't bring over.  On the goldbox I have 
a bare repo that mirrors the canonical repo and then has additional 
branches and is in turn mirrored by another bare mirror which has all 
the additional branches.  I would have to recreate the original remote 
branch setup and then still maintain the remotes to the goldbox.  Then I 
wouldn't really have a simulation of the goldbox anymore because I have 
extra remotes (maybe that wouldn't really hurt anything).  Rsync seems 
like a simpler solution and more accurate solution for creating a copy 
of an ecosystem of interrelated git repos colocated on the same box.

A previous post in the newsgroup states:
"> If you want your rsync backup to be fine, you need to follow some
> ordering.  You need to copy the refs first (.git/packed-refs and
> .git/refs/), then the loose objects (.git/objects/??/*), and then all
> the rest.  If files are copied in a different order while some write
> operations are performed on the source repository then you may end up
> with an incoherent repository."

Would that work?

v/r,
neal
