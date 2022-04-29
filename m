Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2221DC433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 18:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346574AbiD2SyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380082AbiD2SyC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 14:54:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3755820BEA
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 11:50:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E55B11B0E9;
        Fri, 29 Apr 2022 14:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=R03OQcaN1lgJxWTMGZs/k/ypn
        gDs72W8p/KwJykBoZM=; b=yGTd8V93Og+ZI+qcHiNb5C7ZIB018Ry19uVyRI5fW
        RwyXta6wMj3n6R6eykcH6DMS18FEphwedpjIAiQQVWRMUvOdD6EwQaENC+/6E1ry
        HODpjL4PxKv2CiQ7BKfMEX5nOJV0kZmffcXVko09v5c175+l2LGBDrNOoA3xx6XM
        aY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 669EC11B0E8;
        Fri, 29 Apr 2022 14:50:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C477D11B0E6;
        Fri, 29 Apr 2022 14:50:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running
 with sudo
References: <20220428033544.68188-1-carenas@gmail.com>
        <20220428105852.94449-1-carenas@gmail.com>
        <20220428105852.94449-4-carenas@gmail.com>
        <xmqq7d79du6c.fsf@gitster.g>
        <CAPUEspiCjQRiaOcvSVgS5cZ9q=o6YeZgjp5s3BRZEByD=9Un2Q@mail.gmail.com>
        <xmqqv8usex1v.fsf@gitster.g>
        <20220429012438.37o4uaxsrfdu2b6x@carlos-mbp.lan>
Date:   Fri, 29 Apr 2022 11:50:40 -0700
Message-ID: <xmqqee1fbu67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 44DDF058-C7ED-11EC-976B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> If we do :
>
>   [0] login as regular user || sudo to root || login as root

Among these three, the last one is equivalent to "sudo and then
unset the environment", right?

As many installations no longer allow direct "login" as "root",
clarifying how users can get the behaviour for the third column
would help our documentation, and that is the reason behind the
question.  IOW, this is merely a simple yes-or-no question to
sanity-check our mutual understanding, and no need to get overly
defensive about being asked.

>   [1] % mkdir -p root/r
>   [2] % git init root/r
>   [3] % cd root/r && git status
>
>   step \ type | regular user | sudo to root | root
> --------------------------------------------------
>             1 |    work      |     work     | work
>   before    2 |    work      |     work     | work
>             3 |    work      |     work     | work
> ---------------------------------------------------
>             1 |    work      |     work     | work
>    after    2 |    work      |     work     | work
>             3 |    work      |     fail     | work

So the only difference is that in a repository created by a user who
did "sudo mkdir; sudo git init".  It used to be that the same user
can read the repository with "sudo git status" (because we did not
care about how we become 'root', we only saw the owner of the repo
and the current euid).  Now, such an access is no longer allowed.

And a workaround is to use the third-column behaviour, i.e. either
login as root (which is probably too cumbersome as a step in a
typical "make && make test && make install" sequence where at least
the last step need to be done as a privileged user) or use "sudo"
and drop the SUDO_UID environment, for which, the documentation was
added in this series.

But I do not see what relevance the above has to the argument you
were making, against "if you start these tests as 'root' (instead of
starting as an ordinary user), some tests may succeed but for a
wrong reason, and some tests may fail because they are not prepared
for it; it is wrong to mark only the latter with prerequisite and
not the former".  The change in the behaviour we see above is for
those who start as an ordinary user and uses "sudo" without dropping
SUDO_UID.  How is it relevant to allow those who start the test as
'root' (not an ordinary user) to try that?  Tests done under such
condition will see 'root' in euid, SUDO_UID, and st.st_uid, so there
is no way for them to detect any mismatch and behave differently,
so the transition from "it used to work" to "now it is forbidden"
is not even tested.

> and rejects the repository because it is NOT owned by that id (it was c=
reated
> by root anyway, even if there is no way for git to know that it was don=
e
> at a different time and with a different session, and therefore the SUD=
O_UID
> variable it is honoring could be considered irrelevant in the current c=
ontext.
>
> in the documentation patch (which I think would be better to squash wit=
h the
> fix) I explain what to do as a workaround, and I expect this use case t=
o be
> less common than the currently broken one (so a net positive)

Both of these two paragraphs speak truth, but there is no relevance
to, and it does not justify, your "I disagree, and think that the
fact ... proves my point".

For example, this is the 'setup' step.

> +test_expect_success SUDO 'setup' '
> +	sudo rm -rf root &&
> +	mkdir -p root/r &&
> +	sudo chown root root &&
> +	(
> +		cd root/r &&
> +		git init
> +	)
> +'

If the test was started by an ordinary user, root/r is owned by the
user who is not 'root'.  If the test was started by 'root',
everything is owned by 'root'.  Either way, 'root' is owned by
'root'.  In such a repository, we see this test:

+test_expect_success SUDO 'sudo git status as original owner' '
+	(
+		cd root/r &&
+		git status &&
+		sudo git status
+	)
+'

The behaviour we are trying to ensure is that, even though root/r is
owned by non-root, accessing it with "git status" as the original
user and "git status" as root work, as long as if you used "sudo" in
the second "git status", so that "git status" can take SUDO_UID into
account.  The test is making sure that our "pay attention to
SUDO_UID" mechanism has not been broken by future changes.

If we start this test as 'root', we cannot test for that.  The setup
step made everything owned by 'root', and we go there as 'root' and
run "git status", which should succceed, but with "sudo git status",
even we broke SUDO_UID mechanism and compared euid with st.st_uid,
we'll allow an access.

So the test may succeed but it succeeds for a wrong reason even
after we break the mechanism added by this series.
