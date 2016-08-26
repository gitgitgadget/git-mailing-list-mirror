Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C151FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbcHZRlx (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:41:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54456 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751014AbcHZRlw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:41:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E3463787A;
        Fri, 26 Aug 2016 13:40:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W9LGA72Nxh97efiMomsmiFLoTY8=; b=FlnDlS
        T59J4U1yx4y11Yic2CffphdbIA2ND14Lr+wPLjlYa4OSvOX6+whyS4pL70rjW49w
        cv4LPrTFPn26aXLPqeJcftYy0VI0Y/b0p6ulDRZxFUKdR5w5tlwXB5ZhgP5qxttS
        ytsPm7qG25t5PIHuzWqbOckjkbPBhoYhXLvLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dPXPegqjQJT1MgHp9OZryZ4zXTduRTZJ
        4V3eO6bA1bVba7E5dPU8ChbBNeAwNMMarmd7zRueHxXglhLQWj6zYzzXPOy9Um58
        IbSspfaR2y+Dw3xyj/6zK11h29szR19A+NP73aW0e181cvSIzxUyo1LvE0gnpWt+
        B/4ibehgvoE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8508C37878;
        Fri, 26 Aug 2016 13:40:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10F2D37875;
        Fri, 26 Aug 2016 13:40:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/15] sequencer: lib'ify read_populate_opts()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <85a8ec8273994c599402c380abd383ad2f539777.1471968378.git.johannes.schindelin@gmx.de>
Date:   Fri, 26 Aug 2016 10:40:27 -0700
In-Reply-To: <85a8ec8273994c599402c380abd383ad2f539777.1471968378.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 23 Aug 2016 18:07:15 +0200
        (CEST)")
Message-ID: <xmqq1t1big38.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DF6BFFA-6BB4-11E6-AB71-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> -static void read_populate_opts(struct replay_opts **opts_ptr)
> +static int read_populate_opts(struct replay_opts **opts)
>  {
>  	if (!file_exists(git_path_opts_file()))
> -		return;
> -	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts_ptr) < 0)
> -		die(_("Malformed options sheet: %s"), git_path_opts_file());
> +		return 0;
> +	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
> +		return error(_("Malformed options sheet: %s"),
> +			git_path_opts_file());
> +	return 0;

This may not be sufficient to avoid die(), unless we know that the
file we are reading is syntactically sound.  git_config_from_file()
will die in config.c::git_parse_source() when the config_source sets
die_on_error, and it is set in config.c::do_config_from_file().

The source we are reading from is created when the sequencer
machinery starts and is only written by save_opts() which is
called by the sequencer machinery using git_config_set*() calls,
so I think it is OK to assume that we won't hit errors that would
cause git_config_from_file() to die, at least for now.


