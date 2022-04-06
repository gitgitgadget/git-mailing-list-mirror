Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E9EC4332F
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 20:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiDFUO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiDFUN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 16:13:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FC2B18B2
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 10:39:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B722C130ABA;
        Wed,  6 Apr 2022 13:39:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FgK2xMazI6ocnQOpuukCK+2BY+FFJzkHyX/2I8
        fdeXk=; b=GE5+1jRZ7hUF4yRFb3zyvL5trLGkXv5eD9BflXDCKmjzK8MZxRB5jz
        Yvk15rQY7B1NhlddeLrxVeOarprrTx5XxTZsoGv+IYlGlbwibrpnzYb4s6/8yKro
        cNB3J9OLMtkaWipY5IbwWC4vjybQAW2gw0+j+r8LPoV2o0TCiGH7k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD520130AB9;
        Wed,  6 Apr 2022 13:39:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D3329130AB8;
        Wed,  6 Apr 2022 13:39:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [BUG] git-2.36.0-rc0 - t6200 fails due to library/path issues
References: <041601d849a8$1441ce60$3cc56b20$@nexbridge.com>
Date:   Wed, 06 Apr 2022 10:39:04 -0700
In-Reply-To: <041601d849a8$1441ce60$3cc56b20$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Wed, 6 Apr 2022 07:18:39 -0400")
Message-ID: <xmqq35iqyuvb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74C9E4FE-B5D0-11EC-A7C8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> t6200 makes assumptions that ssh-keygen to be used is located in
> /usr/local/bin. This causes problems when we have multiple OpenSSL
> installations - which we do - 3 of them. Our environment supplies OpenSSL
> 1.1 in /usr/local-ssl1.1, with a corresponding version of ssh-agent in a
> different directory. There needs to be a mechanism to override the
> ssh-keygen so that tests will work in this situation.
>
> *** RLD ERROR ***: Unresolved Text Symbol OPENSSL_add_all_algorithms_noconf
> in file /usr/local/bin/ssh-keygen.
>
> *** RLD ERROR ***: Unresolved Text Symbol EVP_MD_CTX_cleanup in file
> /usr/local/bin/ssh-keygen.
>
> *** RLD ERROR ***: Unresolved Text Symbol SSLeay in file
> /usr/local/bin/ssh-keygen.
>
> *** RLD ERROR ***: Unresolved Text Symbol EVP_MD_block_size in file
> /usr/local/bin/ssh-keygen.
>
> *** RLD ERROR ***: Unresolved Text Symbol EVP_MD_CTX_init in file
> /usr/local/bin/ssh-keygen.
>
> I do not know why the test is forcing SSH in /usr/local/bin - it is not
> something coming from our environment, which has PATH set correctly.

Indeed that is curious, as the only hits to usr/local in t/ is this one:

    $ git grep usr/local t/
    t/test-lib.sh:test FreeBSD != $uname_s || GIT_UNZIP=${GIT_UNZIP:-/usr/local/bin/unzip}

