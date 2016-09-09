Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904841F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 20:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbcIIUKH (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 16:10:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54244 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753538AbcIIUKG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 16:10:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6F923A298;
        Fri,  9 Sep 2016 16:09:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OUmv2JX7g0UOSlFxPRG1tQzzqUc=; b=yT7aE+
        ZDWcsySjgRL8iQAlgUARBq0orfGRr7pmDBXNPok/yANe+FquKVoZCu661bBu3e/q
        Tk4qFEaIl7bA1SwN/9pO3Pki3pp5cg58dpa6DRpgVD946rKLZ2Na9He6raYexrWr
        XLRVRH756bky2SXS3xVsrNYYk3s7CYqhOvXVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WpkBfieTdcDIg24BDXC15xIJ8C6GqqPb
        dsO9oKOEk6fYXdDeOkRFL7NnQo9OJxCX+4geD+cfr34g+A9iS/G1dIDzx/7uj+mj
        7zF5cHB4WFHGDq5I66sNLmWe0jlI3NEc7UEIoj2f+m8hncrHtsLRqJ2kBZRsqd6h
        X0ibBZZ/Ti8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD8313A297;
        Fri,  9 Sep 2016 16:09:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 684873A295;
        Fri,  9 Sep 2016 16:09:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, spearce@spearce.org,
        sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v4 3/3] connect: advertized capability is not a ref
References: <cover.1473441620.git.jonathantanmy@google.com>
        <cover.1472836026.git.jonathantanmy@google.com>
        <cover.1473441620.git.jonathantanmy@google.com>
        <ac55dc281e6875df8abcc6ed06d5f258a53dd251.1473441620.git.jonathantanmy@google.com>
Date:   Fri, 09 Sep 2016 13:09:56 -0700
In-Reply-To: <ac55dc281e6875df8abcc6ed06d5f258a53dd251.1473441620.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 9 Sep 2016 10:36:30 -0700")
Message-ID: <xmqq37l8bzsb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61F054E0-76C9-11E6-9059-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Git advertises the same capabilities^{} ref in its ref advertisement for push
> but since it never did so for fetch, the client didn't need to handle this
> case. Handle it.
>
> In this aspect, JGit is compliant with the specification in pack-protocol.txt.

The last sentence somehow looks out of place.

> +	int got_dummy_ref_with_capabilities_declaration = 0;
>  
>  	*list = NULL;
>  	for (saw_response = 0; ; saw_response = 1) {
> @@ -172,8 +173,24 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  			continue;
>  		}
>  
> +		if (!strcmp(name, "capabilities^{}")) {
> +			if (saw_response)
> +				warning("protocol error: unexpected capabilities^{}, "
> +					"continuing anyway");

OK.  saw_response tells us that we saw ".have", a valid ref, or "shallow",
but "capabilities^{}" should happen before any of them, so that is a
protocol violation.  Makes perfect sense.

> +			if (got_dummy_ref_with_capabilities_declaration)
> +				warning("protocol error: multiple capabilities^{}, "
> +					"continuing anyway");
> +			got_dummy_ref_with_capabilities_declaration = 1;
> +			continue;
> +		}
> +
>  		if (!check_ref(name, flags))
>  			continue;
> +
> +		if (got_dummy_ref_with_capabilities_declaration)
> +			warning("protocol error: unexpected ref after capabilities^{}, "
> +				"using this ref and continuing anyway");

Likewise. "capabilities^{}" is used when we cannot piggyback the
capability list after a real ref, so it is unusual to see a real ref
after seeing one.  Makes perfect sense.

Do we want to abort the connection in these cases, I wonder, though?

Thanks.
