From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: do not reuse packfiles without --delta-base-offset
Date: Wed, 02 Apr 2014 10:39:13 -0700
Message-ID: <xmqqfvlvvdfi.fsf@gitster.dls.corp.google.com>
References: <20140402063916.GA1437@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:40:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeTE-0000xS-TL
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbaDBRjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 13:39:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932569AbaDBRj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 13:39:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 375A378A30;
	Wed,  2 Apr 2014 13:39:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VpGQKOYfPW+0xszHfwZXRiKrTTo=; b=ulqgTt
	zlPU6aF9epADxz0dRBU6Ddog+RZqRv/AT+Mus8ki4X7LENZhAWnt7nN2mAdgL0/m
	P9Xf/uRbzRHY5AWyxiSUr5HXq+fGFzZ6d9MMBLW4FMR2iB8JMQNNVhVgktBhRBFR
	FGS6Ut1JupiY85xxZQM/VAAzd2ZB/gGJ6qQ6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nFD8TX5+1Z/dfY55OYudUorG4bppZ8Dr
	P7VO1JtmwK1uYrO24uZzkiXVrQIghW5KB8PkdVlV8GfXcKVn0enVYkJ3cPtZdPXK
	HeZ5jDY2Sz3PP9DzNcONItwtSYuqkZg2eh7x5WMNenXUzK1sJ62w+hAeK0Tl8sMH
	TvzP9XgDTvo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 218CD78A2E;
	Wed,  2 Apr 2014 13:39:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E30BE78A09;
	Wed,  2 Apr 2014 13:39:19 -0400 (EDT)
In-Reply-To: <20140402063916.GA1437@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 2 Apr 2014 02:39:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B9122870-BA8D-11E3-85AE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245691>

Jeff King <peff@peff.net> writes:

> When we are sending a packfile to a remote, we currently try
> to reuse a whole chunk of packfile without bothering to look
> at the individual objects. This can make things like initial
> clones much lighter on the server, as we can just dump the
> packfile bytes.
>
> However, it's possible that the other side cannot read our
> packfile verbatim. For example, we may have objects stored
> as OFS_DELTA, but the client is an antique version of git
> that only understands REF_DELTA. We negotiate this
> capability over the fetch protocol. A normal pack-objects
> run will convert OFS_DELTA into REF_DELTA on the fly, but
> the "reuse pack" code path never even looks at the objects.

The above makes it sound like "reuse pack" codepath is broken. Is it
too much hassle to peek at the initial bytes of each object to see
how they are encoded? Would it be possible to convert OFS_DELTA to
REF_DELTA on the fly on that codepath as well, instead of disabling
the reuse altogether?

> This patch disables packfile reuse if the other side is
> missing any capabilities that we might have used in the
> on-disk pack. Right now the only one is OFS_DELTA, but we
> may need to expand in the future (e.g., if packv4 introduces
> new object types).
>
> We could be more thorough and only disable reuse in this
> case when we actually have an OFS_DELTA to send, but:
>
>   1. We almost always will have one, since we prefer
>      OFS_DELTA to REF_DELTA when possible. So this case
>      would almost never come up.
>
>   2. Looking through the objects defeats the purpose of the
>      optimization, which is to do as little work as possible
>      to get the bytes to the remote.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I happened to be fooling around with git v1.4.0 today, and noticed a
> problem fetching from GitHub. Pre-OFS_DELTA git versions are ancient by
> today's standard, but it's quite easy to remain compatible here, so I
> don't see why not.




 And in theory, alternate implementations might not
> understand OFS_DELTA, though in practice I would consider such an
> implementation to be pretty crappy.
>
>  builtin/pack-objects.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 7950c43..1503632 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2439,12 +2439,23 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
>  	}
>  }
>  
> +/*
> + * This tracks any options which a reader of the pack might
> + * not understand, and which would therefore prevent blind reuse
> + * of what we have on disk.
> + */
> +static int pack_options_allow_reuse(void)
> +{
> +	return allow_ofs_delta;
> +}
> +
>  static int get_object_list_from_bitmap(struct rev_info *revs)
>  {
>  	if (prepare_bitmap_walk(revs) < 0)
>  		return -1;
>  
> -	if (!reuse_partial_packfile_from_bitmap(
> +	if (pack_options_allow_reuse() &&
> +	    !reuse_partial_packfile_from_bitmap(
>  			&reuse_packfile,
>  			&reuse_packfile_objects,
>  			&reuse_packfile_offset)) {
