Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033A2C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADDD2072C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KQU+gPdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgAFTgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:36:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54441 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTgj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 14:36:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA7B7AE3B5;
        Mon,  6 Jan 2020 14:36:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AABDNmIzST07GEnb/4YqOFjDEIg=; b=KQU+gP
        dbVLMS2oJjHmNeG2ndHxzbz2fE7VA0XSKVJ9E/Sw2o/t8inX+O95nt4d3Q/qDH6m
        6ItaOPgryXDNMGJ8WLhJ9uaHnE6DnmTXKlljj88bcAorN++78wKyKqh8xOFcSZGS
        6lta32/PsFR7u913GFvLLh6ngYxKT5KtpALCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TRFOsnyg40GS0aqvNpaKU4kHtjDNzJLC
        KyJ4P2m3WDEbcbpk/dcrBB6C5DbJADZ5MVgBliP3ptnot62HLQFctSvemAR0b3eW
        aiggpnEZ9ky74BwxOK2TNJPA0cvTZp55Cm8YSbR0pC/ya4P7RJH5lUEisyijstKx
        Nuv/ejzVuyk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A30FFAE3B4;
        Mon,  6 Jan 2020 14:36:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E4657AE3B0;
        Mon,  6 Jan 2020 14:36:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] commit: refactor signature verification helpers
References: <20200105135616.19102-1-hji@dyntopia.com>
        <20200105135616.19102-4-hji@dyntopia.com>
Date:   Mon, 06 Jan 2020 11:36:32 -0800
In-Reply-To: <20200105135616.19102-4-hji@dyntopia.com> (Hans Jerry
        Illikainen's message of "Sun, 5 Jan 2020 13:56:14 +0000")
Message-ID: <xmqqtv588ji7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9370724-30BB-11EA-963D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> +static unsigned gpg_flags = GPG_VERIFY_SHORT | GPG_VERIFY_COMPAT;
>  static struct strbuf merge_msg = STRBUF_INIT;
>  static struct strategy **use_strategies;
>  static size_t use_strategies_nr, use_strategies_alloc;
> @@ -633,7 +633,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  		sign_commit = git_config_bool(k, v) ? "" : NULL;
>  		return 0;
>  	} else if (!strcmp(k, "gpg.mintrustlevel")) {
> -		check_trust_level = 0;
> +		gpg_flags ^= GPG_VERIFY_COMPAT;

Did you really mean to "toggle the bit each time the variable
appears"?  Or is this better written as

		gpg_flags &= ~GPG_VERIFY_COMPAT;

instead?  There may be another instance of the same in this patch.

