From: Andreas Ericsson <ae@op5.se>
Subject: Re: interactive rebase not rebasing
Date: Wed, 01 Oct 2008 09:50:44 +0200
Message-ID: <48E32BD4.1050107@op5.se>
References: <20080928235013.5c749c6e.stephen@exigencecorp.com>	<48E078BF.5030806@op5.se> <20081001010306.01cc34eb.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 09:52:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkwV9-0000nm-G8
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 09:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbYJAHuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 03:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbYJAHuw
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 03:50:52 -0400
Received: from mail.op5.se ([193.201.96.20]:51754 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbYJAHuv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 03:50:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A8D7B24B0008;
	Wed,  1 Oct 2008 09:42:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.508
X-Spam-Level: 
X-Spam-Status: No, score=-3.508 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.891, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KAU-3Kbq1TcZ; Wed,  1 Oct 2008 09:42:08 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 94A711B8005F;
	Wed,  1 Oct 2008 09:42:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081001010306.01cc34eb.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97209>

Stephen Haberman wrote:
>>> # A --C------            <-- origin/stable
>>> #  \  |      \
>>> #   B -- D -- E -- F     <-- origin/topic2
>>> #    \|
>>> #     g -- h             <-- topic2
>>>
>>> Nothing has changed. g & h haven't moved...I can keep executing this
>>> operation and the commits never make it on top of origin/topic2's F. 
>>>
>>> Frustratingly, if I run non-interactive rebase, it works perfectly.
>> I can imagine. Since you don't want to preserve the merges in this
>> case, you shouldn't be using the -p flag.
> 
> No, I do want to preserve most merges. This "most" qualification is
> because the merge "g", if rebased, would have been a no-op, so `rebase
> -i -p` correctly kept it out of the TODO file.
> 
> Which is cool, except that later on, when rewriting the other TODO
> commits, some of which were children of "g", it did not remember that
> "g" had gone away, so did nothing to take "g" out of the rewritten
> children's parent list.
> 
>> In fact, for this particular scenario (assuming "h" is really the only
>> commit on topic2), you probably want to just cherry-pick that commit
>> into origin/topic2:
>>
>>    git checkout topic2
>>    git reset --hard origin/topic2
>>    git cherry-pick ORIG_HEAD
> 
> Agreed. This makes a lot of sense for me, who has been hacking around in
> git-rebase--interactive fixing things, but I'd really like the other
> people on my team to just have to run `git rebase -i -p`.
> 
>> I don't think you can have a single command that does all the things
>> you want, because the possible differences in input makes it very
>> nearly impossible to always do "the right thing".
> 
> Ah, you are too pessimistic. :-)
> 

Perhaps, although I think you're being overly optimistic if you think
rebase can do all of this intelligently while still retaining clear
semantics. I'd start with writing a separate tool for it, probably
based on git sequencer. When that works out ok, get it to do what
rebase does today and then incorporate the new tool as an option to
rebase and get ready to answer complex questions for the cases where
it doesn't do what the user wanted it to do.

Git is stupid very, very much by design. Linus constantly says that
he prefers tools that he can figure out why they did something stupid
over tools that try really hard to get it right, and I agree with him
100%, as do most of the core contributors (insofar as I've understood
it). What you're suggesting is that a git command should try hard to
dwim a lot of complexity about choosing tools away, and that goes
right against the KISS principle which serves git so well. I'm not
saying you shouldn't do it. Merely that you should think hard about
it and then make sure it doesn't break anything people are already
doing today with the current toolset.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
