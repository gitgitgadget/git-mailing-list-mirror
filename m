Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD43C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE89610CE
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhINTgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:36:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51218 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbhINTgj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:36:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F974148941;
        Tue, 14 Sep 2021 15:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+B1KGADZAXBaYeHD23TcXlotGwgwdOIbISQiQA
        vuhmA=; b=Qixtfw6H+k/OAZ0ZA6YNBJd34B+kTZIaUqMNPslUHy2ii2L9VY+z9V
        2Tgv4DDn9AlG9cweHIIT1HGRvqbsyBEOuV2bNkkCgqXx8hZWfAC+WBkcH39y7oh7
        miMM8ZIsfRD/1QXUT3amKltAmkL7TBTBqptDKF8OGl4ADdNxd5L5c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 675C1148940;
        Tue, 14 Sep 2021 15:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B14E714893F;
        Tue, 14 Sep 2021 15:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v3 4/6] update-index: use the bulk-checkin infrastructure
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
        <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
        <6b5760389863d86fc15c69cfb31bafce5ad636e1.1631590725.git.gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 12:35:17 -0700
In-Reply-To: <6b5760389863d86fc15c69cfb31bafce5ad636e1.1631590725.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Tue, 14 Sep 2021 03:38:43
        +0000")
Message-ID: <xmqqbl4v0x3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4AA8D0C-1592-11EC-A62C-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> The update-index functionality is used internally by 'git stash push' to
> setup the internal stashed commit.

Nice.

> This change enables bulk-checkin for update-index infrastructure to
> speed up adding new objects to the object database by leveraging the
> pack functionality and the new bulk-fsync functionality. This mode
> is enabled when passing paths to update-index via the --stdin flag,
> as is done by 'git stash'.
>
> There is some risk with this change, since under batch fsync, the object
> files will not be available until the update-index is entirely complete.
> This usage is unlikely, since any tool invoking update-index and
> expecting to see objects would have to snoop the output of --verbose to
> find out when update-index has actually processed a given path.
> Additionally the index is locked for the duration of the update.
>
> Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> ---
>  builtin/update-index.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 187203e8bb5..b0689f2cdf6 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -5,6 +5,7 @@
>   */
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
> +#include "bulk-checkin.h"
>  #include "config.h"
>  #include "lockfile.h"
>  #include "quote.h"
> @@ -1150,6 +1151,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		struct strbuf unquoted = STRBUF_INIT;
>  
>  		setup_work_tree();
> +		plug_bulk_checkin();
>  		while (getline_fn(&buf, stdin) != EOF) {
>  			char *p;
>  			if (!nul_term_line && buf.buf[0] == '"') {
> @@ -1164,6 +1166,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  				chmod_path(set_executable_bit, p);
>  			free(p);
>  		}
> +		unplug_bulk_checkin(&lock_file);
>  		strbuf_release(&unquoted);
>  		strbuf_release(&buf);
>  	}
