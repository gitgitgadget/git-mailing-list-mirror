From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-revert is a memory hog
Date: Tue, 29 Jan 2008 14:15:49 -0800
Message-ID: <7vk5lsmg6i.fsf@gitster.siamese.dyndns.org>
References: <20080127172748.GD2558@does.not.exist>
	<20080128055933.GA13521@coredump.intra.peff.net>
	<alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Adrian Bunk <bunk@kernel.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:17:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJylF-0000Rk-RO
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 23:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbYA2WQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbYA2WQA
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 17:16:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbYA2WP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 17:15:59 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 954B23662;
	Tue, 29 Jan 2008 17:15:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9226535F4;
	Tue, 29 Jan 2008 17:15:51 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801300844170.28476@www.l.google.com> (Linus
	Torvalds's message of "Wed, 30 Jan 2008 08:51:09 +1100 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72003>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 28 Jan 2008, Jeff King wrote:
>> 
>> I tried to reproduce this, but my peak heap allocation was only around
>> 20MB. Is your repository fully packed? Not packed at all? Can you use
>> valgrind/massif to figure out where the memory is going?
>
> I definitely can reproduce it, it's horrid.
>
> This is from "top" fairly late in the game, but with the thing not even 
> done yet. Current git, pretty much fully (and fairly aggressively) packed 
> current kernel repo, and using "diff.renamelmit=0".
>
> 	4751 torvalds  20   0  852m 446m  47m R   72 22.4   2:46.58 git-merge-recur
>
> It finally finished with time reporting:
>
> 	208.15user 3.50system 4:01.50elapsed 87%CPU (0avgtext+0avgdata 0maxresident)k
> 	238736inputs+4544outputs (8261major+280971minor)pagefaults 0swaps
>
> where those 280971 minor page faults are what largely indicates how much 
> memory it used (the technical term for that number is "metric buttload of 
> memory").
>
> But I'm in Melbourne right now on my laptop,and probably won't be able to 
> debug this much. 
>
>> In your case, the patch doesn't apply cleanly, so we end up doing a
>> 3-way merge (in my tests, it is git-merge-recursive which ends up taking
>> up the memory).
>
> It is indeed git-merge-recursive. It just shouldn't take that much memory.

Hmmmmm.  Obviously this depends on where you start your revert
from, but that is not what I am getting.

: gitster linux-2.6/test; git reset --hard
HEAD is now at 0ba6c33... Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.25
: gitster linux-2.6/test; /usr/bin/time git-revert d19fbe8a7
Auto-merged drivers/input/input.c
CONFLICT (content): Merge conflict in drivers/input/input.c
Auto-merged include/linux/input.h
CONFLICT (content): Merge conflict in include/linux/input.h
Automatic revert failed.  After resolving the conflicts,
mark the corrected paths with 'git add <paths>' or 'git rm <paths>' and commit the result.
Command exited with non-zero status 1
1.08user 0.06system 0:01.14elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+19867minor)pagefaults 0swaps

Now, a possible alternative (that produces an identical result)
is not much better, because it ends up using merge-recursive as
its core.

: gitster linux-2.6/test; git reset --hard                                      HEAD is now at 0ba6c33... Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.25
: gitster linux-2.6/test; rm -fr .dotest
: gitster linux-2.6/test; /usr/bin/time sh -c 'git format-patch -R --binary --stdout -1 d19fbe8a7 | git am -3'
Applying Input: prepare to sysfs integration
error: patch failed: drivers/input/input.c:27
error: drivers/input/input.c: patch does not apply
error: patch failed: include/linux/input.h:12
error: include/linux/input.h: patch does not apply
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merged drivers/input/input.c
CONFLICT (content): Merge conflict in drivers/input/input.c
Auto-merged include/linux/input.h
CONFLICT (content): Merge conflict in include/linux/input.h
Failed to merge in the changes.
Patch failed at 0001.
When you have resolved this problem run "git-am -3 --resolved".
If you would prefer to skip this patch, instead run "git-am -3 --skip".
Command exited with non-zero status 1
0.52user 0.25system 0:00.75elapsed 103%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+41208minor)pagefaults 0swaps
