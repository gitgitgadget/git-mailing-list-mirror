From: Eric Wong <e@80x24.org>
Subject: Re: [RFC] fast-import: invalidate pack_id references after loosening
Date: Thu, 26 May 2016 08:02:36 +0000
Message-ID: <20160526080236.GA27652@dcvr.yhbt.net>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
 <20160513103621.GA12329@dcvr.yhbt.net>
 <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
 <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
 <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
 <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
 <20160517121330.GA7346@sigill.intra.peff.net>
 <20160525224907.GA18894@dcvr.yhbt.net>
 <20160525225402.GB18894@dcvr.yhbt.net>
 <20160525230913.GB2634@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 10:06:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5qJg-0007fY-KQ
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 10:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbcEZIGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 04:06:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58034 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753383AbcEZICh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 04:02:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5D51FCC4;
	Thu, 26 May 2016 08:02:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160525230913.GB2634@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295637>

Jeff King <peff@peff.net> wrote:
> On Wed, May 25, 2016 at 10:54:02PM +0000, Eric Wong wrote:
> > +	for (h = 0; h < ARRAY_SIZE(object_table); h++) {
> > +		struct object_entry *e;
> > +
> > +		for (e = object_table[h]; e; e = e->next)
> > +			if (e->pack_id == id)
> > +				e->pack_id = MAX_PACK_ID;
> > +	}

<snip>

> This looks pretty straightforward. I do notice that we never shrink the
> number of items in the object table when checkpointing, and so our
> linear walk will grow ever larger. So if one were to checkpoint every
> k-th object, it makes the whole operation quadratic in the number of
> objects (actually, O(n^2/k) but k is a constant).

Good point, I'll work on a separate patch to fix it.

> That's probably OK in practice, as I think the actual pack-write already
> does a linear walk of the object table to generate the pack index. So
> presumably nobody checkpoints often enough for it to be a problem. And
> the solution would be to keep a separate list of pointers to objects for
> the current pack-id, which would trivially fix both this case and the
> one in create_index().  So we can punt on it until somebody actually
> runs into it, I think.

I might checkpoint that much and run into the problem soon :)
Too tired now; maybe in a day or two I'll be able to make sense
of C again :x
