From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-log: tracking deleted file in a repository with
 multiple "initial commit" histories
Date: Tue, 16 Feb 2016 15:45:57 -0500
Message-ID: <20160216204557.GB27484@sigill.intra.peff.net>
References: <20160216202442.GH21465@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 21:46:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVmVf-0000Bc-GI
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 21:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794AbcBPUqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 15:46:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:43543 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752020AbcBPUqA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 15:46:00 -0500
Received: (qmail 1563 invoked by uid 102); 16 Feb 2016 20:45:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 15:45:59 -0500
Received: (qmail 30476 invoked by uid 107); 16 Feb 2016 20:46:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 15:46:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 15:45:57 -0500
Content-Disposition: inline
In-Reply-To: <20160216202442.GH21465@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286430>

On Tue, Feb 16, 2016 at 12:24:42PM -0800, Brian Norris wrote:

> I'm not sure if this is a known behavior or a new bug report. I at least
> couldn't find anyone mentioning this exact problem.
> 
> I'm using a git repository that has multiple "inital commits" (i.e., a
> few different directory trees were imported via svn-to-git as different
> branches) whose histories have been merged together to the single master
> branch, and the file I want to track is both added and removed in only
> one of those lineages. When I try to do:
> 
>   $ git log -- <file>
> 
> on the deleted file in the master branch, I get no history. But if I
> checkout the particular sub-tree of the merge history, then git-log
> returns the appropriate history.

See the section on History Simplification in git-log. But basically,
when you specify a pathspec, git does not traverse side branches that
had no effect on the given pathspec.

So imagine we are walking backwards through history and showing each
commit, and we hit a merge where the content at that path is at some
sha1 X. We see on one side of the merge that the parent was also at X,
and on the other it was at Y. We do not bother following the commits
down the second parent at all. Perhaps it touched the file and perhaps
it did not, but it does not matter, as the merge threw away anything it
did in favor of the first parent.

Yours is a special case where the final result is "deleted". So there is
a merge where one side had already deleted it, and the other side had
some content, but the merge chose the deletion.

If you want to see the full history, you can with "--full-history"
(there are some other simplification possibilities, but I don't think
any of them are interesting for your particular case).

If you want to find the merge in question, something like:

  git log --graph --full-history -m --oneline --raw -- init/iptables.conf

would work. In your case, it's probably:

  8f4314b Move 'src/platform/init' to 'src/platform2'

-Peff
