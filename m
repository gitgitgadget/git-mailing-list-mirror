From: Jeff King <peff@peff.net>
Subject: Re: [RFC] fast-import: invalidate pack_id references after loosening
Date: Wed, 25 May 2016 18:09:13 -0500
Message-ID: <20160525230913.GB2634@sigill.intra.peff.net>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
 <20160513103621.GA12329@dcvr.yhbt.net>
 <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
 <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
 <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
 <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
 <20160517121330.GA7346@sigill.intra.peff.net>
 <20160525224907.GA18894@dcvr.yhbt.net>
 <20160525225402.GB18894@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Thu May 26 01:09:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hvV-0006xt-BX
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 01:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbcEYXJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 19:09:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:44343 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752312AbcEYXJR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 19:09:17 -0400
Received: (qmail 23977 invoked by uid 102); 25 May 2016 23:09:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 19:09:16 -0400
Received: (qmail 15148 invoked by uid 107); 25 May 2016 23:09:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 19:09:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2016 18:09:13 -0500
Content-Disposition: inline
In-Reply-To: <20160525225402.GB18894@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295613>

On Wed, May 25, 2016 at 10:54:02PM +0000, Eric Wong wrote:

> When loosening a pack, the current pack_id gets reused when
> checkpointing and the import does not terminate.  This causes
> problems after checkpointing as the object table, branch, and
> tag lists still contains pre-checkpoint references to the
> recycled pack_id.
> 
> Merely clearing the object_table as suggested by Jeff King in
> http://mid.gmane.org/20160517121330.GA7346@sigill.intra.peff.net
> is insufficient as the marks set still contains references
> to object entries.
> 
> Wrong pack_id references branch and tags lists do not cause
> errors, but can lead to misleading crash reports and core dumps,
> so they are also invalidated.

Nicely explained.

> +static void invalidate_pack_id(unsigned int id)
> +{
> +	unsigned int h;
> +	unsigned long lu;
> +	struct tag *t;
> +
> +	for (h = 0; h < ARRAY_SIZE(object_table); h++) {
> +		struct object_entry *e;
> +
> +		for (e = object_table[h]; e; e = e->next)
> +			if (e->pack_id == id)
> +				e->pack_id = MAX_PACK_ID;
> +	}
> +
> +	for (lu = 0; lu < branch_table_sz; lu++) {
> +		struct branch *b;
> +
> +		for (b = branch_table[lu]; b; b = b->table_next_branch)
> +			if (b->pack_id == id)
> +				b->pack_id = MAX_PACK_ID;
> +	}
> +
> +	for (t = first_tag; t; t = t->next_tag)
> +		if (t->pack_id == id)
> +			t->pack_id = MAX_PACK_ID;
> +}

This looks pretty straightforward. I do notice that we never shrink the
number of items in the object table when checkpointing, and so our
linear walk will grow ever larger. So if one were to checkpoint every
k-th object, it makes the whole operation quadratic in the number of
objects (actually, O(n^2/k) but k is a constant).

That's probably OK in practice, as I think the actual pack-write already
does a linear walk of the object table to generate the pack index. So
presumably nobody checkpoints often enough for it to be a problem. And
the solution would be to keep a separate list of pointers to objects for
the current pack-id, which would trivially fix both this case and the
one in create_index().  So we can punt on it until somebody actually
runs into it, I think.

-Peff
