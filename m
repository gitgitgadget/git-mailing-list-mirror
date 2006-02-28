From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: bound hash list length to avoid O(m*n) behavior
Date: Tue, 28 Feb 2006 12:05:59 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602281017241.25336@localhost.localdomain>
References: <Pine.LNX.4.64.0602272110320.25336@localhost.localdomain>
 <7vhd6kq8lc.fsf@assigned-by-dhcp.cox.net>
 <7vbqwrq4yi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 18:06:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE8IX-000867-Uu
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 18:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWB1RGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 12:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWB1RGB
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 12:06:01 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38534 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751880AbWB1RGA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 12:06:00 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IVE0008EQ5ZY3F0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 28 Feb 2006 12:05:59 -0500 (EST)
In-reply-to: <7vbqwrq4yi.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16943>

On Mon, 27 Feb 2006, Junio C Hamano wrote:

> Although I do not mean to rain on your effort and substantial
> improvement you made with this patch, we need to admit that
> improving pathological corner case has quite a diminishing
> effect in the overall picture.

It does, unfortunately.

The problem is that the code in diff_delta() is highly solicited during 
a pack generation.  Just the simple hashing change from this patch that 
involves two shifts instead of only one increased the CPU time to 
generate a pack quite appreciably.  This is just to say that this code 
is pretty sensitive to even small details.

> But this definitely is an improvement nevertheless.  I should
> try this on my wife's AMD64 (Cygwin).  The same datasets I used
> in my previous complaint still seem to take a couple of seconds
> (or more) each on my Duron 750 X-<.

There is no miracle.  To prevent the extreme cases additional tests have 
to be performed in all cases, and therefore performance for all cases is 
affected.

> A handful additional ideas.
> 
>  * Lower the hash limit a bit more (obvious).  That might have
>    detrimental effect in the general case.

It does.  The current parameters are what I think is the best compromize 
between cost and compression.  And still 99% of the cases don't need 
a lower hash limit since their hash lists are already way below the 
limit.  For the  cases where it makes a difference, well lowering the 
hash limit also increase the cost associated with the reworking of the 
hash list so there comes a point where you actually increase the 
resulting delta size while the CPU time stays constant.

>  * Study the hash bucket distribution for the pathological case
>    and see if we can cheaply detect a pattern.  I suspect these
>    cases have relatively few but heavily collided buckets with
>    mostly sparse other entries.  If there is such an easily
>    detectable pattern, maybe we can look for such a pattern at
>    runtime, and cull hash entries more aggressively in such a
>    case?

Same issue as above.  And "looking for such a pattern" really does 
increase the CPU time in _all_ cases.  So that looking for patological 
cases has to be as cheap as possible which I think is the case right 
now (and it is still too costly for my taste already).  And yet I don't 
think there is really a need for further reduction of the hash list at 
this point since the patological cases are really handled gracefully 
with this patch even with a nice and pretty packed delta.

>  * Try checking the target buffer to see if it would have many
>    hits on the heavily collided hash entries from the source
>    (maybe hash_count the target buffer as well).

Again that'd add another significant CPU cost to all cases, even those 
that don't need it at all.  The problem is not about those patological 
cases anymore since I think they are well under control now.  It is the 
overhead those few patological cases impose on the other 180000 good 
behaving objects that is a problem.

>  * Have pack-object detect a pathological blob (the test patch I
>    sent you previously uses the eye-candy timer for this
>    purpose, but we could getrusage() if we want to be more
>    precise) by observing how much time is spent for a single
>    round, and mark the blob as such, so we do not delta against
>    it with other blobs in find_deltas, when we are packing many
>    objects.  It does not really matter in the big picture if we
>    choose not to delta the pathological ones tightly, as long as
>    they are relatively few.

That is one solution, but that doesn't handle the root of the problem 
which is the cost of detecting those cases in the first place.

