Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416B4C49361
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C6661351
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhFPIod (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 04:44:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50145 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhFPIod (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 04:44:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1BFD1145B8A;
        Wed, 16 Jun 2021 04:42:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PAFssFhg8kDacv+jF2gSJVlIZOTTw+/iCGfkHi
        BNUWc=; b=i2JHi7DDCrfwMMWRp0rpMi9kh+zyYPcR/ht6diTkP6bnQ8v6gRauM4
        2z0kemmfKarD1tGyvKlIxna6qwKEMt/V6opG63KCXmr+IpMcDB+cXVIuX0XsM7DZ
        loZ4PdxFwtXWQohzvISyEnH8tSpzMWY3uz+ZrVvrcR/fVwF6SMbEQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14D68145B89;
        Wed, 16 Jun 2021 04:42:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8639D145B88;
        Wed, 16 Jun 2021 04:42:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v5] tr2: log parent process name
References: <20210608221059.1935021-1-emilyshaffer@google.com>
Date:   Wed, 16 Jun 2021 17:42:22 +0900
In-Reply-To: <20210608221059.1935021-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Tue, 8 Jun 2021 15:10:59 -0700")
Message-ID: <xmqqo8c6p5e9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5DBB71C-CE7E-11EB-AD47-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

Other than your back-and-forth with Randall on NonStop specifics
that didn't result in any code change, there was no comment on this
patch.  Are other people totally happy with this version, or are
they totally uninterested?

> +	if (reason == TRACE2_PROCESS_INFO_STARTUP) {
> +		/*
> +		 * NEEDSWORK: we could do the entire ptree in an array instead,
> +		 * see compat/win32/trace2_win32_process_info.c.
> +		 */
> +		struct strvec names = STRVEC_INIT;
> +
> +		get_ancestry_names(&names);
> +
> +		if (names.nr == 0) {
>
> +			strvec_clear(&names);
> +			return;
> +		}
>
> +		trace2_cmd_ancestry(names.v);
> +
> +		strvec_clear(&names);


Micronit.  CodingGuidelines tells us not to explicitly compare with
constant 0, '\0', or NULL.  It may be more concise and easier to
follow if written like this:

		get_ancestry_names(&names);
		if (names.nr)
			trace2_cmd_ancestry(names.v);
		strvec_clear(&names);


Thanks.
