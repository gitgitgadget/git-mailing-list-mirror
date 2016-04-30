From: Eric Wong <normalperson@yhbt.net>
Subject: Re: clone hang prevention / timeout?
Date: Sat, 30 Apr 2016 09:04:29 +0000
Message-ID: <20160430090429.GA32220@dcvr.yhbt.net>
References: <CALyZvKwxE4T8-FmEYgPMgAFKLmeAY5f-y-mDL8S9twTb0umRaA@mail.gmail.com>
 <20160413222900.GA10011@sigill.intra.peff.net>
 <CALyZvKzzB9yv-aavw2RH7D7fK=vG88-j9W0LAmD3P6=CkSJCuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jason Vas Dias <jason.vas.dias@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 11:04:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awQpO-0007QN-On
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 11:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbcD3JEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 05:04:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48590 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbcD3JEd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 05:04:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F7F633807;
	Sat, 30 Apr 2016 09:04:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALyZvKzzB9yv-aavw2RH7D7fK=vG88-j9W0LAmD3P6=CkSJCuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293122>

Jason Vas Dias <jason.vas.dias@gmail.com> wrote:
> Thanks very much Eric & Jeff for your reply .
> 
> Personally, I would recommend setting the SO_RECVTIMEO for GIT server
> sockets to a fixed default (eg. 5mins) , settable by a
> '--receive-timeout'   argument or configuration parameter .

(apologies for the delay, I thought I replied earlier :x)

SO_RCVTIMEO only triggers EAGAIN, and AFAIK the git read/write
wrappers are used to transparently retry on EAGAIN...  So it's
not so simple as doing a single setsockopt.

> The problem I was trying to overcome was cloning all the repositories under
> https://anongit.freedesktop.org/xorg/* .
> 
> About 4 git clones would succeed in succession, but then typically the 5th
> would hang in read() forever - I left one such hung 'git clone' for nearly an
> hour and it had not progressed or timed out . I tried inserting a delay of
> up to 30 seconds between clones, but this did not help.

Are you in contact with any of the admins of that server to
help?  Is the problematic repo any larger or in any way
stranger than the others?

> Maybe freedesktop.org's GIT server is too overloaded and they have
> to resort to disabling 1 out of 5 GIT successive clone operations from
> same connection or something.

Anyways I've been thinking about overloaded git servers, lately.
Pack generation on big repos is painful, and having lots of slow
clients can tie up server memory.  So maybe an HTTP server
which can switch between dumb and smart operation depending on
load could be useful for the resource-constrained.

> Here is my solution, in case anyone else needs it :

It'd be nice to get an strace to know where in the clone process
it hangs to help the admin figure out how far things got.

And please don't top-post, it's a waste of resources.
