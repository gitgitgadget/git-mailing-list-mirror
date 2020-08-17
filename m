Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2048C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A982E20758
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dMidNsWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHQVPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:15:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64538 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgHQVPb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:15:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3260B70504;
        Mon, 17 Aug 2020 17:15:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ucQdlm5pqAzrRl/HmXoDl/XJ9PE=; b=dMidNs
        WHQQZtWx3ikAHYMHeAsKWTXwdFAj1z5NV+ywDkqT5nI0Z7CZJaMymSc2htGCDERa
        q6yXVXwy59C4UETmjVrSlkRnvGaNdjS5aLf+r19id/kvrBwDvbD7bvle6eiTPJUN
        ubOdZ2ivA7q9u0QdE5k+D42QIm366tOVL1nEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rwH+VuS1PFquGDeSWHGYG0obR/1OaBas
        b7a2FJr+hhAo1YafCvRukQNr41WEoYxoDKpENzfqZgZ5FbrZZ1QAgeRp85msOPo5
        6Ib8X2cTxediGMOfFGgEFCtNk0QmENdmSSc/3522gXVsICTOpmRfO64f7ZgML0m7
        MHU6/o1e8io=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A30770501;
        Mon, 17 Aug 2020 17:15:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B072F70500;
        Mon, 17 Aug 2020 17:15:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v17 06/10] receive-pack: feed report options to post-receive
References: <20200518094039.757-1-worldhello.net@gmail.com>
        <20200815171740.6257-7-worldhello.net@gmail.com>
Date:   Mon, 17 Aug 2020 14:15:28 -0700
In-Reply-To: <20200815171740.6257-7-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sat, 15 Aug 2020 13:17:36 -0400")
Message-ID: <xmqqy2mdynwv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C68F8D44-E0CE-11EA-AA55-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 58972aa7cf..a687218167 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -777,17 +777,38 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
>  {
>  	struct receive_hook_feed_state *state = state_;
>  	struct command *cmd = state->cmd;
> +	static struct ref_push_report_options *options = NULL;

Exactly the same comment as "don't turn helper functions that can be
reused into unreusable ones by adding internal states" as one of the
previous patches applies here.

