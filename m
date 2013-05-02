From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/8] revision.c: discount UNINTERESTING parents
Date: Thu, 02 May 2013 13:05:26 -0700
Message-ID: <7v61z11721.fsf@alter.siamese.dyndns.org>
References: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
	<1367342788-7795-9-git-send-email-kevin@bracey.fi>
	<7vmwsfbtu7.fsf@alter.siamese.dyndns.org> <5182A7CC.4040009@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu May 02 22:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXzl6-0002bY-HI
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 22:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761933Ab3EBUFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 16:05:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761836Ab3EBUF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 16:05:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D29E19DCF;
	Thu,  2 May 2013 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Ja3IVqGJUbD11g/db4oFBp/EY0=; b=UzQNeI
	zS/j4Q9RKc3a8QXJ6ndW9XDE/FKKaODd3TefcuvKA4AvEu+MxltXXDu2XNnyx289
	VMSzwW70YqzVFNjSvLZfeSkkLzu7vY0Orko/72ImOTqsBIT3eZmm6bikF4iiOEOV
	Ke+EsmOuSINHtOIGLMQI8oieh+NLv1PB3j1qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CjE42LYtrUyomvFyJzo4pNTTwdCi19oP
	kylDW6gmyRbGsAn+x3goamDjQ6TBT/edSNYfakPSDKLMcCH6ZNFmcjJu+Z+V+GNq
	ysL8M2Px+tTH/smaWnYkTL0vbdODRpVaKDRKZFhG5dEE1ZmfqPJoYErsJNEAeMHI
	l2Bv1KF9/T0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8495419DCE;
	Thu,  2 May 2013 20:05:28 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB98119DCC;
	Thu,  2 May 2013 20:05:27 +0000 (UTC)
In-Reply-To: <5182A7CC.4040009@bracey.fi> (Kevin Bracey's message of "Thu, 02
	May 2013 20:52:12 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2174E34-B363-11E2-A7AA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223259>

Kevin Bracey <kevin@bracey.fi> writes:

> On 01/05/2013 00:18, Junio C Hamano wrote:
>
>>> These rules paying more attention to UNINTERESTING do add a tricky
>>> wrinkle to behaviour. Because limited revision lists are conventionally
>>> expressed as A..B (ie B ^A), the bottom commit is UNINTERESTING.
>> OK.
>>
>>> Thus
>>> its connection to the INTERESTING graph is not privileged over side
>>> branches,
>> I take that "its connection" refers to the "===" link below, the
>> nodes connected with "---" form the "INTERESTING graph", and
>>
>>       ....Z...A===X---o---o---B
>>            \\    /
>>             W---Y
>>      "side branches" refer to the development that built W and Y and
>> merged at X.  And you are saying that A===X is not "privileged" over
>> "Y---X", with some definition of "privileged" I am not sure about.
>
> Okay, that's a good graph. The basic problem is that all the rules
> above try to identify a merge from an irrelevant branch and eliminate
> it. But how can we define what a side branch is?
>
> I think the rules I state are conceptually sound - a side branch is an
> extra parent coming in from outside our limited history graph. But the
> problem is at the bottom. In the event that someone specifies "A..B"
> with the above history, we get the resultant graph "W-Y-X-o-o-B". A is
> not on that graph. So with the rules as they stand, "A" being
> UNINTERESTING makes it get treated as a side branch of X, which isn't
> good. A needs to be INTERESTING for the purpose of side-branch logic.
>
> So when someone says "A..B" and generates "W-Y-X-o-o-B", we want to
> know that X's parent path "(Z)-W-Y-X" is the (possibly irrelevant)
> side branch, not "(A)-X".

OK, I think I understand it, and we are in agreement.  For the
purpose of the above paragraph, a side branch is what is not on the
"--ancestry-path", so all of the below "examples" are about the
behaviour when --ancestry-path is used.

> Example undesirable behaviour, with A treated as a side branch:
> ...
> 1) If only commit A changed our file, and merge X took "old" version Y
> for some reason, under these rules "--full-history A..B" would show
> nothing. X doesn't consider A because it's UNINTERESTING. If there had
> been an intervening (even irrelevant) commit A1 between A1 and X, X
> would have been shown.

This is exactly why I hinted that ancestry-path limiting may need to
come before path limiting decides which parents are interesting and
which are irrelevant, and I think it applies the same for the other
two examples.

I haven't thought through the implications of the definition of
"INTERESTING" you propose (without changing the rest of the code to
apply ancestry-path first, I assume).

