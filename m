From: Ingo Molnar <mingo@elte.hu>
Subject: [irq/urgent]: created 3786fc7: "irq: make variable static"
Date: Wed, 22 Oct 2008 08:17:30 +0200
Message-ID: <20081022061730.GA5749@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 08:19:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsX3n-0005Po-IN
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 08:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbYJVGRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 02:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbYJVGRg
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 02:17:36 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:58586 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbYJVGRf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 02:17:35 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KsX2C-00072Z-6Z
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Wed, 22 Oct 2008 08:17:32 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 2B9473E21A3; Wed, 22 Oct 2008 08:17:28 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00,DNS_FROM_SECURITYSAGE autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 DNS_FROM_SECURITYSAGE  RBL: Envelope sender in
	blackholes.securitysage.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98832>


Git recently started printing the branch name when creating commits:

  [irq/urgent]: created 3786fc7: "irq: make variable static"

very nice idea IMO! Having it all on one line allows me to double-check 
that i indeed queued up a patch in the intended topic branch. Had it 
read:

  [irq/urgent]: created 3786fc7: "printk: make variable static"

i'd have noticed the mistake immediately.

this welcome enhancement made me remember of three usage problems i had 
with Git recently:

1)

Btw., it would be nice if there was an easier way to get a similar git 
log display in the ASCII space. For example i frequently ask the 
question "which topic branch did commit XYZ originate from?". All i have 
now is a pretty crude script that displays this for a given file:

earth4:~/tip> tip-log --no-merges linus.. kernel/sched.c | grep ^#
# core/kill-the-BKL: ffda12a: sched: optimize group load balancer
# core/locking: ffda12a: sched: optimize group load balancer
...

(see the script attached below)

but it's very slow with 233 branches, obviously, so i only use it as a 
last resort mechanism.

What i'd _love_ to see is just an ASCII representation of where a commit 
"came from" into the current branch. The first-hop branch it was 
committed to.

it doesnt even have to be correct in the sha1 sense - i.e. it's enough 
for me if the merge commit log is parsed. (and hence it wont be correct 
if a branch ceases to exist or is renamed - but that is OK, i keep the 
branch space static)

any ideas how to achieve that? I'd love to have output like this, if i 
do this from tip/master (the master integration branch):

 # mockup

 earth4:~/tip> gll --no-merges kernel/sched.c
 ffda12a: [sched/core]      sched: optimize group load balancer
 8cd162c: [sched/clock]     sched: only update rq->clock while holding
 0a16b60: [tracing/sched]   tracing, sched: LTTng instrumentation
 a5d8c34: [sched/debug]     sched debug: add name to sched_domain sysctl entries
 34b3ede: [sched/core]      sched: remove redundant code in cpu_cgroup_create()

... and i dont want to embedd the branch name in every single commit.

The semantics seem well-specified to me: walk down the merge tree a 
particular commit came from, and use the branch name that is mentioned 
in a merge commit's comment section 'closest' to this commit.

That information is not 'trustable' in the sha1 sense because merge 
commits can be modified manually and because the momentary name of a 
branch might not be correct anymore - but with a sane topical setup this 
would be a very powerful visualization tool.

It would be a nice tool that makes it easy to check the proper structure 
of topical branches, after the fact. Weird, incorrectly queued up 
commits would stick out _immediately_:

 34b3ede: [x86/xen]      sched: remove redundant code in cpu_cgroup_create()

2)

and while at ASCII representation - this made me remember a problem i 
frequently have with octopus merges: it's _very_ difficult currently to 
'backtrack' along a higher-order octopus in the git log ASCII space.

I dont use the newfangled flashy GUIs all that frequently and i recently 
tried to go back to double-check the history of this order-21 octopus 
merge in the upstream Linux kernel:

 commit e496e3d645c93206faf61ff6005995ebd08cc39c
 Merge: b159d7a... 5bbd4c3... 175e438... 516cbf3... af2d237... 9b15684... 5b7e41f... 1befdef... a03352d... 7b22ff5... 2c7e9fd...  91030ca... dd55235... b3e15bd... 20211e4... efd327a... c7ffa6c...  e51a1ac... 5df4551... d99e901... e621bd1...
 Author: Ingo Molnar <mingo@elte.hu>
 Date:   Mon Oct 6 18:17:07 2008 +0200

     Merge branches 'x86/alternatives', 'x86/cleanups', 'x86/commandline', 'x86/crashdump', 'x86/debug', 'x86/defconfig', 'x86/doc', 'x86/exports', 'x86/fpu', 'x86/gart', 'x86/idle', 'x86/mm', 'x86/mtrr', 'x86/nmi-watchdog', 'x86/oprofile', 'x86/paravirt', 'x86/reboot', 'x86/sparse-fixes', 'x86/tsc', 'x86/urgent' and 'x86/vmalloc' into x86-v28-for-linus-phase1

i wanted to know the history of the 'x86/idle' topical commits. But it 
was not easy to line up the sha1's to the branch names. So i had to 
manually edit the commit log, i manually lined up all 21 sha1's to each 
other, just to be able to figure out branch #11 in that lineup.

Is there some more efficient way to do that? Perhaps some git log output 
that matches up the topic names with the sha1's? [for the cases where 
the octopus merge commit log message still has a reasonable format]

3)

Similarly, when doing Octopus merges, and if the merge _fails_, it's 
hard to see exactly which branch failed. For example, when preparing for 
the v2.6.28 merge window i did something like this at a certain stage:

    git merge x86/alternatives x86/cleanups x86/commandline \
              x86/crashdump x86/debug x86/defconfig x86/doc \
              x86/exports x86/fpu x86/gart x86/xen x86/idle x86/mm  \
              x86/mtrr x86/nmi-watchdog x86/oprofile x86/paravirt \
              x86/reboot x86/sparse-fixes x86/tsc x86/urgent \
              x86/vmalloc

I got a conflicted octopus merge somewhere in the middle of it. But it 
only displayed sha1's when doing the merge. When i did a git log of that 
sha1 it was not obvious at first sight which current branch maps to that 
sha1. So i had to binary-search for the branch that caused the conflict 
(!), to figure out that in the above sequence the 'x86/xen' bit is what 
was causing trouble.

It would be very nice if the Octopus merge tool displayed not only the 
sha1's that it is merging, but also the refspec that it is processing. 
And when it fails it would be nice if it displayed a for-dummies 
"Octopus merge failed when trying to merge x86/xen" kind of thing.

So mapping back sha1's to topic branch names does not seem to be very 
easy at the moment. I realize that it is a fundamentally hard thing to 
do, and the information is not reliable because branch names are 
temporary - but in a sane branch setup it would be very nice to have 
tools for that, to keep topics nice and tidy, and to annotate git logs 
with the topical information.

Maybe there are already tools for that, it's just that i'm ignorant 
about them?

	Ingo

--------------->
for N in $(git branch | grep -vE ' master$| base$|for-linus|auto|linux-next|tmp' | cut -c3-); do

  ITEMS=$(git rev-list --reverse linus..$N -- $@)

  for M in $ITEMS; do
    echo
    echo "# $N: $(git log -1 --pretty=format:"%h: %s" $M $@)"
    echo
    git log -1 --pretty=email --no-merges $M $@ | cat
  done

done | grep ^#
