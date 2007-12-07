From: Andreas Ericsson <ae@op5.se>
Subject: Re: git guidance
Date: Fri, 07 Dec 2007 13:30:56 +0100
Message-ID: <47593D00.9030003@op5.se>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <200712070737.18519.a1426z@gawab.com> <475906F7.5010309@op5.se> <200712071353.11654.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Susi <psusi@cfl.rr.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 13:31:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0cMa-0008DZ-T0
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 13:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbXLGMbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 07:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXLGMbE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 07:31:04 -0500
Received: from mail.op5.se ([193.201.96.20]:44721 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbXLGMbD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 07:31:03 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2315D1F08098;
	Fri,  7 Dec 2007 13:31:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eHnjnE6diSmP; Fri,  7 Dec 2007 13:31:00 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id A1AE91F0802A;
	Fri,  7 Dec 2007 13:30:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <200712071353.11654.a1426z@gawab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67416>

Al Boldi wrote:
> Andreas Ericsson wrote:
>> So, to get to the bottom of this, which of the following workflows is it
>> you want git to support?
>>
>> ### WORKFLOW A ###
>> edit, edit, edit
>> edit, edit, edit
>> edit, edit, edit
>> Oops I made a mistake and need to hop back to "current - 12".
>> edit, edit, edit
>> edit, edit, edit
>> publish everything, similar to just tarring up your workdir and sending
>> out ### END WORKFLOW A ###
>>
>> ### WORKFLOW B ###
>> edit, edit, edit
>> ok this looks good, I want to save a checkpoint here
>> edit, edit, edit
>> looks good again. next checkpoint
>> edit, edit, edit
>> oh crap, back to checkpoint 2
>> edit, edit, edit
>> ooh, that's better. save a checkpoint and publish those checkpoints
>> ### END WORKFLOW B ###
> 
> ### WORKFLOW C ###
> for every save on a gitfs mounted dir, do an implied checkpoint, commit, or 
> publish (should be adjustable), on its privately created on-the-fly 
> repository.
> ### END WORKFLOW C ###
> 

So you *do* want an editor's undo function, but for an entire filesystem.
That's a handy thing to have every now and then, but it's not what git
(or any other scm) does.

> For example:
> 
>   echo "// last comment on this file" >> /gitfs.mounted/file
> 
> should do an implied checkpoint, and make these checkpoints immediately 
> visible under some checkpoint branch of the gitfs mounted dir.
> 
> Note, this way the developer gets version control without even noticing, and 
> works completely transparent to any kind of application.
> 

One other thing that's fairly important to note is that this can never
ever handle changesets, since each write() of each file will be a commit
on its own. It's so far from what git does that I think you'd be better
off just implementing it from scratch, or looking at a versioned fs, like
Jakub suggested in his reply.

You're also neglecting one very important aspect of what an SCM provides
if you go down this road, namely project history. You basically have two
choices with this "implicit save on each edit":
* force the user to supply a commit message for each and every edit
* ignore commit messages altogether

Obviously, forcing a commit message each time is the only way to get some
sort of proper history to look at after it's done, but it's also such an
appalling nuisance that I doubt *anyone* will actually like that, and since
changesets aren't supported, you'll have "implement xniz api, commit 1 of X"
messages. Cumbersome, stupid, and not very useful.

Ignoring commit messages altogether means you ignore the entire history,
and the SCM then becomes a filesystem-wide "undo" cache. This could
ofcourse work, but it's something akin to building a nuclear powerplant
to power a single lightbulb.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
