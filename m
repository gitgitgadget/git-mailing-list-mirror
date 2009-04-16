From: Jeff King <peff@peff.net>
Subject: Re: renaming remote branches
Date: Thu, 16 Apr 2009 09:50:37 -0400
Message-ID: <20090416135037.GA7770@coredump.intra.peff.net>
References: <buo3ac9jn18.fsf@dhlpc061.dev.necel.com> <20090416065934.GA20071@coredump.intra.peff.net> <76718490904160609s1ef9c1e0m6f19ff169666fa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 15:52:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuS0s-0004Ct-NF
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 15:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101AbZDPNup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 09:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbZDPNup
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 09:50:45 -0400
Received: from peff.net ([208.65.91.99]:34118 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbZDPNuo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 09:50:44 -0400
Received: (qmail 3163 invoked by uid 107); 16 Apr 2009 13:50:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Apr 2009 09:50:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2009 09:50:37 -0400
Content-Disposition: inline
In-Reply-To: <76718490904160609s1ef9c1e0m6f19ff169666fa3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116700>

On Thu, Apr 16, 2009 at 09:09:17AM -0400, Jay Soffian wrote:

> On Thu, Apr 16, 2009 at 2:59 AM, Jeff King <peff@peff.net> wrote:
> > Not only is this not user-friendly, but it does not preserve any branch
> > config or reflog at the remote (both things that "branch -m" does).
> 
> I wonder whether we should:
> 
> a) teach git remote a rename-branch sub-command

I think that is a reasonable place for such a helper command to go,
whether it is tightly integrated with git or not (IOW, even with nothing
else, it might still be useful to have a wrapper to parse the remote
hostname and directory from the config, ssh in, and run "git branch
-m").

> b) add support on the remote side for properly preserving the config and reflog

Do you mean over the git protocol? I don't see a real reason not to have
it (since we allow deletion already, the user is not doing anything
more destructive than what we already do). But I think any proposal
would have to spell out how the protocol could accomodate this in a
backwards-compatible manner.

I wonder if we could simply do "rename detection" on the list of pushed
refs, and save the config and reflog in that case. IOW, detect

  git push remote remote/foo:refs/heads/bar :refs/heads/foo

I think there is fundamentally a race condition with the "create new and
delete old" approach, though, as nothing is guaranteeing that your "new"
and the remote's "old" have the same thing in them. You might be
deleting somebody else's new commits, no "--force" required. So probably
it is better to be able to explicitly specify a rename.


All of that is assuming that remote renames are common enough to really
care about. Personally, I've never actually done one.

-Peff
