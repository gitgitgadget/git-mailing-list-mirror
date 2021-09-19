Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE7EC433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 09:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA13610A8
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 09:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbhISJBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 05:01:37 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:35364 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233210AbhISJBg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 05:01:36 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4HC1qC6vh1z5tlB;
        Sun, 19 Sep 2021 11:00:07 +0200 (CEST)
Subject: Re: [PATCH 3/4] difftool: use a strbuf to create the tmpdir path
To:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20210919015729.98323-1-davvid@gmail.com>
 <20210919015729.98323-3-davvid@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <8dfd0683-e019-a45c-30a4-d49ea627e36d@kdbg.org>
Date:   Sun, 19 Sep 2021 11:00:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210919015729.98323-3-davvid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.09.21 um 03:57 schrieb David Aguilar:
> Use a strbuf to create the buffer used for the dir-diff tmpdir.
> Strip trailing slashes "/" from the value read from TMPDIR to avoid
> double-slashes in the calculated paths.
> 
> Add a unit test to ensure that double-slashes are not present.

I wonder why it is necessary to strip trailing slashes? You even go so
far as to add a test case, but then bury the change in a commit with a
title that is about a completely different topic.

So, which one of the two changes is the "while at it, do that, too" change?

> @@ -360,11 +359,17 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  
>  	/* Setup temp directories */
>  	tmp = getenv("TMPDIR");
> -	xsnprintf(tmpdir, sizeof(tmpdir), "%s/git-difftool.XXXXXX", tmp ? tmp : "/tmp");
> -	if (!mkdtemp(tmpdir))
> -		return error("could not create '%s'", tmpdir);
> -	strbuf_addf(&ldir, "%s/left/", tmpdir);
> -	strbuf_addf(&rdir, "%s/right/", tmpdir);
> +	strbuf_add_absolute_path(&tmpdir, tmp ? tmp : "/tmp");
> +	/* Remove trailing slashes when $TMPDIR ends in '/'. */
> +	while (tmpdir.len > 0 && tmpdir.buf[tmpdir.len - 1] == '/') {

This should most likely be is_dir_sep(tmpdir.buf[tmpdir.len - 1]).

-- Hannes
