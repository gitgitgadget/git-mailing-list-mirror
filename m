From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] introduce inline is_same_sha1
Date: Wed, 16 Aug 2006 23:26:28 -0700
Message-ID: <7vzme3vpwr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608161721020.11465@chino.corp.google.com>
	<7vveos17ym.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608162029540.14684@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 08:26:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDbKu-0007PK-KC
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 08:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWHQG0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 02:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWHQG0d
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 02:26:33 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:43440 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750981AbWHQG0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 02:26:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060817062629.ZTWQ6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Aug 2006 02:26:29 -0400
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608162029540.14684@chino.corp.google.com> (David
	Rientjes's message of "Wed, 16 Aug 2006 20:51:58 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25550>

David Rientjes <rientjes@google.com> writes:

> On Wed, 16 Aug 2006, Junio C Hamano wrote:
>
> The reason it is not
> 	int cmp_object_name(const void *, const void *)
>
> ties into the ultimate goal.  As you said, 20 is hardcoded everywhere in 
> the code as the length sha1's name.  Since my own development tree uses 
> two different hashes configurable at runtime, I decided to create a single 
> static inline that would deal with name comparisons.  I submitted a 
> similar change to your tree because, like you, I envisioned that someday 
> you may have several different hashes that require different comparison 
> lengths.

Good, we are on the same wavelength.  But that does not explain
why you do not use (void *) which would let you avoid casts at
the calling sites.

>> I would have liked if the function were to give the comparison
>> results similar to standard comparison functions such as memcmp
>> and strcmp.  I do not know off-hand if we order by the object
>> names, and we might only be interested in equality tests, but
>> still...
>
> Remember, this is an inline function.  The only reason for writing it 
> would be to isolate the number 20 to this particular function (those that 
> require comparisons were untouched, as I previously stated, so it still 
> exists there as well), otherwise it's useless.

I may be slower than I usually am, but I fail to see the logic.
If we are isolating the comparison length and nothing else,
which I agree is a good thing, I would expect the function to
return 0 when same, just like memcmp(), which means "is_same" is
not the interface we would want.  "is_same" is justified only
when all the callers want to know equality and not comparison.

> ... If you're going to allow a 
> configurable hash function, then you'll need to isolate the n-bytes 
> somewhere if you don't want to pass HASH_NAME_LENGTH around everywhere.

Exactly.  So if some other call sites do want comparison, they
would either need to do memcmp() with 20 or needs cmp_object_name()
like interface, wouldn't they?

> git does sort on sha1 name, specifically with qsort in pack-objects using 
> sha1_sort (which isn't an inline, but should be).

Correct, pack idx is sorted by object name.

> (It would be helpful if you were to specifically request changes to a 
> patch or explicitly state whether or not you queued to apply it, I can 
> never tell).

I am interested in this clean-up, but please convince me that
having two interfaces (is_same and compare) is better way to
abstract out 20 than one interface (compare), or if you agree
with me that one interface is better, please redo the patch and
the change the call sites you deliberately left as memcmp() in
the patch as well.

I sometimes say "I'd apply this as is, but you need to fix such
and such", when the contributor has a good track record of
responding.  Please don't get this wrong, but you are still
unknown quantity to me.  This is a learning process for both of
us.

By the way, Wednesdays and Saturdays (my time) are my git days,
so I try to summarize the current status of "master" and "next"
branches on these days.  On other days I hack on git only during
lunch and evenings so the turnaround and response tend be slower
and sketchier.
