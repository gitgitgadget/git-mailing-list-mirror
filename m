Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62A5C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 22:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15E76120D
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 22:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345714AbhI3WTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 18:19:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57957 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhI3WTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 18:19:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A5C0614ABF2;
        Thu, 30 Sep 2021 18:17:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xcd88s1SCI3AWwmogrBH12lWBVvqv+Qw35Y/D9
        PK2Zg=; b=w1UeOwQx9Wj4ittV1/UUTiVVqjYtdhz91yEWKo15lQN57DBxKyTZcl
        jMlztfjzqYzNTI4Wgmsvk5aUoYYfnGI0/QhPygQPPG99BixuYWCjQwEa/DGHeIz/
        FUpWTmjeSQMP6UPywXGUxF+bjL4UC3TIQO87y62hJAN+O04vzDTFQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88BC014ABF0;
        Thu, 30 Sep 2021 18:17:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EAFBD14ABEE;
        Thu, 30 Sep 2021 18:17:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 4/5] difftool: refactor dir-diff to write files using
 a helper function
References: <20210930170146.61489-1-davvid@gmail.com>
        <20210930170146.61489-4-davvid@gmail.com>
Date:   Thu, 30 Sep 2021 15:17:22 -0700
In-Reply-To: <20210930170146.61489-4-davvid@gmail.com> (David Aguilar's
        message of "Thu, 30 Sep 2021 10:01:45 -0700")
Message-ID: <xmqq35plaetp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FF78EEE-223C-11EC-AFC6-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> This is cleanup refactoring that Junio suggested when
> 5bafb3576a (difftool: fix symlink-file writing in dir-diff mode, 2021-09-22)
> touched this area of the code.

Not really what I would want to take credit for  ;-)

> +static void write_entry(const char *path, const char *content,
> +			struct strbuf *buf, size_t len)
> +{
> +	if (!*content)
> +		return;

I am not sure "this function is unable to write an empty file" is a
limitation we want to give to an otherwise more or less generic
helper function that may be useful in this file (it probably is not
very useful outside difftool, as what add_path() does seems quite
specific to it).

Also, is "write entry" a good name for this helper?  The fact that
the contents came from entry->$side is lost inside this callee.  It
looks more like "create a file for <path> and write <content> to it",
i.e. a variant of write_file() but inside the tree specified by the
extra <buf, len> pair.  So perhaps 

	write_file_in_directory(buf, len, path, content);

to match how the write_file() takes its parameters?  While
write_file() takes a single pathname with the payload, this thing
takes three parameters <buf, len, path> to specify to which
"file-in-directory" the payload is written.

> +	add_path(buf, len, path);
> +	ensure_leading_directories(buf->buf);
> +	unlink(buf->buf);
> +	write_file(buf->buf, "%s", content);
> +}

Other than these two minor points, this looks good to me.

Thanks.
