From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/4] format-patch: add '--base' option to record base tree info
Date: Fri, 22 Apr 2016 14:52:26 -0700
Message-ID: <xmqqoa91nwf9.fsf@gitster.mtv.corp.google.com>
References: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
	<1461303756-25975-3-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 23:52:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atj06-0001JX-P3
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 23:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbcDVVwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 17:52:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751609AbcDVVwa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 17:52:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3BE2163DE;
	Fri, 22 Apr 2016 17:52:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PvYPKpoi7AjO12QCpDy4C6MurjY=; b=riEi47
	F901k+wJXipg0Rk7pPv9EgALXA5WQXE2DHI3UUs6eElT2/hXxuff9ZgSmfafQfbe
	6FDMoAl+1djg/3neFJJFr/k1GOW+kWwR8E2AuYU0P2tHLsctkPNecKkB8rM5IecZ
	lTExyAHqPy3fc2/1bjqF9vMUV/wws3oqC8eYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pFcmFsko9G2WBwF9B9hyGbSTnkbmLhTI
	Z+bpxovkt/3WVNrUgKRkpxB3P+qIet+RUGIF2wMY9Vmp8B8ZjTHsV0o3K2FZO0Xi
	pxpPko4BYACBa8xm+/eklk6xiOe1PWfEj5XfoZLq32H3y0MlkQENgIelC1awNXgx
	Bj8rS9zOK3E=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B91E4163DD;
	Fri, 22 Apr 2016 17:52:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F4C0163DC;
	Fri, 22 Apr 2016 17:52:28 -0400 (EDT)
In-Reply-To: <1461303756-25975-3-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Fri, 22 Apr 2016 13:42:34 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8193646C-08D4-11E6-B700-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292268>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

> +static struct commit *get_base_commit(const char *base_commit,
> +				      struct commit **list,
> +				      int total)
> +{
> +	struct commit *base = NULL;
> +	struct commit **rev;
> +	int i = 0, rev_nr = 0;
> +
> +	base = lookup_commit_reference_by_name(base_commit);
> +	if (!base)
> +		die(_("Unknown commit %s"), base_commit);
> +
> +	ALLOC_ARRAY(rev, total);
> +	for (i = 0; i < total; i++)
> +		rev[i] = list[i];
> +
> +	rev_nr = total;
> +	/*
> +	 * Get merge base through pair-wise computations
> +	 * and store it in rev[0].
> +	 */
> +	while (rev_nr > 1) {
> +		for (i = 0; i < rev_nr / 2; i++) {
> +			struct commit_list *merge_base;
> +			merge_base = get_merge_bases(rev[2 * i], rev[2 * i + 1]);
> +			if (!merge_base || merge_base->next)
> +				die(_("Failed to find exact merge base"));
> +
> +			rev[i] = merge_base->item;
> +		}

So merge-base(0,1) is stored in rev[0], merge-base(2,3) is then
stored in rev[1], etc. and the last item, if rev_nr is odd, is left
in rev[rev_nr-1].  When the loop finishes, i is left as rev_nr/2
and...

> +		if (rev_nr % 2)
> +			rev[i] = rev[2 * i];

... when rev_nr is odd, that left-over thing moved down here.
E.g. if rev_nr == 5, the loop is left with i==2, rev[0] and rev[1]
are filled with pairwise merge bases, and this moves rev[4] to
rev[2], so that we can further process rev[0,1,2] with rev_nr set to
3 (i.e. (rev_nr + 1) / 2 below).

Sounds correct.

> +		rev_nr = (rev_nr + 1) / 2;
> +	}
> +
> +	if (!in_merge_bases(base, rev[0]))
> +		die(_("base commit should be the ancestor of revision list"));
> +
> +	for (i = 0; i < total; i++) {
> +		if (base == list[i])
> +			die(_("base commit shouldn't be in revision list"));
> +	}
> +
> +	free(rev);
> +	return base;
> +}
