From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] {fetch,receive}-pack: drop unpack-objects, delay loosing
 objects until the end
Date: Tue, 3 Sep 2013 13:25:14 -0400
Message-ID: <20130903172514.GB1050@sigill.intra.peff.net>
References: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
 <20130903064938.GB3608@sigill.intra.peff.net>
 <CACsJy8ButV8Y6Rm=F8dLTw3NvRCJZ1RgJ5f-591ASbOqfDRRTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:25:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGuLz-0003uF-RL
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758549Ab3ICRZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:25:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:56896 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756708Ab3ICRZR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:25:17 -0400
Received: (qmail 16943 invoked by uid 102); 3 Sep 2013 17:25:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 12:25:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 13:25:14 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8ButV8Y6Rm=F8dLTw3NvRCJZ1RgJ5f-591ASbOqfDRRTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233747>

On Tue, Sep 03, 2013 at 06:56:23PM +0700, Nguyen Thai Ngoc Duy wrote:

> > ...but the cost is paid by total pack size, not number of objects. So if
> > I am pushing up a commit with a large uncompressible blob, I've
> > effectively doubled my disk I/O. It would make more sense to me for
> > index-pack to learn command-line options specifying the limits, and then
> > to operate on the pack as it streams in. E.g., to decide after seeing
> > the header to unpack rather than index, or to drop large blobs from the
> > pack (and put them in their own pack directly) as we are streaming into
> > it (we do not know the blob size ahead of time, but we can make a good
> > guess if it has a large on-disk size in the pack).
> 
> Yeah letting index-pack do the work was my backup plan :) I think if
> there is a big blob in the pack, then the pack should not be unpacked
> at all. If you store big blobs in a separate pack you already pay the
> the lookup cost of one more pack in find_pack_entry(), why go through
> the process of unpacking? index-pack still has the advantage of
> streaming though. Will rework.

In general, our large-blob strategy is to push them out to their own
pack so that we do not incur the I/O overhead of rewriting them whenever
we repack. But the flipside is that we have to pay the cost of an extra
.idx open and lookup for each such object. In the longer term, I think
it might make sense to be able to generate a multi-pack .idx for such a
case (or even to simply store the large blobs in a special area indexed
by the object sha1, as we do for loose objects).

But that is all orthogonal to your patch. I think as long as we are
moving towards "index-pack makes the decisions while it processes the
pack" we are going in a good direction. Even if we do not implement all
of the decisions immediately, it leaves room for doing so later without
loss of efficiency.

-Peff
