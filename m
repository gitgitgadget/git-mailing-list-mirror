Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F200FC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE0E20409
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BAuhcIkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfLKRR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:17:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52581 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfLKRR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 12:17:28 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 523B492BCC;
        Wed, 11 Dec 2019 12:17:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wBR99JbDqBaw5LP6v8LVzDwMjBA=; b=BAuhcI
        kU6X5y6znQ69cBsk6LkX3x2YdfdXyBOJFGmR1tqiUg73jXhvVmfs1D7iNXJi1YET
        Lu27OGJlQo81+VBptJ1VH17acqVWAXcy5mjW155+R0WR8T9z5+lSEuGhLmTuzIn9
        mnTsTucDm2yqj4/Cj30eABOjAjV2XApYGNaPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L+kNNmviipuDYY0N5GmgSnPDwWlQHJg2
        J4xOsxXHTbRSXaBuWuHZNbTf34c3aAl1OmvjUqo0MkFzDdU6ov2aN1G1AX1JuxVh
        kFBoQcc20fq4tutoDtE/0lVH3nciqZOZYmYJEEb2RJQz4Ktz41+OpHA4tj3lmgvz
        SIA+PAZDEjY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BA8E92BCB;
        Wed, 11 Dec 2019 12:17:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6708F92BCA;
        Wed, 11 Dec 2019 12:17:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Outreachy] [PATCH v2] bisect--helper: avoid free-after-use
References: <20191209103923.21659-1-mirucam@gmail.com>
Date:   Wed, 11 Dec 2019 09:17:21 -0800
In-Reply-To: <20191209103923.21659-1-mirucam@gmail.com> (Miriam Rubio's
        message of "Mon, 9 Dec 2019 11:39:23 +0100")
Message-ID: <xmqqo8wepyse.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1895FF06-1C3A-11EA-9244-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> From: Tanushree Tumane <tanushreetumane@gmail.com>
>
> In 5e82c3dd22a (bisect--helper: `bisect_reset` shell function in C,
> 2019-01-02), the `git bisect reset` subcommand was ported to C. When the
> call to `git checkout` failed, an error message was reported to the
> user.
>
> However, this error message used the `strbuf` that had just been
> released already. Let's switch that around: first use it, then release
> it.
>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
> This patch is a new version of
> https://public-inbox.org/git/20191208172813.16518-1-mirucam@gmail.com/
> which itself has been sent previously by Tanushree
> (https://public-inbox.org/git/64117cde718f0d56ebfa4c30f4d8fe2155f5cf65.1551003074.git.gitgitgadget@gmail.com/).
>
>  builtin/bisect--helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1fbe156e67..3055b2bb50 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -169,11 +169,12 @@ static int bisect_reset(const char *commit)
>  
>  		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
>  		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +			error(_("could not check out original"
> +				" HEAD '%s'. Try 'git bisect"
> +				" reset <commit>'."), branch.buf);
>  			strbuf_release(&branch);
>  			argv_array_clear(&argv);
> -			return error(_("could not check out original"
> -				       " HEAD '%s'. Try 'git bisect"
> -				       " reset <commit>'."), branch.buf);

The original obviously was bad X-<.  Will queue.  Thanks.

> +			return -1;
>  		}
>  		argv_array_clear(&argv);
>  	}
