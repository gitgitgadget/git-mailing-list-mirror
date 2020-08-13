Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553E8C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 16:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC1C620774
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 16:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ggVZI0ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMQ7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:59:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51218 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMQ7P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 12:59:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EACC675B41;
        Thu, 13 Aug 2020 12:59:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7CUQtDKuAo/tbdULQ640hTG7mX8=; b=ggVZI0
        rojEH1GubMrGSOpGZjzgs0E+2mCcAO7xHJNQHnPG1xjF7VwHN8bv9CV4dQVItVzV
        R5HpRM9tSZFIGMWKEkYmISHd+7Lp1PK5ZIXsQy6Gb6eT+jZUh+FlM16FEmdssCdT
        5k78Tvx+bawXORbFnttI0dzF4cTWhHHt7RWfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jtd852z89q30wqOD+kuUYzRpRjduGSJS
        4N2diXm7g3CC5M2j6FpnzKOgeLqfgbZbeZSTaZnX3ANXxAbA+RabLcMGZlQzEZsT
        PR5VdWB1wvhfqyVSMnVbquTQu4ln3eVafJAYQcZquak2tHrjZpVQO11RG/JR24ud
        JA4N83C54Mg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E227075B40;
        Thu, 13 Aug 2020 12:59:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5916E75B3F;
        Thu, 13 Aug 2020 12:59:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Barret Rhoden <brho@google.com>, Nuthan Munaiah <nm6061@rit.edu>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] blame: only coalesce lines that are adjacent in result
References: <20200813052054.GA1962792@coredump.intra.peff.net>
        <20200813052531.GC2514880@coredump.intra.peff.net>
Date:   Thu, 13 Aug 2020 09:59:11 -0700
In-Reply-To: <20200813052531.GC2514880@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 13 Aug 2020 01:25:31 -0400")
Message-ID: <xmqq8sei4h40.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FE2DE62-DD86-11EA-896A-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/blame.c b/blame.c
> index 82fa16d658..1be1cd82a2 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -1184,6 +1184,7 @@ void blame_coalesce(struct blame_scoreboard *sb)
>  	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
>  		if (ent->suspect == next->suspect &&
>  		    ent->s_lno + ent->num_lines == next->s_lno &&
> +		    ent->lno + ent->num_lines == next->lno &&
>  		    ent->ignored == next->ignored &&
>  		    ent->unblamable == next->unblamable) {
>  			ent->num_lines += next->num_lines;

When laid out like this, the correctness of the fix is quite obvious
and it is surprising that this bug has survived for all these years,
as it dates back to cee7f245 (git-pickaxe: blame rewritten.,
2006-10-19), the inception of the current "git blame".

Thanks.

> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index 7f39a84289..ba8013b002 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -310,4 +310,13 @@ test_expect_success 'blame coalesce' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'blame does not coalesce non-adjacent result lines' '
> +	cat >expect <<-EOF &&
> +	$orig 1) ABC
> +	$orig 3) DEF
> +	EOF
> +	git blame --no-abbrev -s -L1,1 -L3,3 $split giraffe >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
