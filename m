From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] sha1_file: introduce close_one_pack() to close packs on fd pressure
Date: Thu, 01 Aug 2013 10:12:56 -0700
Message-ID: <7vsiyts5bb.fsf@alter.siamese.dyndns.org>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
	<1375300297-6744-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <peff@peff.net>, <spearce@spearce.org>,
	<sunshine@sunshineco.com>, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 19:13:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4wR0-00074x-0x
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 19:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067Ab3HARNC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 13:13:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726Ab3HARNA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 13:13:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47E2235D04;
	Thu,  1 Aug 2013 17:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uRUzxrCyI+HUN6DGVOIvF1MGzO8=; b=kOfoBq
	oNKzwuu++c057FyBWHfiCPiSKSU/K4KFYbinsQ13XqMPBYBAp97VsL2d56LKZWEO
	9cc/ybL4ElnfZL62VZdX/DqtQ8BzoSAI6IXz4+sNXhjaYnCy6pKxiklFRvkuH/Cl
	7VeMRFUMagLoP0fUTm1hbSu4jYkBBaFSkEJP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W9LnCkrucXzapkZ8ZRDSrX1YHYpunO0H
	3pHWtZROjY8nTV/5NHDOlyKNtc5WSDccL4cWh0o+sZXyILgXOt7rRZVLm1z4hQUo
	XO+Li2jx3IvAaErBB6K3JhyrILQDd15dAvAVsevseBm1h75qkB0g8edSSBcfK5tS
	mDGwvU4/WJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18B4335D03;
	Thu,  1 Aug 2013 17:12:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 510C535D01;
	Thu,  1 Aug 2013 17:12:58 +0000 (UTC)
In-Reply-To: <1375300297-6744-1-git-send-email-bcasey@nvidia.com> (Brandon
	Casey's message of "Wed, 31 Jul 2013 12:51:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D06AB4A-FACD-11E2-8FCF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231491>

Brandon Casey <bcasey@nvidia.com> writes:

> If the refs are loose, then upload-pack will read each ref from the
> pack (allocating one or more mmap windows) so it can peel tags and
> advertise the underlying object. If the refs are packed and peeled,
> then upload-pack will use the peeled sha1 in the packed-refs file and
> will not need to read from the pack files, so no mmap windows will be
> allocated and just like with receive-pack, unuse_one_window() will

Even though what it says is not incorrect, the phrasing around here,
especially "so it can", confused me in my first reading.  It reads
objects "in order to" peel and advertise (and as a side-effect it
can lead to windows into packs that eventually help relieaving the
fd pressure), but a quick scan led me to misread it as "so it can do
peel and advertise just fine", which misses the point, because it is
not like we are having trouble peeling and advertising.

Also, the objects at the tips of refs and the objects they point at
may be loose objects, which is very likely for branch tips.  The fd
pressure will not be relieved in such a case even if these refs were
packed.

I've tentatively reworded the above section like so:

    ... If the refs are loose, then upload-pack will read each ref
    from the object database (if the object is in a pack, allocating
    one or more mmap windows for it) in order to peel tags and
    advertise the underlying object.  But when the refs are packed
    and peeled, upload-pack will use the peeled sha1 in the
    packed-refs file and will not need to read from the pack files,
    so no mmap windows will be allocated ...

> +static int close_one_pack(void)
> +{
> +	struct packed_git *p, *lru_p = NULL;
> +	struct pack_window *mru_w = NULL;
> +
> +	for (p = packed_git; p; p = p->next) {
> +		if (p->pack_fd == -1)
> +			continue;
> +		find_lru_pack(p, &lru_p, &mru_w);
> +	}
> +
> +	if (lru_p) {
> +		close_pack_windows(lru_p);
> +		close(lru_p->pack_fd);
> +		pack_open_fds--;
> +		lru_p->pack_fd = -1;
> +		if (lru_p == last_found_pack)
> +			last_found_pack = NULL;
> +		return 1;
> +	}
> +
> +	return 0;
> +}

OK, so in this codepath where we know we are under fd pressure, we
find the pack that is least recently used that can be closed, and
use close_pack_windows() to reclaim all of its open windows (if
any), which takes care of the accounting for pack_mapped and
pack_open_windows, but we need to do the pack_open_fds accounting
here ourselves.  Makes sense to me.

Thanks.

>  void unuse_pack(struct pack_window **w_cursor)
>  {
>  	struct pack_window *w = *w_cursor;
> @@ -777,7 +838,7 @@ static int open_packed_git_1(struct packed_git *p)
>  			pack_max_fds = 1;
>  	}
>  
> -	while (pack_max_fds <= pack_open_fds && unuse_one_window(NULL, -1))
> +	while (pack_max_fds <= pack_open_fds && close_one_pack())
>  		; /* nothing */
>  
>  	p->pack_fd = git_open_noatime(p->pack_name);
