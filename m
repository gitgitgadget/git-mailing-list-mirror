From: Jeff King <peff@peff.net>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Wed, 25 May 2016 17:56:25 -0500
Message-ID: <20160525225625.GA2634@sigill.intra.peff.net>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
 <20160513103621.GA12329@dcvr.yhbt.net>
 <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
 <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
 <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
 <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
 <20160517121330.GA7346@sigill.intra.peff.net>
 <20160525224907.GA18894@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Luke Diamand <luke@diamand.org>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Thu May 26 00:56:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hj6-0004JC-M4
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbcEYW43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:56:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:44336 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751829AbcEYW42 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:56:28 -0400
Received: (qmail 23468 invoked by uid 102); 25 May 2016 22:56:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 18:56:28 -0400
Received: (qmail 15094 invoked by uid 107); 25 May 2016 22:56:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 18:56:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2016 17:56:25 -0500
Content-Disposition: inline
In-Reply-To: <20160525224907.GA18894@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295612>

On Wed, May 25, 2016 at 10:49:07PM +0000, Eric Wong wrote:

> > Thanks for the analysis. I think this is definitely the problem.  After
> > fast-import finalizes a packfile (either at the end of the program or
> > due to a checkpoint), it never discards its internal mapping of objects
> > to pack locations. It _has_ to keep such a mapping before the pack is
> > finalized, because git's regular object database doesn't know about it.
> > But afterwards, it should be able to rely on the object database.
> 
> Almost; but relying on marks is a problem since that set can contain
> mark => object_entry mappings which the normal object database won't
> know about.

Ah, thanks for finding that. I had a feeling there might be other users
of the object_entry structs, but I didn't dig.

Given that and your other responses here, I agree that just invalidating
the pack_id is probably the most sensible route.

-Peff
