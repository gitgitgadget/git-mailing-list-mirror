From: Andreas Ericsson <ae@op5.se>
Subject: Re: missing git features (was: Re: Errors GITtifying GCC and Binutils)
Date: Fri, 24 Mar 2006 13:59:02 +0100
Message-ID: <4423ED16.9080504@op5.se>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <44223B90.3040500@zytor.com> <1143128751.6850.35.camel@neko.keithp.com> <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org> <BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE> <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org> <20060324123238.GA3070@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Mar 24 13:59:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMlsm-0002sK-SM
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 13:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWCXM7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 07:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWCXM7F
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 07:59:05 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:44512 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751456AbWCXM7E
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 07:59:04 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id A50666BCFE
	for <git@vger.kernel.org>; Fri, 24 Mar 2006 13:59:02 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20060324123238.GA3070@linux-mips.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17917>

Ralf Baechle wrote:
> 
> For my various hacking projects and archiving needs git has done me alot
> of good and it's pretty close to the answer to the question for life,
> universe and everything.  But a few rough areas (I'm currently using git
> 1.2.4 btw.)  remain:
> 
>  o During the debugging phase before a new kernel release I put anything
>    that isn't appropriate for the master branch on a queue branch which
>    I am rebasing frequently to ensure things will work right in the
>    "patch bombing" phase before the next -rc1 when I'm sending everything
>    on the queue branch upstream.
>    The problem: users pull such a branch, create their own branch starting
>    somewhere on my queue branch.  So eventually when they pull again
>    after I rebased the branch things blow up spectactularly.  This needs a
>    simple solution.

See how Junio does with next and pu and recommend your users to do the 
same. There's no way of pulling a rebased branch, because the rebasing 
destroys ancestry information, meaning the original commits other people 
have cease to exist in your repository.

>  o git rebase had no reasonable handling of conflicts last I ran into a
>    rebase conflict.

"git rerere" might be of service here. Other than that, it's merging 
that goes, unless we come up with a way of patching the delta on the fly 
when such things are encountered. Unfortunately that is beyond me, but 
perhaps there are other takers on the list. It would indeed be very nice 
to have.

>  o If a file is modified in a user's tree and a non-conflicting patch is
>    being pull users seem to expect the old CVS behaviour which is trying
>    to merge into the checked out tree, worst case adding conflict markers.
>    Git just refuses the operation.

A pull (fetch + merge) requires a pristine index. If the user has done 
"git update-index" on the files, but not committed the merge *should* 
fail every time. If they have changes in the working tree but not in the 
index, the fetch should work, but the final phase (checking out the 
updated head) should fail, since the working tree has un-committed changes.


>  o I had people piling up over 2GB in their $GIT_DIR/objects/pack/
>    directory because they were using the rsync method for updating.

This most likely happens because you're doing too large packs. You can 
do incremental packing, or ask users to switch to using the git:// 
protocol, which is much faster for incremental updates.

>  o Git is a dramatically more powerful and for most operations better
>    performing SCM than CVS - but CVS is what people know, it's easy to
>    learn and handling special cases like conflicts is sort of obvious
>    because CVS expects the user to cleanup the mess and does not try to
>    compete with the users in that.


git doesn't compete with the user either, but it doesn't touch the 
working tree unless the merge succeeds, which is sane imo but surprising 
for CVS users where the action is done in the working tree and the 
result is put under rcs control.


>  o A Git for Dummies book would be helpful.

The tutorial is fairly complete.

http://www.kernel.org/pub/software/scm/git/docs/tutorial.html

>  o When users have problems with git I found it useful to explain them
>    how git internally works so they get a better understanding of what
>    actually is going on.  Dominic Sweetman which is an excellent
>    technical writer has made a similar experience and started writing
>    a bit about git in the wiki at http://www.linux-mips.org/wiki/WhatIsGit
>    May somebody wants to extend this?
>    (Dominic unfortunately is currently deeply burried in writing the
>    2nd issue of See MIPS Run, so can't really contribute ...)
> 

Good to know. Unfortunately I don't know git internals half as well as I 
would like. I can sometimes answer questions, but starting from scratch 
and explain it is beyond me.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
