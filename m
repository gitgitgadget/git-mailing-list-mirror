From: Jeff King <peff@peff.net>
Subject: Re: git rebase keeps saying local changes would conflict..what
 changes?
Date: Fri, 15 Jun 2012 12:08:13 -0400
Message-ID: <20120615160813.GB4572@sigill.intra.peff.net>
References: <D8381FF2-A6B4-4596-B565-7E5BB3F239D8@color.com>
 <2652085F-C1BC-4EAB-9289-F508E64982F0@color.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Gillum <eric@color.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 18:08:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfZ4O-0003xE-4N
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 18:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203Ab2FOQIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 12:08:17 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:56432
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755063Ab2FOQIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 12:08:16 -0400
Received: (qmail 603 invoked by uid 107); 15 Jun 2012 16:08:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 12:08:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 12:08:13 -0400
Content-Disposition: inline
In-Reply-To: <2652085F-C1BC-4EAB-9289-F508E64982F0@color.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200065>

On Thu, Jun 14, 2012 at 04:49:54PM -0700, Eric Gillum wrote:

> Just found a similar problem here:
> http://stackoverflow.com/questions/5074136. I do use Xcode, which may
> be related. Maybe I'll try the proposed solution. But I'd still love
> to know what the issue is, or how I can help debug it.

Reading that thread, one answer mentions that Xcode may overwrite files
in the middle of your rebase. There is no git fix for that; tweaking
files in the middle of a git operation can only lead to bad and
confusing results.

Turning off trustctime only makes sense if Xcode is touching the file
metadata but not modifying the file at all. Is that what's happening?

Further confusing to me is that the original poster there mentioned that
the dirty state is untracked files in the working directory. But ctime
shouldn't be involved at all, then. It sounds more like tracked files
were not deleted when we switched away from the branch (either because
of a bug in git, or because something like Xcode is re-creating them
behind our back).

> > I have a sometimes-reproducible issue when trying to rebase. In
> > short, I've created a local branch B off of master, made several
> > commits on B, switched to master and pulled, switched back to B,
> > then tried "git rebase master", which fails. What I get about half
> > the time is a failure that claims I have local changes to files that
> > would be overridden by the merge. Nothing is reported by git status
> > (I've even tried closing all editors), so I am forced to do git
> > rebase --abort or --skip.

Try running "git diff-files" instead of "git status". If something is
munging the files behind git's back, then the index (which should have
been refreshed by "git update-index --refresh" at the start of the
rebase) will be out of date. "git status" will refresh the index itself,
but we would not want that if we are interested in making the same
comparison that the rebase is doing.

> > What's wrong? Why would I get the local changes warning but have no
> > local changes? The merge conflicts tend to be within a file that has
> > been changed multiple times on B. These "conflicts" are literally
> > changes I've made at one point or another on B. The relevant files
> > were never touched on master while I was working on B. And no
> > changes on B are amends or reverts or anything remotely tricky --
> > they're simply more changes committed with "git commit". So why
> > would I have to "resolve conflicts"?

You shouldn't have to if there were no changes to the same areas on
master. But if something like Xcode were externally munging files to
some other version, then it would make sense.

-Peff
