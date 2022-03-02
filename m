Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8CFC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 21:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbiCBVH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiCBVH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 16:07:27 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C475A9FEE
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 13:06:40 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 176F411DC04;
        Wed,  2 Mar 2022 16:06:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/hBdChaQvn6m
        UiV+J9kdil6z5JaUlG2EWfW8NG1+TQg=; b=rOIo7Yi+/MFQFuceYjb3iX4DXD1Q
        6RCXH19Dpg2iJ851oSLEKD+q5ZGKOKBgySdG6vlWn/HlVzTv8i0P8/Ir08ea6AOJ
        oqMUyDu8HT4xWo9STVzFCwlKvqIj7fjUCuXF5x9xswoWltiJNmdsuFgawcWYTToM
        mMF+QRX6/bPWqY4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E42411DC03;
        Wed,  2 Mar 2022 16:06:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6824011DC02;
        Wed,  2 Mar 2022 16:06:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/10] t5540: don't rely on "hook/post-update.sample"
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
        <patch-02.10-4bee939a894-20220302T131859Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 13:06:38 -0800
In-Reply-To: <patch-02.10-4bee939a894-20220302T131859Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 14:22:21
        +0100")
Message-ID: <xmqqh78gjc81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A73AD4EA-9A6C-11EC-88C7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change code added in a87679339c0 (test: rename http fetch and push
> test files, 2014-02-06) to stop relying on the "exec git
> update-server-info" in "templates/hooks--post-update.sample", let's
> instead inline the expected hook in the test itself.

For this particular hook, it indeed is a good change, as future
post-update samples we ship may have something quite different.

I do not know if it is a good idea in general, though.  We want
to promise shipping certain sample scripts as part of the default
install, and the default install is what our tests check.  We want
to keep something that ensures the default install does ship the
sample we want to include, and such tests do need to rely on the
presence of .sample files.  But this script does not need to be
the one to do so.

>  	git --bare update-server-info &&
> -	mv hooks/post-update.sample hooks/post-update &&
> +	write_script hooks/post-update <<-\EOF &&
> +	exec git update-server-info
> +	EOF
>  	ORIG_HEAD=3D$(git rev-parse --verify HEAD) &&
>  	cd - &&
>  	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"

OK.

We might want to deprecate and remove the support for dumb walkers,
but until then, this looks superb.

Thanks.

