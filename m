Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A1C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588C060FE6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhIMAjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 20:39:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63133 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhIMAjw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 20:39:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C08FE0DCE;
        Sun, 12 Sep 2021 20:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0V+eLQRl7RFGk6xR/jH26RO/vpsTfza7bB4qQc
        C3KP0=; b=yej4wtzPB5/qIOOe4Q/3AjHToMFXJrIMrVdIiQQ30t/aATGV4YL/wz
        yKZK2C6qXnHKlBE7Y6xXOZ1wJjJHgoADZ4oGu3DpTLwcxBtvv6y5lorXXOp+xOGk
        mmXvbRgHKrPgapX4l1p5RteVH/heA4ZVBRXQZxEp5cq+hf3VcQ780=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43654E0DCD;
        Sun, 12 Sep 2021 20:38:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C40E4E0DCB;
        Sun, 12 Sep 2021 20:38:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/4] midx.c: respect 'pack.writeBitmapHashcache' when
 writing bitmaps
References: <cover.1631049462.git.me@ttaylorr.com>
        <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
Date:   Sun, 12 Sep 2021 17:38:36 -0700
In-Reply-To: <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 7 Sep 2021 17:18:01 -0400")
Message-ID: <xmqqee9tia2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEBDDED4-142A-11EC-8EE0-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +static int git_multi_pack_index_write_config(const char *var, const char *value,
> +					     void *cb)
> +{
> +	if (!strcmp(var, "pack.writebitmaphashcache")) {
> +		if (git_config_bool(var, value))
> +			opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
> +		else
> +			opts.flags &= ~MIDX_WRITE_BITMAP_HASH_CACHE;
> +	}
> +
> +	/*
> +	 * No need to fall-back to 'git_default_config', since this was already
> +	 * called in 'cmd_multi_pack_index()'.
> +	 */

It's probably not just "No need to", but calling default_config() or
any "more generic" config this late is a wrong pattern, as the one
that was already called in the caller may have been overridden by
the command line options parser, and calling "more generic" config
callback after that would be a no-no.  So I think this should read
"we should never make a fall-back call to ...", instead.

Granted, cmd_multi_pack_index() only uses default_config(), and what
it sets will not be overridden by the command line argument parser
of the multi-pack-index command, so it is not a problem yet, but if
we ever introduce configuration variables that are applicable to
multiple subcommands of multi-pack-index, this distinction may start
to matter.

Unless a Git subcommand cannot work with just a single call to
git_config() with a callback upfront, I actually think it may be
better for them to issue a more pointed git_config_get_*() on the
variables they are interested in, never making a separate call to
git_config().

But that can be left for the future.
