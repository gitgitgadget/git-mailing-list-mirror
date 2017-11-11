Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC101F42B
	for <e@80x24.org>; Sat, 11 Nov 2017 02:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754883AbdKKCNZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 21:13:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50677 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754653AbdKKCNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 21:13:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44F5B95201;
        Fri, 10 Nov 2017 21:13:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZtjyHPEIqk8DB3+zx4ArJVdBO80=; b=IGhzrf
        /7KcwoG1h2K3ZMAvqanOvyPBhbWJ6RFzDWfM7fmTv2YTuUIfAw6DNmHSoRCYdbr7
        EforOdTKq5FbIie7Pn9pJ3iDTt+PfCBd6ZRpbtYS4aJGR9moOotAbiYVkdj8uK4S
        9mwjNWn0QzGfc5U9L2xKm5iTdjcFs11BUnouw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A8188eW/lpz3K8im6AkaxP1TP2ZDLjYi
        jMFjREehnfG+bSlPR12pN06KOJqZuIJj+dd+scuxo4wWRy1Z9nIgcxMCJDRtpqBE
        exPmkqpPN/xc96rAyE4l4NRHmfXfC+eGve+I2YEch0n7EJxoec5byNuemko/2EIE
        msGJMYjXOUA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E17F95200;
        Fri, 10 Nov 2017 21:13:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B57A7951FF;
        Fri, 10 Nov 2017 21:13:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: Re: use of PWD
References: <20171107192239.6hinu235hfpwqpv6@kitenet.net>
        <20171108075336.is4awgyw53dohf7y@sigill.intra.peff.net>
Date:   Sat, 11 Nov 2017 11:13:21 +0900
In-Reply-To: <20171108075336.is4awgyw53dohf7y@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 8 Nov 2017 02:53:36 -0500")
Message-ID: <xmqqd14pef5q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4AD10E6-C685-11E7-A4D9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So totally orthogonal to your bug, I wonder if we ought to be doing:
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 057262d46e..0b76233aa7 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -530,11 +530,11 @@ void prepare_alt_odb(void)
>  	if (alt_odb_tail)
>  		return;
>  
> -	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
> -	if (!alt) alt = "";
> -
>  	alt_odb_tail = &alt_odb_list;
> -	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
> +
> +	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
> +	if (alt)
> +		link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
>  
>  	read_info_alternates(get_object_directory(), 0);
>  }
>
> to avoid hitting link_alt_odb_entries() at all when there are no
> entries.

Sounds sane.
