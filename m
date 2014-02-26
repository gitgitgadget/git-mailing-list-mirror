From: Jeff King <peff@peff.net>
Subject: Re: GSoC idea: allow "git rebase --interactive" todo lines to take
 options
Date: Wed, 26 Feb 2014 06:42:01 -0500
Message-ID: <20140226114200.GA3779@sigill.intra.peff.net>
References: <530DA00E.4090402@alum.mit.edu>
 <20140226105249.GE25711@sigill.intra.peff.net>
 <530DCC83.1060805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git discussion list <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:42:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIcsO-0001qu-DF
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbaBZLmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 06:42:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:57323 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751393AbaBZLmD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 06:42:03 -0500
Received: (qmail 13643 invoked by uid 102); 26 Feb 2014 11:42:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Feb 2014 05:42:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Feb 2014 06:42:01 -0500
Content-Disposition: inline
In-Reply-To: <530DCC83.1060805@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242728>

On Wed, Feb 26, 2014 at 12:14:11PM +0100, Michael Haggerty wrote:

> > [1] The one feature I would like in this vein is that editing the title
> >     in the instruction-sheet would modify the commit message of the
> >     relevant commit. For some reason I try to do this every few weeks,
> >     but of course the changes are just thrown away.
> 
> Given that commit messages can be more than one line long, a feature
> like this would be confusing, I think, and perhaps subtly encourage
> people to limit their commit messages to a single line, which would be a
> bad thing.

Right, I was assuming it would just modify the subject-line, and leave
the rest intact (I often want to use it to just replace one word or fix
a typo, since I am starting right at it in the insn sheet).

> Plus, until now such edits were thrown away, so there are
> backwards compatibility problems if we suddenly start preserving such edits.

Good point. For true interactive use it probably wouldn't be that big a
deal, but people do weird things with GIT_EDITOR and auto-munging the
list of commits. A heuristic like "is there any message there at all"
might work, as you mentioned, but heuristics make me nervous.

> But using the other ideas discussed here one could do
> 
>     pick -m "New log message" <sha1>

Yeah, that would work, though you have to retype the whole thing, which
is potentially annoying (clever use of your editor can pull it over from
the other side, but it's not super-friendly).

Something like:

  pick --subject <sha1> <modified message...>

would be simpler.

>     amend -m "Revised log message"

That would replace the whole message, which I definitely don't want (and
would encourage bad habits).

> Another, more wonkish idea I though of would be
> 
>     pick --tree=<treeish> <sha1>
> 
> to force the tree of the commit to be set to that of the specified
> <treeish> while keeping the commit metadata from <sha1>.

I think there's a large foot-shooting capacity there. Any commit you've
reordered from after the "--tree" to before it will mysteriously get
undone in the "--tree" commit. E.g.:

  pick aaaaaaa
  pick bbbbbbb
  pick ccccccc

being done as:

  pick ccccccc
  pick bbbbbbb
  pick --tree=bbbbbbb aaaaaaa

-Peff
