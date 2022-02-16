Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03427C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 17:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiBPRPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:15:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbiBPRPY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 12:15:24 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E972A7970
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 09:15:11 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68A9917B3D2;
        Wed, 16 Feb 2022 12:15:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tyTO5flXmT+b/M5SfDgq9UIAp6HjgVirCE7thu
        JbN6E=; b=D4tv2Ec9PQO4Kj2y6SUF+nP+QYibwN0tOmHPcAeYn7TrWfGaJOcwuk
        JhwZNXgW27rol6cMIdITLml1yacjaxOHNN79hdPuJP443VvbbcUsT0Ky/y5EJ8WV
        8pXgZNoTyUUAG+LBJSbPiylPT5gFyYRmxtYPvWOKE5qC9rFIeCTug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6072D17B3D0;
        Wed, 16 Feb 2022 12:15:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 683DF17B3CF;
        Wed, 16 Feb 2022 12:15:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v8 4/4] cat-file: add --batch-command mode
References: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
        <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
        <8edf80574b8dd72ca8489df6e480cf6820b98070.1645023740.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 09:15:07 -0800
In-Reply-To: <8edf80574b8dd72ca8489df6e480cf6820b98070.1645023740.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Wed, 16 Feb 2022 15:02:20
        +0000")
Message-ID: <xmqqwnhuu410.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDC43382-8F4B-11EC-9B0B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/* Loop through each queued_cmd, dispatch the function, free the
> + * memory associated with line so the cmd array can be reused.
> + * Callers must set nr back to 0 in order to reuse the cmd array.
> + */

Style.

	/*
	 * Our multi-line comments look like this;
	 * slash-asterisk on the opening line and
	 * asterisk-slash on the closing line sit
	 * on their own lines.
	 */

I am not sure if that is an accurate description.  The caller does
not have to reuse the cmd array.  The only thing they have to know
about this function is that the .line member is freed after the
function is done with it, so they do not have to free the member
themselves.

As it seems that this code structure and division of responsibility
between the caller and the callee is confusing even to the author of
this code, it may make sense to make the caller responsible for
freeing.

Then the caller becomes

> +		if (!strcmp(cmd->name, "flush")) {
> +			dispatch_calls(opt, output, data, queued_cmd, nr);

			for (i = 0; i < nr; i++)
				free(queued_cmd[i].line);

> +			nr = 0;
> +			continue;
> +		}

which is not too bad.  And then we'd free the array itself at the
end ...

> ...
> +		call.line = xstrdup_or_null(p);
> +		queued_cmd[nr++] = call;
> +	}
> +
> +	if (opt->buffer_output &&
> +	    nr &&
> +	    !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0))
> +		dispatch_calls(opt, output, data, queued_cmd, nr);
> +
> +	free(queued_cmd);

... which may be easier to see what is going on.

Thanks.
