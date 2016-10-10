Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217F620989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbcJJRl4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:41:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65284 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752963AbcJJRlz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:41:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE87A43639;
        Mon, 10 Oct 2016 13:41:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UjAU/QPaU4FegQYwhT2HL5C4P84=; b=Ts2Rps
        G2hqPkyQDW4A3MMiRxZtUarQp59brWSOyQ2h8HD5lyIquNpL6RDgzWPXi2Hr8YT9
        hfnJ2C/8ztWSgbCuRwmSHCmlWtBN8U4G7+nKD3fJ4Ad0LLtOY0F64f5MuB5mPH5O
        V93F0k9cghLk/qg8OzBe3IoQ/VoVUZkDRI+II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CGoV6KbDXR3Zf+mV+arSzleyHh6zB3K+
        3OwMDPLyfklFE+DsGfN3dB6iql/84o6hmT+9dNmd9HwEQ96xVhtFypTAFn62Tago
        eIzpu2g1wc9BLltKDpnnEbWuwkOg9NT9TMRXbYtv1G3+DKKTYPxwSHsta0V4wChs
        qXXzQJvgWwE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C29DF43638;
        Mon, 10 Oct 2016 13:41:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13D6143637;
        Mon, 10 Oct 2016 13:41:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@freedesktop.org>
Cc:     t.gummerer@gmail.com, git@vger.kernel.org
Subject: Re: git 2.10.1 test regression in t3700-add.sh
References: <A433322C-2B75-4B4B-A8CC-BAC3179EE7A7@freedesktop.org>
        <98EB348E-221D-488C-A466-1FACB1C768FF@freedesktop.org>
        <6CA5F44F-38C1-4C15-9B85-FE84FB93E616@freedesktop.org>
        <49BF26B2-8E6D-40B1-87A2-1FDDF9A76B8E@freedesktop.org>
Date:   Mon, 10 Oct 2016 10:41:51 -0700
In-Reply-To: <49BF26B2-8E6D-40B1-87A2-1FDDF9A76B8E@freedesktop.org> (Jeremy
        Huddleston Sequoia's message of "Sun, 9 Oct 2016 20:46:08 -0700")
Message-ID: <xmqq8ttwgkyo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4A16CEA-8F10-11E6-A77D-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@freedesktop.org> writes:

> Actually, looks like that as just a rabbit hole.  The real issue
> looks to be because an earlier test drops down xfoo3 as a symlink,
> which causes this test to fail due to the collision.  I'll get out
> a patch in a bit.

[administrivia: please don't top-post, it is extremely hard to
follow what is going on]

There indeed is a test that creates xfoo3 as a symbolic link and
leaves it in the filesystem pointing at xfoo2 much earlier in the
sequence.  It seems that later one of the "add ignore-errors" tests
(there are two back-to-back) runs "git reset --hard" to make it (and
other symbolic links that are similarly named) go away, namely this
part of the code:

    test_expect_success POSIXPERM,SANITY 'git add --ignore-errors' '
            git reset --hard &&
            date >foo1 &&
            date >foo2 &&
            chmod 0 foo2 &&
            test_must_fail git add --verbose --ignore-errors . &&
            git ls-files foo1 | grep foo1
    '

    rm -f foo2

    test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors)' '
            git config add.ignore-errors 1 &&
            git reset --hard &&
            date >foo1 &&
            date >foo2 &&
            chmod 0 foo2 &&
            test_must_fail git add --verbose . &&
            git ls-files foo1 | grep foo1
    '
    rm -f foo2

"git reset --hard" in the first one, because these symbolic links
are not in the index at that point in the sequence, would leave them
untracked and in the working tree.  Then "add" is told to be
non-atomic with "--ignore-errors", adding them to the index while
reporting a failure.  When the test after that runs "git reset --hard"
again, because these symlinks are in the index (and not in HEAD),
they are removed from the working tree.

And that is why normal people won't see xfoo3 in later tests, like
the one you had trouble with.

Are you running without SANITY by any chance (I am not saying that
you are doing a wrong thing--just trying to make sure I am guessing
along the correct route)?

If that is the issue, then I think the right correction would be to
make sure that the files that an individual test expects to be
missing from the file system is indeed missing by explicitly
removing it, perhaps like this.

I also notice that the problematic test uses "chmod 755"; don't we
need POSIXPERM prerequisite on this test, too, I wonder?

Thanks.

-- >8 --
t3700: fix broken test under !SANITY

An "add --chmod=+x" test recently added by 610d55af0f ("add: modify
already added files when --chmod is given", 2016-09-14) used "xfoo3"
as a test file.  The paths xfoo[1-3] were used by earlier tests for
symbolic links but they were expected to have been removed by the
test script reached this new test.

The removal with "git reset --hard" however happened in tests that
are protected by POSIXPERM,SANITY prerequisites.  Platforms and test
environments that lacked these would have seen xfoo3 as a leftover
symbolic link, pointing somewhere else, and chmod test would have
given a wrong result.



 t/t3700-add.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 924a266126..53c0cb6dea 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -350,6 +350,7 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
 '
 
 test_expect_success 'git add --chmod=[+-]x changes index with already added file' '
+	rm -f foo3 xfoo3 &&
 	echo foo >foo3 &&
 	git add foo3 &&
 	git add --chmod=+x foo3 &&

