Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D924C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 01:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6349C61106
	for <git@archiver.kernel.org>; Wed,  5 May 2021 01:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhEEBNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 21:13:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54124 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhEEBNG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 21:13:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00EC0B42BC;
        Tue,  4 May 2021 21:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rE+Ry1f4Hjufb18ckUCco2eaZOAV0ga3iDA/3A
        Z6V2M=; b=Gin4IlAR4mOD2lKEL6LODR6CZg4ws67D8ER1DSPSAW2n2CkIVDaGgU
        yz3Wx/MojDbCHSW0l0+XO2blTwr+rKmfsrA4ebrjvrRRjbdJADZ1A1qTmY4B97AH
        Y3TCU70P6+ei7Pv/CRCfnIeoZdHzcZ/s2YKJkJXepJuEbmOUWpUpw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECEE2B42BB;
        Tue,  4 May 2021 21:12:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FC64B42BA;
        Tue,  4 May 2021 21:12:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, lilinchao@oschina.cn, stolee@gmail.com
Subject: Re: [PATCH] t5601: mark protocol v2-only test
References: <20210504223455.92823-1-jonathantanmy@google.com>
Date:   Wed, 05 May 2021 10:12:08 +0900
In-Reply-To: <20210504223455.92823-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 4 May 2021 15:34:55 -0700")
Message-ID: <xmqq8s4u56hj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA4C2FA2-AD3E-11EB-A918-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> A HTTP-clone test introduced in 4fe788b1b0 ("builtin/clone.c: add
> --reject-shallow option", 2021-04-01) only works in protocol v2, but is
> not marked as such.
>
> The aforementioned patch implements --reject-shallow for a variety of
> situations, but usage of a protocol that requires a remote helper is not
> one of them. (Such an implementation would require extending the remote
> helper protocol to support the passing of a "reject shallow" option, and
> then teaching it to both protocol-speaking ends.)
>
> For now, to make it pass when GIT_TEST_PROTOCOL_VERSION=0 is passed, add
> "-c protocol.version=2". A more complete solution would be either to
> augment the remote helper protocol to support this feature or to return
> a fatal error when using --reject-shallow with a protocol that uses a
> remote helper.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I think the remote helper solution can be done by adding an "option"
> (something that can be passed using the "option" command). We have
> options for things like "from-promisor", for example. I haven't looked
> into this in detail, though.

Sounds like a good direction to go in.  In the meantime, certainly
this will work around the issue in the original test.

Will queue---thanks.


>  t/t5601-clone.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 329ae599fd..c0688467e7 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -762,7 +762,7 @@ test_expect_success 'partial clone using HTTP' '
>  test_expect_success 'reject cloning shallow repository using HTTP' '
>  	test_when_finished "rm -rf repo" &&
>  	git clone --bare --no-local --depth=1 src "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> -	test_must_fail git clone --reject-shallow $HTTPD_URL/smart/repo.git repo 2>err &&
> +	test_must_fail git -c protocol.version=2 clone --reject-shallow $HTTPD_URL/smart/repo.git repo 2>err &&
>  	test_i18ngrep -e "source repository is shallow, reject to clone." err &&
>  
>  	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo
