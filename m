Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA208C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A9F2220E
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JPncmcqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgIQSYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:24:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65389 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgIQSYC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:24:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F85C873BB;
        Thu, 17 Sep 2020 14:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tl6HLrvkioTZpFNQCGBMn5CNbhM=; b=JPncmc
        qySMF85Q5YIcYu4yg7aB5l5zzQNey80Typ2h3kjOccQulzIbcykR+dgQ24IP+lKp
        A6FO+21FY3FBegxhlL9oe13jb+M89aui0PkYY9O/961/DNXry/ovBcpAme+H0nKO
        aDXg+HFu6mjAW3b29lqo6lmisIiEq1PkGO+qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JQzno/WFZCUF1k0Z/U2ne3VnrYCaqM1y
        0mdH+tF0BLV0Z9HZNsAKu/zCiexjJQFRSW+1kkCehd8ur/7ENyL4LJNqFEdcXHd9
        LasgSa8Cq2COCug3qZjMar2vMiT0bPq2hoohnFmEsuKdAK/JzYvFJk98jAXDDqXK
        j+iPXGSxmY0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57B26873BA;
        Thu, 17 Sep 2020 14:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C869D873B9;
        Thu, 17 Sep 2020 14:23:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
References: <cover.1599723087.git.liu.denton@gmail.com>
        <cover.1600328335.git.liu.denton@gmail.com>
        <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
Date:   Thu, 17 Sep 2020 11:23:54 -0700
In-Reply-To: <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 17 Sep 2020 00:44:13 -0700")
Message-ID: <xmqq363gs1mt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1B94DDC-F912-11EA-AEC3-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +	if (read_stdin && merge_base)
> +		die(_("--stdin and --merge-base are mutually exclusive"));
> +
> +	if (merge_base) {
> +		struct object_id oid;
> +
> +		if (opt->pending.nr != 2)
> +			die(_("--merge-base only works with two commits"));
> +
> +		diff_get_merge_base(opt, &oid);
> +		opt->pending.objects[0].item = lookup_object(the_repository, &oid);
> +	}
> +

This looks quite straight-forward.

> -	/*
> -	 * We saw two trees, ent0 and ent1.  If ent1 is uninteresting,
> -	 * swap them.
> -	 */
> -	if (ent1->item->flags & UNINTERESTING)
> -		swap = 1;
> -	oid[swap] = &ent0->item->oid;
> -	oid[1 - swap] = &ent1->item->oid;
> +	if (merge_base) {
> +		diff_get_merge_base(revs, &mb_oid);
> +		oid[0] = &mb_oid;
> +		oid[1] = &revs->pending.objects[1].item->oid;
> +	} else {
> +		int swap = 0;
> +
> +		/*
> +		 * We saw two trees, ent0 and ent1.  If ent1 is uninteresting,
> +		 * swap them.
> +		 */
> +		if (ent1->item->flags & UNINTERESTING)
> +			swap = 1;
> +		oid[swap] = &ent0->item->oid;
> +		oid[1 - swap] = &ent1->item->oid;
> +	}

It is not entirely clear why the original has to become an [else]
clause here, unlike the change we saw earlier in cmd_diff_tree().
It feels quite inconsistent.

Thanks.
