Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDE9C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 07:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C7A60FDA
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 07:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhFIHC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:02:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52251 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbhFIHCX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 03:02:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D2F9D5235;
        Wed,  9 Jun 2021 03:00:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=3M1MOtcNWsLMp8QjIBJbsdkxwt5k8pEEOj3we3VsMtU=; b=VI91
        IBFmJqDn4sQaVwr5Y7NSHl7yWI7PkXemuYm5gzWNvi2OAkAaFsO0xgmk98Htjeca
        rrdxEoq00ez+B7UeBI/l0JY3dpzCpstNYyu/gewAUxz1DjlgFzJlZnML1Duvmso5
        35IfEyW6GyF0eEerUF0ZAww0Ts1Bbzf34bl7h00=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 752CDD5234;
        Wed,  9 Jun 2021 03:00:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02A31D5233;
        Wed,  9 Jun 2021 03:00:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
        <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
        <xmqq7dj6w7a6.fsf@gitster.g>
        <CAOLTT8S+5m+-XF-AcQi9t8njTvyDYzHt=BU+4OPcvTT27RP6dw@mail.gmail.com>
        <CAOLTT8QE7pafPmhnz-6=5zuyjg9n1FNbu_k6bA80jE1e5vYCmQ@mail.gmail.com>
        <CAOLTT8TSue=Cx8xos20vnGSi3oOd8+=jTfTw2h82gXmmd4KyLg@mail.gmail.com>
        <xmqqk0n4q1t6.fsf@gitster.g>
Date:   Wed, 09 Jun 2021 16:00:25 +0900
Message-ID: <xmqq4ke7jzee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E0921B2-C8F0-11EB-BDD9-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Is that what you want to add to give "cat-file --batch"?  Even in
> the context of "cat-file --batch", you can throw an object name for
> a blob to the command, but there is no path for the blob (a blob can
> appear at different places in different trees---think "rename), so I
> am not sure what benefit you are trying to derive from it.

I think I kind-of see what is going on here.  There is

    git cat-file blob --textconv --path="$path" "$blob_object_name"

that allows a blob to be fed to the command, pretend as if it
appears at $path in a tree object and grab attribute for it, and
show the blob contents converted using the textconv filter.  If we
were to mimic it by extending the format based substitutions, a
design consistent with the behaviour is to teach --format=%(raw)
to show the contents after applying the textconv filter instead of
the raw blob contents.

And there is a corresponding

    git cat-file --batch --textconv

The "--path=$path" parameter is omitted when using --batch, as each
object would sit at different path in the tree (so the input stream
would be given as a run of "<blob> <path>" to give each item its own
path).

So to answer my question in the previous message, yes, this is an
attempt to support the "cat-file --textconv".  So in the context of
that command, something may need to be added.  But I do not think it
makes any sense to expose that to for-each-ref and friends, even if
we were to share the internal machinery (after all, sharing of the
internal machinery is a mere means to an end that is to make it
easier to give the same syntax and same behaviour to end users and
is not a goal itself; "because we use the same machinery, the users
have to tolerate that irrelevant %(atoms) are accepted by the parser"
is not making a good excuse for a sloppy implementation).

Having said all that, I somehow doubt that the "--batch=<format>"
was designed to interact sensibly with the "--textconv" option.
builtin/cat-file.c::expand_atom() does not know anything at all that
the data could be modified from the raw contents of the blob, so
--batch="%(contents) %(size)" --textconv, if existed, may show the
conveted contents with size of blob before conversion, or something
incoherent like that.  And if your rewrite using the shared internal
machinery results in a more coherent behaviour, that would be
excellent.  For example, we could imagine that the machinery, when
textconv (or filter) is in use, would first grab the blob contents
and run the requested conversion, and then work solely on that
conveted contents when computing what to fill with %(raw:size) and
other blob-related atoms.

Thanks.