While I'd like to see a solution that avoids to actually limit with
ancestry-path before limiting with pathspec (because I would imagine
that the most naive way to do so is to scan the graph twice, first
without pathspec to find and cull side branches from "ancestry-path"
point of view and then traverse the resulting graph again with
pathspec to further drop branches that did not contribute to the end
result), I am fairly sure that the end result we produce, whatever
its more efficient implementation would end up to be, _should_ be
equilvalent to the "cull with ancestry path first and then ignore
noncontributing branches with pathspec" semantics.

It is not immediately clear to me that your proposed implementation
will give us that semantics.  Oh, also, even though I said "I am
fairly sure" above, you may already have a counter-example that
shows why the semantics I think is right is not useful in some
cases.

I'll have to think about this a bit more, but it is unlikely I have
time to do so for the coming couple of days.  Sorry about that.

> All 3 cases work if A is treated as "INTERESTING" for side-branch
> rules. We shouldn't have needed to put in an extra A1 commit to make
> them work.
>
>>>   #          D---E-------F
>>>   #         /     \       \
>>> +#    B---C-G0-G--H---I---J
>>>   #   /                     \
>>>   #  A-------K---------------L--M
>>>   #
>>>
>>>
>>> Conceptually, the "ancestry-path" shouldn't get affected by any
>>> pathspec. The range "--ancestry-path G0..M" should be equivalent to
>>> the range "G0..M ^F ^E ^K", and with the rule to ignore non-sameness
>>> with uninteresting side branches, I would have expected that H and J
>>> would be equally irrelevant, because E and F would be outside the
>>> graph we would want to look at sameness.
>
> Those two pathspecs produce the same graph of commits, and yes,
> they've always produced the same thing up until now. But we're trying
> to do something new(ish) here. We're trying to define "side branch",
> to allow us to make more useful pruning comparisons. And we can't
> reliably define "side branch" unless we can reliably define where
> we're coming from.
>
> Looking at this case, given that graph of commits G-H-I-J-L-M
> (produced by any pathspec/flags), that is "easy" because it's
> linear. The bottom of the INTERESTING graph has a single parent, and
> we can follow it straight from bottom to top. We can deduce that
> non-merge "G" is bottom, and thus call the connections to E and F
> "sides". (But that could have been wrong if the graph had been made
> some other way, and the user wasn't asking for history since G0).
>
> But if presented with H-I-J-L-M we get stuck. The lowest commit in our
> graph has 2 parents. How do we distinguish between E and G? Which is
> the side, and which is the bottom? We can only define "side branch"
> here if we know where our bottom is. The version of this patch as
> posted can't distinguish whether E or G is more important, so merge H
> always gets shown. And that makes me unhappy. And note that normal
> merge-simplification will often prune away boring non-merge commits,
> leaving the user-specified UNINTERESTING bottom attached to an
> INTERESTING graph by a merge commit like this. So it would be very
> common to stumble over this first connection onto the INTERESTING
> graph with --simplify-merges.
>
> So my proposal here is that for pruning purposes, we need to mark the
> bottom(s), so we can reliably identify the sides.A side branch is
> spotted by being UNINTERESTING && !BOTTOM.
>
> Doing this means that "--ancestry-path E..M", "--ancestry-path G..M"
> and "G..M ^F ^E ^K" would all produce a walk starting at H, but for
> pruning purposes they will prioritise differences against specified
> bottom commits, and discount them against non-specified boundary
> commits.
>
> So "E..M" will treat "G" as a side branch, and "G..M" will treat "D-E"
> as a side branch. "--ancestry-path E..M" will show H iff it differs
> from E, and "--ancestry-path G..M" will show H iff it differs from G.
>
> And as a result, manually specifying with "G..M ^F ^E ^K" will be
> paying extra attention to merges H, J and L, caring if they differ
> from listed commits E F and K, and not treating them as ignorable side
> branches. H will be shown if it differs from either G or E.
>
> All of which feels right and good to me, but it does mean the neat
> mathematical purity of the commit set model is somewhat disrupted - 
> different pathspecs specifying the same set of commits will prune
> differently. But I think the behaviour fits intuitive expectation
> well. When a user specifies "A..B" or "B ^A", they almost always mean
> that they want the change since A, and they’re not thinking of A as a
> “commit set subtraction”. The specific edge to A is important to
> them. So let's be helpful and meet normal expectation, and treat the
> edge between the INTERESTING graph and the specified bottom commit as
> important.
>
> Revised patch 8/8 doing this follows. The fact it adds a BOTTOM flag
> potentially has an impact on other areas, as noted in the comments. If
> we went down this route, the BOTTOM flag addition would obviously want
> to be a separate preceding patch, covering impact on
> collect_bottom_commits etc.
>
> And the thing about "only need merges with 2+ INTERESTING parents for
> topology" should really be separated out too - that's actually quite
> distinct from the TREESAME side branch stuff, and rather more
> straightforward.
>
> Kevin
