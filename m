From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Fri, 24 Aug 2012 11:43:40 +0200
Message-ID: <87393cbp6b.fsf@thomas.inf.ethz.ch>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
	<878vd5k7uu.fsf@thomas.inf.ethz.ch>
	<7vd32h4h1t.fsf@alter.siamese.dyndns.org>
	<7v393d49xs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 11:43:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4qQi-0001CX-2f
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 11:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758639Ab2HXJnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 05:43:46 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:27101 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754493Ab2HXJno (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 05:43:44 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 24 Aug
 2012 11:43:31 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 24 Aug
 2012 11:43:40 +0200
In-Reply-To: <7v393d49xs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 23 Aug 2012 13:42:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204196>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> At the very least it should be possible to change in_merge_bases() to
>>> not do any of the post-filtering; perhaps like the patch below.
>>
>> I do not recall the details but the post-filtering was added after
>> the initial naive version without it that was posted to the list did
>> not work correctly in corner cases.  I wouldn't doubt that N*(N-1)
>> loop can be optimized to something with log(N), but I offhand find
>> it hard to believe "to not do any" could be correct without seeing
>> more detailed analysis.
>
> If "one on one side, many on the other side" in merge_bases_many()
> confuses any of you in the readers, you can just ignore many-ness.
> Getting merge bases for "one" against many "two"s using
> merge_bases_many() is exactly the same as getting merge bases for
> "one" against a (fictitious) single commit you can make by merging
> all "two"s.
>
> So we can think about the degenerate case of merge base between two
> commits A and B in the following discussion.
>
> A merge-base between A and B is defined to be a commit that is a
> common ancestor of both A and B, and that is not an ancestor of any
> other merge-base between A and B.

Ok, under that definition I really do think that it's "easy".

You have all the pieces here but one:

> Start from A and B.  Follow from B to find 'x' and paint it in blue,
> follow from A to find 'y' and paint it in amber.  Follow from 'x' to
> '1', paint it in blue.  Follow from 'y' to '1', paint it in amber
> but notice that it already is painted in blue.
[...]
>             o-------o
>            /         \
>           /       y---A
>          /       /
>      ---2---z---1---x---B
>          \         /
>           o-------o
[...]
> So we need to notice that '1' and '2' have ancestry relation in
> order to reject '2' as "common but not merge-base".  One way of
> doing so is not to stop at '1' and keep digging (and eventually we
> find that '2' is what we could reach from '1' that already is a
> merge base), but then we will be susceptible to the same kind of
> clock skew issue as the revision traverser.

I think that is *the* way to do it.

And the way to fix the clock skew issue (also in the revision traversal)
is Peff's generation number cache.  Just keep propagating marks, digging
in generation order, until the generations prove that nothing new can
happen.

  [Side note, in reply to an earlier comment in the rev-list thread: I
  agree with Peff's reasoning that a cache is better than a commit
  header.]

The precise termination condition should be:

  There are no more one-colored commits to walk, and

  The maximum generation of the remaining commits in the walk is less
  than the minimum generation of the merge base candidates

Then the generation numbers ensure that no commit in the walk (which by
then only propagates STALE marks) can possibly be a descendant of any of
the candidates.  At that point, the candidates are the true set of merge
bases.


I conjecture that every history walking problem can be solved in time
linear in the number of commits once we properly use the generation
numbers ;-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
