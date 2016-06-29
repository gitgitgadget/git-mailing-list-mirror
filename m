Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D0D20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 20:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbcF2UIv (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 16:08:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751672AbcF2UIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 16:08:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F20B6280BB;
	Wed, 29 Jun 2016 16:08:21 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=865dQr2EyToADT0YaqC3vZbyurY=; b=cp8gxI
	hmV139jtkv995r2EsfGDRCPDgti8xREntcJikJh70w7iR8jM7ffTurTDca4LsYIe
	CKKDAdoTBYay1pPdkubs5NGAks23KbjQp2PRtZHjxzVotmvHeRNYb2xwzt6ecMG2
	ftWLFGy/qyoxjfJfy/zr3N7DNHMnZDYEfpICo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=woR+3Cw1knLGLMkYWAKO/pnuYFCIu6t3
	ZSU+d0ASNv8oLqU9tF3fdwukyKp71SiG86oCf5IW2MvwjMWbW15YdcR2OEf3lTLw
	tgG2XUXljZUYeAeLkNwQfijnqsx60/O9PR6ReXV/iTMRn7m9/V88M8PtME6SoLyU
	gMBmoUgR9EQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB979280BA;
	Wed, 29 Jun 2016 16:08:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7782F280B8;
	Wed, 29 Jun 2016 16:08:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 4/9] merge_recursive: abort properly upon errors
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<81a74b02ac714a4fa3734dfb774cff6dea3a3471.1467199553.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 13:08:19 -0700
In-Reply-To: <81a74b02ac714a4fa3734dfb774cff6dea3a3471.1467199553.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 13:36:51 +0200
	(CEST)")
Message-ID: <xmqqvb0r3gi4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A612EF8-3E35-11E6-94F8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> There are a couple of places where return values indicating errors
> are ignored. Let's teach them manners.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  merge-recursive.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index bcb53f0..c4ece96 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1944,8 +1944,9 @@ int merge_recursive(struct merge_options *o,
>  		saved_b2 = o->branch2;
>  		o->branch1 = "Temporary merge branch 1";
>  		o->branch2 = "Temporary merge branch 2";
> -		merge_recursive(o, merged_common_ancestors, iter->item,
> -				NULL, &merged_common_ancestors);
> +		if (merge_recursive(o, merged_common_ancestors, iter->item,
> +				NULL, &merged_common_ancestors) < 0)
> +			return -1;
>  		o->branch1 = saved_b1;
>  		o->branch2 = saved_b2;
>  		o->call_depth--;

OK, this early return (and others in this patch) are only for
negative (i.e. error) cases, and "attempted a merge, resulted in
conflicts" cases are handled as before.

Which is good.

I wonder if o->branch[12] need to be restored, though.  The only
sensible thing the caller can do is to punt, but would it expect to
be able to do some error reporting based on these fields, e.g.
printf("merge of %s and %s failed", o->branch1, o->branch2) or
something?  In addition to that kind of "state restoration", we may
need to watch out for resource leaks, but I think there is none at
least these three early returns.

Thanks.

> @@ -1961,6 +1962,8 @@ int merge_recursive(struct merge_options *o,
>  	o->ancestor = "merged common ancestors";
>  	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
>  			    &mrtree);
> +	if (clean < 0)
> +		return clean;
>  
>  	if (o->call_depth) {
>  		*result = make_virtual_commit(mrtree, "merged tree");
> @@ -2017,6 +2020,9 @@ int merge_recursive_generic(struct merge_options *o,
>  	hold_locked_index(lock, 1);
>  	clean = merge_recursive(o, head_commit, next_commit, ca,
>  			result);
> +	if (clean < 0)
> +		return clean;
> +
>  	if (active_cache_changed &&
>  	    write_locked_index(&the_index, lock, COMMIT_LOCK))
>  		return error(_("Unable to write index."));
