Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9554CC433E6
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB1F23AA1
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbhAVWW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:22:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60539 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbhAVWWB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 17:22:01 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E912795227;
        Fri, 22 Jan 2021 17:21:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ggDxbjgVeUqCszbcmse86Lj5yak=; b=wno2Ra
        sdGoiSXoKiSPFbUizAxSOVg2cQSB5nHla4vFd00IZl4JNhiFQfcdAnV5sHlAsnZR
        YYdU1U039Wv2T5WK+VGiYpoAD67tna9wSXhyUUcX1jH3XCiYsOgSoI2hSMHVZ6Wv
        we64bq0ae1cV/Fve3gNsunP+PdfDozcI40uA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qP81rjSoStKILMPXOgVsY9gZ855S0mpD
        kVD/GLh8q/zURhL1UBtC9rIUEhazh2vQDrmjCsLhf6h427XW2xRNDC+zU66ntJi2
        6Chuk5TElSgWDurkMlzT605F9b8CMPCvDKtvYXKSRYcdRedHmZOrpnEkQ5sOdPa6
        SuZTX+CdcNM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE98495226;
        Fri, 22 Jan 2021 17:21:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FC0695225;
        Fri, 22 Jan 2021 17:21:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Vosmaer <jacob@gitlab.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] run-command: document use_shell option
References: <20210122142137.21161-1-jacob@gitlab.com>
        <20210122142137.21161-2-jacob@gitlab.com>
        <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
        <YAs9pTBsdskC8CPN@coredump.intra.peff.net>
Date:   Fri, 22 Jan 2021 14:21:15 -0800
In-Reply-To: <YAs9pTBsdskC8CPN@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 22 Jan 2021 16:03:33 -0500")
Message-ID: <xmqqzh1062as.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24D2C896-5D00-11EB-A0F7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/run-command.h b/run-command.h
> index 6472b38bde..d08414a92e 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -126,8 +126,15 @@ struct child_process {
>  	 */
>  	unsigned silent_exec_failure:1;
>  
> -	unsigned stdout_to_stderr:1;
> +	/**
> +	 * Run the command from argv[0] using a shell (but note that we may
> +	 * still optimize out the shell call if the command contains no
> +	 * metacharacters). Note that further arguments to the command in
> +	 * argv[1], etc, do not need to be shell-quoted.
> +	 */
>  	unsigned use_shell:1;
> +
> +	unsigned stdout_to_stderr:1;

Reads well.  Thanks.

It is curious why "diff" chose to move stdout_to_stderr line around,
though.

>  	unsigned clean_on_exit:1;
>  	unsigned wait_after_clean:1;
>  	void (*clean_on_exit_handler)(struct child_process *process);
