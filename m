Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31384C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 17:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiG2R6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 13:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiG2R6B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 13:58:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C9089659
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:58:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2B761A22BA;
        Fri, 29 Jul 2022 13:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kzMydGQ23zQxw2t6gBDfT0C/UPX374P+aNgGo1
        PWrOk=; b=TMe9ThSlplbZ09c17nJxWx6ZY0DY/CQlEVa3r4OIx2bp23Iiip6fwQ
        ZH3H4gASdU76s09LTG3qEXgPYysxapaWYSwFQAluEUq6zfqtdKzHlg3RLgiNjwOQ
        Vpjws15Go4hFTVTdi24s3QFp3FinNfbjjgahRZKXnPH66tRBH6kDc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB1D91A22B8;
        Fri, 29 Jul 2022 13:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 581D21A22B7;
        Fri, 29 Jul 2022 13:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v5 4/6] serve: advertise object-info feature
References: <20220502170904.2770649-1-calvinwan@google.com>
        <20220728230210.2952731-5-calvinwan@google.com>
Date:   Fri, 29 Jul 2022 10:57:55 -0700
In-Reply-To: <20220728230210.2952731-5-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 28 Jul 2022 23:02:08 +0000")
Message-ID: <xmqqk07v7qe4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9B47AB2-0F67-11ED-A4EE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> In order for a client to know what object-info components a server can
> provide, advertise supported object-info features. This will allow a
> client to decide whether to query the server for object-info or fetch as
> a fallback.

OK.  Now we will no longer advertise a bare "object-info", but
"object-info=size" (and possibly in the future things other than
"size").  How would this change affect older clients who knows what
to do with "object-info" but not "object-info=<values>" yet?

> +static int object_info_advertise(struct repository *r,
> +				   struct strbuf *value)
> +{
> +	if (value)
> +		strbuf_addstr(value, "size");
> +	return 1;
> +}
> +
>  static void session_id_receive(struct repository *r,
>  			       const char *client_sid)
>  {
> @@ -132,7 +140,7 @@ static struct protocol_capability capabilities[] = {
>  	},
>  	{
>  		.name = "object-info",
> -		.advertise = always_advertise,
> +		.advertise = object_info_advertise,
>  		.command = cap_object_info,
>  	},
>  };
> diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
> index b1cfe8b7db..5a16d4259a 100755
> --- a/t/t5555-http-smart-common.sh
> +++ b/t/t5555-http-smart-common.sh
> @@ -131,7 +131,7 @@ test_expect_success 'git upload-pack --advertise-refs: v2' '
>  	fetch=shallow wait-for-done
>  	server-option
>  	object-format=$(test_oid algo)
> -	object-info
> +	object-info=size
>  	0000
>  	EOF
>  
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 1896f671cb..ebb32644e3 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -20,7 +20,7 @@ test_expect_success 'test capability advertisement' '
>  	fetch=shallow wait-for-done
>  	server-option
>  	object-format=$(test_oid algo)
> -	object-info
> +	object-info=size
>  	0000
>  	EOF
