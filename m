From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC/PATCH 1/3] revision.c: tighten up TREESAME handling of merges
Date: Sun, 28 Apr 2013 10:03:10 +0300
Message-ID: <517CC9AE.30407@bracey.fi>
References: <517AD304.6020807@bracey.fi> <1367004718-30048-1-git-send-email-kevin@bracey.fi> <7vppxfsirl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 09:28:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWM24-0002SB-1C
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 09:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574Ab3D1H2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 03:28:19 -0400
Received: from mo2.mail-out.ovh.net ([178.32.228.2]:60715 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab3D1H2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 03:28:18 -0400
Received: from mail431.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 75D60DC1A1A
	for <git@vger.kernel.org>; Sun, 28 Apr 2013 09:03:14 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 28 Apr 2013 09:05:33 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 28 Apr 2013 09:05:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
In-Reply-To: <7vppxfsirl.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 14572241020554416344
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeelucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeelucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222730>

On 28/04/2013 01:36, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> Historically TREESAME was set on a commit if it was TREESAME to _any_ of
>> its parents. This is not optimal, as such a merge could still be worth
>> showing, particularly if it is an odd "-s ours" merge that (possibly
>> accidentally) dropped a change.
> "... and with options like --full-history or --simplify-merges are
> used to get more complete history", I think.  "git log path" without
> these options is a tool to get one version of simplified history
> that explains the end result, and by definition, the side branch
> merged by "-s ours" did _not_ contribute anything to the end result.

Yeah, I'm not happy with this commit message - I knocked it up 
separately from my first pass, which I didn't have to hand. Next version 
will combine it with the original, which better distinguished the 
default mode, and specifically addressed the "--full-history -S" search 
problem.

That's key - that I really want such searches to be able to track the 
entire life of a change on a side branch, not potentially showing just 
its birth as now, but also always including any ultimate merge death. (I 
think that we may be able to refine --ancestry-path to give an even 
tighter pinpoint, but --full-history should definitely include the 
information, as per its name).

>
> Do we want to discard the decoration data when the commit becomes a
> non-merge?

Would seem reasonable, and would also help make concrete why we update 
TREESAME immediately, and not in update_treesame(), but I didn't spot a 
mechanism to discard decoration. I'll recheck.

>
>> +		commit->object.flags |= TREESAME;
>> +		for (n = 0; n < st->nparents; n++) {
>> +			if (!st->treesame[n]) {
>> +				commit->object.flags &= ~TREESAME;
>> +				break;
>> +			}
>> +		}
> Can a commit that earlier was marked as TREESAME become not TREESAME?
> Wouldn't simplification only increase sameness, never decrease?

That's true - I paid attention to that earlier when it really mattered 
due to the cost of recalculating it with try_to_simplify_commit(). Not 
sure that it matters so much any more, and I don't see how we can use 
that information to change this "scan for !treesame" loop.

I could insert an "if (!commit->object.flags & TREESAME)" test to skip 
the entire update. I'd be inclined to do that as the caller of 
update_treesame(). I think update_treesame() itself should be 
general-purpose without assumptions about what changes have been made, 
so it's a pure treesame[]->TREESAME calculation, without TREESAME as an 
input.

(Aside - just occurred to me we could swap the loop for 
"strlen(st->treesame) == st->nparents", if we kept a zero terminator in 
the array. Maybe a bit too smart-ass?)


>
>> +	for (pp = &commit->parents;
>> +	     (parent = *pp) != NULL;
>> +	     pp = &parent->next, nth_parent++) {
> I see the reason to change from while to for is because you wanted
> to count, and I think it makes sense; but it is more readable to
> initialise the counter here, too, if that is the case. I.e.
>
> 	for (pp = &commit->parents, nth_parent = 0;
> 	     !(parent = *pp);
> 	     pp = &parent->next, nth_parent++) {

Agree on nth_parent, but  "!(parent = *pp)"  isn't "(parent = *pp) != 
NULL", mind. Did you mean "!!"? In which case I still prefer it my way.

>
> +				if (!tree_changed)
> +					ts->treesame[0] = 1;
> Have we made any two tree comparison at this point to set this one?
> Ahh, this is tricky.  You do this in the _second_ iteration of the
> loop, so tree_changed here is from inspecting the first parent, not
> the one we are looking at (i.e. *p).

Yes, this is the "we've reached our second iteration, so from now on 
we're dealing a merge" if {} block. I'll clarify this in the comment at 
the top, and note that we're populating the newly-allocated treesame[] 
from our first iteration.

>
>>   
>> @@ -773,6 +861,9 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
>>   	 * NEEDSWORK: decide if we want to remove parents that are
>>   	 * not marked with TMP_MARK from commit->parents for commits
>>   	 * in the resulting list.  We may not want to do that, though.
>> +	 *
>> +	 * Maybe it should be considered if we are TREESAME to such
>> +	 * parents - now possible with stored per-parent flags.
>>   	 */
> Hmm, that is certainly a thought.

My comment's wrong though. Reconsidering, what I think needs removing is 
actually off-ancestry parents that we are !TREESAME to, when we are 
TREESAME on the ancestry path.

I've realised while testing this that there's been one thing that's 
confused me repeatedly, and I think this comment was an example of it. 
The example in the rev-list-options manual is wrong.

           .-A---M---N---O---P
          /     /   /   /   /
         I     B   C   D   E
          \   /   /   /   /
           `-------------'

Contrary to the manual, merge P is !TREESAME to E (or I).  E's base is 
old enough that E isn't up-to-date w.r.t. "foo". Thus merge "P" is no 
longer TREESAME and does become subject to display with the new 
--full-history:

    I  A  B  N  D  O  P

I believe this is correct, because P is a merge that determined the fate 
of "foo", so merits --full-history inspection. (--simplify-merges 
obviously knocks P back out again: --simplify-merges becomes more 
important if --full-history gets fuller).

Given this error, and this change, I think this example may want a 
slight rethink. Do we want a proper "messing with other paths but 
TREESAME merge" example? Say if E's parent was O, P would not be 
TREESAME and not included in --full-history.

>
> OK, even though the use of TMP_MARK (meant to be very localized)
> across two functions feel somewhat yucky, they are file scope
> statics next to each other and hopefully are called back to back.

Well, by the end of the series you've got two functions setting it, in 
preparation for later input to this function. And what's the upper bound 
on complexity of functions that may want to mark removal? They may need 
TMP_MARK to do the job. I'm beginning to think that it should be a 
dedicated REMOVE bit.

Kevin
