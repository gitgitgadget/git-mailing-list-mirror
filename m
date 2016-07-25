Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26B5203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbcGYWKO (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:10:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932151AbcGYWJz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 18:09:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DC2F2F9C8;
	Mon, 25 Jul 2016 18:09:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BrXNAlIJl6+olzMNLIA0U/Sfo9M=; b=SwOp2Y
	cYsKHlkEMIV0WcjDZ++aiPSTSpbKkg03a+EBnKt63zA7bh6p4mdbaMJ2yGXwX+PV
	hCrs3pLfvyTO0A7goyH7p/5QHpe3+oK3aKD4GqnQKZxE+oj8sWLju+T0qw5cse0z
	BxSyMQ/1KPKWRnDqJopjawm+Js0lf5CSTi4YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=btH7C01rmHBZhq+Vzh54bXRBzy9rp5qm
	keECOuxCwHiSTdnzIvPjdMv0z/bdIGsjMN/Gn2umK8h1HLya7otGDvqkLf5cJqMy
	FSXUkg+sB322a9iOrWzLq2jDwQFeE+M8YqSdzZUUqDxrifOwNcu+Mk+2t34QeocR
	eXRICkgohUQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2434C2F9C7;
	Mon, 25 Jul 2016 18:09:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89BFB2F9C6;
	Mon, 25 Jul 2016 18:09:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 06/16] merge_recursive: abort properly upon errors
References: <cover.1467902082.git.johannes.schindelin@gmx.de>
	<cover.1469187652.git.johannes.schindelin@gmx.de>
	<26f12ac5a5b8e722d81c782b32585531521c98d4.1469187653.git.johannes.schindelin@gmx.de>
Date:	Mon, 25 Jul 2016 15:09:51 -0700
In-Reply-To: <26f12ac5a5b8e722d81c782b32585531521c98d4.1469187653.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 22 Jul 2016 14:25:16 +0200
	(CEST)")
Message-ID: <xmqq7fc94bf4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83930856-52B4-11E6-AD57-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> There are a couple of places where return values indicating errors
> are ignored. Let's teach them manners.

That is because the return value never indicated errors before this
series, isn't it?  A true error used to be expressed by dying, and
the return value indicating "cleanliness" of the merge were
deliberately ignored.

The world order changed by previous patches in this series and the
callers need to be updated to take the new kind of return values
into account.  That is not teaching them manners ;-)

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  merge-recursive.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index dc3182b..2d4cb80 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1949,8 +1949,9 @@ int merge_recursive(struct merge_options *o,
>  		saved_b2 = o->branch2;
>  		o->branch1 = "Temporary merge branch 1";
>  		o->branch2 = "Temporary merge branch 2";
> -		merge_recursive(o, merged_common_ancestors, iter->item,
> -				NULL, &merged_common_ancestors);
> +		if (merge_recursive(o, merged_common_ancestors, iter->item,
> +				    NULL, &merged_common_ancestors) < 0)
> +			return -1;
>  		o->branch1 = saved_b1;
>  		o->branch2 = saved_b2;
>  		o->call_depth--;

This hunk feels somewhat wrong as-is.

There is a comment before the pre-context explaining why cleanness
flag is ignored.  It needs to be updated.  We still do not care
about cleanliness, i.e. 0=clean, 1=merged with conflict, but we now
can get negative values so we need to reject and return early if
this call indicates an error.

Thee other two hunks make sense.

Thanks.

> @@ -1966,6 +1967,8 @@ int merge_recursive(struct merge_options *o,
>  	o->ancestor = "merged common ancestors";
>  	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
>  			    &mrtree);
> +	if (clean < 0)
> +		return clean;
>  
>  	if (o->call_depth) {
>  		*result = make_virtual_commit(mrtree, "merged tree");
> @@ -2022,6 +2025,9 @@ int merge_recursive_generic(struct merge_options *o,
>  	hold_locked_index(lock, 1);
>  	clean = merge_recursive(o, head_commit, next_commit, ca,
>  			result);
> +	if (clean < 0)
> +		return clean;
> +
>  	if (active_cache_changed &&
>  	    write_locked_index(&the_index, lock, COMMIT_LOCK))
>  		return error(_("Unable to write index."));
