Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC51CE7734C
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 23:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjI2XDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjI2XDv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 19:03:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD291E5
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 16:03:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 830281B327B;
        Fri, 29 Sep 2023 19:03:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=LgdIC3Un2Ne+OWL9+cvK1XZ3qctYmW/bYeyK3I
        fx7Zs=; b=GGUxTrPOE2VbxkLWJVBlQJoiedwIUxwk2+i3TIJeGU9o04MoRjrqkd
        ybfgWSBYp9xz4mU+xDMaevV08zuuGkibFb9DXkoUR8JQbRB1dkAYgIhIx34l3our
        UHPYUQIOo81v+k46sFd5DCrlt76pykWfe+K7Fr24bk/y5Dx5OIGyE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B4EE1B327A;
        Fri, 29 Sep 2023 19:03:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E31DE1B3279;
        Fri, 29 Sep 2023 19:03:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v4 3/4] config: correct bad boolean env value error message
In-Reply-To: <e4c20a81f93e2a4e2ad65920920ead690b162e25.1696021277.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 29 Sep 2023 14:20:50 -0700")
References: <20230627195251.1973421-1-calvinwan@google.com>
        <cover.1696021277.git.jonathantanmy@google.com>
        <e4c20a81f93e2a4e2ad65920920ead690b162e25.1696021277.git.jonathantanmy@google.com>
Date:   Fri, 29 Sep 2023 16:03:44 -0700
Message-ID: <xmqqa5t4inu7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 714A7496-5F1C-11EE-A33A-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> From: Calvin Wan <calvinwan@google.com>
>
> An incorrectly defined boolean environment value would result in the
> following error message:
>
> bad boolean config value '%s' for '%s'
>
> This is a misnomer since environment value != config value. Instead of
> calling git_config_bool() to parse the environment value, mimic the
> functionality inside of git_config_bool() but with the correct error
> message.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Makes sense.

I briefly wondered if there are ways to share more code, but this
seems to be the best we can do.  The duplication is not too bad to
begin with anyway.

Looking good.  Will queue.


> diff --git a/config.c b/config.c
> index 3846a37be9..7dde0aaa02 100644
> --- a/config.c
> +++ b/config.c
> @@ -2133,7 +2133,14 @@ void git_global_config(char **user_out, char **xdg_out)
>  int git_env_bool(const char *k, int def)
>  {
>  	const char *v = getenv(k);
> -	return v ? git_config_bool(k, v) : def;
> +	int val;
> +	if (!v)
> +		return def;
> +	val = git_parse_maybe_bool(v);
> +	if (val < 0)
> +		die(_("bad boolean environment value '%s' for '%s'"),
> +		    v, k);
> +	return val;
>  }
>  
>  /*
