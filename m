Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086B9C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 01:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAAD20878
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 01:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GtGCCUOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfKUBaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:30:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59038 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUBaT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 20:30:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABAFF2CF9D;
        Wed, 20 Nov 2019 20:30:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zsmrmTxBjwqXBudwf9AmEke3EHE=; b=GtGCCU
        Of1ncxRc4W5Ah0OwpVl7HHtQ25uSIDKfJP78yJDlKwlAAehtvTSOUZ2DikIKxumA
        x8SRaSSfYVNGzyAL/E/l1qm75Sn/jXVQatzgU8cBl5Hjq57cczVPzDpA/SGZ3Xqz
        g3HzS2ksBBq6Fkgf/Rwgk/7uJRMrqskM/HluM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a5LjhMneOy8IFjYEeuuXXkOdo1ifA8A7
        hhnKZWqcZYp2j/sCO7WnaJ3uH630AykMAEHXh8qu5ZmnmVZqml2kXifAMhWWvFXK
        KxFtHVcdCnjj9k0EhlhBxgSZySGxLj7Bb31keHIk5yvfNzDScA14gIXr6qaGR7Uj
        rWTK/bA4+FM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3E8C2CF9C;
        Wed, 20 Nov 2019 20:30:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D1BA2CF9B;
        Wed, 20 Nov 2019 20:30:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, predatoramigo@gmail.com
Subject: Re: [RFC PATCH v2 1/4] builtin/rebase.c: reuse loop variable
References: <20191114163549.7648-1-rybak.a.v@gmail.com>
        <20191120095238.4349-2-rybak.a.v@gmail.com>
Date:   Thu, 21 Nov 2019 10:30:16 +0900
In-Reply-To: <20191120095238.4349-2-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Wed, 20 Nov 2019 10:52:35 +0100")
Message-ID: <xmqqmucq9ftj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79CD9DA2-0BFE-11EA-896C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Variable "int i" is already defined at the top of the function
> cmd_rebase, so reuse it instead of declaring other variables, which mask
> the outer "i".

The log message must also mention the other reason why this
simplification is correct, namely, that outer "i" is dead at the
point in the code that is touched by this patch and the value is
never used in the later parts of the code (I just followed the
codepath and made sure that is the case---iow, I think this patch
is correct).

Thanks.

>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  builtin/rebase.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 4a20582e72..793cac1386 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1747,8 +1747,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (exec.nr) {
> -		int i;
> -
>  		imply_interactive(&options, "--exec");
>  
>  		strbuf_reset(&buf);
> @@ -1769,8 +1767,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (strategy_options.nr) {
> -		int i;
> -
>  		if (!options.strategy)
>  			options.strategy = "recursive";
