From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add--interactive: allow diff colors without
	interactive colors
Date: Sat, 5 Jan 2008 04:57:44 -0500
Message-ID: <20080105095743.GA31220@coredump.intra.peff.net>
References: <20080104083521.GB3354@coredump.intra.peff.net> <7v3atdi0na.fsf@gitster.siamese.dyndns.org> <20080105033713.GA26806@coredump.intra.peff.net> <7vk5mod7kg.fsf@gitster.siamese.dyndns.org> <20080105085113.GA30598@coredump.intra.peff.net> <7v3atcd3k6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 10:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB5nK-0006Gc-Az
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 10:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbYAEJ5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 04:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYAEJ5s
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 04:57:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3656 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752379AbYAEJ5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 04:57:47 -0500
Received: (qmail 23226 invoked by uid 111); 5 Jan 2008 09:57:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 05 Jan 2008 04:57:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2008 04:57:44 -0500
Content-Disposition: inline
In-Reply-To: <7v3atcd3k6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69661>

On Sat, Jan 05, 2008 at 01:28:25AM -0800, Junio C Hamano wrote:

> Who said anything about "interactive is limited to interactive
> menus" anywhere?  That is where we differ and what you do not
> seem to be getting.  I am talking about color.interactive that
> controls the whole user experience of interacting with "add -i".

I did, just now. I am "getting" it just fine, but am trying to propose
an equally valid, and IMHO more useful, semantic for
"color.interactive." (which btw, is a horrible name if you truly mean
"the behavior of git add -i" since there are _other_ interactive
commands. Why doesn't it turn on color for git-rebase -i?).

> What I am aiming at in longer term is to simplify things this way:
> 
>  * Users are categorized broadly into two groups.  The ones who
>    like colours and the ones who don't want colours at all.
>    color.git would control this (with backward compatibility
>    options per command such as color.diff and
>    color.interactive);

OK, that makes sense. But I disagree somewhat with the phrase "backward
compatibility."

>  * Minorities who want to disable colours for particular parts
>    of the UI have enough knobs to tweak in the form of palettes.

They do, but those knobs are a pain to use. Why are we making it so hard
for them when we _already_ have the nice knobs for them to use. IOW, for
these users, git after this change will be _more_ annoying to use. Not
to mention that we must keep those other knobs around for historical
reasons for some amount of time.

Why not just add the higher-level knob and leave the existing ones
(using the priority scheme I mentioned in my last mail)?

>    By definition this needs to address "particular parts", so
>    "color.$command.$context" variables (e.g. color.diff.new,
>    color.interactive.new; if somebody really really wants to
>    have different settings between diff/show/log, that person
>    could add color.{show,log}.new as well) are needed if we want
>    to do this.

Sure. Though like you said previously, I think in 99% of cases, nobody
is going to set these to something exotic; they're going to set them all
ot their custom colors, or all to "plain". In which case, we are just
making work for them by not providing "color.show = false".

> I am trying to avoid introducing new intermediate level knobs
> (e.g. color.log vs color.diff), as it is enough to disable or in
> general change the way particular parts of the UI is coloured by
> palette setting that specifically states which part of the UI is
> tweaked (e.g. color.interactive.prompt).

It is "enough" but I don't think it is the sensible goal. I respect your
desire to keep knobs to a minimum. But I think the fact that we can
split these color knobs into "dead simple, color = true" and "advanced,
super-picky color options" in the documentation makes it less of an
issue.

Anyway, almost none of this is pre-1.5.4. The one thing which is, IMHO,
is the semantics of color.interactive (since it has not yet been
released, this is the best time to set it). I will summarize my stance,
and you can do what you will. Beyond that, this discussion has already
taken way more time than this change is worth.

My opinion is that color.diff should be respected in "git-add -i"
regardless of color.interactive because:
  - the color.diff setting controls diffs in all porcelain parts of git
    (diff, log, show, reflog)
  - parts of diffs are the same as diffs. Thus, hunks should in
    general be treated like diffs for presentation.
  - splitting color by functionality (i.e., diff versus menus) is
    therefore more consistent with the rest of git than splitting it by
    program ("git add -i" versus "git diff")
  - I also happen to think that users are more likely to find "split by
    functionality" useful, but neither of us has relevant data
    (except that you seemed to indicate that's what you would find more
    useful, and that's what I find more useful. So it's 2-0, and clearly
    statistically significant :) ).

So if you are swayed by that, then please apply my previous patch, and
consider the documentation patch below. And if not, let me know and I
will begin changing my color.interactive.* config. :)

-- >8 --
Clarify color.interactive documentation

There are two possible confusions with the color.interactive
description:

  1. the short name "interactive" implies that it covers all
     interactive commands; let's explicitly make it so, even
     though there are no other interactive commands which
     currently use it

  2. Not all parts of "git add --interactive" are controlled
     by color.interactive (specifically, the diffs require
     tweaking color.diff). So let's clarify that it applies
     only to displays and prompts.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e1eaee9..8907e16 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -406,7 +406,8 @@ color.diff.<slot>::
 	in color.branch.<slot>.
 
 color.interactive::
-	When set to `always`, always use colors in `git add --interactive`.
+	When set to `always`, always use colors for interactive prompts
+	and displays (such as those used by "git add --interactive").
 	When false (or `never`), never.  When set to `true` or `auto`, use
 	colors only when the output is to the terminal. Defaults to false.
 
-- 
1.5.4.rc2.1125.ga305e-dirty
