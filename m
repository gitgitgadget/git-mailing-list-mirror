From: Andreas Ericsson <ae@op5.se>
Subject: Re: [irq/urgent]: created 3786fc7: "irq: make variable static"
Date: Wed, 22 Oct 2008 10:34:59 +0200
Message-ID: <48FEE5B3.9060202@op5.se>
References: <20081022061730.GA5749@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Oct 22 10:37:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsZDD-0006gJ-14
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 10:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbYJVIfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 04:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbYJVIfP
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 04:35:15 -0400
Received: from mail.op5.se ([193.201.96.20]:51514 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbYJVIfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 04:35:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2D56D1B8006F;
	Wed, 22 Oct 2008 10:28:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.91
X-Spam-Level: 
X-Spam-Status: No, score=-3.91 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.489, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxb4AqXwjjU2; Wed, 22 Oct 2008 10:28:42 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 653111B8005F;
	Wed, 22 Oct 2008 10:28:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081022061730.GA5749@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98848>

Ingo Molnar wrote:
> Git recently started printing the branch name when creating commits:
> 
>   [irq/urgent]: created 3786fc7: "irq: make variable static"
> 
> very nice idea IMO!

Thanks! Be sure to read the paintshop discussion that lead to the
change ;-)

> Having it all on one line allows me to double-check 
> that i indeed queued up a patch in the intended topic branch. Had it 
> read:
> 
>   [irq/urgent]: created 3786fc7: "printk: make variable static"
> 
> i'd have noticed the mistake immediately.
> 
> this welcome enhancement made me remember of three usage problems i had 
> with Git recently:
> 
> 1)
> 
> Btw., it would be nice if there was an easier way to get a similar git 
> log display in the ASCII space. For example i frequently ask the 
> question "which topic branch did commit XYZ originate from?". All i have 
> now is a pretty crude script that displays this for a given file:
> 
> earth4:~/tip> tip-log --no-merges linus.. kernel/sched.c | grep ^#
> # core/kill-the-BKL: ffda12a: sched: optimize group load balancer
> # core/locking: ffda12a: sched: optimize group load balancer
> ...
> 
> (see the script attached below)
> 
> but it's very slow with 233 branches, obviously, so i only use it as a 
> last resort mechanism.
> 
> What i'd _love_ to see is just an ASCII representation of where a commit 
> "came from" into the current branch. The first-hop branch it was 
> committed to.
> 
> it doesnt even have to be correct in the sha1 sense - i.e. it's enough 
> for me if the merge commit log is parsed. (and hence it wont be correct 
> if a branch ceases to exist or is renamed - but that is OK, i keep the 
> branch space static)
> 
> any ideas how to achieve that? I'd love to have output like this, if i 
> do this from tip/master (the master integration branch):
> 

If you have the branch-heads around, do "git branch --contains <sha1>".
If I understand the i386 tree correctly (integration branches are named
without slashes), you could pipe it to "grep /" to see only the
topic-branches that has it.

I imagine you'd want to use it to find out which branches you can (or
can't) merge, and in that case you need to know about all the topics
which have the commit. Assuming you don't go crazy cherry-picking and
criss-cross merging, it should only list a few. The output is not as
fancy as below, but it should be faster than the appended script (by
several orders of magnitude).

