From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [1.8.0] Recursively checkout, merge and reset populated submodules
Date: Mon, 21 Feb 2011 19:30:30 +0100
Message-ID: <4D62AF46.8030508@web.de>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org> <4D5FF6E7.8090104@web.de> <4D628F21.3050808@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 19:30:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PraX6-0005o2-Tj
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 19:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab1BUSad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 13:30:33 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:39357 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab1BUSac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 13:30:32 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4A52A1890A126;
	Mon, 21 Feb 2011 19:30:31 +0100 (CET)
Received: from [93.246.44.148] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PraWl-0004kY-00; Mon, 21 Feb 2011 19:30:31 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D628F21.3050808@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/HqiA735vNhkZWdLy8xiSlTrJ88OUkYIN3mpfX
	yV47ODKqVrFslFLPjRIOzUemXyWzHfdFLW6Y+7grMFfmwLqpcF
	W6LaKxu0EX2IxOQ3zcKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167499>

Am 21.02.2011 17:13, schrieb Marc Branchaud:
> On 11-02-19 11:59 AM, Jens Lehmann wrote:
> Could you clarify the proposal a bit?  A few questions occurred to me as I
> read it:
> 
> * How is the initial set of populated submodules set up during a clone
> operation?  Specifically, how would the origin repo specify which submodules
> to recursively clone?  (My understanding is that the origin's .gitmodules
> file, as it exists in whatever branch is being cloned, would specify
> submodule.<name>.update values, and those would drive the recursion.)

That is what I have in mind. I tend towards updating all populated
submodules on local operations (like switching branches, merging and so
on) unless configured otherwise, while for cloning me thinks an explicit
"submodule.<name>.update=checkout" or such should be necessary.

(But please note that cloning was not part of my proposal, I was only
talking about the local operations for now ;-)

> * Which values of submodule.<name>.update would enable/disable recursion
> during a clone?  Would just "checkout" enable it, or should "merge" and
> "rebase" also trigger recursion when cloning?

"merge" and "rebase" could do that too, but wait: That would make it
impossible to say "I want his submodule merged/rebased but *not* cloned"
... Hmm, good point, I'll have to think about that some more ...

> * What happens when a clone's user manually populates one of the other
> submodules that wasn't part of the initial set?  Automatic recursion into
> this newly-populated submodule is controlled by the setting of the global
> recurse-submodules option, right?

There will be a global and a per-submodule configuration. But yes, if the
.git/config or .gitmodules don't specify anything for this submodule the
global config will kick in. And if that isn't set I imagine that porcelain
by default will recurse into populated submodules while plumbing won't.

> * What are the possible values of the global recurse-submodules option?
> Here's what I came up with:
> 
>   all       -- Always recurse
>   populated -- Only recurse into *all* currently-populated submodules
>   respect   -- Respect each submodule's "update" option (better name?)
>   none      -- Never recurse

For porcelain I tend to unify "all", "populated" and "respect": recurse
into all populated submodules unless configured otherwise ("all" seems
kind of superfluous, as I would respect the users choice not to populate
a submodule after the initial clone). But for plumbing a "respect" option
makes sense, using it could tell it to use the same defaults and config
that porcelain uses to make writing scripts easier.

> * What will happen when I start checked out at commit A, with a populated
> submodule, then check out commit B where that submodule doesn't exist, then
> return to commit A?  How will whatever recursion settings I had at the start
> be preserved?

I think the same option that controls the cloning of submodules should
control whether a new submodule will be populated or not. For submodules
that already existed despite that it might be nice to remember and respect
the users choice and restore it if it existed before.


Maybe I'll have to mention the next steps not covered by my proposal:

2) Checkout submodules on clone

3) Move .git-Directories into the .git of the superproject (this will
   enable us to delete and recreate submodules without cloning again or
   loosing local branches and/or tags).


After thinking about it again I now tend to agree with Junio that we should
bring in the functionality without enabling it by default first and then
later decide if and to what we change the defaults. So I draw back this
proposal and will post it again when all three steps are implemented and can
be properly evaluated.

Thanks both for your feedback!
