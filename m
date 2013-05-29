From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] patch-ids: check modified paths before calculating diff
Date: Wed, 29 May 2013 11:08:46 -0700
Message-ID: <7vip21u09d.fsf@alter.siamese.dyndns.org>
References: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
	<20130529062007.GA11955@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Kevin Bracey <kevin@bracey.fi>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 29 20:09:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhko1-0007FR-Qk
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198Ab3E2SI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 14:08:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44302 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964986Ab3E2SI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 14:08:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4240523643;
	Wed, 29 May 2013 18:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o86DIxxtp3iSwd279M4Cz9Y2iy0=; b=fhRz2N
	IPUwjtrNE4k8PFThEedIdo2BAiSu+uoASdFjBDGsYsaM/VDUqlbskDbfg2YW1u+J
	4UqpxVWJeURa5lhztPPltCbbbrvNAEEadSnVf5oBXvnziONY+8ntBjVytTUW+HcH
	m6O9SC38roS0/JqL6XQzqvlCd5UOhXwvveoi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D7R8BmMYT+odQ9QD+iC7NmJX8C0IgP88
	hx1NjrxR6PXHgvU5Q6jIMWGMHoZ3nVTU+tgo1/N5zdhJdTTQgChiePb80qGfI5g2
	ZvLI90XKcduPOc7+B1BKMKOTI55D8NS13SMINWGUO2/rpd2I+4vUjQM1/C0uCsGp
	zkeM0aJD0JU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A51423640;
	Wed, 29 May 2013 18:08:56 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95FC92363B;
	Wed, 29 May 2013 18:08:55 +0000 (UTC)
In-Reply-To: <20130529062007.GA11955@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 29 May 2013 02:20:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3A2B812-C88A-11E2-9C72-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225857>

Jeff King <peff@peff.net> writes:

> I think such a loose patch-id could just be a hash of the filenames that
> were changed by the patch (e.g., the first 32-bits of the sha1 of the
> concatenated filenames). Computing that should be about as expensive as
> a tree-diff. Per observation 2 above, if two commits do not have the
> same loose id, we know that they cannot possibly have the same strict
> id.

Because the "strict" one already hashes the filenames, if files that
are touched by a patch is different from that of another patch, we
judge them being different.

> Then we can forget about the smaller-side and bigger-side entirely, and
> just do something like:
>
>   1. Make a sorted list (or hash table) of loose ids for one side.
>
>   2. For each commit on the other side, calculate its loose id and look
>      that up in the sorted list. If no hits, we know that there is no
>      match. For any hits, lazily calculate (and cache) the strict patch
>      id for both sides and compare as usual.
>
> In the best case, we compute no patch-ids at all. And even for the
> average case, I'd expect our lazy calculation to only have to compute a
> handful of ids.

Correct.

This has rather interesting ramifications on cherry-pick and rebase,
though.  Both command can handle changes that come from an old tree
before some paths were renamed, but strict patch-id would not spot
equivalent changes we already have in our history if our change
happened after a rename, i.e.

   Z
  /
 O---R---X---Y

where Z updates path F, R moves F to G and X changes G the same way
as Z changes F, and we are trying to cherry-pick Z on top of Y.  The
cherry-pick filter will see different patch-id for Z and X.

We will likely to notice that "patch already applied" (if using am-3
machinery) or "already up-to-date" (if using merge machinery) even
when we missed this equivalency and drop the duplicate from the
result, so it is not a big loss, but we might want to consider
removing the filename from patch-id computation, at least for the
ones we internally use and discard for revs->cherry_pick filtering.
