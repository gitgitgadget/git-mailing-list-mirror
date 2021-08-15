Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CDDC4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 17:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6786561104
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 17:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhHORhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 13:37:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64394 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhHORhW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 13:37:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED3FD145603;
        Sun, 15 Aug 2021 13:36:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fe90ijR1bj7ZdDikQ+gu+P1U37UZztKvHsLUVm
        KDguI=; b=MzILFijlxO/rezFHcDl+oe2EXiRSqMSoZshCgqGOq9GcRU7uY9lIfQ
        mOJxHmbs5RHm0VjAFNMW1jbypnflaL36XUINfS35j5MAOjU9kQjIV3/2/xdk0obC
        A/dvNN2g8eCh72tDY7yvAwRHgEFtHz1ApeCmjoSXWcK3WFhu7U40o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E5DB0145602;
        Sun, 15 Aug 2021 13:36:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38117145601;
        Sun, 15 Aug 2021 13:36:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victor Gambier <vgambier@excilys.com>
Subject: Re: [PATCH 1/3] t3403: fix commit authorship
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
        <7559781ca92096f89a6dcbfeeaa4d2b4d7b98094.1628587917.git.gitgitgadget@gmail.com>
        <CABPp-BFFTLgtrs_m9Gp7tSRwpBnAEoArhMZhhJcuzqNS_g8sUw@mail.gmail.com>
        <xmqq5ywddtsn.fsf@gitster.g>
        <3b438e42-488c-e4ab-d1fe-3d0992ef0619@gmail.com>
        <nycvar.QRO.7.76.6.2108142350420.59@tvgsbejvaqbjf.bet>
Date:   Sun, 15 Aug 2021 10:36:47 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2108142350420.59@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 14 Aug 2021 23:53:06 +0200 (CEST)")
Message-ID: <xmqqsfzasj80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EAEEE24-FDEF-11EB-9B3F-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Good point.  The commit tagged with amended-goodbye is later used in
>> > some tests that ensure the author ident does not change across a
>> > rebase.  If this commit gets created without authorship customized
>> > (i.e. before Phillip's fix), we would not catch a possible breakage
>> > to make rebase discard the original authorship information.
>> >
>> > But with this fix, we now can catch such a breakage.
>>
>> I'll expand the commit message to make that clear
>
> Maybe you could even add a `test another.author@example.com = $(git show
> -s --format=%ae HEAD)`?

The version I have from Phillip has updated log message already, but
not with such a regression prevention.

The test that the patch under discussion corrects does this:

    test_expect_success 'correct authorship when committing empty pick' '
        test_when_finished "git rebase --abort" &&
        test_must_fail git rebase -i --onto goodbye \
                amended-goodbye^ amended-goodbye &&
        git commit --allow-empty &&
        git log --pretty=format:"%an <%ae>%n%ad%B" -1 amended-goodbye >expect &&
        git log --pretty=format:"%an <%ae>%n%ad%B" -1 HEAD >actual &&
        test_cmp expect actual
    '

to ensure that the authorship is the same between the original
(i.e. amended-goodbye) and the rebased (i.e. HEAD), with the
expectation that a bug may lose the authorship and instead use the
default one used in the test suite.  What this test truly cares is
not that amended-goodbye was authored by another.author, but it was
not written by the default author.

We could test both, like the attached patch, for completeness.  The
first half makes sure amended-goodbye (the original) was written by
the another.author, and the other one makes sure that author is not
the one we use to prepare commits for the tests by default.

I do not think the latter is actually a good idea ("As long as the
command produces a result different from THIS, any random garbage is
accepted" does not make a good test), so perhaps the first half
would be good enough.

 t/t3403-rebase-skip.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git c/t/t3403-rebase-skip.sh w/t/t3403-rebase-skip.sh
index e26762d0b2..1405720767 100755
--- c/t/t3403-rebase-skip.sh
+++ w/t/t3403-rebase-skip.sh
@@ -40,6 +40,14 @@ test_expect_success setup '
 	test_tick &&
 	git tag amended-goodbye &&
 
+	# Make sure the authorship info is different from the default one
+	echo "Another Author <another.author@example.com>" >expect &&
+	git log --pretty=format:"%an <%ae>" -1 amended-goodbye >actual &&
+	test_cmp expect actual &&
+
+	git log --pretty=format:"%an <%ae>" -1 goodbye >unexpect &&
+	! test_cmp unexpect actual &&
+
 	git checkout -f skip-reference &&
 	echo moo > hello &&
 	git commit -a -m "we should skip this" &&
