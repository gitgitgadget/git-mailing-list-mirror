From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/3] faster inexact rename handling
Date: Tue, 30 Oct 2007 00:21:19 -0400
Message-ID: <20071030042118.GA14729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andy C <andychup@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imibg-0006ff-DS
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 05:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbXJ3EVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 00:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbXJ3EVW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 00:21:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3976 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbXJ3EVW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 00:21:22 -0400
Received: (qmail 29680 invoked by uid 111); 30 Oct 2007 04:21:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 30 Oct 2007 00:21:20 -0400
Received: (qmail 14778 invoked by uid 1000); 30 Oct 2007 04:21:19 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62655>

This is my first stab at faster rename handling based on Andy's code.
The patches are on top of next (to get Linus' recent work on exact
renames). Most of the interesting stuff is in 2/3.

  1/3: extension of hash interface
  2/3: similarity detection code
  3/3: integrate similarity detection into diffcore-rename

The implementation is pretty basic, so I think there is room for
code optimization (50% of the time is spent in hash lookups, so we might
be able to micro-optimize that) as well as algorithmic improvements (like the
sampling Andy mentioned).

With these patches, I can get my monster binary diff down from about 2
minutes to 17 seconds. And comparing all of linux-2.4 to all of
linux-2.6 (similar to Andy's previous demo) takes about 10 seconds.

There are a few downsides:
  - the current implementation tends to give lower similarity values
    compared to the old code (see discussion in 2/3), but this should be
    tweakable
  - on large datasets, it's more memory hungry than the old code because
    the hash grows very large. This can be helped by bumping up the
    binary chunk size (actually, the 17 seconds quoted above is using
    256-byte chunks rather than 64-byte -- with 64-byte chunks, it's
    more like 24 seconds) as well as sampling.
  - no improvement on smaller datasets. Running "git-whatchanged -M
    --raw -l0" on the linux-2.6 repo takes about the same time with the
    old and new code (presumably the algorithmic savings of the new code
    are lost in a higher constant factor, so when n is small, it is a
    wash).

-Peff
