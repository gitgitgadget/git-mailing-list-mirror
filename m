From: josh@joshtriplett.org
Subject: Re: Pretty format specifier for commit count?
Date: Tue, 20 Jan 2015 15:11:10 -0800
Message-ID: <20150120231110.GC14475@cloud>
References: <20150119012926.GA24004@thin>
 <54BD0C85.1070001@drmicha.warpmail.net>
 <20150120011724.GA1944@thin>
 <20150120214952.GA18778@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 00:11:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDhx8-0008DH-Ag
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 00:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbbATXLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 18:11:14 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35544 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbATXLN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 18:11:13 -0500
Received: from cloud (joshtriplett.org [IPv6:2604:3400:dc1:41:216:3eff:fe9f:2070])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id F2802172094;
	Wed, 21 Jan 2015 00:11:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150120214952.GA18778@peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262702>

On Tue, Jan 20, 2015 at 04:49:53PM -0500, Jeff King wrote:
> On Mon, Jan 19, 2015 at 05:17:25PM -0800, Josh Triplett wrote:
> 
> > > Can you be a bit more specific about the type count that you are after?
> > > "git describe" counts commits since the most recent tag (possibly within
> > > a specific subset of all tags). Is that your desired format?
> > 
> > That might work, since the repository in question has no tags; I'd
> > actually like "commits since root commit".
> 
> That's basically a generation number. But I'm not sure if that's really
> what you want; in a non-linear history it's not unique (two children of
> commit X are both X+1).

That would actually be perfectly fine.  If I need to distinguish
branches, I can either use branch/tag names, or append a commit hash.  I
don't mind the following:

 /-B-\
A     D
 \-C-/

A=1
B=C=2
D=3

I could (and probably should) append "+hash" to the version number for
uniqueness, and if I care what order B and C sort in, I can use tags,
branches, or some other more clever mechanism.

> It sounds like you really just want commits
> counting up from the root, and with side branches to have their own
> unique numbers. So something like:
> 
>        C
>       /
>   A--B--D
> 
>   A=1
>   B=2
>   C=3
>   D=4
> 
> except the last two are assigned arbitrarily. You need some rules for
> linearizing the commits.

I don't care about the numbers assigned to anything not reachable from
the committish I start from.

> But that's not deterministic as you add more starting points (either new
> ref tips, or just new merges we have to cross). For example, imagine
> this:
> 
>          G--H
>         /    \
>        C--E   \
>       /    \   \
>   A--B--D---F---I
> 
> If we start at I, then we might visit H and G first, meaning we learn
> about C much earlier than we otherwise would. Then we hit F, and get to
> C from there. But now it it may be in a different position with respect
> to D!

Right, the numbers need to always stay the same as you add more commits
over time.  If walking a given graph assigns a given set of generation
numbers, walking any subgraph should assign all the same generation
numbers to the common nodes.

> I suspect your problem statement may simply assume a linear history,
> which makes this all much simpler. But we are not likely to add a
> feature to git that will break badly once you have a non-linear history. :)

Not assuming a linear history, but assuming a linear changelog file. :)

> I think in the linear case that a generation number _would_ be correct,
> and it is a useful concept by itself. So that may be the best thing to
> add.

Sounds good to me.

- Josh Triplett
