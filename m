From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC/PATCH 1/3] revision.c: tighten up TREESAME handling of merges
Date: Mon, 29 Apr 2013 20:46:45 +0300
Message-ID: <517EB205.6090804@bracey.fi>
References: <517AD304.6020807@bracey.fi> <1367004718-30048-1-git-send-email-kevin@bracey.fi> <7vppxfsirl.fsf@alter.siamese.dyndns.org> <517CC9AE.30407@bracey.fi> <7v61z6sdpz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 19:47:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWsAC-0007ZP-VX
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757685Ab3D2Rqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:46:52 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:45417 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756877Ab3D2Rqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:46:51 -0400
X-Greylist: delayed 125015 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Apr 2013 13:46:51 EDT
Received: from mail621.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id B0B6FDC1B8F
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 19:46:49 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 29 Apr 2013 19:46:53 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 29 Apr 2013 19:46:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
In-Reply-To: <7v61z6sdpz.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 12829066488962846936
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrhedvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500176/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrhedvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222827>

On 28/04/2013 21:38, Junio C Hamano wrote:
>
>>>>    @@ -773,6 +861,9 @@ static void limit_to_ancestry(struct
>>>> commit_list *bottom, struct commit_list *li
>>>>    	 * NEEDSWORK: decide if we want to remove parents that are
>>>>    	 * not marked with TMP_MARK from commit->parents for commits
>>>>    	 * in the resulting list.  We may not want to do that, though.
>>>> +	 *
>>>> +	 * Maybe it should be considered if we are TREESAME to such
>>>> +	 * parents - now possible with stored per-parent flags.
>>>>    	 */
>>> Hmm, that is certainly a thought.
>> My comment's wrong though. Reconsidering, what I think needs removing
>> is actually off-ancestry parents that we are !TREESAME to, when we are
>> TREESAME on the ancestry path.
> I thought I read you meant exactly that, i.e. !TREESAME, but now I
> re-read what is quoted, you did say "we are TREESAME" ;-).  I think
> I agree with you that we do not want any side branch that is not on
> the ancestry path we are interested in to affect the sameness
> assigned to the merge commit.

I did a trial implementation of this in limit_to_ancestry(), and the 
result was lovely, but in the end I decided it's not actually the right 
place to do it. The logic is more general than that; this isn't just an 
ancestry-path issue, and I think "hiding" parents isn't the right way to 
go about it anyway.

To slightly generalise your own wording: I think the rule is "we do not 
want any side branch that is UNINTERESTING to affect the sameness 
assigned to the merge commit". I think that rule applies to all dense, 
pruned modes.

Having experimented with some of the annoyingly complex merge paths that 
originally prompted this series, it seems this rule makes a huge 
difference, and it's useful whether asking "--simplify-merges A..B 
<file>" or "--ancestry-path A..B <file>".

At present, either query will show lots of really boring merge commits 
of topic branches at the boundary, with 1 INTERESTING parent that 
they're TREESAME too, and 1 UNINTERESTING parent that they may or may 
not be TREESAME to, depending on how old the base of that topic branch 
was. Most such commits are of no relevance to our history whatsoever. In 
the case of "--simplify-merges", the fact that they're UNINTERESTING 
actually _prevented_ their simplification - if it had been allowed to 
follow the UNINTERESTING path back further, it would have reached an 
ancestor, and been found redundant. So limiting the rev-list actually 
increases the number of merges shown.

We can lose all those boring commits with these two changes:

1) Previously TREESAME was defined as "this commit matches at least 1 
parent". My first patch changes it to "this commit matches all parents". 
It should be refined further to "this commit matches all INTERESTING 
parents, if it has any, else all (UNINTERESTING) parents". (Can we word 
that better?) Note that this fancy rule collapses to the same 
straightforward TREESAME check as ever for 0- or 1-parent commits.

2) simplify_merges currently will not simplify commits unless they have 
exactly 1 parent. That's not what we want. We only need to preserve 
commits that don't have exactly 1 INTERESTING parent.

Those 2 rules produce the desirable result: if we have a merge commit 
with exactly 1 INTERESTING parent it is TREESAME to, it is always 
simplified away - any other UNINTERESTING parents it may have did not 
affect our code, so we don't care about whether we were TREESAME to them 
or not, and as we don't want to see any of the UNINTERESTING parents 
themselves, the merge is not worth showing.

This makes a massive difference on some of my searches, reducing the 
total commits shown by a factor of 5 to 10, greatly improving the 
signal-to-noise ratio.

I'll put together a trial patch at the end of the next iteration of the 
series that implements this logic. I need to think a bit more - I think 
"get_commit_action" needs a similar INTERESTING check for merges too, to 
get the same sort of effect without relying on simplify_merges. Parent 
rewriting shouldn't necessitate keeping all merges - only merges with 2+ 
INTERESTING parents.

>>
>>                    *   *
>>            .-A---M---N---O---P
>>           /*    /   /*  /*  /*
>>          I     B   C   D   E
>>           \   /*  /   /*  /
>>            `-------------'
> I've added '*' next to each arc between a commit-pair whose contents
> at 'foo' are different to the illustration, following the set-up the
> manual describes.  E is the same as I for 'foo' and P would resolve
> 'foo' to be the same as O.

I think that sort of thing could be a useful patch to the docs.
>
>> Given this error, and this change, I think this example may want a
>> slight rethink. Do we want a proper "messing with other paths but
>> TREESAME merge" example? Say if E's parent was O, P would not be
>> TREESAME and not included in --full-history.
> I am not sure if I follow your last sentence.
>
> Do you mean this topology, where E's sole parent is O, i.e.
>
>                E
>               / \
> 	N---O---P
>             /*
>            D
>
> and E does not change 'foo' from O?  Then P is TREESAME to all its
> parents and would not have to appear in the full history for the
> same reason M does not appear in your earlier IABNDOP output, no?

That's the topology I was thinking of.  Yes, P is then "full-TREESAME" 
like M, but it's just a more typical example of a real merge and why 
TREESAMEness arises than M is.  M didn't appear in full-history because 
both parents made the same change to foo - indeed both parents were 
identical. Whereas P wouldn't appear because E is different, but changed 
something other than foo.

Kevin
