Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1ECC4707F
	for <git@archiver.kernel.org>; Wed, 26 May 2021 00:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CF160FE3
	for <git@archiver.kernel.org>; Wed, 26 May 2021 00:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhEZA6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 20:58:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58311 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhEZA6C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 20:58:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C0C2C3CAD;
        Tue, 25 May 2021 20:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nnxOQbOO/IwQOJOgSLLRK4YHMgC8SNODrsrBcY
        K5otM=; b=HvBfzZsKEcfaqRtp1jlawPMLiSW9cL/getJMuAzi9o8BMePFF/P7tp
        cReKF1Ow/G/SfIbNtZlT9NDNAO05yjtbMtAEIN0dINavTBNHVL6j1Fa4OkuGUMYy
        aFepCy0uFylwfOk1iBQefytV/IfeiYtYxexh6tqkuQv1zpXg+jzjM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43781C3CAC;
        Tue, 25 May 2021 20:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8ACC2C3CAB;
        Tue, 25 May 2021 20:56:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 0/3] [GSOC][RFC] ref-filter: add contents:raw atom
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
        <xmqq1r9xndjf.fsf@gitster.g>
Date:   Wed, 26 May 2021 09:56:28 +0900
In-Reply-To: <xmqq1r9xndjf.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        24 May 2021 10:09:08 +0900")
Message-ID: <xmqq8s42cnyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34B7BC8A-BDBD-11EB-BE70-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> git for-each-ref --format="%(contents)" --python refs/mytrees/first
>>
>> will output a string processed by python_quote_buf_with_size(), which
>> contains'\0'. But the binary files seem to be useless after quoting. Should
>> we allow these binary files to be output in the default way with
>> strbuf_add()? If so, we can remove the first patch.
>
> The --language option is designed to be used to write a small script
> in the language and used like this:
>
>     git for-each-ref --format='
> 		name=%(refname)
> 		var=%(placeholder)
>                 mkdir -p "$(dirname "$name")"
> 		printf "%%s" "$var" >"$name"
>     ' --shell | /bin/sh
>
> Note that %(refname) and %(placeholder) in the --format string is
> not quoted at all; the "--shell" option knows how values are quoted
> in the host language (shell) and writes single-quotes around
> %(refname).  If %(placeholder) produces something with a single-quote
> in it, that will (eh, at least "should") be quoted appropriately.
>
> So It does not make any sense not to quote a value that comes from
> %(placeholder), whether it is binary or not, to match the syntax of
> the host language you are making the "for-each-ref --format=" to
> write such a script in.
>
> So, "binary files seem to be useless after quoting" is a
> misunderstanding.  They are useless if you do not quote them.

Another thing to keep in mind is that not all host languages may be
capable of expressing a string with NUL in it.  Most notably, shell.
The --shell quoting rule used by for-each-ref would produce an
equivalent of the "script" produced like this:

	$ tr Q '\000' >script <<\EOF
	#!/bin/sh
	varname='varQname'
	echo "$varname"
	EOF

but I do not think it would say 'var' followed by a NUL followed by
'name'.  The NUL is likely lost when assigned to the variable.

So for some host languages, binaries may be useless with or without
quoting.  But for ones that can use strings to hold arbitrary byte
sequence, it should be OK to let for-each-ref to quote the byte
sequence as a string literal for the language (so that the exact
byte sequence will end up being in the variable after assignment).

That reminds me of another thing.  The --python thing was written
back when Python3 was still a distant dream and strings were the
appropriate type for a random sequence of bytes (as opposed to
unicode, which cannot have a random sequence of bytes).  Somebody
needs to check if it needs any update to work with Python3.
