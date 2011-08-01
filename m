From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 1 Aug 2011 12:25:16 -0600
Message-ID: <20110801182516.GC10302@sigill.intra.peff.net>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
 <1311012516-4836-5-git-send-email-kusmabite@gmail.com>
 <7vmxga7zb9.fsf@alter.siamese.dyndns.org>
 <CABPQNSYtpRpNQVW=QvyfFhmWge5-C+k85bs2EJeK8k0jdfHzrw@mail.gmail.com>
 <20110728160845.GA14337@sigill.intra.peff.net>
 <20110728164758.GA15931@sigill.intra.peff.net>
 <20110728170222.GB15931@sigill.intra.peff.net>
 <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com>
 <20110801174603.GB10302@sigill.intra.peff.net>
 <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:25:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnxB6-0000vS-UM
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab1HASZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:25:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33518
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466Ab1HASZT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:25:19 -0400
Received: (qmail 22228 invoked by uid 107); 1 Aug 2011 18:25:52 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Aug 2011 14:25:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2011 12:25:16 -0600
Content-Disposition: inline
In-Reply-To: <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178394>

On Mon, Aug 01, 2011 at 08:02:22PM +0200, Erik Faye-Lund wrote:

> > Weird. What does j.tgz end up looking like? Is it empty, or does it have
> > bogus data in it? Does gzip actually get invoked at all? Try running
> > with GIT_TRACE=1. I don't suppose you guys have something like strace,
> > which might be helpful.
> >
> 
> It does have data, and gzip does get invoked:
> $ gunzip -c j.tgz | wc -c
> 
> gzip: j.tgz: invalid compressed data--format violated
>  131072
> 
> So it seems there are around 130k of valid data before it barfs.
> 
> Hmm, but when I try the same after re-running the test, I get a
> different amount of valid data (491520 bytes this time)... Is this a
> timing-related issue?

Hmm. Non-deterministic output is not good. Could be timing, or we could
be touching memory we're not supposed to. I just ran t5000 through
valgrind, and nothing turned up. And of course I can't replicate the
test failure on Linux. So I assume it really is Windows-specific.

That makes me suspect some difference in how the run-command API works
on the two platforms, since that is the code here that will be vastly
difference. I notice the start_command code uses dup() on Windows
instead of dup2() (I guess you guys don't have dup2?). I wonder if there
could be some issue with another descriptor accidentally pointing to the
same spot. But that's just a wild guess.

I think at this point, I'd probably start stepping through the archive
code with gdb.

-Peff
