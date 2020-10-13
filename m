Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC4C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 21:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3959821582
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 21:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bfvqy38V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgJMVOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 17:14:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61025 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgJMVOI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 17:14:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3C9E74263;
        Tue, 13 Oct 2020 17:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MNURWrg3FDUWDTnldLjktvqDPz8=; b=bfvqy3
        8VWnLidIuQMDMz5WverczuLNhk4Vay9o012R7+wrEmpZfHKdPb3OGdlB6yy9y9lh
        KQLQhUbd+Nh+USVGw2MZvQhQXrotFUsckmKaMUTcp3Cc0zR1oXVa6F8DLK09660l
        l5nrrtY0Gdk1Nkg6pu2WRC0wGl0lQqhy1hSfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xRVK3tSObUL9LHOLbzn4EDERlt2TdBrE
        qF7rBYvbp5UR9334suazhCNVByeyDnYQX0hO5Rc6eAN1AuUbt4FtCnPcK3SZsqo6
        witg1rbOYr/g5fV3rgo2m8CGWI4TKR224PDvkLGPdvnPh7h3aR1mBRt8k5PuzHcD
        QY5Q4Ftwrfc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA8E874261;
        Tue, 13 Oct 2020 17:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D2D917425F;
        Tue, 13 Oct 2020 17:14:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sean McAllister <smcallis@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, masayasuzuki@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
References: <20201013191729.2524700-1-smcallis@google.com>
        <20201013191729.2524700-3-smcallis@google.com>
Date:   Tue, 13 Oct 2020 14:14:04 -0700
In-Reply-To: <20201013191729.2524700-3-smcallis@google.com> (Sean McAllister's
        message of "Tue, 13 Oct 2020 13:17:29 -0600")
Message-ID: <xmqq362hkew3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 061FCB9E-0D99-11EB-A85D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sean McAllister <smcallis@google.com> writes:

>  test_expect_success 'partial clone using HTTP with redirect' '
> -	_NONCE=`gen_nonce` && export _NONCE &&
> +	_NONCE=$(gen_nonce) &&
>  	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
>  	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
>  	curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
>  	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server"

It also bothers me somewhat that we waste 40 seconds waiting to
complete this test, most of the time just sleeping.

Now, do we still need gen_nonce in the test library, now there is
only one or two tests, both in a single test script?

Thanks.
