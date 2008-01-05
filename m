From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add--interactive: allow diff colors without interactive colors
Date: Sat, 05 Jan 2008 00:01:51 -0800
Message-ID: <7vk5mod7kg.fsf@gitster.siamese.dyndns.org>
References: <20080104083521.GB3354@coredump.intra.peff.net>
	<7v3atdi0na.fsf@gitster.siamese.dyndns.org>
	<20080105033713.GA26806@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 09:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB3zQ-00024T-RL
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 09:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbYAEICH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 03:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbYAEICG
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 03:02:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbYAEICF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 03:02:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A7566B06;
	Sat,  5 Jan 2008 03:02:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 829306B04;
	Sat,  5 Jan 2008 03:01:58 -0500 (EST)
In-Reply-To: <20080105033713.GA26806@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 4 Jan 2008 22:37:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69648>

Jeff King <peff@peff.net> writes:

> Let's assume that we don't want to add another color.interactive-diff
> knob (though that is an option). That means that we have to tie the
> colorization either to color.interactive or to color.diff. Right now we
> subdivide it by command, so that the coloring of interactive diffs is
> tied to color.interactive[1]. What I am proposing is to divide it by
> _functionality_, so that by saying color.diff you mean "I like color
> diffs, no matter where they are." And by saying color.interactive, you
> mean "I like color interactive menus, no matter where they are." I think
> it is much more likely that users will find that division useful. And
> it's something we already do, since color.diff is respected not just by
> git-diff, but by diffs produced by all programs, including the git-log
> family.

I think I understood that part.  What I was saying was that it
is equally valid for other people to say "I like to interact
with 'git add -i' without colours because coloured output
distracts me when I have to think, even though I usually want to
view the whole diff in colours."  So yes, color.interactive-diff
is an option to give more flexibility, but no I do not think
that's a good flexibility.  I'd prefer a single "color.git"
environment that rules all, which is far simpler to explain and
configure.  Either you use colour for all your interaction with
git, or you live in black-and-white world.

> [1]: Actually, we currently tie interactive diff coloring to "diff &&
> interactive" which is even less useful. If I turn on color.interactive,
> I still don't get colored diffs. But if I turn on color.diff, then
> git-diff starts producing colored diffs. So you really can't represent
> all choices, and I think the subdivision I outlined makes more sense (at
> least it does to me).

And my point was that I doubt the change is such a big
improvement, certainly not in the way your justification
claimed, _even though I agree_ that the current "diff &&
interactive" way may not be something many people would want (by
the way, it happens to cover my preference, but that only means
I am a minority).  Neither covers all cases, and as I said, I do
not think more flexibility to cover all cases is necessarily a
good thing to shoot for.

Also there is another confusion factor we haven't discussed.

To an end user, the fact that "git add -p" shows diff using the
underlying "git diff" machinery does not matter.  That's just an
implementation detail.  "git diff" shows the whole diff at once
while "git add -p" shows it hunk by hunk.  It is clear they are
doing different things to the end user.  If he told "git add -p"
to be monochrome, he has every right to expect the part to pick
hunks to also stay monochrome.  To people who know the internal
implementation, it might be natural to expect the color.diff
configuration variable to affect the colouring of the hunk
picker.  To others, it is counterintuitive if color.diff had any
effect to what "git add -i" did.

> That being said, all of those knobs _are_ confusing. In my case, I like
> color. I just don't like the colors that color.interactive provides, so
> I don't want to use them.  However, you can tune that quite a bit by
> changing color.interactive.* (and just choosing "plain" for things you
> don't want marked).

Yes, I 100% agree with you that they are confusing, and being to
able to futz with color.interactive.* palette would probably
alleviate the need to have color.{diff,interactive,status,etc}.

> ... Of course that still doesn't allow you to have
> _different_ color settings between the diffs of git-diff and those of
> git-add--interactive. But then, my point is that I don't think sane
> users want that. They either want diffs colored or they don't, no matter
> what command is producing them.

That point I would agree with you but only 70%.  No sane user
would want deleted lines in red in "git diff" output and in
purple in hunk picker.  But I think it is reasonable to want to
view them in monochrome while in hunk picker (by setting
color.*.old to plain) but in red in normal diff output.

Perhaps a saner alternative would be:

 * When color.interactive tells to use color, all interaction
   with "add -i" will be in color.  There is no need to have
   both color.diff and color.interactive set.

 * When color.interactive tells not to use color, everything
   including the diff output will be monochrome.  What you have
   in color.diff does not matter.

 * We could allow color.interactive.* pallete to have elements
   that are parallel to color.diff.* palette to be used while
   showing the colored diff.  But this would be a low priority
   because (1) a custom setting to anything but "plain" does not
   make much practical sense, as it is just introducing needless
   inconsistency between "git diff" and the hunk picker, and (2)
   custom setting to "plain" would be used by people who like
   colored "git add -i" prompts but not colored hunk picker,
   which would be a minority.

The point of the third item is that you enable color.interactive
and set diff related entries of color.interactive.* palette to
plain, if you want some color while interacting with "add -i"
but do not like colored hunk picker.  This would parallel the
way you can selectively enable coloring in "git diff" output,
where you enable color.diff and set metainfo color to plain if
you want some color in diff output but do not like colored
metainfo.

Admittedly, it's more work.
