Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7C520437
	for <e@80x24.org>; Tue, 31 Oct 2017 05:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbdJaFYG (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 01:24:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55300 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753109AbdJaFYF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 01:24:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EA55A8DFB;
        Tue, 31 Oct 2017 01:24:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=a3lY6xFccLiCCFO9OXwZS91AltQ=; b=pvN4c5+DWyDsFm6vw1mN
        c4x5xdG75tuyZIXK3J774suroHfb2v1qLboD3gO5Wslcu2SGaVB1+JAjmdnKpLog
        oSTpubDAKV/0NHFkTYeMOn5mC02Cl2gplwC5JKjMBM/ntk9Z3OtxA+LzUnMgNoF+
        gb6VcFLC4AY3+jJjQeqnK9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=fYbbM1AoikutSPLtHO020agXAbgwZmqkakpHIfXgZynZxr
        pAfIzJYBzhne0WzaMeS4YHqDyjTlMOGuWA3Kc9PTuP2EJ/2xzo9kubHeAlNnWKAw
        bP8/ECoeW1V3+14LgZ2+J+QrFLd+zWPWuqqeWaNt7Up5ccRT5eXEQ38Aw/N5o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 060E2A8DF9;
        Tue, 31 Oct 2017 01:24:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D4D4A8DF7;
        Tue, 31 Oct 2017 01:24:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v3 4/4] fsmonitor: Delay updating state until after split index is merged
References: <20171027232637.30395-1-alexmv@dropbox.com>
        <4b488da5e0710e9699f92d2dabe5e3352f3eb394.1509146542.git.alexmv@dropbox.com>
        <5cb81a33c31ffa585861f0d3f5a7c7eef5bd8fe0.1509146542.git.alexmv@dropbox.com>
Date:   Tue, 31 Oct 2017 14:24:03 +0900
Message-ID: <xmqqa80728lo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5F4E48C-BDFB-11E7-95E8-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Vandiver <alexmv@dropbox.com> writes:

> diff --git a/fsmonitor.c b/fsmonitor.c
> index 4ea44dcc6..417759224 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -49,20 +49,7 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
>  		ewah_free(fsmonitor_dirty);
>  		return error("failed to parse ewah bitmap reading fsmonitor index extension");
>  	}
> -
> -	if (git_config_get_fsmonitor()) {
> -		/* Mark all entries valid */
> -		for (i = 0; i < istate->cache_nr; i++)
> -			istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
> -
> -		/* Mark all previously saved entries as dirty */
> -		ewah_each_bit(fsmonitor_dirty, fsmonitor_ewah_callback, istate);
> -
> -		/* Now mark the untracked cache for fsmonitor usage */
> -		if (istate->untracked)
> -			istate->untracked->use_fsmonitor = 1;
> -	}
> -	ewah_free(fsmonitor_dirty);
> +	istate->fsmonitor_dirty = fsmonitor_dirty;

This makes local variable "int i;" in this function unused and gets
compiler warning.

