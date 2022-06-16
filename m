Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A67FC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 04:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358245AbiFPEzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiFPEzk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 00:55:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD54427DE
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 21:55:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2A381AB052;
        Thu, 16 Jun 2022 00:55:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rUZPNhSpKbIyKr/pOfzHyi+q5eb3lIW11yFxmE
        rw0o0=; b=lcq5CC56HRkQZUd2PpSiQZfFT9aBPoFzmvEJZqGp7ROz9YdEwf7b4t
        ZfYiHFElPH22pbUQ/YU1VgGzLmntMwvdvwr7orSdNrU9A0wXCk75MfbtTVobgmqu
        YMFrn1deX9nXNv9FSyjU/20Jw0MpAFAp50r8K4+6fVcvLmnwIiJ4Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B94B41AB051;
        Thu, 16 Jun 2022 00:55:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 531371AB050;
        Thu, 16 Jun 2022 00:55:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 07/11] submodule--helper: avoid memory leak when
 fetching submodules
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <ad3f23a9f0c2c92ac95406fcadc51eec1a9861ff.1655336146.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 21:55:35 -0700
In-Reply-To: <ad3f23a9f0c2c92ac95406fcadc51eec1a9861ff.1655336146.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 15 Jun 2022
        23:35:41 +0000")
Message-ID: <xmqqedzpw6k8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F825140-ED30-11EC-9CF2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In c51f8f94e5b3 (submodule--helper: run update procedures from C,
> 2021-08-24), we added code that first obtains the default remote, and
> then adds that to a `strvec`.
>
> However, we never released the default remote's memory.
>
> Reported by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/submodule--helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d7b8004b933..9a8248ffe6a 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2208,6 +2208,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
>  		char *hex = oid_to_hex(oid);
>  		char *remote = get_default_remote();
>  		strvec_pushl(&cp.args, remote, hex, NULL);
> +		free(remote);

Trivially correct.  Will queue.

>  	}
>  
>  	return run_command(&cp);
