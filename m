From: Jeff King <peff@peff.net>
Subject: Re: problem with modification time of packfiles
Date: Mon, 19 Oct 2015 19:52:30 -0400
Message-ID: <20151019235230.GA14800@sigill.intra.peff.net>
References: <87io63503w.fsf@msstf091.ucc.ie>
 <20151019025727.GA23404@vauxhall.crustytoothpaste.net>
 <87a8re4oks.fsf@msstf091.ucc.ie>
 <20151019230919.GA60184@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Amann <a.amann@ucc.ie>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 01:52:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoKEI-0003oM-7B
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 01:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbbJSXwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 19:52:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:45786 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750784AbbJSXwd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 19:52:33 -0400
Received: (qmail 7855 invoked by uid 102); 19 Oct 2015 23:52:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Oct 2015 18:52:33 -0500
Received: (qmail 30631 invoked by uid 107); 19 Oct 2015 23:52:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Oct 2015 19:52:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Oct 2015 19:52:30 -0400
Content-Disposition: inline
In-Reply-To: <20151019230919.GA60184@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279898>

On Mon, Oct 19, 2015 at 11:09:19PM +0000, brian m. carlson wrote:

> On Mon, Oct 19, 2015 at 08:59:15PM +0100, Andreas Amann wrote:
> > Thank you for your answer.  However, this reasoning only applies to loose
> > objects and not packfiles.
> > 
> > My understanding is that "git prune" will not prune any pack files
> > (except those starting with tmp_).  Only "git repack" should do that.
> > Repack seems to be however mtime agnostic and therefore it does not seem
> > to be necessary to freshen packfiles.
> > 
> > It therefore seems that git freshens packfiles unnecessarily, which can
> > lead to expensive and unnecessary backup operations.
> > 
> > Given this, would a trivial patch to remove the freshening of packfiles
> > be acceptable?
> 
> I'm not familiar enough with the code to say for certain, but it looks
> like you're right.  Peff, Junio, do you think this is safe, or is there
> something we're missing?

No, it's not safe. When doing a full repack, we pack only reachable
objects. Unreachable ones are either loosened and given the mtime of the
packfile (from which they can then be pruned), or discarded if the pack
mtime is already old (as an optimization to avoid writing and then
immediately pruning).

See builtin/pack-objects.c:loosen_unused_packed_objects.

-Peff
