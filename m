From: Jeff King <peff@peff.net>
Subject: Re: Repacking a repository uses up all available disk space
Date: Sun, 12 Jun 2016 17:38:04 -0400
Message-ID: <20160612213804.GA5428@sigill.intra.peff.net>
References: <20160612212514.GA4584@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Sun Jun 12 23:38:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCD5D-0004Ud-SJ
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 23:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbcFLViK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2016 17:38:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:53521 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933195AbcFLViI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 17:38:08 -0400
Received: (qmail 4915 invoked by uid 102); 12 Jun 2016 21:38:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jun 2016 17:38:07 -0400
Received: (qmail 8450 invoked by uid 107); 12 Jun 2016 21:38:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jun 2016 17:38:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:38:04 -0400
Content-Disposition: inline
In-Reply-To: <20160612212514.GA4584@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297141>

On Sun, Jun 12, 2016 at 05:25:14PM -0400, Konstantin Ryabitsev wrote:

> Hello:
> 
> I have a problematic repository that:
> 
> - Takes up 9GB on disk
> - Passes 'git fsck --full' with no errors
> - When cloned with --mirror, takes up 38M on the target system

Cloning will only copy the objects that are reachable from the refs. So
presumably the other 8.9GB is either reachable from reflogs, or not
reachable at all (due to rewinding history or deleting branches).

> - When attempting to repack, creates millions of files and eventually
>   eats up all available disk space

That means these objects fall into the unreachable category. Git will
prune unreachable loose objects after a grace period based on the
filesystem mtime of the objects; the default is 2 weeks.

For unreachable packed objects, their mtime is jumbled in with the rest
of the objects in the packfile.  So Git's strategy is to "eject" such
objects from the packfiles into individual loose objects, and let them
"age out" of the grace period individually.

Generally this works just fine, but there are corner cases where you
might have a very large number of such objects, and the loose storage is
much more expensive than the packed (e.g., because each object is stored
individually, not as a delta).

It sounds like this is the case you're running into.

The solution is to lower the grace period time, with something like:

  git gc --prune=5.minutes.ago

or even:

  git gc --prune=now

That will prune the unreachable objects immediately (and the packfile
ejector is smart enough to skip ejecting any file that would just get
deleted immediately anyway).

-Peff
