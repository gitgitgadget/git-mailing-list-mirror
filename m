From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add--interactive: allow diff colors without
	interactive colors
Date: Fri, 4 Jan 2008 22:37:13 -0500
Message-ID: <20080105033713.GA26806@coredump.intra.peff.net>
References: <20080104083521.GB3354@coredump.intra.peff.net> <7v3atdi0na.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 04:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAzr5-0001cl-0E
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 04:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYAEDhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 22:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752665AbYAEDhS
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 22:37:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2429 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbYAEDhR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 22:37:17 -0500
Received: (qmail 22004 invoked by uid 111); 5 Jan 2008 03:37:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 22:37:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 22:37:13 -0500
Content-Disposition: inline
In-Reply-To: <7v3atdi0na.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69636>

On Fri, Jan 04, 2008 at 04:20:09PM -0800, Junio C Hamano wrote:

> Although I would agree with what this patch does, I think you
> are contradicting with yourself in the above justification.
> Some users may want to color "git diff" output but not
> interaction with "git add -i", and that's also "just one without
> the other", but you just tied them together, only differently,
> and "seems unlikely" is a rather weak excuse.

Then let me state it another way that I think makes a better argument.
You have two knobs, color.interactive and color.diff, controlling
menu-coloring of git-add--interactive and controlling colorization of
git-diff output. Now we have a third thing that may be colorized: diff
output of git-add--interactive.

Let's assume that we don't want to add another color.interactive-diff
knob (though that is an option). That means that we have to tie the
colorization either to color.interactive or to color.diff. Right now we
subdivide it by command, so that the coloring of interactive diffs is
tied to color.interactive[1]. What I am proposing is to divide it by
_functionality_, so that by saying color.diff you mean "I like color
diffs, no matter where they are." And by saying color.interactive, you
mean "I like color interactive menus, no matter where they are." I think
it is much more likely that users will find that division useful. And
it's something we already do, since color.diff is respected not just by
git-diff, but by diffs produced by all programs, including the git-log
family.

[1]: Actually, we currently tie interactive diff coloring to "diff &&
interactive" which is even less useful. If I turn on color.interactive,
I still don't get colored diffs. But if I turn on color.diff, then
git-diff starts producing colored diffs. So you really can't represent
all choices, and I think the subdivision I outlined makes more sense (at
least it does to me).

> The justification should instead be: having more independent
> knobs is not necessarily better.  The user should not have to
> tweak too many knobs.
>
> In the longer term, I think we should try reducing the number of
> knobs by giving "color.git" that allows you to pretend as if all
> of the "color.interactive", "color.diff", "color.status",
> "color.someothercolorizedcommand" are all set.  I do not think
> being able to control the use of colors per command is giving
> much other than confusion to the user.

I'm not sure I agree with that; my problem here is that I _want_ to turn
a knob, but the functionality is tied to another knob. IOW, reducing the
number of knobs is going to make it worse.

That being said, all of those knobs _are_ confusing. In my case, I like
color. I just don't like the colors that color.interactive provides, so
I don't want to use them.  However, you can tune that quite a bit by
changing color.interactive.* (and just choosing "plain" for things you
don't want marked). Of course that still doesn't allow you to have
_different_ color settings between the diffs of git-diff and those of
git-add--interactive. But then, my point is that I don't think sane
users want that. They either want diffs colored or they don't, no matter
what command is producing them.

> That may not be so easy with the current structure of the config
> reader, though.

I don't think it's hard; the client code for the colors checks a
"color_foo" knob. It would just check "color_foo || color_all".

-Peff
