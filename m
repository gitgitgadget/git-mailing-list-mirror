From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 09:34:58 +0100
Message-ID: <496DA3B2.1070807@viscovery.net>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>	 <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>	 <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>	 <496D9572.2090303@viscovery.net> <2729632a0901140008r59e429aeq3ce367e1bc7df71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 14 09:36:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN1Eh-0007Ig-Tw
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 09:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461AbZANIfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 03:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757431AbZANIfD
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 03:35:03 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:18182 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339AbZANIfA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 03:35:00 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LN1DG-0003GD-M5; Wed, 14 Jan 2009 09:34:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5C8CFA865; Wed, 14 Jan 2009 09:34:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <2729632a0901140008r59e429aeq3ce367e1bc7df71@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105603>

[Please reply-to-all on this list, to keep Cc: list]

skillzero@gmail.com schrieb:
> On Tue, Jan 13, 2009 at 11:34 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> 
>> Well, the way to do it is "careful planning".
>>
>> If you have a *slight* suspicion that some change *might* be needed on a
>> different branch, then:
>>
>> 1. you commit the change on a branch of its own that forks off of the
>> merge-base of *all* the branches that *might* need it;
>>
>> 2. next, you merge this fix-up branch into the branch where you need it
>> first, which is very likely your current topic-under-development.
>>
>> 3. Later you can merge the branch into the other branches if you find that
>> it is really needed.
> 
> If I create a separate bug-fix-only branch X that forks from the
> latest common commit of all the branches that might need it and some
> of those branches already have commits after that merge base (e.g.
> branch Z is 5 commits after the common merge base by the time I fix
> the bug), will git be able to merge the new branch X into Z in a way
> that will allow me to also merge branch X into my original feature
> branch A and then later merge A into Z without duplicating the commit
> that is now in both branch X and Z?
> 
> It seems like I'd run into my original duplicate commit problem
> because even though branch X was originally based off the same parent
> commit, it will have a different parent when it is merged into Z
> because Z is no longer at that common merge commit (it's 5 commits
> beyond it).

After you created the fixup, you have this situation:

    o--o--o   <- A (feature branch)
   /
--o--x        <- X (the fix-up branch)
   \
    o--o--o   <- Z (probably your master)

You merge the fix-up into the feature branch and continue developing the
feature:

    o--o--o--M--o--o   <- A
   /        /
--o--x-----'           <- X
   \
    o--o--o            <- Z

Other people need the fix in Z right now, so you merge it into Z as well:

    o--o--o--M--o--o   <- A
   /        /
--o--x-----<           <- X
   \        \
    o--o--o--N         <- Z

You complete your feature and merge it into Z:

    o--o--o--M--o--o     <- A
   /        /       \
--o--x-----<         \   <- X
   \        \         \
    o--o--o--N---------O <- Z

The fix-up commit is only once in your history.

-- Hannes
