Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7770DECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 18:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiIMSUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIMST6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 14:19:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B5DDF6
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 10:32:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA58815CEE4;
        Tue, 13 Sep 2022 13:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OdIfz+6WPI55FI9w9CS7Zr2Rlt/Yw3vPqIWl8k
        5sB7I=; b=AU03NDCMGbsMhRoTl+6f4Ory7fLhgvfPjlv6jT43dKyBUQSmluTSyf
        dyJ7d5GUuer6gegJCONjE/UqQ/t37HR+Cnl8CydBAnzJwJ+jg3beJTTyZI+mWF0w
        4UXsNK6QZjvuM2wcYbq0a1vcWJhGxxP78v9MVh1FuIYWVyDALroB0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E038515CEE3;
        Tue, 13 Sep 2022 13:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9117515CEE2;
        Tue, 13 Sep 2022 13:32:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Diomidis Spinellis <dds@aueb.gr>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        avarab@gmail.com
Subject: Re: [PATCH v4] grep: fix multibyte regex handling under macOS
References: <20220826085815.2771102-1-dds@aueb.gr>
Date:   Tue, 13 Sep 2022 10:32:06 -0700
In-Reply-To: <20220826085815.2771102-1-dds@aueb.gr> (Diomidis Spinellis's
        message of "Fri, 26 Aug 2022 11:58:15 +0300")
Message-ID: <xmqqzgf389k9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD940120-3389-11ED-A623-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diomidis Spinellis <dds@aueb.gr> writes:

> - Fold test script into t7810-grep.sh
> - Simplify the test prerequisite evaluation

The tests certainly look better, and as v3, the build procedure
sounds OK.

> diff --git a/common-main.c b/common-main.c
> index c531372f3f..0a22861f1c 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -40,6 +40,7 @@ int main(int argc, const char **argv)
>  
>  	git_resolve_executable_dir(argv[0]);
>  
> +	setlocale(LC_CTYPE, "");
>  	git_setup_gettext();
>  
>  	initialize_the_repository();
> ...
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 58d7708296..c6fa3c7469 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -212,6 +212,7 @@
>  #endif
>  #include <errno.h>
>  #include <limits.h>
> +#include <locale.h>
>  #ifdef NEEDS_SYS_PARAM_H
>  #include <sys/param.h>
>  #endif

I'll let others more familiar with the locale support to comment on
these changes.  We are unconditionally including <locale.h> now;
platforms that lack <locale.h> could set NO_GETTEXT to work it
around before this change, but that will no longer work.

I do not know if thta is a practical downside to anybody, but it
could be a problem.

Perhaps cook this in 'next' and see if anybody screams?

Thanks.
