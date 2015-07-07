From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] index-pack: fix allocation of sorted_by_pos array
Date: Tue, 7 Jul 2015 12:06:31 -0400
Message-ID: <20150707160630.GA4456@peff.net>
References: <1429354025-24659-1-git-send-email-pclouds@gmail.com>
 <1429354025-24659-3-git-send-email-pclouds@gmail.com>
 <xmqqoajt5glu.fsf@gitster.dls.corp.google.com>
 <CACsJy8D872sj9WQec_FZrTxx=gqy++L1XLxJdEtEQNpGpFYr=Q@mail.gmail.com>
 <xmqqzj3c3efv.fsf_-_@gitster.dls.corp.google.com>
 <xmqqr3on369x.fsf_-_@gitster.dls.corp.google.com>
 <CACsJy8CsUu1zEnah9Ah3tQxk8N-xPpOBuV5TpQ4EB6+nyiDW3g@mail.gmail.com>
 <xmqqvbdw3r40.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 18:06:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVOJ-00012H-2Q
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757093AbbGGQGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:06:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:56922 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755116AbbGGQGe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:06:34 -0400
Received: (qmail 31545 invoked by uid 102); 7 Jul 2015 16:06:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 11:06:33 -0500
Received: (qmail 10490 invoked by uid 107); 7 Jul 2015 16:06:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 12:06:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jul 2015 12:06:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbdw3r40.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273571>

On Tue, Jul 07, 2015 at 08:49:19AM -0700, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > I keep tripping over this "real_type vs type" in this code. What do
> > you think about renaming "type" field to "in_pack_type" and
> > "real_type" to "canon_type" (or "final_type")? "Real" does not really
> > say anything in this context..
> 
> An unqualified name "type" does bother me for the word to express
> what representation the piece of data uses (i.e. is it a delta, or
> is it a base object of "tree" type, or what).  I think I tried to
> unconfuse myself by saying "representation type" in in-code
> comments, reviews and log messages when it is not clear which kind
> between "in-pack representation" or "Git object type of that stored
> data" a sentence is talking about, and I agree "in_pack_type" would
> be a vast improvement over just "type".

I think this is doubly confusing because pack-objects _does_ use
in_pack_type. And its "type" is therefore the "real" object type. Which
is the opposite of index-pack, which uses "type" for the in-pack type.
So at the very least, we should harmonize these two uses.

> Especially, if the other one is renamed with "in_pack_" prefix,
> "real_type" is not just clear enough but is probably better because
> it explains what it is from its "meaning" (i.e. it is the type of
> the Git object, not how it is represented in the pack-stream) than
> "final_type" that is named after "how" it is computed (i.e. it makes
> sense to you only if you know that an in-pack type "this is delta"
> does not have the full information and you have to traverse the
> delta chain and you will finally find out what it is when you hit
> the base representation).

Yeah, I agree real_type is fine when paired with in_pack_type. We might
consider modifying pack-objects.h to match (on top of just moving
index-pack to in_pack_type).

-Peff
