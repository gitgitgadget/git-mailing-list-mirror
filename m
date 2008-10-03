From: Jeff King <peff@peff.net>
Subject: Re: Numeric Revision Names?
Date: Fri, 3 Oct 2008 13:14:34 -0400
Message-ID: <20081003171434.GC30592@coredump.intra.peff.net>
References: <19796862.post@talk.nabble.com> <m3d4ihr7as.fsf@localhost.localdomain> <20081003115557.08d80c2f.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	marceloribeiro <marcelo@sonnay.com>, git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 19:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KloFn-0004La-7M
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 19:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbYJCROh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 13:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753199AbYJCROh
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 13:14:37 -0400
Received: from peff.net ([208.65.91.99]:2543 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbYJCROh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 13:14:37 -0400
Received: (qmail 7881 invoked by uid 111); 3 Oct 2008 17:14:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 03 Oct 2008 13:14:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2008 13:14:34 -0400
Content-Disposition: inline
In-Reply-To: <20081003115557.08d80c2f.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 03, 2008 at 11:55:57AM -0500, Stephen Haberman wrote:

> For projects that do have a central authority (e.g. internal corporate
> projects), revision numbers make more sense.
> 
> Granted, they are on separate branches (like svn), but the nice thing
> about them is that they are monotonically increasing. E.g. our qa
> people love numbers--the bug fix ticket says dev just put in
> r100...qa/production box says it is on r95. Doesn't matter the
> branch/whatever, they know the box doesn't have r100. Now, right, if
> its r105, it is trickier, although we also throw in branch name (e.g.
> topica-r100) which means no false positives but can lead to false
> negatives.

If you are constraining yourself to a central repo, then you could just
add a receive hook that tags each new commit with a monotonically
increasing revision number. Clients would get the tags upon fetch.

Something like the following (totally untested, and probably needs to
handle locking and errors more sanely) in the post-receive hook:

  n=`cat revnumber 2>/dev/null || echo 0`
  while read old new branch; do
    git rev-list $old..$new |
      while read rev; do
        n=$(($n+1))
        git tag r$n $rev
      done
  done
  echo $n >revnumber

-Peff
