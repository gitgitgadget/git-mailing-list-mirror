From: Andreas Ericsson <ae@op5.se>
Subject: Re: I want "fast forward my workdir to upstream if it's safe"
Date: Fri, 08 May 2009 08:53:22 +0200
Message-ID: <4A03D6E2.2050708@op5.se>
References: <86prekfv7z.fsf@blue.stonehenge.com> <20090508023028.GA1218@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 08 08:53:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Jxf-0001d9-7b
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 08:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbZEHGx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 02:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbZEHGx0
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 02:53:26 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:58953 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbZEHGxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 02:53:25 -0400
Received: by fxm2 with SMTP id 2so1204153fxm.37
        for <git@vger.kernel.org>; Thu, 07 May 2009 23:53:25 -0700 (PDT)
Received: by 10.86.96.12 with SMTP id t12mr3288870fgb.77.1241765605094;
        Thu, 07 May 2009 23:53:25 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id 12sm895402fgg.25.2009.05.07.23.53.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 23:53:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090508023028.GA1218@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118569>

Jeff King wrote:
> On Thu, May 07, 2009 at 02:40:00PM -0700, Randal L. Schwartz wrote:
> 
>> So, what I need is a command, likely an option to "git merge" that says "do
>> everything that a git merge would do except abort if it would have been a
>> merge commit".  In other words, abort if the workdir is dirty or is not a
>> fast-forward update to the upstream.  Bonus if it exits non-zero if
>> something went wrong.
> 
> Can you define more clearly what you want, because you are asking for
> conflicting things. "abort if it would have been a merge commit" is
> purely about fast forward. But it sounds like you also care about "would
> merge have succeeded". So I think you are asking for:
> 
>   1. There are no local commits on the branch.
> 
> and one of:
> 
>   2a. There are no local edits.
> 
>   2b. There are no local edits in the same files as those that are
>       affected by any new commits from upstream.
> 
>   2c. Any local edits you have done would not cause a conflict if merged
>       with what's in upstream.
> 
> And before I discuss those further, let me address:
> 
>> Please don't tell me "use these three commands in this script".
>> I want a *command* I can tell people in #git.
> 
> by saying that I don't think there is currently a single command to
> cover both (1) and (2) (any of the (2) options). So we need to talk
> about "use these three commands in a script" for a moment to figure out
> what such a command _should_ do, and then we can talk about putting it
> into a single command (and presumably making that command part of the
> git distribution) that you can tell people about in #git.
> 
> Both (1) and (2) involve finding out who your upstream is. As of 1.6.3,
> this is easy to do as:
> 
>   upstream=`git for-each-ref --format='%(upstream)' `git symbolic-ref HEAD`
> 
> One you have that, (1) is easy:
> 
>   test -z "`git rev-list -1 $upstream..HEAD`"
> 
> (2a) is also pretty easy:
> 
>   git diff-files --quiet && git diff-index --quiet
> 
> (2b) is a bit harder, but do-able:
> 
>   git diff-tree --name-only HEAD $upstream | sort >them
>   (git diff-files --name-only; git diff-index --name-only) | sort >us
>   test -z "`comm -12 us them`"
> 
> (2c) is the trickiest (and of course, therefore probably the one you
> want ;) ).  I'm not sure there is a simple way to do it short of hacking
> git-merge to actually try the merge and roll it back. Because you really
> have to deal not just with merging actual text file content but with
> custom merge drivers.
> 

The "rolling back" part is about as simple as
* never touch the worktree (only use in-index merge)
* preserve the last HEAD commit object name
* preserve the index

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
