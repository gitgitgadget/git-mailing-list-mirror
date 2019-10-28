Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888181F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 17:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfJ1ReO (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 13:34:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57729 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbfJ1ReO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 13:34:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E61D27803;
        Mon, 28 Oct 2019 13:30:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hhUEFLIcEKYo7SUNWgAqNHvYosU=; b=RGq56m
        8UgsA6L2QFhl9PWxBF0o01513y6D0Mt41YganvOYstq6E65bsq4xBGylRqfGJ6lM
        EwQ8YuDLIvLLC2NzL8DL7Gwjzy8RbtPR3V7nnqRRzX4vaCew5mRmEQI1C4UxvGA1
        8lnVr6WyjBK/D+nSNEB0kzktJZbZqrLdWZsJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lE+bz+u/4Mz3Mj98tDfMlj34RZzsUOsg
        EU8SEN/upkJJHGJNbZOsJoaCvYcZ1xBTzyj10EpzC2SSarlcB+xP/c7jdT/IQtdl
        i93xAEuiAwKK2cGyevwJ+mulP65nqsTZNJKIRWURmW+StAKgGbl+7UXMR8VevXkb
        OCtxYwmWps0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1091F27802;
        Mon, 28 Oct 2019 13:30:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBF1527800;
        Mon, 28 Oct 2019 13:30:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] git_path(): handle `.lock` files correctly
References: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
        <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
        <8b1f4f089a6d4a2293507a1a77668c828598e84f.1571694882.git.gitgitgadget@gmail.com>
        <20191022160105.GE4348@szeder.dev>
        <nycvar.QRO.7.76.6.1910281225260.46@tvgsbejvaqbjf.bet>
Date:   Tue, 29 Oct 2019 02:30:18 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910281225260.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 28 Oct 2019 13:01:49 +0100 (CET)")
Message-ID: <xmqqtv7s93rp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D299232-F9A8-11E9-B173-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>   size_t len;
>>   if (strip_suffix(base, ".lock", &len))
>>           base = base2 = xstrndup(base, len);
>
> Actually, we should probably avoid the extra allocation. Earlier, I was
> concerned about multi-threading issues when attempting to modify the
> `strbuf`. But then, we modify that `strbuf` a couple of lines later
> anyway, so my fears were totally unfounded. Therefore, my current
> version reads like this:
>
> -- snip --
> 	int has_lock_suffix = strbuf_strip_suffix(buf, LOCK_SUFFIX);
>
> 	init_common_trie();
> 	if (trie_find(&common_trie, base, check_common, NULL) > 0)
> 		replace_dir(buf, git_dir_len, common_dir);
>
> 	if (has_lock_suffix)
> 		strbuf_addstr(buf, LOCK_SUFFIX);
> -- snap --

Makes sense.  Thanks for thinking it through.
