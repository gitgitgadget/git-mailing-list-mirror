From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: t5401-update-hooks test failure
Date: Tue, 9 Feb 2010 17:29:35 -0800
Message-ID: <20100210012935.GD28936@spearce.org>
References: <20100208213256.GA470@coredump.intra.peff.net> <7viqa7cqs9.fsf@alter.siamese.dyndns.org> <20100208223107.GB21718@cthulhu> <7vpr4f9wey.fsf@alter.siamese.dyndns.org> <20100209045417.GA15210@cthulhu> <7v4olqlva7.fsf@alter.siamese.dyndns.org> <20100209175139.GA28936@spearce.org> <alpine.LFD.2.00.1002091337421.1681@xanadu.home> <20100209192628.GC28936@spearce.org> <7vpr4eyqok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Larry D'Anna <larry@elder-gods.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 02:29:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf1Oj-0006xN-4I
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 02:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980Ab0BJB3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 20:29:39 -0500
Received: from mail-iw0-f183.google.com ([209.85.223.183]:64879 "EHLO
	mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab0BJB3j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 20:29:39 -0500
Received: by iwn13 with SMTP id 13so9165330iwn.25
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 17:29:38 -0800 (PST)
Received: by 10.231.146.66 with SMTP id g2mr3073283ibv.88.1265765378242;
        Tue, 09 Feb 2010 17:29:38 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm489109iwn.2.2010.02.09.17.29.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 17:29:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpr4eyqok.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139469>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > The only way I can see this missing message happening is if the C
> > library isn't flushing the stdio buffer before the hook process
> > exits.  Given that the hook process is a /bin/sh shell script,
> > and its using echo to print its messages... I'm at a loss for how
> > to fix that in Git.
> >
> > Unless its the recv_sideband() somehow skipping a line.  But I
> > can't see it doing that.
> 
> The detection method of test is fooled by intermixed message.
> 
> This is what send.err has, and you grep for '^remote:' in it.
> 
> -- >8 --
> warning: updating the current branch
> warning: Updating the currently cheremote: STDERR pre-receive        
> ,
..
> But there indeed _is_ some skipping.  "Updating the currently che"
> is interrupted by the output from the pre-receive hook, and I do not see
> the remainder "cked out branch may cause confusion,\n" anywhere.

Uh.  I got the problem now, thanks.

What's going on is, other messages inside of builtin-receive-pack
are being sent to stderr, while hook output is going over the
multiplexed side-band through stdout, where its parsed and written
to stderr by send-pack.

What I missed in my patch was changing all of these other messages
inside of receive-pack to also go over the side-band #2 if we have
use_sideband enabled.

Patch coming in a few minutes.

-- 
Shawn.
