Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8F1E7737C
	for <git@archiver.kernel.org>; Sat, 30 Sep 2023 17:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjI3RZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Sep 2023 13:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjI3RZx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2023 13:25:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25552E5
        for <git@vger.kernel.org>; Sat, 30 Sep 2023 10:25:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A16D1B9BCD;
        Sat, 30 Sep 2023 13:25:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=+S2Wl8Ge2KviKc5kwjVD7kuPhZrvbuRvw/Na6I
        C5onQ=; b=oZWXaMEd3Kb25wjtMR+7+ekqirOUlxcdqFFhJP/Wg8bAR5eCXfMkhh
        dP//Bb4lVYaLka8F1lD1ovtPFYJjVb8HpnogUFhBiaHEj/LM45nWCIVkBLDQD6qm
        G7xKr/07wLDODs4wBkM+pzB1ghC1fvRCdp0gwrI3KJJ/63lEkBI/I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91D841B9BCC;
        Sat, 30 Sep 2023 13:25:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E86C71B9BCA;
        Sat, 30 Sep 2023 13:25:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Irina Gulina <igulina@redhat.com>
Cc:     git@vger.kernel.org, Tomas Tomecek <ttomecek@redhat.com>
Subject: Re: bug - Inconsistency of git status and branch, ./git/branches
 and ./git/HEAD
In-Reply-To: <CAAcHogUEtcsFcDYp16g=154CMPh_a5fmY6ABEfp9zeqEJBNb6w@mail.gmail.com>
        (Irina Gulina's message of "Sat, 30 Sep 2023 09:03:22 +0200")
References: <CAAcHogVu+jrLdtEZi+Jx9d9gM5BvUF_nRVKEc4BsWCxCanL9Uw@mail.gmail.com>
        <CAAcHogUEtcsFcDYp16g=154CMPh_a5fmY6ABEfp9zeqEJBNb6w@mail.gmail.com>
Date:   Sat, 30 Sep 2023 10:25:48 -0700
Message-ID: <xmqqcyxzfu8z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66488980-5FB6-11EE-86BB-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Irina Gulina <igulina@redhat.com> writes:

>> What did you do before the bug happened? (Steps to reproduce your issue)
>> 1. create an empty directory in CLI: mkdir test_repo
>> 2. convert it to a git directory: cd test_repo & git init
>> 3. 'git status' will say you are "On branch master"
>> 4. 'git branch', 'git branch --all', or 'git branch --list' - nothing
>> will say the master branch exists. And per man pages definition the
>> branch command displays existing branches. So the question is why 'git
>> status' says "On branch master", but 'git branches' don't?

Chris gave a good answer to this most relevant question; let me
fill in one gap with others.

>> 5. check on 'ls -la ./git/branches' - it's empty

The directory is where you would configure how individual local
branches you have would behave, and it is expected to be empty if
you did not do anything special.

>> 6. check on 'ls -la ./git/refs/heads' - it's empty

You can never expect the contents of .git/refs/*  hierarchy to
correspond to any state of the refs.  If you have a history behind
your local branch 'master', i.e., after running something like

    $ git init empty && cd empty && git commit --allow-empty -m init

you can "pack" the references, i.e.,

    $ git pack-refs --all

and all the necessary data for Git to know what your branches are
and what commits they point at will be removed from .git/refs/* and
stored in different place in .git/ hierarchy.  So "there is no file
at .git/refs/heads/master" does not mean "there is no master branch",
even when we are not talking about a branch in the unborn state.

>> 7. check on 'cat ./git/HEAD' - it shows 'ref: refs/heads/master' -
>> why? if we didn't create any commit, and no branch exists?

The same comment applies to the above.  If you want to know the
state of HEAD, there are commands to do so ("git branch --list" being
one of them).  Do not expect that .git/HEAD would stay forever be
the implementation detail of what the HEAD ref points at.
