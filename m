Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B210C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BF320872
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w4PkxO8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgKYXxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 18:53:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50154 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgKYXxp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 18:53:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 945AD8E983;
        Wed, 25 Nov 2020 18:53:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SqAb1yPCzxW1qoQqoTRFUBVuFco=; b=w4PkxO
        8gw3zA+6NdSpiWgQiSz34LkKdmT45XPUlugyYXLi73owkssOShqA6PJ8Vndh/b5J
        D0540TXihuOVXy+cJoCiGqP2HLS9sS262NLjttTtQyb+R8jqJXYC0oXeH4rnoJ0w
        57b2jBro1c39Zz832/hhqddnsm4gZeDGmuJmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jLGe9c+jfbnBdPPVJq6zSnc+8Hj1VzhE
        TAfoUlhUC7xuOjOvU0we9oixLMAR/14bN45s6YOyT0I1TpJsFZEfBn3rX+ooXDaE
        l/fSCfxxME+cOgbGAPEaBp06iek4e0JngjCpGOsBhy1rb+K5bhlkr672zDCQ0RCh
        m8c0EUE9A40=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C0468E982;
        Wed, 25 Nov 2020 18:53:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 156C78E97E;
        Wed, 25 Nov 2020 18:53:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>
Subject: Re: [PATCH v3 3/3] refspec: make @ a synonym of HEAD
References: <20201125233443.63130-1-felipe.contreras@gmail.com>
        <20201125233443.63130-4-felipe.contreras@gmail.com>
Date:   Wed, 25 Nov 2020 15:53:42 -0800
In-Reply-To: <20201125233443.63130-4-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Wed, 25 Nov 2020 17:34:43 -0600")
Message-ID: <xmqqpn41at89.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72F3D6E6-2F79-11EB-83DB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Since commit 9ba89f484e git learned how to push to a remote branch using
> the source @, for example:
>
>   git push origin @:master
>
> However, if the right-hand side is missing, the push fails:
>
>   git push origin @
>
> It is obvious what is the desired behavior, and allowing the push makes
> things more consistent.
>
> Additionally, @:master now has the same semantics as HEAD:master.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  refspec.c             |   5 +-
>  t/t5511-refspec.sh    |   2 +
>  t/t5516-fetch-push.sh | 106 ++++++++++++++++++++++--------------------
>  3 files changed, 61 insertions(+), 52 deletions(-)

Sorry, but I cannot queue this version in today's pushout due to
time constraints.

> -test_expect_success 'push with HEAD' '
> +for head in HEAD @; do

Style: replace "; " with a LF.

> +	test_expect_success "push with $head" "

Don't open the test body with double-quote; keep using the original
single-quote and the reference to $head is resolved while running
the test, not when the test body is formulated before eval'ed.

Two benefits are

 - (obvious) you do not need extra quoting, e.g. \$the_commit etc.

 - in this case it does not matter, but it works intuitively when
   the variable has $IFS whitespace in it.  If you write in the test
   body that is enclosed in a single-quote pair,

		git push testrepo "$head"

   would correctly give the contents of variable head as a single
   element in argv[] of "git push".

For the latter reason, it is encouraged to make it a habit to do so.

Thanks.
