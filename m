Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BFCEC875D
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 21:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjIGVQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjIGVQO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 17:16:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D002092
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 14:16:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D012D1A5F02;
        Thu,  7 Sep 2023 17:16:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=fKOD8NHFznYm3Cm05Dv+O4ekkEroi6ATsW5L10
        uWlDw=; b=MAmolTDYmn0YDgocvNslE/Bmi7pIoEK0lnj+b/uxBo8xFT0FB6xAFL
        jY8thUxasjQp9tercU2AVDvAfNpYF0CbalgPSAeMLSNvAiHYngr8u8i8DnkahFtE
        fymuiJWAXzZIy2EaBrjo5Ye3EnmuXymp8UqHFq0nCtiZSNXmzWCrA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C87721A5F01;
        Thu,  7 Sep 2023 17:16:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 317CF1A5EFF;
        Thu,  7 Sep 2023 17:16:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
In-Reply-To: <pull.1581.git.1694080982621.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Thu, 07 Sep 2023 10:03:02 +0000")
References: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 14:16:07 -0700
Message-ID: <xmqq5y4lk7l4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3189C4A-4DC3-11EE-9D85-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the user presses Ctrl-C to interrupt a program run by a rebase "exec"
> command then SIGINT will also be sent to the git process running the
> rebase resulting in it being killed. Fortunately the consequences of
> this are not severe as all the state necessary to continue the rebase is
> saved to disc but it would be better to avoid killing git and instead
> report that the command failed.

The above made me wonder if we can guarantee that the intention of
the end-user is always to kill only the external program and not
"git".  But with or without this change, "git" will stop making
progress after such a signal (in other words, it is not like killing
"exec sleep 20" will make "git rebase -i -x 'sleep 20'" to move to
the next step without complaining), so "ignore signals" is not all
that harmful as the phrasing makes it sound like.  With the patch,
we just handle signals that will kill the external programs, and
their consequences, a bit more gracefully.

But that makes me wonder what happens if the external program has
good reasons to ignore the signal (that is, the program does not die
when signaled, without misbehaving).  If "git" dies in such a case,
would it help the overall end-user experience, or would it even
hurt?  If the latter, then "git" that ignores these interactive
interrupts would be improvement in both cases (i.e. external
programs that dies with signals, and those that ignores them).  If
the former, however, "git" that ignores the signals would be a
regression.

Other than that, the change is well reasoned, I would think.

Thanks.

