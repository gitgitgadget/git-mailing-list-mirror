Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550F1C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 19:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiBYTEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 14:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiBYTEB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 14:04:01 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A46182D9B
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:03:29 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2AD2818C076;
        Fri, 25 Feb 2022 14:03:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AvhmCnoZ/3xhByNsBR+rIyQrtEApawhIcB02mp
        BM62M=; b=ITrDdM2m1tSYUrCCConwub0hw1g0g1SXXmNYoVM/V2NIXD6SV5rzc3
        /l87L6qqGDe6pdysoaGeS6bSm5ZmSYDutzyaA30io7nzAqBmP5A5a+bbvR29fPoS
        OK8R4yuYRFEeIkTnSjIYWWr1P1A/IBSjXtnSgzN0pPHcULQHCUXuM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2338218C074;
        Fri, 25 Feb 2022 14:03:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7ED7918C073;
        Fri, 25 Feb 2022 14:03:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/1] xdiff: provide indirection to git functions
References: <20220217225218.GA7@edef91d97c94>
        <20220217225408.GB7@edef91d97c94>
Date:   Fri, 25 Feb 2022 11:03:25 -0800
In-Reply-To: <20220217225408.GB7@edef91d97c94> (Edward Thomson's message of
        "Thu, 17 Feb 2022 22:54:08 +0000")
Message-ID: <xmqq4k4mdb0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CA5A85A-966D-11EC-9E2C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edward Thomson <ethomson@edwardthomson.com> writes:

> Provide an indirection layer into the git-specific functionality and
> utilities in `git-xdiff.h`, prefixing those types and functions with
> `xdl_` (and `XDL_` for macros).  This allows other projects that use
> git's xdiff implementation to keep up-to-date; they can now take all the
> files _except_ `git-xdiff.h`, which they have customized for their own
> environment.

Continuing the "what do they exactly do" line of thought, the above
is not quite in line with what I heard.  They take all the files
including git-xdiff.h and they must modify git-xdiff.h to match
their environment.

In any case, ...

> diff --git a/xdiff/git-xdiff.h b/xdiff/git-xdiff.h
> new file mode 100644
> index 0000000000..664a7c1351
> --- /dev/null
> +++ b/xdiff/git-xdiff.h
> @@ -0,0 +1,16 @@
> +#ifndef GIT_XDIFF_H
> +#define GIT_XDIFF_H

... here is a good place to spell the expectation out, i.e. that
they are expected to change this file to match their system, and
that all the things they see below here (including the inclusion of
git-compat-util.h) is specific to git-core they are expected to rip
out and replace.

> +
> +#include "git-compat-util.h"
> +
> +#define xdl_malloc(x) xmalloc(x)
> +#define xdl_free(ptr) free(ptr)
> +#define xdl_realloc(ptr,x) xrealloc(ptr,x)
> +
> +#define xdl_regex_t regex_t
> +#define xdl_regmatch_t regmatch_t
> +#define xdl_regexec_buf(p, b, s, n, m, f) regexec_buf(p, b, s, n, m, f)
> +
> +#define XDL_BUG(msg) BUG(msg)
> +
> +#endif

Thanks.
