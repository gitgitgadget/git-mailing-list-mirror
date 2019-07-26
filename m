Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ED2D1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 18:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfGZSb4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 14:31:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52110 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfGZSb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 14:31:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE2ED1678ED;
        Fri, 26 Jul 2019 14:31:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tALz+2yZE+2eMT0tpJB93mtNprk=; b=jjIC55
        yrXAIAtD6CN1RnZvxppEWdUsbAvw7qxL5Orj4kWSOPAx5ktKi87m4RpZK6o80g5n
        PkkeATIoZ9TiNMGpbrS0BiFVpEar/JTdXNDYCkC0Gsg/tMTZ+TQBQbbpLwP6ZgcX
        R6wx/i85Ae9/Yy2xAx6cFTdxtNAS1M2G/85ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fmpESl4rPCwJsVpGQWf1RzczlYdxcNBI
        lEMPmxGR3JMw4jzW7Dq6G2fMoOs5LeYTkGNrVwunqXDGEMlKLln4wpVHEjC5Rdvt
        HHTJHZTZpcirJqZcKnSQ98BicTIaTKgWXiycv3vTs5CR1xFru8NAHj0CArduG0Jc
        AVdTG3NASTM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C41271678EC;
        Fri, 26 Jul 2019 14:31:53 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 260E01678EB;
        Fri, 26 Jul 2019 14:31:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 01/20] merge-recursive: fix minor memory leak in error condition
References: <20190725174611.14802-1-newren@gmail.com>
        <20190726155258.28561-1-newren@gmail.com>
        <20190726155258.28561-2-newren@gmail.com>
Date:   Fri, 26 Jul 2019 11:31:52 -0700
In-Reply-To: <20190726155258.28561-2-newren@gmail.com> (Elijah Newren's
        message of "Fri, 26 Jul 2019 08:52:39 -0700")
Message-ID: <xmqqo91godev.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3BFDC88-AFD3-11E9-B745-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Returning before freeing the allocated buffer is suboptimal; as with
> elsewhere in the same function, make sure buf gets free'd.

I do not have a real objection to the patch text, but the above
justification does not make much sense to me.  The original code
returned an error when buf is NULL, so there is no leak returning
directly, without jumping to free_buf: label (whose only effect is
to free(buf) and return the value in ret).

The real value of this change is it may future-proof the codepath by
making sure that everybody after an error goes to the same place to
free all resources---which happens to be only buf in the current
code, but this change allows it to change in the future, where some
additional resources may have been allocated before the call to
read_object_file() and freed after free_buf: label.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 12300131fc..1163508811 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -934,9 +934,11 @@ static int update_file_flags(struct merge_options *opt,
>  		}
>  
>  		buf = read_object_file(&contents->oid, &type, &size);
> -		if (!buf)
> -			return err(opt, _("cannot read object %s '%s'"),
> -				   oid_to_hex(&contents->oid), path);
> +		if (!buf) {
> +			ret = err(opt, _("cannot read object %s '%s'"),
> +				  oid_to_hex(&contents->oid), path);
> +			goto free_buf;
> +		}
>  		if (type != OBJ_BLOB) {
>  			ret = err(opt, _("blob expected for %s '%s'"),
>  				  oid_to_hex(&contents->oid), path);
