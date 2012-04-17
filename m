From: Jeff King <peff@peff.net>
Subject: Re: gc --aggressive
Date: Tue, 17 Apr 2012 15:08:38 -0700
Message-ID: <20120417220838.GB10797@sigill.intra.peff.net>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:08:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGZs-0003Wi-1m
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab2DQWIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 18:08:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37395
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab2DQWIn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 18:08:43 -0400
Received: (qmail 9100 invoked by uid 107); 17 Apr 2012 22:08:50 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Apr 2012 18:08:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Apr 2012 15:08:38 -0700
Content-Disposition: inline
In-Reply-To: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195815>

On Tue, Apr 17, 2012 at 12:16:15PM -0400, Jay Soffian wrote:

> For a couple years now I've had a maintenance script which repacks all
> the repos at @dayjob thusly:
> 
>   git config repack.usedeltabaseoffset true
>   git config pack.compression 9
>   git config pack.indexversion 2
>   git config gc.autopacklimit 4
>   git config gc.packrefs true
>   git config gc.reflogexpire never
>   git config gc.reflogexpireunreachable never
>   git gc --auto --aggressive --prune
> 
> This has worked fine on repos large and small. However, starting a
> couple days ago git started running out of memory on a relatively
> modest repo[*] while repacking on a Linux box with 12GB memory (+ 12GB
> swap). I am able to gc the repo by either removing --aggressive or
> .keep'ing the oldest pack.

I wonder where the memory is going. In theory, the memory consumption
for packing comes from keeping all of the objects for a given window in
memory (so we are looking for a delta for object X, and we have a window
of Y[0]..Y[$window] objects that we will consider). And for a
multi-threaded pack, that's per-thread.

How many cores are there on this box? Have you tried setting
pack.windowMemory to (12 / # of cores) or thereabouts?

> 1) If --aggressive does not generally provide a benefit, should it be
> made a no-op?

In your case, I think it is overkill. But it seems lame that git _can't_
do a full repack on such a beefy machine. You don't want to do it all
the time, but you might want to do it at least once.

-Peff
