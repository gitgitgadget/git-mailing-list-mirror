Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7E1C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 07:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359154AbhKZHhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 02:37:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61069 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245483AbhKZHfV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 02:35:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2E4C16C86D;
        Fri, 26 Nov 2021 02:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=moQvCWZV6F5PUio9NiUFJcjl2cqhTOY2gj6RcE
        gTqYg=; b=PK7dpzJ2pN/QTp15Ch6xN0aIdeVuF8lKqXBrh3HVGhqhCtg7zU0elA
        EFN/CtTdyBGlOgtG/SRYf0XUQkgmfPI+ERWEmiMNPtDFXifwIfbh2RO+Kn8IYhpD
        gqUaDtIyBY80lRp28GSizumSjIVmR9dvwFo4HolwVI9hgmxIp3Itc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BD2716C86C;
        Fri, 26 Nov 2021 02:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B46DC16C86B;
        Fri, 26 Nov 2021 02:32:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/2] refs: allow skipping OID verification
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <900cea2ade9e86b135e4189070a68deea5e9b575.1637855761.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 23:32:03 -0800
In-Reply-To: <900cea2ade9e86b135e4189070a68deea5e9b575.1637855761.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 25 Nov 2021
        15:56:01 +0000")
Message-ID: <xmqqbl278j9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3FCFFA2-4E8A-11EC-A5C7-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This introduces the REF_SKIP_OID_VERIFICATION flag, which lets the ref-store
> test helper write non-existent or unparsable objects into the ref storage.

Yay.

> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 658628375c8..f5333196b07 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -452,9 +452,8 @@ test_expect_success 'the --allow-unknown-type option does not consider replaceme
>  	# Create it manually, as "git replace" will die on bogus
>  	# types.
>  	head=$(git rev-parse --verify HEAD) &&
> -	test_when_finished "rm -rf .git/refs/replace" &&
> -	mkdir -p .git/refs/replace &&
> -	echo $head >.git/refs/replace/$bogus_short_sha1 &&
> +	test_when_finished "test-tool ref-store main delete-refs 0 msg refs/replace/$bogus_short_sha1" &&
> +	test-tool ref-store main update-ref msg "refs/replace/$bogus_short_sha1" $head $ZERO_OID 1024 &&

Double yay.  Tests that are independent of backend is indeed much nicer.