>  * Also in pack-object, have an optional backing-store to write
>    out deltified representations for results that took more than
>    certain amount of time to produce in find_deltas(), and reuse
>    them in write_object().

The pack reusing code is pretty effective in doing so already, isn't it?  
Since using git-repack -f should not be the common case then those 
patological cases (now taking one second instead of 60 or more) should 
be reused most of the time.

> I tried an experimental patch to cull collided hash buckets
> very aggressively.  I haven't applied your last "reuse index"
> patch, though -- I think that is orthogonal and I'd like to
> leave that to the next round.

It is indeed orthogonal and I think you could apply it to the next 
branch without the other patches (it should apply with little problems).  
This is an obvious and undisputable gain, even more if pack-objects is 
reworked to reduce memory usage by keeping only one live index for 
multiple consecutive deltaattempts.

> With the same dataset: resulting pack is 9651096 vs 9664546
> (your patch) final pack size, with wallclock 2m45s (user 2m31).
> Still not good enough, and at the same time I wonder why it gets
> _smaller_ results than yours.

It really becomes hard to find the best balance especially when the 
resulting delta is then fed through zlib.  Sometimes a larger delta will 
compress better, sometimes not.  My test bench was the whole git 
repository and the kernel repository, and with such large number of 
objects it seems that smaller deltas always translate into smaller 
packs.  But it might not necessarily always be the case.

> I'd appreciate it if you can test it on the 20MB blobs and see
> what happens if you have time.

Before your patch:
user 0m9.713s, delta size = 4910988 bytes, or 1744110 compressed.

With your patch:
user 0m3.948s, delta size = 6753517 bytes, or 1978803 once compressed.

BTW there is another potential for improvement in the delta code (but I 
have real work to do now so)...

Let's suppose the reference buffer has:

 
***********************************************************************/

This is common with some comment block styles.  Now that line will end 
up with multiple blocks that will hash to the same thing and linked 
successively in the same hash bucket except for the last ones where the 
'/' is involved in the hashing.

Now if the target buffer also contains a line similar to the above but 
one '*' character longer.  The first "***" will be hashed to x, then x 
will be looked up in the reference index, and the first entry 
corresponding to the first character of the line above will be returned.  
At that point a search forward is started to find out how much matches.  
In this case it will match up to the '/' in the reference buffer while 
the target will have another '*'.  The length will be recorded as the 
best match, so far so good.

Now the next entry from the same hash bucket will be tested in case it 
might provide a starting point for a longer match.  But we know in this 
case that the location of the second '*' in the reference buffer will be 
returned.  And we obviously know that this cannot match more data than 
the previous attempt, in fact it'll match one byte less.  And the hash 
entry to follow will return the location of the third '*' for another 
byte less to match.  Then the fourth '*' for yet another shorter match. 
And so on repeating those useless string comparisons multiple times.

One improvement might consist of counting the number of consecutive 
identical bytes when starting a compare, and manage to skip as many hash 
entries (minus the block size) before looping again with more entries in 
the same hash bucket.

The other case to distinguish is when the target buffer has instead a 
_shorter_ line, say 5 fewer '*''s before the final '/'.  Here we would 
loop 4 times matching only a bunch of '*' before we finally match the 
'/' as well on the fifth attempt becoming the best match.  In this case 
we could test if the repeated byte we noticed from the start is present 
further away in the reference buffer, and if so simply skip hash entries 
while searching forward in the reference buffer.  When the reference 
buffer doesn't match the repeated character then the comparison is 
resumed with the target buffer, and in this case the '/' would match 
right away, avoiding those four extra loops recomparing all those '*' 
needlessly.

Such improvements added to the search algorithm might make it 
significantly faster, even in the presence of multiple hash entries all 
located in the same bucket.  Or maybe not if the data set has few 
repeated characters.  And this is probably worthwhile only on top of my 
small block patch. Only experimentation could tell.  Someone willing to 
try?


Nicolas
