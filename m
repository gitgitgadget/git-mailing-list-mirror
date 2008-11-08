From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diffcore-rename: support rename cache
Date: Sat, 8 Nov 2008 06:47:20 -0500
Message-ID: <20081108114719.GA4989@sigill.intra.peff.net>
References: <1226068533-10152-1-git-send-email-pclouds@gmail.com> <20081107222128.GB4030@nan92-1-81-57-214-146.fbx.proxad.net> <7vy6zvdt25.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0811072001o6df7ae00k1b1bffaadf75d3a1@mail.gmail.com> <20081108092409.GD4030@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 12:48:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KymIw-0005FQ-PN
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 12:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbYKHLrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 06:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbYKHLrY
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 06:47:24 -0500
Received: from peff.net ([208.65.91.99]:1789 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782AbYKHLrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 06:47:23 -0500
Received: (qmail 5666 invoked by uid 111); 8 Nov 2008 11:47:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 08 Nov 2008 06:47:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2008 06:47:20 -0500
Content-Disposition: inline
In-Reply-To: <20081108092409.GD4030@nan92-1-81-57-214-146.fbx.proxad.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100396>

On Sat, Nov 08, 2008 at 10:24:10AM +0100, Yann Dirson wrote:

> Well, it could be that an out-of-pathspec pair would have a better
> score than an in-pathspec one.  Maybe cache recording should be turned
> off when doing pathspec limitation ?

One thing I notice is that the cache works at the level of "here is the
best rename for this commit." Maybe it could go down a level and say
"here is the inexact rename score between these blobs". Then you would
still find the best score between two blobs each time, but save the
really computationally intensive part (which is comparing the actual
_content_ of the blobs).

That should work in the face of path limiting or any other option,
because it is caching something immutable: this is the similarity score
between two pieces of content. And then you get arbitrary tree-to-tree
speedups for free, since such a cache would be valid for every commit.

The downsides are:

 - your cache is potentially bigger, since you are caching the score of
   every pair you look at, instead of just "good" pairs (OTOH, you are
   not doing a per-commit cache, which helps reduce the size)

 - you can still "lie" about a score to pre-seed imported SVN renames,
   but such lying will actually apply to all commits.

-Peff
