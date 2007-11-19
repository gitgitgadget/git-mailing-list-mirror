From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Sun, 18 Nov 2007 17:28:15 -0800
Message-ID: <7vwssfqb0w.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site>
	<11954023881802-git-send-email-prohaska@zib.de>
	<119540238994-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Nov 19 02:28:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItvRN-0001XU-5U
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 02:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbXKSB2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 20:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbXKSB2Y
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 20:28:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60004 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbXKSB2X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 20:28:23 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6B0132F2;
	Sun, 18 Nov 2007 20:28:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B1330974DD;
	Sun, 18 Nov 2007 20:28:38 -0500 (EST)
In-Reply-To: <119540238994-git-send-email-prohaska@zib.de> (Steffen Prohaska's
	message of "Sun, 18 Nov 2007 17:13:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65399>

Steffen Prohaska <prohaska@zib.de> writes:

> Often you want to push only the current branch to the default
> remote.  This was awkward to do in the past.

While I think --current is a handy shorthand to have, I do not
think the above description is correct.

Wouldn't your earlier patch have allowed the configuration setting:

	[remote "$there"]
        	push = HEAD
	[branch "$current"]
        	remote = $there

to work very well already?

I do not think it is "Often you want" that makes it awkward.

Instead, the awkward case is if you do the "only the current"
push NOT often enough.  If it is often enough, you set the
configuration once and the awkwardness is behind you.

If however it is not often enough, you cannot afford to have the
configuration above, because that would force you to tell from
the command line which branches, not just the current one, to
push, and that is inconvenient because it is not rare enough.

Together with your [PATCH 1/2], I like the general direction
these patckes are taking us, but it feels a bit too hasty.  I
personally am not convinced that switching to --current for
everybody is a good move.

> ...
> Maybe in two years (that's twice an eternity in git time scales):
>
> 4) make "git push --current" the default.

If these, both the uncertainly expressed by "Maybe" and "twice
an eternity" are true, which they are, the new warning in the
current patch are inappropriate.  Many people's settings depend
on a working "push the matching refs" behaviour, and we need a
very good excuse to annoy the existing happy users with such a
warning.

Remember, how much vocal the dissenters might have been on the
list in the recent discussions, we need to consider the needs of
the silent majority that has been content with the current
behaviour for a long time.

The "warning" to annoy them may be a way to get their attention
and get them involved in a discussion to decide what the default
should be.  But changing the default without giving the people
who do not like the _new_ default a way to avoid inconvenience
of always typing --matching or --current is not nice.  And
honestly, I do not think there is one single default that is
good for everybody.

We should be doing better.

A smoother transition route would be:

 - Keep "matching" the built-in default for now;

 - Take your patches (but drop "warning" bits at this point) to
   introduce 'matching' and 'current' behaviours, and a way to
   override the built-in default from the command line;

 - Introduce a configuration 'push.defaultRefs' ('matching' or
   'current') to override that built-in default, so people who
   prefer 'current' can override the built-in default, without
   having to type --current every time.

After all that happens, we can start discussing what the
built-in default should be.  When it is changed after the
discussion concludes (which may never happen), people who want
to keep 'matching' behaviour would have had the configuration
mechanism to override that built-in default for some time during
the discussion period.  So the beginning of that discussion
period is when we should start talking about "We might change
the default soon; set the configuration to your liking if you do
not want to get affected" in the warning.

Then after that, we may or may not decide to change the default.
Even if we end up not changing the default, 'current' people
will then have a way (push.matching = false) to tailor their git
for their liking, so everybody wins.

>  DESCRIPTION
> @@ -63,6 +63,12 @@ the remote repository.
>  	Instead of naming each ref to push, specifies that all
>  	refs under `$GIT_DIR/refs/heads/` be pushed.
>  
> +\--matching::
> +	Instead of naming each ref to push, specifies that matching
> +	refs under `$GIT_DIR/refs/heads/` be pushed.  Matching means
> +	the branch exists locally and at the remote under the same name.
> +	Currently, this is the default.  But this will change in the future.

For the above reason, "But this will..." is a bit premature.
