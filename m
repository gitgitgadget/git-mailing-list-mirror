From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Wed, 05 Feb 2014 09:39:39 +0100
Organization: Organization?!?
Message-ID: <87vbwuuf5g.fsf@fencepost.gnu.org>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<874n4ewouz.fsf@fencepost.gnu.org>
	<xmqqr47i7dt4.fsf@gitster.dls.corp.google.com>
	<87zjm6v99y.fsf@fencepost.gnu.org>
	<xmqqmwi67cty.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 09:39:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAy1W-0005mN-TO
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 09:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbaBEIjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 03:39:55 -0500
Received: from plane.gmane.org ([80.91.229.3]:46139 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbaBEIjx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 03:39:53 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAy1O-0005ix-Df
	for git@vger.kernel.org; Wed, 05 Feb 2014 09:39:50 +0100
Received: from x2f4740e.dyn.telefonica.de ([2.244.116.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Feb 2014 09:39:50 +0100
Received: from dak by x2f4740e.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Feb 2014 09:39:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f4740e.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:sCNq8Yn/Yca/JRxMi6Z/Sv3XLB4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241599>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>>> so something like
>>>
>>> 	for (p = buf; p < end; p++) {
>>>         	p = find the end of this line
>>>                 if (!p)
>>>                 	break;
>>> 		num++;
>>> 	}
>>>
>>> perhaps?
>>
>> Would crash on incomplete last line.
>
> Hmph, even with "if !p"?

Admitted.  So we have one _proper_ loop termination condition in the
middle of the loop, and we have a snake oil condition at the start of
the loop that can, according to the standard, _only_ yield true reliably
when p == end (any end > p can only result from undefined behavior when
p points to an object of size end - p).

The effect of this condition basically is to state "we don't trust
memchr to do the right thing when called with 0 as its last argument
which can happen at most once".  This condition will come about by the
_combined_ effect of p = ... _in_ the loop (which is the real iteration
advancing p) and p++ hidden in the for statement (which never makes any
sense separated from the p = ...).

It turns out that
a) memchr is provided by a compatibility layer in case it is missing or
   defective
b) other code in Git demands that memchr works correctly with a zero
   last argument.  See, for example, attr.c:
                        if (dirlen <= len)
                                break;
                        cp = memchr(path + len + 1, '/', dirlen - len - 1);

This clearly needs to be able to work with dirlen == len + 1.

So the loop gets rewritten in a manner where the for statement
_pretends_ to loop linearly through buf, but where the loop _body_ has
its own _regular_ termination condition it shields from the original
for, and p is advanced _independently_.  The advancement of p to beyond
the next '\n' is distributed to two different places in the loop, and
one place is made to look as if it does something else.

> But that last round of the loop will be no-op, so "p < end" vs "p <=
> end" does not make any difference.  It is not even strictly
> necessary because memchr() limits the scan to end, but it would
> still be a good belt-and-suspenders defensive coding practice, I
> would think.

It's snake oil making debugging harder.  It masks the real action, and
it will route around suspected faulty behavior that is wrong according
to the standards and not permitted elsewhere in the codebase.  Other
than that, it just takes additional performance from every iteration.

Putting belts and suspenders on a bike looks comforting until the
suspenders get caught in the wheelspokes.

> which is the same as
>
> 	for (p = buf; ; p++) {
>         	*lineno++ = p - buf;
>                 p = memchr...
>                 if (!p)
>                 	break;
> 	}
>
> and the latter has the loop control p++ at where it belongs to.

But it's only half the control.

As it is clear that we won't get to a state where I'd be willing to have
"git blame" pointing to me as the author, I suggest that you either put
your belts and suspenders on with a separate commit under your own
authorship, or that we drop this altogether.

As I stated already: this patch was just provided because the original
code offends my sense of aesthetics, so there is no point to it if it
offends yours.

I'd still recommend fixing the sizeof(int *) with sizeof(int) confusion.

> If we wanted to have a belt-and-suspenders safety, we need "p <=
> end" here, not "p < end",

That would be totally ridiculous since end > p cannot ever happen except
by undefined behavior.  Pointer inequalities require both pointers to be
associated with the same object.

> This was fun ;-)

At the expense of seriously impacting my motivation to do any further
code cleanup on Git.

Which is a reasonable tradeoff since your fun is more important to Git's
well-being than my one.

-- 
David Kastrup
