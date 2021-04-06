Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9E3C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 06:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44C2613BC
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 06:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhDFGO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:14:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56838 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbhDFGO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 02:14:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C81A01275D8;
        Tue,  6 Apr 2021 02:14:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0eaOhEGVkxmi3fQ7F2HVV6pP9OI=; b=PBsc1U
        ZE91uT7sWItz62qQz6yqgqXY36gZ4IzSWEGakCiOIF7y/6J38FklWuMxfurwOkQk
        5uuaYJEmayIl8nM4NK02JxhdBB9c7u9MOKkvJu92K4VZDslQEapFpfoEoRr/N/1G
        GUxojjeHXMiMVI+7UfvS/+Ojj2rHwElNGE2oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yM/uFrZRlpWDzHxDe0quf/zqpxkWPEbI
        FXfFQ/1k5JDZSKJc0zz4bT9INnH0O+x/B4tx8HBCvcnXbpOSnvP9QDUkawio9b0J
        /T0zN/npNABWLP9LbB8hCZzTmoLYqv/8HpOMbK+YfxGxS7Rqgpi1hxlqYpNQH/ff
        1eKMrKhGGOY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B15521275D7;
        Tue,  6 Apr 2021 02:14:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E9A321275D6;
        Tue,  6 Apr 2021 02:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, newren@gmail.com, ross@skydio.com,
        abe@skydio.com, brian.kubisiak@skydio.com
Subject: Re: [PATCH] git-apply: try threeway first when "--3way" is used
References: <20210406025551.25213-1-jerry@skydio.com>
Date:   Mon, 05 Apr 2021 23:14:46 -0700
In-Reply-To: <20210406025551.25213-1-jerry@skydio.com> (Jerry Zhang's message
        of "Mon, 5 Apr 2021 19:55:51 -0700")
Message-ID: <xmqq7dlg2b3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6396CD92-969F-11EB-8A4C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
> index d62db3fbe16f35a625a4a14eebb70034f695d3eb..0a7332fed5f60a8a2c9c25fc6713d513c3f0ace1 100755
> --- a/t/t4108-apply-threeway.sh
> +++ b/t/t4108-apply-threeway.sh
> @@ -160,4 +160,24 @@ test_expect_success 'apply -3 with add/add conflict (dirty working tree)' '
>  	test_cmp three.save three
>  '
>  
> +test_expect_success 'apply -3 with ambiguous repeating file' '
> +	git reset --hard &&
> +	test_write_lines 1 2 1 2 1 2 1 2 1 2 1>one_two_repeat &&

Missing SP before '>' (same issue on other redirections below).

> +	git add one_two_repeat &&
> +	git commit -m "init one" &&
> +	test_write_lines 1 2 1 2 1 2 1 2 one 2 1>one_two_repeat &&
> +	git commit -a -m "change one" &&
> +
> +	git diff HEAD~ >Repeat.diff &&
> +	git reset --hard HEAD~ &&
> +
> +	test_write_lines 1 2 1 2 1 2 one 2 1 2 one>one_two_repeat &&
> +	git commit -a -m "change surrounding one" &&
> +
> +	git apply --index --3way Repeat.diff &&
> +	test_write_lines 1 2 1 2 1 2 one 2 one 2 one>expect &&
> +
> +	test_cmp expect one_two_repeat
> +'
> +
>  test_done
