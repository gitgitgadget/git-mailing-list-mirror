Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BCFE1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755469AbcHSUYZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:24:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60544 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755458AbcHSUYY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:24:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F693358B2;
        Fri, 19 Aug 2016 16:24:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZMR211TpL4GQZDBA8c4Ec487fu8=; b=h0i33B
        m+kFajO01X3onxTlUhFo6NymrmJmG2Y/dhJOFz2rHRX+VZ35VE0/QmuucxL33EN5
        Ehqzh7LKOcrfqleUCiuz7/AFfwjIn+ed9aPJa6l7LnbTYfKoMu20IUAMkfpPaQkM
        KpmnyQlk2QjNTi/OzyFFLr0I7gpgapMj7effk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hxFsUEE5M8S+GrLD/HF14KgBAT3+RRzw
        niy+AhRl+vMMEGfT9zD3Kj3UqA5i5azWIWYFaeewtjLEei/LayZnAAmFoZmccZLg
        anTlik8IPXH4XmyzJ8NAT5H/cJ0n8jQ6H5t8CacifizvOwqcWLfpAOYVSWHqSHDE
        QgNcSCKAb28=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 671FC358B1;
        Fri, 19 Aug 2016 16:24:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9165358B0;
        Fri, 19 Aug 2016 16:24:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v8 6/8] submodule: refactor show_submodule_summary with helper function
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
        <20160819000031.24854-7-jacob.e.keller@intel.com>
Date:   Fri, 19 Aug 2016 13:24:20 -0700
In-Reply-To: <20160819000031.24854-7-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 18 Aug 2016 17:00:29 -0700")
Message-ID: <xmqqk2fc1p8r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA7C3E4E-664A-11E6-99DA-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> @@ -290,12 +289,6 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
>  	add_pending_object(rev, &left->object, path);
>  	add_pending_object(rev, &right->object, path);
>  	merge_bases = get_merge_bases(left, right);
> -	if (merge_bases) {
> -		if (merge_bases->item == left)
> -			*fast_forward = 1;
> -		else if (merge_bases->item == right)
> -			*fast_backward = 1;
> -	}
>  	for (list = merge_bases; list; list = list->next) {
>  		list->item->object.flags |= UNINTERESTING;
>  		add_pending_object(rev, &list->item->object,

Not a new issue with this patch, but I wonder if this commit_list is
leaking here.

> +	/*
> +	 * Warn about missing commits in the submodule project, but only if
> +	 * they aren't null.
> +	 */
> +	if ((!is_null_oid(one) && !*left) ||
> +	     (!is_null_oid(two) && !*right))
> +		message = "(commits not present)";
> +
> +	merge_bases = get_merge_bases(*left, *right);
> +	if (merge_bases) {
> +		if (merge_bases->item == *left)
> +			fast_forward = 1;
> +		else if (merge_bases->item == *right)
> +			fast_backward = 1;
> +	}

And probably merge_bases also leaks here.

It is not cheap to compute merge bases, but show_submodule_summary()
makes two calls to get_merge_bases(), one in show_submodule_header()
and then another inside prepare_submodule_summary() to compute
exactly the same set of merge bases.  We somehow need to reduce it
to just one.

