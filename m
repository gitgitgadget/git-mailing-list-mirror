Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA54CC433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 00:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9D860E96
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 00:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhJXAHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 20:07:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51616 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhJXAHF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 20:07:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E9C3315DC2A;
        Sat, 23 Oct 2021 20:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=N
        bGUFN1fyTay8wcZbF+Jxsy3KC87gFrVXZxYwcc2Vwk=; b=ZyPjw7jx1kZV9SHnO
        80jqmiF2P/gEF5melBZqTzCmRhZ7akL132b0Ris+ev6YLY/3/bxTcDIkC5yPYY41
        lvIWHzwVNs++66lmV0h74IWRiFof6ykm//esG81/mg8TW8A8UhkBslcNcMvU1M10
        NE8QQPAyCYIvtd/qD180Tas3nU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E41F915DC29;
        Sat, 23 Oct 2021 20:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 533DC15DC28;
        Sat, 23 Oct 2021 20:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Is t7006-pager.sh racy?
Date:   Sat, 23 Oct 2021 17:04:42 -0700
Message-ID: <xmqq1r4b8ezp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDA2C312-345D-11EC-BA4D-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems under --stress it is fairly easy to break the said test,
especially the one near the end

    test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
            test_when_finished "rm pager-used trace.normal" &&
            test_config core.pager ">pager-used; test-tool sigchain" &&
            GIT_TRACE2="$(pwd)/trace.normal" &&
            export GIT_TRACE2 &&
            test_when_finished "unset GIT_TRACE2" &&

            if test_have_prereq !MINGW
            then
                    OUT=$( ((test_terminal git log; echo $? 1>&3) | :) 3>&1 ) &&
                    test_match_signal 13 "$OUT"
            else
                    test_terminal git log
            fi &&

            grep child_exit trace.normal >child-exits &&
            test_line_count = 1 child-exits &&
            grep " code:143 " child-exits &&
            test_path_is_file pager-used
    '

When it fails the code in child-exits is actually -1 not 143, a
propagated pipe.

What makes us expect that the "git log" invocation should trigger a
SIGPIPE in the first place?  test-sigchain emitting a few lines and
exiting without ever reading from its standard input?  Will it
reliably die soon enough before, or linger around until, we attempt
to write to the pager?  If it does not die quickly enough, can we
attempt to write, successfully fill the buffer between us and the
pager, and wait to notice that test-sigchain exiting with non-zero,
or something?
