Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C77C2D0F7
	for <git@archiver.kernel.org>; Tue, 12 May 2020 20:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19832312A
	for <git@archiver.kernel.org>; Tue, 12 May 2020 20:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mOiBFsdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbgELUFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 16:05:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60728 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbgELUFM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 16:05:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39474BC791;
        Tue, 12 May 2020 16:05:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pb1sVtv3KVpZ4+lKfjb8sROHIhY=; b=mOiBFs
        dBarOy0Ntz7IPKq4qwgbVh0a82cCB5gbMZS2kisV17IUwrFsLB8N2kHXLlRTjkaM
        fb7ENYgjSHb1hnLO/67Ri8iHM+3rR1w9JYBGUKQlZc1uHuEZU6arfbcHR4qP+QEz
        +8D/cXG0mUg38vGbIzGgAegudXKWMkBNXBZ4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WlhlKNVr8XVNIYjCcBiMuwlfWKTaDVnT
        9izbLL/zNIbIPZmZOpYw/5ofUU5iFzbfO5VqXIStkf5EanQvVUoQNiMZWK5v/Od2
        kcq175VMg0oPoeshFG2W9TnmbwQftxiewYhwsV1NmrJwC5FAPTrQhdXvrNO4vyhj
        Z65tyAHGjkg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30E7ABC790;
        Tue, 12 May 2020 16:05:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 043DBBC78F;
        Tue, 12 May 2020 16:05:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v2] git-p4.py: fix --prepare-p4-only error with multiple commits
References: <pull.775.git.git.1588352952840.gitgitgadget@gmail.com>
        <pull.775.v2.git.git.1589289359302.gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 13:05:02 -0700
In-Reply-To: <pull.775.v2.git.git.1589289359302.gitgitgadget@gmail.com> (Ben
        Keene via GitGitGadget's message of "Tue, 12 May 2020 13:15:59 +0000")
Message-ID: <xmqq1rnodimp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE5EF9C6-948B-11EA-ABB0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ...
> Be aware - this change will fix the existing test error in t9807.23
> for --prepare-p4-only. However there is insufficent coverage for
> this flag.  If more than 1 commit is pending submission to P4, the
> method will properly prepare the P4 changelist, however it will
> still exit the application with an exitcode of 1.
>
> The current documentation does not define what the exit code should be
> in this condition.
> (See: https://git-scm.com/docs/git-p4#Documentation/git-p4.txt---prepare-p4-only)

Then some proposal to define what the behaviour should be is needed,
the consensus implements and then documented.

>
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---


>     git-p4.py: fix --prepare-p4-only error with multiple commits
>     
>     When using git p4 submit with the --prepare-p4-only option, the program
>     should prepare a single p4 changelist and notify the user that more
>     commits are pending and then stop processing.
>     
>     A bug has been introduced by the p4-changelist hook feature that causes
>     the program to continue to try and process all pending changelists at
>     the same time.
>     
>     The function applyCommit should return True when applying the commit was
>     successful and the program should continue. In the case of the
>     --prepare-p4-only flag, the function should return False, alerting the
>     caller that the program should not proceed with additional commits.
>     
>     Change the return value from True to False in the applyCommit function
>     when git-p4 is executed with --prepare-p4-only flag.

This space below the three-dash-line is the best place to describe
the difference between the previous version and this one.  It seems
that the above text is not such a "here are what was bad/missing in
v1 that got fixed/extended", or a copy of the log message (like many
patches that come from GGG has).  I am a bit puzzled what it is, but
for now let's pretend there wasn't any text below the three-dash-line
and read on.

>  git-p4.py | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index b8b2a1679e7..c4a4012bcc1 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2537,11 +2537,12 @@ def run(self, args):
>                  ok = self.applyCommit(commit)
>              if ok:
>                  applied.append(commit)
> -            else:
> -                if self.prepare_p4_only and i < last:
> -                    print("Processing only the first commit due to option" \
> -                          " --prepare-p4-only")

So, it used to be that after failing to apply a commit, unless we
are at the last step, we gave a message and left the loop under the
prepare-p4-only mode.  We did not do anything special under the
prepare-p4-only mode if applyCommit returned a success.

> +                if self.prepare_p4_only:
> +                    if i < last:
> +                        print("Processing only the first commit due to option" \
> +                                " --prepare-p4-only")

Now, after successfully applying, we leave the loop under the
prepare-p4-only mode.  We give the message only when we are not at
the last step.

>                      break
> +            else:

So..., what happens when the first step fails to apply and then the
user tells us to skip the commit?  We'll go on to the next commit
and then applyCommit() may say 'ok' this time around.  Does that
count as "processed only the first commit and we are done"?

>                  if i < last:
>                      # prompt for what to do, or use the option/variable
>                      if self.conflict_behavior == "ask":
>
> base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
