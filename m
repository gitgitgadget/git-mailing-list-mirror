From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Fri, 02 Nov 2007 12:42:33 -0700
Message-ID: <7vfxzo3046.fsf@gitster.siamese.dyndns.org>
References: <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de>
	<7v8x5jiseh.fsf@gitster.siamese.dyndns.org>
	<B3C76DB8-076D-4C43-AC28-99119A05325C@zib.de>
	<7vve8nglrt.fsf@gitster.siamese.dyndns.org>
	<B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de>
	<7vlk9jgeee.fsf@gitster.siamese.dyndns.org>
	<6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de>
	<!47299855.9010204@op5.se>
	<3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de> <472AF5F8.40208@op5.se>
	<20071102132446.GA31758@hermes.priv> <472B2B8F.1060203@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Prince <tom.prince@ualberta.net>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 02 20:43:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io2Pw-0005wO-Nl
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 20:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbXKBTmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 15:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753698AbXKBTmn
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 15:42:43 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:47893 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbXKBTmm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 15:42:42 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0E8672EF;
	Fri,  2 Nov 2007 15:43:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1EED191196;
	Fri,  2 Nov 2007 15:42:56 -0400 (EDT)
In-Reply-To: <472B2B8F.1060203@op5.se> (Andreas Ericsson's message of "Fri, 02
	Nov 2007 14:52:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63161>

Andreas Ericsson <ae@op5.se> writes:

> Tom Prince wrote:
>>
>> I haven't had occasion to use git-bisect much, but I was under the
>> impression that bisect could already handle merges, or any other shaped
>> history just fine.
>
> It appears the code supports your statement. I started writing on my
> hack-around about a year ago, and the merge-handling code got in with
> 1c4fea3a40e836dcee2f16091bf7bfba96c924d0 at Wed Mar 21 22:16:24 2007.
> Perhaps I shouldn't be so paranoid about useless merges anymore then.
> Hmm. I shall have to look into it. Perhaps Junio can clarify how it
> works? The man-page was terribly silent about how git-bisect handles
> merges.

Bisecting through merge is not a problem.  Not at all, from the
very beginning of the bisect command.

	Side note.  The commit you quote does not change (let
	alone fix) the semantics at all.  It is a pure
	optimization.  The theory behind how bisect works, see
	my OLS presentation (reachable from the gitwiki).

The real problem is what to do when the culprit turns out to be
a merge commit.  How to spot what really is wrong, and figure
out how to fix.  The problem is not for the tool but for the
human, and it is real.

Imagine this history.

      ---Z---o---X---...---o---A---C---D
          \                       /
           o---o---Y---...---o---B

Suppose that on the upper development line, the meaning of one
of the functions existed at Z was changed at commit X.  The
commits from Z leading to A change both the function's
implementation and all calling sites that existed at Z, as well
as new calling sites they add, to be consistent.  There is no
bug at A.

Suppose in the meantime the lower development line somebody
added a new calling site for that function at commit Y.  The
commits from Z leading to B all assume the old semantics of that
function and the callers and the callee are consistent with each
other.  There is no bug at B, either.

You merge to create C.  There is no textual conflict with this
three way merge, and the result merges cleanly.  You bisect
this, because you found D is bad and you know Z was good.  Your
bisect will find that C (merge) is broken.  Understandably so,
as at C, the new calling site of the function added by the lower
branch is not converted to the new semantics, while all the
other calling sites that already existed at Z would have been
converted by the merge.  The new calling site has semantic
adjustment needed, but you do not know that yet.  You need to
find out that is the cause of the breakage by looking at the
merge commit C and the history leading to it.

How would you do that?

Both "git diff A C" and "git diff B C" would be an enormous patch.
Each of them essentially shows the whole change on each branch
since they diverged.  The developers may have well behaved to
create good commits that follow the "commit small, commit often,
commit well contained units" mantra, and each individual commit
leading from Z to A and from Z to B may be easy to review and
understand, but looking at these small and easily reviewable
steps alone would not let you spot the breakage.  You need to
have a global picture of what the upper branch did (and
among many, one of them is to change the semantics of that
particular function) and look first at the huge "diff A C"
(which shows the change the lower branch introduces), and see if
that huge change is consistent with what have been done between
Z and A.

If you linearlize the history by rebasing the lower branch on
top of upper, instead of merging, the bug becomes much easier to
find and understand.  Your history would instead be:

    ---Z---o---X'--...---o---A---o---o---Y'--...---o---B'--D'

and there is a single commit Y' between A and B' that introduced
the new calling site that still uses the new semantics of the
function that was already in A.  "git show Y'" will be a much
smaller patch than "git diff A C" and it is much easier to deal
with.
