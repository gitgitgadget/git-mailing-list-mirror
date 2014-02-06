From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Thu, 06 Feb 2014 01:34:51 +0100
Organization: Organization?!?
Message-ID: <87r47hjcyc.fsf@fencepost.gnu.org>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<874n4ewouz.fsf@fencepost.gnu.org>
	<xmqqr47i7dt4.fsf@gitster.dls.corp.google.com>
	<87zjm6v99y.fsf@fencepost.gnu.org>
	<xmqqmwi67cty.fsf@gitster.dls.corp.google.com>
	<87vbwuuf5g.fsf@fencepost.gnu.org>
	<xmqqk3d92t0z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 01:35:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBCvz-0000jc-OY
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 01:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbaBFAfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 19:35:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:54280 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbaBFAfG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 19:35:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WBCvm-0000Zg-GB
	for git@vger.kernel.org; Thu, 06 Feb 2014 01:35:02 +0100
Received: from x2f4740e.dyn.telefonica.de ([2.244.116.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 01:35:02 +0100
Received: from dak by x2f4740e.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 01:35:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f4740e.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:QypG5zFRHCJCi9qT9A3HlHJkT8o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241680>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> It's snake oil making debugging harder.
>
> OK, that is a sensible argument.
>
>>> This was fun ;-)
>>
>> At the expense of seriously impacting my motivation to do any further
>> code cleanup on Git.
>
> Well, I said it was "fun" because I was learning from a new person
> who haven't made much technical or code aethesitics discussion here
> so far.  If teaching others frustrates you and stops contributing to
> the project, that is a loss.

The implication of "Thanks for catching them, but this patch needs heavy
style fixes." is not one of learning.

> But the styles matter, as the known pattern in the existing code is
> what lets our eyes coast over unimportant details of the code while
> reviewing and understanding.  I tend to be pickier when reviewing code
> from new people who are going to make large contributions for exactly
> that reason---new blood bringing in new ideas is fine, but I'd want to
> see those new ideas backed by solid thiniking, and that means they may
> have to explain themselves to those who are new to their ideas.

Well, the point of stylistic decisions is exactly that they are not
individually "backed by solid thinking": if they were, one would not
require a style.

A pattern of
some loop {
  ...
  if (condition) {
    code intimately related to condition;
    continue;
  }
  break;
}

is somewhat awkward.  The superficially simpler

some loop {
  ...
  if (!condition)
    break;
  code intimately related to condition;
}

separates related parts with a central loop exit.  Which maybe a tossup.
The former pattern of break; at the end of a loop, however, becomes
indispensible in the form

some loop {
  ...
  switch (...) {
    various cases ending in either break; or continue;
  }
  break;
}

In this case, the break; before the end of the loop establishes the
statement "any commencement of the loop will be explicitly done using
continue;", particularly important since a break; inside of the switch
statement does not, without this help, break out of the loop.

It's a pattern that is transparent enough to be still preferable over
"crank out the goto already, chicken".

Is "if I have to use x in some situations anyway I may as well pick it
when there would be equivalent solutions" solid thinking?  Not really.
It's about choosing one's familiars.  Which ultimately boils down to
personal style.  And where the differences are not really significant
for understanding and _are_ a conscious expression rather than just an
accident, the thin line between "write in a way that does not go against
our style and/or good sense" and "write in the way I would have written
it" may be the line between fun and work.

-- 
David Kastrup
