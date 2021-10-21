Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658E1C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7E46101C
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhJVABA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 20:01:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54449 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJVABA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 20:01:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91F20163F5D;
        Thu, 21 Oct 2021 19:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0LkJ9QezXWyP
        S/0Uu0SpE9CUcM7O2sGE8icYYuyYIUo=; b=Hcf30JYd0N+ZMW2nSK7t90FAKOUn
        vIlhQzC42pbatIASL3YXht+7NtSiIaXEq0Upc0GdiK97GN/ZANTs1siLBdSSQc6O
        Fu/QVyHLb9C4cqaqe9pTxIl77vptsLqRdK1+Ff3KTzIpOajtbFlbiE+NhM5yCuq7
        PJXsLoiK+e9fVas=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A8F7163F5C;
        Thu, 21 Oct 2021 19:58:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B852D163F5B;
        Thu, 21 Oct 2021 19:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/6] grep: use object_array_clear() in cmd_grep()
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
        <patch-2.6-727fdb27a2a-20211021T155529Z-avarab@gmail.com>
Date:   Thu, 21 Oct 2021 16:58:39 -0700
In-Reply-To: <patch-2.6-727fdb27a2a-20211021T155529Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Oct
 2021 17:57:33 +0200")
Message-ID: <xmqqmtn2exqo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0B1A01A-32CA-11EC-84C1-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Free the "struct object_array" before exiting. This makes grep tests
> (e.g.  "t7815-grep-binary.sh") a bit happer under SANITIZE=3Dleak.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/grep.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index fd184c182a3..555b2ab6008 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1196,6 +1196,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>  		run_pager(&opt, prefix);
>  	clear_pathspec(&pathspec);
>  	free_grep_patterns(&opt);
> +	object_array_clear(&list);
>  	free_repos();
>  	return !hit;
>  }

Not a new issue introduced by this patch, but after run_pager(), it
seems that opt.output_priv aka path_list is never cleared.  Should
this step do that, too, as the series never revisits this file?
