Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1B3C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 21:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC07961039
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 21:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhKJVwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 16:52:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64112 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhKJVwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 16:52:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8423E8C6C;
        Wed, 10 Nov 2021 16:49:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CVJ+HxlNexfxDHuI+8ThWBEU/vvs4jWblopaCi
        Sb3Bk=; b=ovd2a9l55lWhqoIZ1eRV0dIbIK+NLxXj0qSlQYUxPI9yPsivjGY/rb
        CtLE5q/G/5508KgYR06L0bQfWhHRfuayXo3h+lotFWrzdrI8JgAONUKDywajZ33M
        wBE209RjPFgoDgf434sR00xxxy9Y5W0h2hmTZZIQCa7Sz1gsDj48Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FB4AE8C6B;
        Wed, 10 Nov 2021 16:49:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D934E8C69;
        Wed, 10 Nov 2021 16:49:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
References: <xmqq4k8kzuz2.fsf@gitster.g>
        <YYtbdkLsCSFFE5io@coredump.intra.peff.net>
        <YYtgD8VT/0vuIHRX@coredump.intra.peff.net>
Date:   Wed, 10 Nov 2021 13:49:53 -0800
In-Reply-To: <YYtgD8VT/0vuIHRX@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 10 Nov 2021 01:00:47 -0500")
Message-ID: <xmqq1r3ny932.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 237C28CE-4270-11EC-97C9-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So it would be nice to have a more exact test, but without understanding
> the openssh bug, I think this is the best we can do in the meantime.

Sounds good.  We can also ensure that the key we are going to
generate here is actually usable before we leave the lazy-prereq
block, but we can leave it for another day.

Will apply.  Thanks.


>
> -- >8 --
> Subject: [PATCH] t/lib-gpg: avoid broken versions of ssh-keygen
>
> The "-Y find-principals" option of ssh-keygen seems to be broken in
> Debian's openssh-client 1:8.7p1-1, whereas it works fine in 1:8.4p1-5.
> This causes several failures for GPGSSH tests. We fulfill the
> prerequisite because generating the keys works fine, but actually
> verifying a signature causes results ranging from bogus results to
> ssh-keygen segfaulting.
>
> We can find the broken version during the prereq check by feeding it
> empty input. This should result in it complaining to stderr, but in the
> broken version it triggers the segfault, causing the GPGSSH tests to be
> skipped.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/lib-gpg.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index 1d8e5b5b7e..a3f285f515 100644
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -104,6 +104,12 @@ test_lazy_prereq GPGSSH '
>  	test $? != 127 || exit 1
>  	echo $ssh_version | grep -q "find-principals:missing signature file"
>  	test $? = 0 || exit 1;
> +
> +	# some broken versions of ssh-keygen segfault on find-principals;
> +	# avoid testing with them.
> +	ssh-keygen -Y find-principals -f /dev/null -s /dev/null
> +	test $? = 139 && exit 1
> +
>  	mkdir -p "${GNUPGHOME}" &&
>  	chmod 0700 "${GNUPGHOME}" &&
>  	(setfacl -k "${GNUPGHOME}" 2>/dev/null || true) &&
