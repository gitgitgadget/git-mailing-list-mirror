Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915AAC47080
	for <git@archiver.kernel.org>; Mon, 24 May 2021 01:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648966109F
	for <git@archiver.kernel.org>; Mon, 24 May 2021 01:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhEXBKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 21:10:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62316 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhEXBKk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 21:10:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9DCF12ABE8;
        Sun, 23 May 2021 21:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DmY9HANYe+4pphpJ7Mpm8gUtcfQdae8RR2YyfQ
        bUzoo=; b=aTXIlg60q5hZ9STZhxoGBgoxHDMuR1U1nYlE36tI+jUczCEMbNtMeg
        VPZJGQ+9eqUVXplDxDeWCSf+buhe9jxF5nscNdJbklJytF2qVjpt6duzcueA0Pfw
        uGX4vu1izIPNJwbRgoOa9PpmBOoVK/ao2Pqj66FPfi5PkpKQGwFRc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A270312ABE4;
        Sun, 23 May 2021 21:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F001112ABE3;
        Sun, 23 May 2021 21:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 0/3] [GSOC][RFC] ref-filter: add contents:raw atom
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
Date:   Mon, 24 May 2021 10:09:08 +0900
In-Reply-To: <pull.959.git.1621763612.gitgitgadget@gmail.com> (ZheNing Hu via
        GitGitGadget's message of "Sun, 23 May 2021 09:53:29 +0000")
Message-ID: <xmqq1r9xndjf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5220A1C-BC2C-11EB-BB35-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In (a2f3241: [GSOC] ref-filter: add contents:raw atom) I did not notice the
> ...

Before going into any of these details, remember that the cover
letter is where you first sell the series to the readers.  Why is it
worth their time to read it?  What problem does it solve in the
bigger picture?  Mention that we want to let "cat-file --batch" use
the ref-filter --format logic, if that is the primary reason why we
have these three patches, for example.

I actually do not know if a modified form of %(contents) is a good
match for this feature.  It was invented as a way to extract the
unstructured "free text" part of structured textual objects (namely,
commits and tags) so it is natural that it would not apply to trees
(they are structured and there is no unstractured "free text" part)
nor blobs (they are totally unstructured and does not even have to
be text).

Is there another word to refer to the entire payload unadulterated?

> git for-each-ref --format="%(contents)" --python refs/mytrees/first
>
> will output a string processed by python_quote_buf_with_size(), which
> contains'\0'. But the binary files seem to be useless after quoting. Should
> we allow these binary files to be output in the default way with
> strbuf_add()? If so, we can remove the first patch.

The --language option is designed to be used to write a small script
in the language and used like this:

    git for-each-ref --format='
		name=%(refname)
		var=%(placeholder)
                mkdir -p "$(dirname "$name")"
		printf "%%s" "$var" >"$name"
    ' --shell | /bin/sh

Note that %(refname) and %(placeholder) in the --format string is
not quoted at all; the "--shell" option knows how values are quoted
in the host language (shell) and writes single-quotes around
%(refname).  If %(placeholder) produces something with a single-quote
in it, that will (eh, at least "should") be quoted appropriately.

So It does not make any sense not to quote a value that comes from
%(placeholder), whether it is binary or not, to match the syntax of
the host language you are making the "for-each-ref --format=" to
write such a script in.

So, "binary files seem to be useless after quoting" is a
misunderstanding.  They are useless if you do not quote them.

Thanks.

P.S. I am mostly offline today, and response will be slow.

