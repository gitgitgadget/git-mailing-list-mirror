Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B094FC433F5
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 00:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhKUAtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 19:49:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64639 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhKUAtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 19:49:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F032E46C7;
        Sat, 20 Nov 2021 19:46:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=et24HWGlwgaOzlstes558G1rSEnqoxRRaF/ctw
        /SVK0=; b=JjajJV2g4tMEeNqOIFayAJLZGOasYcBw5fXy2Undj6Mo6b7EnwcLK3
        VvLVlMc5f8CDjjjCy2GDUeNXGTAg6w7Hjv4VYqRQVp0aSXgv0eIg4Cet+SO2c4Bt
        s5VEfLXXuyDwA9fo89Icr0WQFudn8XhgvEAMKcZtj9jQb9i9w5Y38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36CCDE46C6;
        Sat, 20 Nov 2021 19:46:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CE92E46C5;
        Sat, 20 Nov 2021 19:46:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Danial Alihosseini <danial.alihosseini@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
        <YZaHpJKeyDEY8qKW@coredump.intra.peff.net>
        <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
        <CACLOEFbY3LwMa2uhc=9jmcGFf0mvWzEM=YityLyFcuGWXVmqbw@mail.gmail.com>
        <72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com>
        <190a1fea-124d-2e85-38ea-9dab87f3e377@kdbg.org>
        <429375f7-ec3e-596f-5f79-c724570c8397@gmail.com>
        <CAPx1GveHusi8n8n03hUwBu6B3=_j0ZY6FWXWKDs8mLGwHEN-Qg@mail.gmail.com>
Date:   Sat, 20 Nov 2021 16:46:10 -0800
In-Reply-To: <CAPx1GveHusi8n8n03hUwBu6B3=_j0ZY6FWXWKDs8mLGwHEN-Qg@mail.gmail.com>
        (Chris Torek's message of "Sat, 20 Nov 2021 14:41:44 -0800")
Message-ID: <xmqq5ysmnxnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C596E48-4A64-11EC-9B6F-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> ...  So the standard
> explanation -- at least, the one I use -- is this:
>
>  * Git opens and reads the working tree directory.  For each file
>    or directory that is actually present here, Git checks it
>    against the ignore rules.  Some rules match only directories
>    and others match both directories and files.  Some rules say
>    "do ignore" and some say "do not ignore".
>
>  * The *last* applicable rule wins.
>
>  * If this is a file and the file is ignored, it's ignored.
>    Unless, that is, it's in the index already, because then it's
>    tracked and can't be ignored.
>
>  * If this is a directory and the directory is ignored, it's
>    not even opened and read.  It's not in the index because
>    directories are never in the index (at least nominally).
>    If it is opened and read, the entire set of rules here
>    apply recursively.
>
> This works, but skips over files that are in the index and are in
> a directory that won't be read.  So I add one last rule, which is

All of the above is sensible.  If you deal with a path that is in
the index upfront, you can simplify the later rules somewhat, I
would think.  I.e. add a first rule before everything else that
says:

 * A file in the index is not ignored.  Everything below is about a
   path not in the index.

Then your third rule can lose "Unless...", and you do not have to
add one last rule outside the bulleted list, either.

;-)

