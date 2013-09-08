From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] upload-pack: send the HEAD information
Date: Sun, 8 Sep 2013 03:13:59 -0400
Message-ID: <20130908071359.GJ14019@sigill.intra.peff.net>
References: <20130906155204.GE12966@inner.h.apk.li>
 <20130906155608.GF12966@inner.h.apk.li>
 <xmqqsixhyhan.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 09:14:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZCD-00007F-PH
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab3IHHOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:14:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:43193 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab3IHHOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:14:03 -0400
Received: (qmail 7146 invoked by uid 102); 8 Sep 2013 07:14:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 02:14:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 03:13:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsixhyhan.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234195>

On Fri, Sep 06, 2013 at 10:46:24AM -0700, Junio C Hamano wrote:

> I think it is perfectly fine to expose _only_ HEAD now, and wait
> until we find a good reason that we should send this information for
> other symbolic refs in the repository.

Yeah, I agree with that.

> However, because we already anticipate that we may find such a good
> reason later, on-the-wire format should be prepared to support such
> later enhancement.  I think sending
> 
> 	symref=HEAD:refs/heads/master
> 
> is probably one good way to do so, as Peff suggested in that old
> thread ($gmane/102070; note that back then this wasn't suggested as
> a proper capability so the exact format he suggests in the message
> is different).  Then we could later add advertisements for other
> symbolic refs if we find it necessary to do so, e.g.
> 
> 	symref=HEAD:refs/heads/master
>         symref=refs/remotes/origin/HEAD:refs/remotes/origin/master
> 
> (all on one line together with other capabilities separated with a
> SP in between).

It somehow feels a little weird to me that we would output the
information about refs/foo on the HEAD line. A few possible issues (and
I am playing devil's advocate to some degree here):

  1. What if we have a large number of symrefs? Would we run afoul of
     pkt-line length limits?

  2. What's the impact of having to display all symrefs on the first
     line, before we output other refs? Right now we can just stream out
     refs as we read them, but we would have to make two passes (and/or
     cache them all) to find all of the symrefs before we start
     outputting. Will the extra latency ever matter?

What do you think about teaching git to read extra data after "\0" for
_every_ ref line? And then ref advertisement might look something like:

  <sha1> HEAD\0multi_ack thin-pack ... symref=refs/heads/master\n
  <sha1> refs/heads/master\n
  <sha1> refs/heads/my-alias\0symref=refs/heads/master

That would leave us future room for more ref annotations if we should
want them, and I think (but haven't tested) that existing receivers
should ignore everything after the NUL.

-Peff
