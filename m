From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: fix accidentally quadratic behavior
Date: Wed, 20 Jan 2016 20:58:21 -0800
Message-ID: <xmqq60ynzfyq.fsf@gitster.mtv.corp.google.com>
References: <1453349156-12553-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 05:58:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM7KG-000727-E4
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 05:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757489AbcAUE6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 23:58:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756680AbcAUE6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 23:58:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4824D3E6CD;
	Wed, 20 Jan 2016 23:58:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=15+rI8xBZ/JaV/A1ZVoe9x6e2pc=; b=PWk1Xe
	dA0XRzwie6cqIHnrO7dMXf56KjYSNRHh2561z5BoKhVdWdNwHdVDav1yoDwamMSu
	XjBRhO1lR2KVvMTvRaCUP+z7dt4gNR2Jo+puG2Z+StxgwUKHEmeCT6L0TQTEVvQz
	pnNYSZixbsrc++PYjaJNU7FB41A88jA7rl+NA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FS8AmAbc6QQCqFIPQj0DF1wYgi+5njdi
	rDdubvfdk/5HC7zVJsX+ZU3uHPSrMMLKg72Rme1AreQ90Gj71jVFikeMbd3huhiz
	0mDDvaXVo26kfGoCJu6ce8vOvo2++KhjRMXRM+jIwA5WT2wIVSYd8CqS6URjy2+q
	dTFdB+SsD/4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3F3633E6CC;
	Wed, 20 Jan 2016 23:58:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B1A6F3E6CB;
	Wed, 20 Jan 2016 23:58:22 -0500 (EST)
In-Reply-To: <1453349156-12553-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 20 Jan 2016 23:05:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98E3375E-BFFB-11E5-9555-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284504>

David Turner <dturner@twopensource.com> writes:

> While unpacking trees (e.g. during git checkout), when we hit a cache
> entry that's past and outside our path, we cut off iteration.
>
> This provides about a 45% speedup on git checkout between master and
> master^20000 on Twitter's monorepo.  Speedup in general will depend on
> repostitory structure, number of changes, and packfile packing
> decisions.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

I haven't thought things through, but does this get fooled by the
somewhat strange ordering rules of tree entries (i.e. a subtree
sorts as if its name is suffixed with a '/' in a tree object)?

Other than that, I like this.  "We know the list is sorted, and
after seeing this entry we know there is nothing that will match" is
an obvious optimization that we already use elsewhere.

Thanks.

>  unpack-trees.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 5f541c2..b18a611 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -695,8 +695,25 @@ static int find_cache_pos(struct traverse_info *info,
>  				++o->cache_bottom;
>  			continue;
>  		}
> -		if (!ce_in_traverse_path(ce, info))
> +		if (!ce_in_traverse_path(ce, info)) {
> +			/*
> +			 * Check if we can skip future cache checks
> +			 * (because we're already past all possible
> +			 * entries in the traverse path).
> +			 */
> +			if (info->prev && info->traverse_path) {
> +				int prefix_cmp = strncmp(ce->name, info->traverse_path, info->pathlen);
> +				if (prefix_cmp > 0)
> +					break;
> +				else if (prefix_cmp == 0 &&
> +					 ce_namelen(ce) >= info->pathlen &&
> +					 strcmp(ce->name + info->pathlen,
> +						 info->name.path) > 0) {
> +					break;
> +				}
> +			}
>  			continue;
> +		}
>  		ce_name = ce->name + pfxlen;
>  		ce_slash = strchr(ce_name, '/');
>  		if (ce_slash)
