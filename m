From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] blame: new option --prefer-first to better handle merged cherry-picks
Date: Tue, 14 Jan 2014 00:37:05 -0800
Message-ID: <7va9ez0xji.fsf@alter.siamese.dyndns.org>
References: <20140113063008.GA3072@client.brlink.eu>
	<xmqqfvor5xil.fsf@gitster.dls.corp.google.com>
	<20140113225229.GA3418@client.brlink.eu>
	<xmqqbnzf5vvu.fsf@gitster.dls.corp.google.com>
	<xmqq7ga35qdd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Tue Jan 14 09:36:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2zUS-0007MM-N3
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 09:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbaANIgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 03:36:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbaANIgs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 03:36:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 089FD59F2F;
	Tue, 14 Jan 2014 03:36:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=inuK/717V9XCkjhWa9VP8b4RhUc=; b=UWf8Tr
	7euCNn5yStRFCR7KOTQFoh9MbMU7XvOn26ud4Yrx6qT/OYLPgCfMoZeZrGBOBwgt
	jjQagG/ecdwGNSYO8rA2MPZyFE9myxGDTBlltd6G0a1JR4BsWv9enuXN9U1yT/4Q
	PLF9MXeNtJHlE/VjuZw08Qkg1iQWSMny9hQ0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pXgT46bpHPFzFQPchgZN307GU8caz/ae
	5S/iRMsGzie6hkS6fleJUENLNPNw5hZRlCQY5raoGUwww6r2/8Pu+4OT5b8BGC3m
	O28Th/FwNP5EADTeKTJnsmst+nWouVeWSt+SoiiylBdO0DTPa2KeKbPWj/EJBV1L
	Gf60N0CuziA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68D3C59F2C;
	Tue, 14 Jan 2014 03:36:46 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C350059F2A;
	Tue, 14 Jan 2014 03:36:44 -0500 (EST)
In-Reply-To: <xmqq7ga35qdd.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 13 Jan 2014 17:00:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: FFE29548-7CF6-11E3-BC0B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240392>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> While the result is more consistent and more predictable in the case
>>> of merged cherry picks, it is also slower in every case.
>>
>> Consistent and predictable, perhaps, but I am not sure "exact" would
>> be a good word.
>
> Another thing I am not enthusiasitc about this change is that I am
> afraid that this may make "git blame -- path" and "git log -- path"
> work inconsistenly.  The both cull side branches whenever one of the
> parents gave the resulting blob, even that parent is not the first
> one.  But "git blame --prefer-first -- path", afaict, behaves quite
> differently from "git log --first-parent -- path", even though they
> share similar option names, adding more to the confusion.

I think I am starting to understand why this patch felt wrong to me.
This wasn't about "--first-parent" at all, and you are correct that
you didn't call the option as such), but I somehow thought that they
were related; perhaps the fact that both disable the "if the result
exactly matches one parent, all the other parents can be culled to
simplify the history" logic blinded me.

In reality, the new flag is a lot closer in spirit to the total
opposite of "--first-parent", i.e. "--full-history".  That option
also disables that "if same to one parent, other parents do not
matter" logic, but its effect is quite different.  It makes the
other histories that did not have to have contributed the end result
shown in the output.

Now, when we step back and think about how the normal "git blame"
logic apportions the blame to multiple parents when there is no
exact match, it does so in a pretty arbitrary way.  It lets earlier
parents to claim the responsibility and later parents only get
leftover contents that weren't claimed by the earlier ones.  We can
call that "favouring earler ones", i.e. "--prefer-first".

It was implemented this way, not because this order makes any sense,
but primarily because no order is particularly better than any
other, and the designer (me) happened to have picked the easiest one
at random.

The "pick the one that exactly matches if exists" can be thought of
an easy hack to hide the problems that come from this arbitrary
choice.  Without it, if the result matches the second parent (i.e. a
typical merge of a work done on the topic branch while the mainline
has been quiescent in the same area), the "give earlier parents a
chance to claim responsiblity before later ones" rule would have
split the blame for parts that weren't changed in the side branch
topic to the mainline and blame would have been passed to the side
branch only for the portion that were changed by the side branch.
Instead, "pass the whole blame to the one that exactly matches" hack
keeps larger blocks of text unsplit, clumping related contents
together as long as possible while we traverse the history.

It is an "easy hack", because we only need to compare the object
name, but a logical extension to it would have been to compute the
similarity scores between the result and each of the parents, sort
the parents by that similarity score order, and give more similar
ones a chance to claim responsibility before less similar ones.
We could call it "favouring similar ones", i.e. "--prefer-similar"
or something.

That would have made the result more stable.  Imagine that in one
history, a merge's result matchs exactly the second parent, and in
another history, a merge's result almost matches exactly the second
parent but the difference is the result adds one blank line at the
end of the file relative to what the second parent has.

With the current code, blaming the file will get quite a different
result.

In the former history, the sub-history leading to the second parent
of the merge will get all the blame, but in the latter history, the
sub-history leading to the first parent of the merge will have a
chance to claim the responsibility for the shared part before the
second parent has a say in the output.

If we sorted the parents in the similarity order and gave the first
refusal right to more similar parents before less similar ones, then
the resulting output from "git blame" would be very similar in these
two histories, which would be a very desirable property.  If the
only difference between the results of the merge in the former and
the latter histories is one blank line at the end of the file in
question, blames for the remaining part of the file should be
assigned the same between the two histories, but the "pass the
entire blame to the second parent only when the second parent
exactly matches" hack gets in the way for that ideal, and "sort the
parents in similarity order" will fix that.

Of course, it would make the computation a lot more costly, but it
would make the behaviour more predictable and understandable.

But that is a different tangent.

I think the new feature introduced by your change can be explained
as "'git blame' uses the same history simplification as the commands
in the 'git log' family that culls other side branches when the
merge result exactly matches one parent, and in all other cases, it
lets earlier parents claim responsibility before the later ones.
This option disables the culling of the irrelevant side branches, in
a way similar to how '--full-history' option to the commands in the
'git log' family works, and lets earlier parents claim
responsibility to the merge result (even when the later parents
contributed a lot more to the result) before the later parents.".

And if it were sold that way, I think I could at least understand it
(I do not necessarily buy it as a useful feature, though---at least
not yet).

In any case, "--prefer-first" is not particularly a good name, as
that is the default mode of operation for "git blame".  If we were
ever going to implement the "sort parents by similarity", that would
be triggered with "--prefer-similar" and "--prefer-first" would
becomeq a way to choose the current algorithm (i.e. not sort the
parents by similarity but go from earlier to later parents).  We
would regret if we gave that option name to the feature proposed by
the patch under discussion.  How about calling it "--full-history",
which is a way to tell Git not to cull side branches when the result
matches one of the parents?  It is even plausible that we may later
come up with "--prefer-<something>" (sort the parents not in the
original parent order nor in the similarity order but with some
other heuristics), and I suspect "--full-history" would be an
orthogonal axis to the order in which the parents are given a chance
to claim responsiblity.

Thanks; I'll queue the patch on 'pu' and wait for others to comment.
