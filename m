Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F944C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 01:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhLPBkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 20:40:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60181 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhLPBkM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 20:40:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCA58171584;
        Wed, 15 Dec 2021 20:40:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vi7xswKBRwudWBMp6bXGA9F8xgSlJ4ZPGw94y0
        x0S/o=; b=gmV8kHe3kIyzb+e8ryi8vlWKQMB6l3NbJtbE4GPM/HAQSfErt7vOJy
        yvaNvBC/55mhhCvuks1wSG0eLqfwuBrNEnaeAsTIb90YzG2EorbVaZvk3buQeleA
        7ClyTuE4efaNDgrGEO7rnjmWNkLEE1skKfBhpUBjtjvGYmyaWVDcU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5772171583;
        Wed, 15 Dec 2021 20:40:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 21B04171582;
        Wed, 15 Dec 2021 20:40:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH V5 2/2] git-apply: add --allow-empty flag
References: <20211213220327.16042-1-jerry@skydio.com>
        <20211213220327.16042-2-jerry@skydio.com>
Date:   Wed, 15 Dec 2021 17:40:06 -0800
In-Reply-To: <20211213220327.16042-2-jerry@skydio.com> (Jerry Zhang's message
        of "Mon, 13 Dec 2021 14:03:27 -0800")
Message-ID: <xmqqee6dz5s9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19C65306-5E11-11EC-8D58-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

>  t/t4126-apply-empty.sh      | 22 ++++++++++++++++++----
>  4 files changed, 30 insertions(+), 7 deletions(-)
> ...
> diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
> index ceb6a79fe0..949e284d14 100755
> --- a/t/t4126-apply-empty.sh
> +++ b/t/t4126-apply-empty.sh
> @@ -7,10 +7,12 @@ test_description='apply empty'
>  test_expect_success setup '
>  	>empty &&
>  	git add empty &&
>  	test_tick &&
>  	git commit -m initial &&
> +	git commit --allow-empty -m "empty commit" &&
> +	git format-patch --always HEAD~ >empty.patch &&
>  	for i in a b c d e

When merged with anything that has ab/mark-leak-free-tests-even-more
topic, this will start breaking the tests, as it is my understanding
that "git log" family hasn't been audited and converted for leak
sanitizer.

This is sort of water under the bridge, as the other topic is
already in 'master', but come to think of it, the strategy we used
with TEST_PASSES_SANITIZE_LEAK variable was misguided.  

If the git subcommands a single test script uses were only the
subcommands that the test script wants to test, the approach to
default to "this subcommand has not been made leak sanitizer clean",
and then to add TEST_PASSES mark as we sanitize the subcommand makes
perfect sense, but most test scripts need to run git subcommands
that are *not* the focus of the test---they run them only to prepare
the scene in which the subcommands being tested are excersized.  In
such a situation (which is exactly what happens here), marking that
"right now, all the tested subcommands and also all the subcommands
that happen to be exercised to prepare fixture are clean" would
force us to flip-flop with "now we use a subcommand we didn't use in
this script before to prepare the scene, and it is not yet sanitizer
clean, so we need to unmark it", which is not quite ideal, but is
much better than forcing the contributor who is *not* working on making
these subcommands leak-sanitizer-clean to worry about such a breakage.

I am tempted to drop the "TEST_PASSES" bit from this script for now,
but I have to say that the "mark leak-free tests" topic took us in
an awkward place.  We probably want to do something a bit more fine
grained about it.

Thanks.
