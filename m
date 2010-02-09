From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: t5401-update-hooks test failure
Date: Tue, 9 Feb 2010 11:26:28 -0800
Message-ID: <20100209192628.GC28936@spearce.org>
References: <7vtytrih7b.fsf@alter.siamese.dyndns.org> <7vvde7h1mn.fsf@alter.siamese.dyndns.org> <20100208213256.GA470@coredump.intra.peff.net> <7viqa7cqs9.fsf@alter.siamese.dyndns.org> <20100208223107.GB21718@cthulhu> <7vpr4f9wey.fsf@alter.siamese.dyndns.org> <20100209045417.GA15210@cthulhu> <7v4olqlva7.fsf@alter.siamese.dyndns.org> <20100209175139.GA28936@spearce.org> <alpine.LFD.2.00.1002091337421.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Larry D'Anna <larry@elder-gods.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 20:26:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NevjO-0005wF-GS
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 20:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076Ab0BIT0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 14:26:35 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:41544 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab0BIT0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 14:26:34 -0500
Received: by iwn1 with SMTP id 1so3900622iwn.24
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 11:26:33 -0800 (PST)
Received: by 10.231.59.5 with SMTP id j5mr3094854ibh.6.1265743592834;
        Tue, 09 Feb 2010 11:26:32 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm263171iwn.10.2010.02.09.11.26.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 11:26:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002091337421.1681@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139437>

Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 9 Feb 2010, Shawn O. Pearce wrote:
> > 
> > builtin-send-pack.c clearly isn't stopping early while processing
> > the stream, since we see later messages from the post-receive and
> > post-update hooks just fine.
> > 
> > So I think the only code that is in question is the case 2 arm of
> > recv_sideband().  But to be honest, I can't find any fault with it.
> 
> Note that strict order of messages passed through the sideband can't be 
> relied upon.  Often you have sideband 1 connected to stdin and sideband 
> 2 connected to stderr,

Oh.  Sure.  But that isn't really the case here.

The messages are all coming down side band #2, before we write
anything down side band #1.  The missing message in question
should have appeared somewhere in the middle of that side band
#2 stream that we are seeing in the test output.  Given that its
all serialized down into a single stream by the parent process
receive-pack, we really shouldn't see the messages out of order.


> and they are linked with pipes, and various 
> factors such as stdio buffering or even printf implementation in the C 
> lib

The only way I can see this missing message happening is if the C
library isn't flushing the stdio buffer before the hook process
exits.  Given that the hook process is a /bin/sh shell script,
and its using echo to print its messages... I'm at a loss for how
to fix that in Git.

Unless its the recv_sideband() somehow skipping a line.  But I
can't see it doing that.

-- 
Shawn.
