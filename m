Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE35C19F29
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 20:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiHAUlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 16:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiHAUlM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 16:41:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A835656B
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 13:41:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCE5E1A458D;
        Mon,  1 Aug 2022 16:41:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+zSkP9SAKbfDX77iraS88Ca+8IWVEnJ+8LrqPc
        qVqG0=; b=kbX903QOx/ZEzMQ1M10koVysKrOV1QJBuTzpHWCxzx+iQo1VL6eiJF
        YAU09ajGq6Ti87GEBWdNVNdtnnQ6/iJkbJewFW0dpDtwEzn8rm5kpzhYuUCixeIE
        6jMi2VaMO1OR3rgy3wqhxaJ6XAZZ9QoQ21NHQCg5aU7YzdjiUX3Ks=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A71191A458C;
        Mon,  1 Aug 2022 16:41:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 336301A458A;
        Mon,  1 Aug 2022 16:41:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, avarab@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 1/3] t0021: avoid grepping for a Perl-specific string
 at filter output
References: <cover.1659291025.git.matheus.bernardino@usp.br>
        <5ec95c7e696a49104322d243bee1d5f137bc8222.1659291025.git.matheus.bernardino@usp.br>
Date:   Mon, 01 Aug 2022 13:41:04 -0700
In-Reply-To: <5ec95c7e696a49104322d243bee1d5f137bc8222.1659291025.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Sun, 31 Jul 2022 15:19:48 -0300")
Message-ID: <xmqqr11zpuhr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4426556A-11DA-11ED-AB8F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> This test sets the t0021/rot13-filter.pl script as a long-running
> process filter for a git checkout command. It then expects the filter to
> fail producing a specific error message at stderr. In the following
> commits we are going to replace the script with a C test-tool helper,
> but the test currently expects the error message in a Perl-specific
> format. That is, when you call `die <msg>` in Perl, it emits
> "<msg> at - line 1." In preparation for the conversion, let's avoid the
> Perl-specific part and only grep for <msg> itself.

Sounds sane.  I am a bit surprised that we check for messages from
the external filter tool, actually, rather than messages we would
emit in response to an error by the filter tool, which ought to be
more stable no matter how the external tool expresses its failures.

But the posted change gets the job done perfectly fine, so it is OK.

Thanks.

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  t/t0021-conversion.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 1c840348bd..963b66e08c 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -735,7 +735,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
>  		rm -f debug.log &&
>  		git checkout --quiet --no-progress . 2>git-stderr.log &&
>  
> -		grep "smudge write error at" git-stderr.log &&
> +		grep "smudge write error" git-stderr.log &&
>  		test_i18ngrep "error: external filter" git-stderr.log &&
>  
>  		cat >expected.log <<-EOF &&
