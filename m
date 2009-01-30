From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] EasyGit (eg) 0.97
Date: Fri, 30 Jan 2009 15:03:07 -0500
Message-ID: <20090130200307.GA3054@coredump.intra.peff.net>
References: <51419b2c0901300842rb993454u7e8b6d1032c12ac8@mail.gmail.com> <e2b179460901300859r438a4230hc990305688b4f29e@mail.gmail.com> <51419b2c0901301035g6867b9d8l2d4de9590035bd4e@mail.gmail.com> <20090130194727.GA31927@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 21:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSzbR-0001a0-Aa
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 21:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbZA3UDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 15:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZA3UDL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 15:03:11 -0500
Received: from peff.net ([208.65.91.99]:38192 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913AbZA3UDL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 15:03:11 -0500
Received: (qmail 4191 invoked by uid 107); 30 Jan 2009 20:03:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Jan 2009 15:03:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 15:03:07 -0500
Content-Disposition: inline
In-Reply-To: <20090130194727.GA31927@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107867>

On Fri, Jan 30, 2009 at 02:47:27PM -0500, Jeff King wrote:

> There is also a related set of fixes for spawning externals via fork,
> which fixes a bug with the pager not getting cleaned up. But it looks
> like it is also in the version you tested.
> 
> Can you give a more complete recipe for reproducing? Since I was just
> touching this area in git, I want to make sure it isn't a git bug you
> are triggering. :)

Ah, OK. I just peeked through the 'eg' source. It looks like you may
have replicated the same bug that I just fixed in git. :)

You  want to make sure that "eg" is the last process to die (i.e.,
_after_ the pager). Otherwise after it dies, less has trouble reading
from the terminal (I don't know for sure, but I assume this has to do
with the shell making "eg" the process group leader and magic about
process groups and controlling terminals).

I think perl may even do the wait() for you under ordinary
circumstances. But, for example, if I kill "eg" with a signal (say, by
hitting ^C), then it will die but the pager will live on. In git, we
catch the signal and wait() before dying.

So I don't know for sure that is your problem (it really depends on how
much magic perl is doing behind the scenes with wait()ing on children,
and I don't recall the exact details of that). But it is something to
look into.

I don't think it's a git problem, though. "eg log" doesn't spawn a git
pager, since you pipe the output into eg. The paging is all your local
"less" invocation.

-Peff
