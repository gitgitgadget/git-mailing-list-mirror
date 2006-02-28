From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-delta: bound hash list length to avoid O(m*n) behavior
Date: Mon, 27 Feb 2006 22:51:43 -0800
Message-ID: <7vhd6kq8lc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602272110320.25336@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 07:52:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDyiE-0005qP-TU
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 07:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWB1Gvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 01:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWB1Gvv
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 01:51:51 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:56807 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932111AbWB1Gvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 01:51:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228064830.ZZVY17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Feb 2006 01:48:30 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602272110320.25336@localhost.localdomain>
	(Nicolas Pitre's message of "Mon, 27 Feb 2006 23:09:55 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16920>

Nicolas Pitre <nico@cam.org> writes:

> The diff-delta code can exhibit O(m*n) behavior with some patological 
> data set where most hash entries end up in the same hash bucket.

> Other data points from the Linux kernel repository:
>
> blob 9af06ba723df75fed49f7ccae5b6c9c34bc5115f ->
> blob dfc9cd58dc065d17030d875d3fea6e7862ede143
> size (491102 -> 496045)
> delta size (16 byte blocks): 248899 in less than 0.1 sec
> delta size (3 byte blocks): 136000 in 11.8 secs
> delta size (3 byte blocks + this patch): 171688 in 0.79 sec

These numbers are misleading.

The 36K objects pack I used in my previous tests gives 9971223
(from "next" branch) vs 9664546 (this patch) final pack size.
The wallclock time on my machine is 1m35 vs 3m30.  I doubt many
people are willing to pay 100% more waiting time for 3% tighter
pack.

Although I do not mean to rain on your effort and substantial
improvement you made with this patch, we need to admit that
improving pathological corner case has quite a diminishing
effect in the overall picture.

But this definitely is an improvement nevertheless.  I should
try this on my wife's AMD64 (Cygwin).  The same datasets I used
in my previous complaint still seem to take a couple of seconds
(or more) each on my Duron 750 X-<.

A handful additional ideas.

 * Lower the hash limit a bit more (obvious).  That might have
   detrimental effect in the general case.

 * Study the hash bucket distribution for the pathological case
   and see if we can cheaply detect a pattern.  I suspect these
   cases have relatively few but heavily collided buckets with
   mostly sparse other entries.  If there is such an easily
   detectable pattern, maybe we can look for such a pattern at
   runtime, and cull hash entries more aggressively in such a
   case?

 * Try checking the target buffer to see if it would have many
   hits on the heavily collided hash entries from the source
   (maybe hash_count the target buffer as well).

 * Have pack-object detect a pathological blob (the test patch I
   sent you previously uses the eye-candy timer for this
   purpose, but we could getrusage() if we want to be more
   precise) by observing how much time is spent for a single
   round, and mark the blob as such, so we do not delta against
   it with other blobs in find_deltas, when we are packing many
   objects.  It does not really matter in the big picture if we
   choose not to delta the pathological ones tightly, as long as
   they are relatively few.

 * Also in pack-object, have an optional backing-store to write
   out deltified representations for results that took more than
   certain amount of time to produce in find_deltas(), and reuse
   them in write_object().

If anybody is interested, here are some other interesting pairs
from the Linux 2.6 repositories.

        2645d6239b74 cb968e7a0fcd
        357980942d73 5bb837052ef1
        5412dcb4b6d0 ac07e18abb1d
        5bb837052ef1 1f8744ad9cde
        63d827d7da07 5bb837052ef1
        9af06ba723df 1896a0eea7e5
        cb968e7a0fcd 97b5578ae9b1
        d8c5a8dbd086 97b5578ae9b1
        d8c5a8dbd086 cb968e7a0fcd
        dfc9cd58dc06 1896a0eea7e5
        fa0f82ec9fa0 b611e27470e1
