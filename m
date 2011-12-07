From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/2] grep: turn off threading for non-worktree
Date: Wed, 7 Dec 2011 15:45:31 -0500
Message-ID: <20111207204530.GA20907@sigill.intra.peff.net>
References: <cover.1322830368.git.trast@student.ethz.ch>
 <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
 <4ED8F9AE.8030605@lsrfire.ath.cx>
 <4EDE9BBA.2010409@lsrfire.ath.cx>
 <4EDE9ED1.8010502@lsrfire.ath.cx>
 <20111207044242.GB10765@sigill.intra.peff.net>
 <20111207201105.GA22995@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Dec 07 21:45:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYON2-0001Ly-F2
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 21:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757652Ab1LGUpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 15:45:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42878
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757578Ab1LGUpd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 15:45:33 -0500
Received: (qmail 19855 invoked by uid 107); 7 Dec 2011 20:52:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 15:52:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 15:45:31 -0500
Content-Disposition: inline
In-Reply-To: <20111207201105.GA22995@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186499>

On Wed, Dec 07, 2011 at 03:11:05PM -0500, J. Bruce Fields wrote:

> >   $ time git grep --threads=8 'a.*b' HEAD >/dev/null
> >   real    0m8.655s
> >   user    0m23.817s
> >   sys     0m0.480s
> 
> Dumb question (I missed the beginning of the conversation): what kind of
> storage are you using, and is the data already cached?

Sorry, I should have been clear: all of those numbers are with a warm
cache. So this is measuring only CPU.

> I seem to recall part of the motivation for the multithreading being
> NFS, where the goal isn't so much to keep CPU's busy as it is to keep
> the network busy.
> 
> Probably a bigger problem for something like "git status" which I think
> ends up doing a series of stat's (which can each require a round trip to
> the server in the NFS case), as it is a problem for something like
> git-grep that's also doing reads.
> 
> Just a plea for considering the IO cost as well when making these kinds
> of decisions....

This system has a decent-quality SSD, so the I/O timings are perhaps
not as interesting as they might otherwise be. But here are cold cache
numbers (each run after 'echo 3 >/proc/sys/vm/drop_caches'):

  HEAD, --threads=0: 4.956s
  HEAD, --threads=8: 9.917s
  working tree, --threads=0: 17.444s
  working tree, --threads=8: 6.462s

So when pulling from the object db, threads are still a huge loss
(because the data is compressed, the SSD is fast, and we spend a lot of
CPU time inflating; so it ends up close to the warm cache results). But
for the working tree, the I/O parallelism is a huge win.

So at least on my system, cold cache vs. warm cache leads to the same
conclusion. "git grep --threads=8 ... HEAD" might still be a win on slow
disks or NFS, though.

-Peff
