From: "George Spelvin" <linux@horizon.com>
Subject: Re: Git commit generation numbers
Date: 21 Jul 2011 13:36:33 -0400
Message-ID: <20110721173633.21195.qmail@science.horizon.com>
References: <1311263869.9745.72.camel@drew-northup.unet.maine.edu>
Cc: anthonyvdgent@gmail.com, david@lang.hm, git@vger.kernel.org,
	nico@fluxnic.net, torvalds@linux-foundation.org
To: drew.northup@maine.edu, linux@horizon.com
X-From: git-owner@vger.kernel.org Thu Jul 21 19:37:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjxB6-0002Zg-Nq
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 19:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394Ab1GURgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 13:36:36 -0400
Received: from science.horizon.com ([71.41.210.146]:15777 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752460Ab1GURge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 13:36:34 -0400
Received: (qmail 21196 invoked by uid 1000); 21 Jul 2011 13:36:33 -0400
In-Reply-To: <1311263869.9745.72.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177592>

Drew Northup wrote:
> On Thu, 2011-07-21 at 08:55 -0400, George Spelvin wrote:
>> I have not read yet one discussion about how generation numbers [baked
>> into a commit] deal with rebasing, for instance. Do we assign one more
>> than the revision prior to the base of the rebase operation or do we
>> start with the revision one after the highest of those original commits
>> included in the rebase? Depending on how that is done
>> _drastically_different_ numbers can come out of different repository
>> instances for the same _final_ DAG. This is one major reason why, as I
>> see it, local storage is good for generation numbers and putting them in
>> the commit is bad. 
> 
> Er, no.  Whenever a new commit object is generated (as the result
> of a rebase or not), its commit number is computed based on its
> parent commits.  It is NEVER copied.

> I don't see the word "copy" in my original. 

Indeed, you didn't use it; it was my simplified mental model of your
suggestion that the rebased commits would have generation numbers that
somehow depended on the generation numbers before rebasing.

Althouugh you suggested something different, the mistake is the same:
the rebased commits' generation numbers have simply no relationship to
those of the original pre-rebase commits.  The generation numbers depend
only on the commits explicitly listed as parents in the commit objects.

That's why I went on to explain that the equivalence of the commits
produced by a rebase operation is a higher-level concept; the core git
object database just knows that they aren't identical, and therefore
are different.

Thus, they would retain the same relative order as before the rebase
(unless you permuted them with rebase -i), but start with the generation
number of the rebase target.

> B-O1-O2-O3-O4-O5-O6
>  \
>   R1----R2-------R3

> What's the correct generation number for R3? I would say gen(B)+3. My
> reading of the posts made by some others was that they thought gen(O6)
> was the correct answer. Still others seemed to indicate gen(O6)+1 was
> the correct answer. I don't think everybody MEANT to be saying such
> different things--that's just how they appeared on this end.

According to the canonical algorithm, it's gen(B)+3 = gen(R2)+1.

However, any non-decreasing series is equally permissible for
optimizing history walking, so you could add jumps to (for example)
make the numbers unique if that simplified anything.

I don't think it does simplify anything, so the issue hasn't been
discussed much.

For the purpose of the optimization enabled by the generation
numbers, however, it doesn't actually matter.

What matters is that if I am listing commits down multiple branches,
once I have walked back on each branch to commits of generation N or
less, I know that I have found all possible descendants of all commits
of generation N or more.

This lets me display the recent part of the commit DAG (back to generation
N) without exploring the entire commit treem or worrying that I'll have to
"back up" to insert a commit in its proper order.  Without precomputed
generation numbers, the only way to be sure of this is to explore back
to generation 0 (parentless commits) or to use date-based heuristics.

> Now, did you mean something different by "commit number?"

No, just a bran fart I didn't catch before posting.
I meant "generation number".
