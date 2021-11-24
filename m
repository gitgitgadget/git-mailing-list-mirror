Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8275C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 19:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhKXTqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 14:46:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64543 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhKXTqv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 14:46:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A0C1105BCA;
        Wed, 24 Nov 2021 14:43:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DbbncVmVENWhDEZGu+PfF8PvPN/fh3J8Uxb9U/
        M+DWA=; b=xDANaUK0wWfblpTB+EnsaKjbFBJbaWf4hPVYyizixt1e6hXTQuYb+1
        ih1zAE6ukeQtezxM9kvSPCsr2RH9yx1HYsRKMOMwYsz6+Qa07gIuBQWbXAQzBAVu
        IUI1rLzyit/WnkOuiuuvYIKoveYONNonEkzPmQqlMV43VCdpQhLSA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 708B4105BC9;
        Wed, 24 Nov 2021 14:43:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D39CC105BC8;
        Wed, 24 Nov 2021 14:43:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
        <20211123003958.3978-1-chooglen@google.com>
        <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
        <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
        <211124.86ee76e4fl.gmgdl@evledraar.gmail.com>
        <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
Date:   Wed, 24 Nov 2021 11:43:39 -0800
In-Reply-To: <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
        (Elijah Newren's message of "Tue, 23 Nov 2021 20:35:44 -0800")
Message-ID: <xmqqo8691gr8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D34B71C6-4D5E-11EC-88C3-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Doesn't this series also change the behavior of e.g.:
>>
>>     cd contrib/subtree
>>     git rm -r ../subtree
>
> Yes, of course!
>
> Before:
>
>     $ cd contrib/subtree
>     $ git rm -r -q ../subtree/
>     $ ls -ld ../subtree/
>     ls: cannot access '../subtree/': No such file or directory
>     $ git status --porcelain
>     fatal: Unable to read current working directory: No such file or directory
>     $ git checkout HEAD ../subtree/
>     fatal: Unable to read current working directory: No such file or directory
>
> After:
>
>     $ cd contrib/subtree
>     $ git rm -r -q ../subtree/
>     $ ls -ld ../subtree/
>     drwxrwxr-x. 1 newren newren 0 Nov 23 19:18 ../subtree/
>     $ git status --porcelain
>     D  contrib/subtree/.gitignore
>     D  contrib/subtree/COPYING
>     D  contrib/subtree/INSTALL
>     D  contrib/subtree/Makefile
>     D  contrib/subtree/README
>     D  contrib/subtree/git-subtree.sh
>     D  contrib/subtree/git-subtree.txt
>     D  contrib/subtree/t/Makefile
>     D  contrib/subtree/t/t7900-subtree.sh
>     D  contrib/subtree/todo
>     $ git checkout HEAD ../subtree/
>     Updated 10 paths from c557be478e
>
> Very nice fix, don't you think?

Not necessarily.  Devil's advocate hat on.

Because you used "ls -ld" in your illustration, we cannot see what
happened to contrib/subtree/t/ directory, but presumably that one is
gone.

Now, after this, if we "git commit", making contrib/subtree
directory truly unnecessary, nothing reminds us that we need to
remove it manually with "rmdir" or "git clean -d", no?

With the "before" behaviour, the user still can go back to the top
level of the repository by going back to the directory the user was
in before typing "cd contrib/subtree", by saying "cd -" and "git
status" and everything else would just work, including not having to
worry about remembering to clean an empty directory contrib/subtree
that is no longer needed.

