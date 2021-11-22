Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D1C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhKVS5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:57:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55792 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbhKVS5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:57:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54EF9F42F6;
        Mon, 22 Nov 2021 13:54:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zfM+pDE8niwCuzplMCIH98tkgqURPHq0GhZjEU
        ICcg8=; b=bbxuDj13QftrBzn6qAaSS1wfLOltWbw/FpWOfXTMtQ61ZzXeLqV6jz
        6BjyaAqcxWzgRA1ec1fOly6/GmDgZ/QVZIqC8eLHRfsXLgyGZ9XsjYxQVpKePobt
        iFsaxqeP2Lq/7TxYndZIj7noyyROc3MJY8nJmkJVImZkADOgPwLe4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A64EF42F5;
        Mon, 22 Nov 2021 13:54:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A08B6F42F4;
        Mon, 22 Nov 2021 13:54:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, congdanhqx@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v3 1/1] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
References: <cover.1637567328.git.dyroneteng@gmail.com>
        <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
Date:   Mon, 22 Nov 2021 10:54:01 -0800
In-Reply-To: <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
        (Teng Long's message of "Mon, 22 Nov 2021 16:07:28 +0800")
Message-ID: <xmqqczmsf2d2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F510C50-4BC5-11EC-9082-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Sometimes, we only want to get the objects from output of `ls-tree`
> and commands like `sed` or `cut` is usually used to intercept the
> origin output to achieve this purpose in practical.

"in practical" -> "in practice".

That's true and that is exactly this plumbing command was designed
to be used.

> This commit supply an option names `--oid-only` to let `git ls-tree`
> only print out the OID of the object. `--oid-only` and `--name-only`
> are mutually exclusive in use.

    Teach the "--oid-only" option to tell the command to only show
    the object name, just like "--name-only" option tells the
    command to only show the path component, for each entry.  These
    two options are mutually exclusive.

perhaps?

The above leaves "mode-only" and "type-only".  I wonder if it is a
better design to add just one new option, --hide-fields, and make
the existing --name-only into a synonym to

    git ls-tree --hide-fields=mode,type,object $T

which would mean we do not need to end up with four mutually
exclusive commands, and anybody who wants to only see object names
can do

    git ls-tree --hide-fields=mode,type,file $T

Note: the above uses the terminology in the OUTPUT FORMAT section;
if we want to use "name" instead of "file", I am perfectly OK with
it, but then we should update the documentation to match.

Come to think of it, I think "--show-fields" may work even better
than "--hide-fields".  We can use it to get rid of the "--long"
option:

    git ls-tree --show-fields=mode,type,object,size,file $T

would be equivelent to

    git ls-tree --long $T

The field order may need to be thought through, especially when "-z"
output is not being used.  We may need a rule to require "file" to
be at the end, if exists, or even simpler rule "you can choose which
fields are shown but the order they come out is not affected" (i.e.
"--show-fields=mode,type" and "--show-fields=type,mode" give the
same output).

I am OK if we started with "only a single field allowed" and extend
it to support multiple fields later (until that happens, we cannot
emulate the "--long" output, though).  Then we do not have to answer
two tricky questions, what to do with the output order, and what
field separators are used in the output.
