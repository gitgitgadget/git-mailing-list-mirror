From: Junio C Hamano <gitster@pobox.com>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 15:28:17 -0700
Message-ID: <7vod9a1h8e.fsf@gitster.siamese.dyndns.org>
References: <20080318180118.GC17940@kernel.dk>
 <7vd4pq2ymo.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803191444490.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Axboe <jens.axboe@oracle.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:29:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6mk-0005RO-D6
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763421AbYCSW2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S941218AbYCSW2f
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:28:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S941214AbYCSW2b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:28:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DDC771EFF;
	Wed, 19 Mar 2008 18:28:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 16AF01EDC; Wed, 19 Mar 2008 18:28:24 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803191444490.3020@woody.linux-foundation.org>
 (Linus Torvalds's message of "Wed, 19 Mar 2008 14:52:14 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77573>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 19 Mar 2008, Junio C Hamano wrote:
>> 
>> Having said that, I am not sure how the auto gc is triggering for your
>> (presumably reasonably well maintained) repository that has only small
>> number of loose objects.  I haven't seen auto-gc annoyance myself (and
>> git.git is not the only project I have my git experience with), and Linus
>> also said he hasn't seen breakages.
>
> I think it was 'autopacklimit'.
>
> I think the correct solution is along the following lines:
>
>  - disable "git gc --auto" entirely when "gc.auto <= 0" (ie we don't even 
>    care about 'autopacklimit' unless automatic packing is on at all)
>
>    Rationale: I do think that if you set gc.auto to zero, you should 
>    expect git gc --auto to be disabled.

Sensible, I would say.

>  - make the default for autopacklimit rather higher (pick number at 
>    random: 50 instead of 20).
>
>    Rationale: the reason for "git gc --auto" wasn't to keep things 
>    perfectly packed, but to avoid the _really_ bad cases. The old default 
>    of 20 may be fine if you want to always keep the repo very tight, but 
>    that wasn't why "git gc --auto" was done, was it?

I do not think "very tight" was the reason, but on the other hand, my
personal feeling is that 20 was already 10 too many pack idx files we have
to walk linearly while looking for objects at runtime.

Each auto gc that sees too many loose objects will add a new packfile (we
do not do "repack -a" for obvious reasons) that would hopefully contain
6-7k objects, so you would need to generate 120-140k objects before
hitting the existing 20 limit.

And then auto gc will notice you have too many packs, and "repack -A" to
pack them down in a single new pack, and you are back to "single pack with
less than 6-7k loose objects" situation for the cycle to continue.

At least, that is the theory.

The kernel history with 87k commits have 720k objects, which roughly
translates to 8 objects per commit on average.  You would need to perform
13k commits to generate 100k new loose objects.  I am sensing that Jens is
mightily annoyed, rightfully so, by observing much shorter cycle than that
for "gc --auto" to kick in ("rev-list --author=Jens --since=8.month master"
tells me there are 145 commits in the last 8 months, far smaller than
13k).  So there is something else going on.

Perhaps fetching with dumb transports should run "gc --auto" (or even an
unconditional "repack -a -d") at the end?
