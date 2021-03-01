Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C141C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24E560200
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbhCAShV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 13:37:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50375 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbhCASfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 13:35:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB71FAB152;
        Mon,  1 Mar 2021 13:34:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0FWUyLDgdqdZFZJ5JP3Pmhb+LNw=; b=BSywgF
        UIHSA8JrXVdv1IUSI7wYT87LD7VnKQVmLMPPo+MsrGdL3RGcf/huhvb6lZZb6+9u
        /3dce9m0DYVoEHBAO87g0njVVLxZYeSr1ZIT34ZGph/UZm81JjnwkDrUPtu1OZPb
        Mfr4GgL2ECW/QH6woiWbSDYoJ/CbqBYonuxWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NZDctHFunyRHldBmTxUNu9jooEgfhO2b
        xf2aOJh4gpKsDCfNy/+l9yXPIp7+atw3DY2S6hBXDwm37AX+cBiZBcu9NZtDR/k3
        01i6rf0L/CfbVVIFrrFiM7kOAYA89+4cUtppNxiFIB34+/3lSqnKgkvlA3i8c5H0
        X6ynRbiK75Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B26FCAB151;
        Mon,  1 Mar 2021 13:34:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D84FAB150;
        Mon,  1 Mar 2021 13:34:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210301084512.27170-3-charvi077@gmail.com>
Date:   Mon, 01 Mar 2021 10:34:25 -0800
In-Reply-To: <20210301084512.27170-3-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Mon, 1 Mar 2021 14:15:10 +0530")
Message-ID: <xmqqlfb6radq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C03E431C-7ABC-11EB-A3B3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> +static int prepare_amend_commit(struct commit *commit, struct strbuf *sb,
> +								 struct pretty_print_context *ctx) {

Why does this need to be overly indented?  Are you using some funny
tab width settings?  In this project, a tab stop is 8-spaces wide.

> +		/*
> +		 * Only `-m` commit message option is checked here, as
> +		 * it supports `--fixup` to append the commit message.

As it is OK to use "-m" with the plain vanilla "--fixup", an earlier
check did not reject the combination, but now we look at what kind
of fixup it is, and error out if it is "--fixup=amend:".  OK.

> +		 * The other commit message options `-c`/`-C`/`-F` are
> +		 * incompatible with all the forms of `--fixup` and
> +		 * have already errored out while parsing the `git commit`
> +		 * options.
> +		 */


