From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [1.8.0] Recursively checkout, merge and reset populated submodules
Date: Mon, 21 Feb 2011 14:56:53 -0500
Message-ID: <4D62C385.90204@xiplink.com>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org> <4D5FF6E7.8090104@web.de> <4D628F21.3050808@xiplink.com> <4D62AF46.8030508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 21 20:57:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrbsP-0007zC-OJ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 20:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629Ab1BUT4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 14:56:53 -0500
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:52614 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab1BUT4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 14:56:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp34.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id A350D380534;
	Mon, 21 Feb 2011 14:56:51 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp34.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 5EBDB380519;
	Mon, 21 Feb 2011 14:56:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <4D62AF46.8030508@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167504>

On 11-02-21 01:30 PM, Jens Lehmann wrote:
> Am 21.02.2011 17:13, schrieb Marc Branchaud:
>> On 11-02-19 11:59 AM, Jens Lehmann wrote:
>> Could you clarify the proposal a bit?  A few questions occurred to me as I
>> read it:
>>
>> * How is the initial set of populated submodules set up during a clone
>> operation?  Specifically, how would the origin repo specify which submodules
>> to recursively clone?  (My understanding is that the origin's .gitmodules
>> file, as it exists in whatever branch is being cloned, would specify
>> submodule.<name>.update values, and those would drive the recursion.)
> 
> That is what I have in mind. I tend towards updating all populated
> submodules on local operations (like switching branches, merging and so
> on) unless configured otherwise, while for cloning me thinks an explicit
> "submodule.<name>.update=checkout" or such should be necessary.
> 
> (But please note that cloning was not part of my proposal, I was only
> talking about the local operations for now ;-)

Ooops, sorry for jumping the gun!  I figured that since clone normally does a
checkout that this would have to be worked out as part of the proposal.

>> * Which values of submodule.<name>.update would enable/disable recursion
>> during a clone?  Would just "checkout" enable it, or should "merge" and
>> "rebase" also trigger recursion when cloning?
> 
> "merge" and "rebase" could do that too, but wait: That would make it
> impossible to say "I want his submodule merged/rebased but *not* cloned"
> ... Hmm, good point, I'll have to think about that some more ...
> 
>> * What happens when a clone's user manually populates one of the other
>> submodules that wasn't part of the initial set?  Automatic recursion into
>> this newly-populated submodule is controlled by the setting of the global
>> recurse-submodules option, right?
> 
> There will be a global and a per-submodule configuration. But yes, if the
> .git/config or .gitmodules don't specify anything for this submodule the
> global config will kick in. And if that isn't set I imagine that porcelain
> by default will recurse into populated submodules while plumbing won't.
> 
>> * What are the possible values of the global recurse-submodules option?
>> Here's what I came up with:
>>
>>   all       -- Always recurse
>>   populated -- Only recurse into *all* currently-populated submodules
>>   respect   -- Respect each submodule's "update" option (better name?)
>>   none      -- Never recurse
> 
> For porcelain I tend to unify "all", "populated" and "respect": recurse
> into all populated submodules unless configured otherwise ("all" seems
> kind of superfluous, as I would respect the users choice not to populate
> a submodule after the initial clone).

A lot of what I'm confused about is how git would distinguish between 2 things:

 - How the user specifies submodule recursion within a local repo.

 - How a repo specifies initial submodule recursion for clones.

I'm happy to wait for your follow-up work to discuss this.  Cloning aside,
what you're proposing looks good to me.

> But for plumbing a "respect" option
> makes sense, using it could tell it to use the same defaults and config
> that porcelain uses to make writing scripts easier.

I haven't thought enough about plumbing to tell if it makes sense to
configure plumbing behavior explicitly.  But at first glance it seems odd...

>> * What will happen when I start checked out at commit A, with a populated
>> submodule, then check out commit B where that submodule doesn't exist, then
>> return to commit A?  How will whatever recursion settings I had at the start
>> be preserved?
> 
> I think the same option that controls the cloning of submodules should
> control whether a new submodule will be populated or not. For submodules
> that already existed despite that it might be nice to remember and respect
> the users choice and restore it if it existed before.

So, .gitmodules initially controls recursion.  When a submodule gets
populated, it gets an entry in .git/config which then determines the
recursion behavior from then on.  Changing branches might change .gitmodules,
but anything in .git/config will persist so any customizations the user makes
will also persist.

Sounds good to me!

		M.
