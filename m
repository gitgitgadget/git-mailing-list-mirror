Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA221F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 05:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKSF7s (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 00:59:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51914 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfKSF7r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 00:59:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7697B8D71B;
        Tue, 19 Nov 2019 00:59:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QmjJyM8A7Gv+S50wVRXs3HROT64=; b=c0gIBU
        dNGI1VbxGpUKzNEENQz8oyoItTI1qkONOG/kePjQz8ozZKNV7jJwVwYEPGMVS2Xq
        JLlF8JKUf0aX7eCkNTfGN1C3DhN0J1p8CDIuEkOW+9qx/kp/ZdgYz043/FLVWmK3
        vAKifs481BOcu8gfCUIokW9rCcFhEXFGtUp7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BH1unkeEy3eZy1srxAPUVd0yGQYS5pZ+
        566IB+EkkdlXYQyEbrKcz3+Crl7P8cg4e44oe97KRxzrvQeJUyR8UV+opsnmFx2f
        9KDIjZcc/7ymdxShlzK4GG1kbh9il8h0Cr62N70JkYQHL2j3xWZvaENVdqtAPoUf
        rUa1jKZbJGs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D2FC8D719;
        Tue, 19 Nov 2019 00:59:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 98BE38D718;
        Tue, 19 Nov 2019 00:59:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 2/6] pathspec: add new function to parse file
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
        <96697ba0724caee556f21ada3959c4190d80c0b9.1573055478.git.gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 14:59:40 +0900
In-Reply-To: <96697ba0724caee556f21ada3959c4190d80c0b9.1573055478.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Wed, 06 Nov 2019
        15:51:14 +0000")
Message-ID: <xmqqzhgsxv77.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7C67FC4-0A91-11EA-9B08-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
> +			 unsigned flags, const char *prefix,
> +			 const char *file, int nul_term_line)
> +{
> +	struct argv_array parsed_file = ARGV_ARRAY_INIT;
> +	strbuf_getline_fn getline_fn = nul_term_line ? strbuf_getline_nul :
> +						       strbuf_getline;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf unquoted = STRBUF_INIT;
> +	FILE *in = NULL;

Useless initialization to NULL can be dropped here.

> +	if (!strcmp(file, "-"))
> +		in = stdin;
> +	else
> +		in = xfopen(file, "r");
