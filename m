From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Always release pack files before calling gc --auto
Date: Wed, 13 Jan 2016 12:52:38 -0500
Message-ID: <20160113175237.GA13139@sigill.intra.peff.net>
References: <cover.1452705584.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:52:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJPbG-0006lp-Ew
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbcAMRwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:52:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:53085 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932464AbcAMRwk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:52:40 -0500
Received: (qmail 6196 invoked by uid 102); 13 Jan 2016 17:52:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 12:52:40 -0500
Received: (qmail 30392 invoked by uid 107); 13 Jan 2016 17:52:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 12:52:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2016 12:52:38 -0500
Content-Disposition: inline
In-Reply-To: <cover.1452705584.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283957>

On Wed, Jan 13, 2016 at 06:20:02PM +0100, Johannes Schindelin wrote:

> These patches are companions to 786b150 (clone --dissociate: avoid
> locking pack files, 2015-10-06), triggered by a bug report to the Git
> for Windows project.
> 
> Johannes Schindelin (4):
>   fetch: release pack files before garbage-collecting
>   am: release pack files before garbage-collecting
>   merge: release pack files before garbage-collecting
>   receive-pack: release pack files before garbage-collecting

I think this is fine, but I noticed an almost-problem that I think is
worth mentioning.

Closing packs can open up race conditions in some cases. I.e., we think
we have an object in a particular pack, do some work on that basis, and
then later find the pack to be inaccessible (due to somebody else
running gc). If we keep the fd open, there's no race, but if we close
it, we can't reopen it.

I think all of the cases here are fine, for two reasons:

  1. The new closing is right before the program would exit anyway, so
     there's no interesting work left to do (and obviously that's where
     we generally want to call "gc --auto", too)

  2. This type of race might only be an issue for pack-objects (or at least that's
     the only place I've seen it).  Most normal read_sha1_file() callers
     will happily re-scan the pack directory for the new packs upon
     finding that the old pack went away. But pack-objects peeks in the
     packfiles a little more intimately, and will record the actual pack
     and offset (for delta reuse).

     It _might_ also be possible to trigger this race using bitmaps,
     which are also pretty intimate with the packfile code. I'm not
     sure.

So I think this series is OK.

-Peff
