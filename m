From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add--interactive: allow diff colors without
	interactive colors
Date: Sat, 5 Jan 2008 03:51:13 -0500
Message-ID: <20080105085113.GA30598@coredump.intra.peff.net>
References: <20080104083521.GB3354@coredump.intra.peff.net> <7v3atdi0na.fsf@gitster.siamese.dyndns.org> <20080105033713.GA26806@coredump.intra.peff.net> <7vk5mod7kg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 09:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB4kw-0002C0-1b
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 09:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbYAEIvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 03:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbYAEIvR
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 03:51:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2299 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbYAEIvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 03:51:16 -0500
Received: (qmail 22844 invoked by uid 111); 5 Jan 2008 08:51:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 05 Jan 2008 03:51:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2008 03:51:13 -0500
Content-Disposition: inline
In-Reply-To: <7vk5mod7kg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69653>

On Sat, Jan 05, 2008 at 12:01:51AM -0800, Junio C Hamano wrote:

> I think I understood that part.  What I was saying was that it
> is equally valid for other people to say "I like to interact
> with 'git add -i' without colours because coloured output
> distracts me when I have to think, even though I usually want to
> view the whole diff in colours."  So yes, color.interactive-diff

Right. My contention is that I think such people will be in the minority
(though obviously I have no numbers to back it up, and nobody else is
participating in this thread).

> To an end user, the fact that "git add -p" shows diff using the
> underlying "git diff" machinery does not matter.  That's just an
> implementation detail.

But he doesn't have to care about that. He cares only that "color.diff"
means "diffs are displayed in color." And "color.interactive" means
"interactive menus are displayed in color." Period. There is no concern
for the implementation detail of the diff machinery.

> "git diff" shows the whole diff at once while "git add -p" shows it
> hunk by hunk.  It is clear they are doing different things to the end
> user.

I don't see that distinction as relevant. Diffs are diffs, whether you
look at them with a small viewport or the whole thing. Would you expect
"git diff -- file1 file2" to have different display options than "git
diff -- file"?

> If he told "git add -p" to be monochrome, he has every right to expect
> the part to pick hunks to also stay monochrome.  To people who know

But he didn't. He said "git menus should be monochrome."

And yes, that's not exactly what config.txt says that color.interactive
does; but I think that is probably worth fixing.

> picker.  To others, it is counterintuitive if color.diff had any
> effect to what "git add -i" did.

Then why does it affect what "git log" does? Why does it affect what
"git reflog" does? Why does the documentation for color.diff say "use
colors in patch" without any reference to specific programs?

> Perhaps a saner alternative would be:
> 
>  * When color.interactive tells to use color, all interaction
>    with "add -i" will be in color.  There is no need to have
>    both color.diff and color.interactive set.
> 
>  * When color.interactive tells not to use color, everything
>    including the diff output will be monochrome.  What you have
>    in color.diff does not matter.

I think this is equally confusing. A user who sets color.diff will see
color diffs from all porcelains _except_ "add -i".

Moreover, this doesn't allow "I always want color in diffs, but I don't
want menu coloring" which is the very thing I have been trying to
accomplish (but yes, I can do that by individually setting
color.interactive.* to plain).

> The point of the third item is that you enable color.interactive
> and set diff related entries of color.interactive.* palette to
> plain, if you want some color while interacting with "add -i"
> but do not like colored hunk picker.  This would parallel the
> way you can selectively enable coloring in "git diff" output,
> where you enable color.diff and set metainfo color to plain if
> you want some color in diff output but do not like colored
> metainfo.

I fail to see how this is less confusing than just adding a separate
interactive-diff knob, since you are asking them to individually set
each color preference to plain. I.e., "set color.interactive to true and
color.interactive-diff to false" versus "set color.interactive to true,
but then for every type of diff colorization, set the color for it in
color.interactive.* to false".

I think the extra knob is not a problem; it is simply a matter of
defaulting the knobs based on other knobs. The rules for knobs
interacting may seem complex, but I think we can DWIM. E.g., given
config options:

  - color
  - color.diff
  - color.interactive
  - color.interactive.diff

The rules for "git add -i" diff coloring would be:

  (1) if color.interactive.diff is set to TRUE/FALSE, use that
  (2) otherwise, if color.interactive is set to TRUE/FALSE, use that
  (3) otherwise, if color.diff is set to TRUE/FALSE, use that
  (4) otherwise, if color is set to TRUE/FALSE, use that

IOW, even though we _have_ all of those knobs, users which don't want to
fine-tune can just use the higher-level knobs. Those that want to can
negate the higher level with lower level knobs. It's flexible, and it's
easy to tell users "just do 'git config color true'."

> Admittedly, it's more work.

Of course. ;) But I am willing to implement what I said above if you
agree that it is sensible.

-Peff
