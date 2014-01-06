From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] [RFC] Making use of bitmaps for thin objects
Date: Mon, 6 Jan 2014 14:41:52 -0500
Message-ID: <20140106194152.GB27062@sigill.intra.peff.net>
References: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
 <5CDDBDF2D36D9F43B9F5E99003F6A0D43B67C0DA@PRN-MBX02-1.TheFacebook.com>
 <20140106151052.GB15489@sigill.intra.peff.net>
 <xmqq38l1kqw2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Maurer <bmaurer@fb.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 20:42:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0G3j-0004ZE-2g
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 20:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbaAFTlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 14:41:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:56055 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755537AbaAFTly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 14:41:54 -0500
Received: (qmail 13623 invoked by uid 102); 6 Jan 2014 19:41:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jan 2014 13:41:54 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jan 2014 14:41:52 -0500
Content-Disposition: inline
In-Reply-To: <xmqq38l1kqw2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240053>

On Mon, Jan 06, 2014 at 08:37:49AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We could probably teach index-pack an "--assume-refs-are-thin"
> > option to optimize for this case, and have fetch-pack/receive-pack pass
> > it whenever they know that delta-base-offset was negotiated.
> 
> I thought the existing negotiation merely means "I understand offset
> encoded bases, so you are allowed to use that encoding", not "I will
> not accept encoding other than the offset format, so you must use
> that encoding for everything".

You are right about what it means. But this is an optimization, not a
correctness thing. So if we assume that senders who are allowed to send
offsets will generally do so, it might be a reasonable optimization to
guess that ref-delta objects will need thin completion. If we are wrong,
the worst case is that we add an extra local object to the end of the
pack. So as long as we are right most of the time, it may still be a
win.

Of course, it may also be possible to simply multi-thread the
thin-completion portion of index-pack. That would be even better, though
I am not sure how it would work. The resolution of an object in one
thread can always become the input for another thread. But maybe we
could have each thread come up with a proposed set of objects to add to
the pack, and then drop duplicates or something. I haven't looked
closely.

-Peff
