From: Jeff King <peff@peff.net>
Subject: Re: Extremely slow progress during 'git reflog expire --all'
Date: Sat, 3 Apr 2010 16:33:49 -0400
Message-ID: <20100403203348.GA11433@coredump.intra.peff.net>
References: <201004022154.14793.elendil@planet.nl>
 <201004022350.20999.elendil@planet.nl>
 <20100402224100.GA997@coredump.intra.peff.net>
 <201004031629.01970.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, shawn@vger.kernel.org,
	git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Sat Apr 03 22:34:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyA2p-00014h-P4
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 22:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927Ab0DCUeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 16:34:09 -0400
Received: from peff.net ([208.65.91.99]:39288 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755784Ab0DCUeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 16:34:06 -0400
Received: (qmail 32225 invoked by uid 107); 3 Apr 2010 20:34:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 03 Apr 2010 16:34:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Apr 2010 16:33:49 -0400
Content-Disposition: inline
In-Reply-To: <201004031629.01970.elendil@planet.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143901>

On Sat, Apr 03, 2010 at 04:29:01PM +0200, Frans Pop wrote:

> On Saturday 03 April 2010, Jeff King wrote:
> > > I can make that available, but it's going to take a while to upload
> > > and I don't want to leave it up too long as I'll be abusing a project
> > > service for that. So the people who want to look at it would have grab
> > > it fairly promptly (within 2 days or so).
> 
> The tarball is up at:
> http://alioth.debian.org/~fjp/.tmp/linux-2.6_reflog-issue.tar
> 
> Because of the Easter weekend I'll leave it up a bit longer. I plan to 
> remove it sometime on Thursday.

Thanks, I was able to get it and reproduce your problem. The slowness is
in the expire-unreachable code. You can work around it with:

  git config gc.reflogExpireUnreachable never

Obviously that's not really a fix, but it should let your "git gc" work.

It looks like we do two merge-base calculations for each reflog entry,
which is what takes so long. Perhaps if we know we are going to do a
large number of reachability checks, we can pre-mark all reachable
commits, and then each reflog entry would just need to check the commit
mark.

I don't have any more time now to look at it, but I am cc'ing Junio (who
wrote the original expire-unreachable code) and Shawn (the resident
reflog expert), who may have more input.

-Peff
