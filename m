From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 08:01:53 -0500
Message-ID: <20090210130153.GA17305@coredump.intra.peff.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com> <20090210110330.GB12089@coredump.intra.peff.net> <49916524.4000400@drmicha.warpmail.net> <20090210114506.GF12089@coredump.intra.peff.net> <499174E8.3030207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 14:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsGp-00040e-OS
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 14:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZBJNB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 08:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754122AbZBJNB4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 08:01:56 -0500
Received: from peff.net ([208.65.91.99]:44379 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbZBJNBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 08:01:55 -0500
Received: (qmail 13603 invoked by uid 107); 10 Feb 2009 13:02:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 08:02:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 08:01:53 -0500
Content-Disposition: inline
In-Reply-To: <499174E8.3030207@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109231>

On Tue, Feb 10, 2009 at 01:36:56PM +0100, Michael J Gruber wrote:

> > I would much prefer that, if it had been done that way from the
> > beginning. But I think we are stuck with "git status" due to hysterical
> > raisins.
> 
> ROTFTCOOTF!

I have to admit, this is a new acronym for me...I get the first half,
but not the second.

> > The big downside with the snippet I posted above is that it runs three
> > separate commands that go through the index. In theory, you could do it
> > in one pass. But wt-status _doesn't_ do that, since the diff
> > infrastructure isn't there (a long time ago, Junio had an experimental
> > parallel diff walker patch, but it never made it out of next).
> 
> We completely agree. How do you suggest to progress? Go for the diff
> walker? For a (porc.) command like shortstatus I think going through the
> index 3 times isn't that bad, all disk access should be cached after the
> first run.

I don't know if resurrecting the parallel diff walker is worth the
trouble. I guess if somebody cares enough about the performance they can
find the old patch and try benchmarking it.

Making a C command rather than a shell script is probably reasonable if
this is performance critical (and there seems to be talk of putting it
into a prompt).  What I really object to in the patch is:

  - sticking this in builtin-commit.c. It really has _nothing_ to do
    with commit or the existing status. Especially using the same
    option parser is just nonsensical.

  - I'm not sure bolting this onto wt-status really makes much sense.
    Especially the performance-critical --mini prompt mode _doesn't_
    want to do the string collection because it wastes a lot of cycles
    figuring out things that we are just going to throw away.

    However, for the "regular" mode, I don't think it is too big a
    problem. wt_status does a few extra things that shortstatus won't
    care about, but I don't think they are too performance critical
    (e.g., I believe it will find out the "your branch is N commits
    ahead of the remote" information).

-Peff