>  # mockup
> 
>  earth4:~/tip> gll --no-merges kernel/sched.c
>  ffda12a: [sched/core]      sched: optimize group load balancer
>  8cd162c: [sched/clock]     sched: only update rq->clock while holding
>  0a16b60: [tracing/sched]   tracing, sched: LTTng instrumentation
>  a5d8c34: [sched/debug]     sched debug: add name to sched_domain sysctl entries
>  34b3ede: [sched/core]      sched: remove redundant code in cpu_cgroup_create()
> 
> ... and i dont want to embedd the branch name in every single commit.
> 
> The semantics seem well-specified to me: walk down the merge tree a 
> particular commit came from, and use the branch name that is mentioned 
> in a merge commit's comment section 'closest' to this commit.
> 
> That information is not 'trustable' in the sha1 sense because merge 
> commits can be modified manually and because the momentary name of a 
> branch might not be correct anymore - but with a sane topical setup this 
> would be a very powerful visualization tool.
> 
> It would be a nice tool that makes it easy to check the proper structure 
> of topical branches, after the fact. Weird, incorrectly queued up 
> commits would stick out _immediately_:
> 
>  34b3ede: [x86/xen]      sched: remove redundant code in cpu_cgroup_create()
> 
> 2)
> 
> and while at ASCII representation - this made me remember a problem i 
> frequently have with octopus merges: it's _very_ difficult currently to 
> 'backtrack' along a higher-order octopus in the git log ASCII space.
> 
> I dont use the newfangled flashy GUIs all that frequently and i recently 
> tried to go back to double-check the history of this order-21 octopus 
> merge in the upstream Linux kernel:
> 
>  commit e496e3d645c93206faf61ff6005995ebd08cc39c
>  Merge: b159d7a... 5bbd4c3... 175e438... 516cbf3... af2d237... 9b15684... 5b7e41f... 1befdef... a03352d... 7b22ff5... 2c7e9fd...  91030ca... dd55235... b3e15bd... 20211e4... efd327a... c7ffa6c...  e51a1ac... 5df4551... d99e901... e621bd1...
>  Author: Ingo Molnar <mingo@elte.hu>
>  Date:   Mon Oct 6 18:17:07 2008 +0200
> 
>      Merge branches 'x86/alternatives', 'x86/cleanups', 'x86/commandline', 'x86/crashdump', 'x86/debug', 'x86/defconfig', 'x86/doc', 'x86/exports', 'x86/fpu', 'x86/gart', 'x86/idle', 'x86/mm', 'x86/mtrr', 'x86/nmi-watchdog', 'x86/oprofile', 'x86/paravirt', 'x86/reboot', 'x86/sparse-fixes', 'x86/tsc', 'x86/urgent' and 'x86/vmalloc' into x86-v28-for-linus-phase1
> 
> i wanted to know the history of the 'x86/idle' topical commits. But it 
> was not easy to line up the sha1's to the branch names. So i had to 
> manually edit the commit log, i manually lined up all 21 sha1's to each 
> other, just to be able to figure out branch #11 in that lineup.
> 
> Is there some more efficient way to do that? Perhaps some git log output 
> that matches up the topic names with the sha1's? [for the cases where 
> the octopus merge commit log message still has a reasonable format]
> 

A mock-up of desired output would be good here. Perhaps something like this?

--%<--%<--
<X>-way octopus merge

 x86/alternatives <abbrev sha1>: "<abbreviated x86/alternatives subject>"
 x86/cleanups <abbrev sha1>: "<abbreviated x86/cleanups subject>"

Signed-off-by: ...
--%<--%<--

The subject for this says absolutely nothing, but it's not so long that it
can't be viewed comfortably either, and hopefully the author will amend
the subject with something suitable.

> 3)
> 
> Similarly, when doing Octopus merges, and if the merge _fails_, it's 
> hard to see exactly which branch failed. For example, when preparing for 
> the v2.6.28 merge window i did something like this at a certain stage:
> 
>     git merge x86/alternatives x86/cleanups x86/commandline \
>               x86/crashdump x86/debug x86/defconfig x86/doc \
>               x86/exports x86/fpu x86/gart x86/xen x86/idle x86/mm  \
>               x86/mtrr x86/nmi-watchdog x86/oprofile x86/paravirt \
>               x86/reboot x86/sparse-fixes x86/tsc x86/urgent \
>               x86/vmalloc
> 
> I got a conflicted octopus merge somewhere in the middle of it. But it 
> only displayed sha1's when doing the merge. When i did a git log of that 
> sha1 it was not obvious at first sight which current branch maps to that 
> sha1. So i had to binary-search for the branch that caused the conflict 
> (!), to figure out that in the above sequence the 'x86/xen' bit is what 
> was causing trouble.
> 
> It would be very nice if the Octopus merge tool displayed not only the 
> sha1's that it is merging, but also the refspec that it is processing. 
> And when it fails it would be nice if it displayed a for-dummies 
> "Octopus merge failed when trying to merge x86/xen" kind of thing.
> 
> So mapping back sha1's to topic branch names does not seem to be very 
> easy at the moment. I realize that it is a fundamentally hard thing to 
> do, and the information is not reliable because branch names are 
> temporary - but in a sane branch setup it would be very nice to have 
> tools for that, to keep topics nice and tidy, and to annotate git logs 
> with the topical information.
> 

Branch-names may be temporary, but we already record them for merge
messages so I don't see why we couldn't also use them when reporting
error messages but in a different format. I had a quick look at the
git-merge-octopus.sh but didn't find the obvious place to hack this
thing in, so I'll have to defer that to someone for whom this is a
more pressing need (hint ;-)), or who knows their way around gits
plumbing better than I do.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
