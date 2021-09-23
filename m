Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D4DC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72431601FF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243361AbhIWVsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:48:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51780 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243343AbhIWVsF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 17:48:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E241160C20;
        Thu, 23 Sep 2021 17:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hc62GMCHcqj/NdEzb4p2CBmhHL5WBHuX0A2ks1
        Yr1yA=; b=m/UaS9SYDcPB8PxP7APlpmncQ9aoXhM2sMqoSZ92KqylH+/CZThI4M
        DRAf/THhHywfNeaGIlRkxIVqzoVE/QQmIoyzisuRJ2OCGmuKbzcM+9xnml6OtE2l
        Yh1CoMD2tVZUY3Mkg8pJDPKHeFtRrjZiD9rkfZ2yBNNkB/IEeaSgw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 965B4160C1F;
        Thu, 23 Sep 2021 17:46:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 07259160C1E;
        Thu, 23 Sep 2021 17:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/3] difftool: fix symlink-file writing in dir-diff mode
References: <20210923041252.52596-1-davvid@gmail.com>
        <20210923041252.52596-2-davvid@gmail.com>
Date:   Thu, 23 Sep 2021 14:46:29 -0700
In-Reply-To: <20210923041252.52596-2-davvid@gmail.com> (David Aguilar's
        message of "Wed, 22 Sep 2021 21:12:50 -0700")
Message-ID: <xmqqv92rx8wa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6A3EDBE-1CB7-11EC-B5C2-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index bb9fe7245a..21e055d13a 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -557,11 +557,13 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  		if (*entry->left) {
>  			add_path(&ldir, ldir_len, entry->path);
>  			ensure_leading_directories(ldir.buf);
> +			unlink(ldir.buf);
>  			write_file(ldir.buf, "%s", entry->left);
>  		}
>  		if (*entry->right) {
>  			add_path(&rdir, rdir_len, entry->path);
>  			ensure_leading_directories(rdir.buf);
> +			unlink(rdir.buf);
>  			write_file(rdir.buf, "%s", entry->right);
>  		}
>  	}

Curiously, this pattern repeats twice in the vicinity of the code.
We cannot see it because it is out of pre-context, but the above is
a body of a loop that iterates over "symlinks2" hashmap.  There is
another identical loop that iterates over "submodules", and we are
not protecting ourselves from following a stray/leftover symbolic
link in the loop.

I wonder if we should do the same to be defensive?  I also wondered
if write_file() should be the one that may want to be doing the
unlink(), but I ran out of time before I finished reading all the
callers to see if that is even a correct thing to do (meaning: some
caller may want to truly overwrite an existing file, and follow
symlinks if there already is, and I didn't audit all callers to see
if there is no such caller).

The two identical looking loops also look like an accident waiting
to happen---a patch like this that wants to touch only one of them
would risk application to the other, wrong, loop if the patch gets
old enough and patch offset grows larger ;-).

Thanks.

