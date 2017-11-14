Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BBD8201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 02:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbdKNCth (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 21:49:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56302 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751182AbdKNCtg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 21:49:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02221ABB08;
        Mon, 13 Nov 2017 21:49:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wcIgeVcKr1cnPN/1z0pydNo1hO0=; b=MHp78V
        NUp4YJv7q+ZPTFeILD7nYIeDSgmjoOwJYgkh+gKNtF2o99Bs1MvhhyKbqX3JWVVv
        bqpEdiAuSVTXVqpYWNvk68jP3qR+siEZ7+DFH4unEMMlvy1Tq9Mf7Adopm4J45Is
        r0wMZoxAanLfnUp1ldvOUncWjQSzQx/1mc8VU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uu6hcLuJKDzF2iQ6/CAIJWTCYIApXh8n
        AHeg62C9slVJPBetFMt5jPHEkwT3Yh3xBNEoQYtmJiSb9t2JNH6ufp4ZcRR9v1wc
        +OVfJrK4og66M0QU6EuB+eeqEexOLbFkG+VSEkhpvLJE7kb+qF7EdBaFRN0oY7LO
        Z1GUETqjg7I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED78CABB07;
        Mon, 13 Nov 2017 21:49:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 667D7ABB06;
        Mon, 13 Nov 2017 21:49:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
References: <20171113210745.24638-1-tmz@pobox.com>
Date:   Tue, 14 Nov 2017 11:49:34 +0900
In-Reply-To: <20171113210745.24638-1-tmz@pobox.com> (Todd Zullinger's message
        of "Mon, 13 Nov 2017 16:07:45 -0500")
Message-ID: <xmqq60ad7ewx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72EE7FEA-C8E6-11E7-A85F-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> In 29ff1f8f74 (t: lib-gpg: flush gpg agent on startup, 2017-07-20), a
> call to gpgconf was added to kill the gpg-agent.  The intention was to
> ignore all output from the call, but the order of the redirection needs
> to be switched to ensure that both stdout and stderr are redirected to
> /dev/null.  Without this, gpgconf from gnupg-2.0 releases would output
> 'gpgconf: invalid option "--kill"' each time it was called.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>
> I noticed that gpgconf produced error output for a number of tests on
> CentOS/RHEL.  As an example:
>
>     *** t5534-push-signed.sh ***
>     gpgconf: invalid option "--kill"
>
> Looking at the code in lib-gpg.sh, it appeared the intention was to ignore this
> output.  Reading through the review of the patch confirmed that feeling[1].  The
> current code gets caught by the subtleties of output redirection.  (Who hasn't
> been burned at some point by the difference between '2>&1 >/dev/null' and
> '>/dev/null 2>&1' ? ;)

**Blush**.  I should have caught this during the review.  Thanks.

> Lastly, I also noticed that git-rebase.sh uses the same 2>&1 >/dev/null.  I
> suspect it's similarly not intentional:
>
>     $ git grep -h -C4 '2>&1 >/dev/null' -- git-rebase.sh
>     apply_autostash () {
>     	if test -f "$state_dir/autostash"
>     	then
>     		stash_sha1=$(cat "$state_dir/autostash")
>     		if git stash apply $stash_sha1 2>&1 >/dev/null
>     		then
>     			echo "$(gettext 'Applied autostash.')" >&2
>     		else
>     			git stash store -m "autostash" -q $stash_sha1 ||
>
> I'll send a separate patch to adjust that code as well.

If it were intentional, the caller of apply_autostash() must be
expecting to see an error message from its standard output and
prepared to do something interesting with it, which I do not see, so
I agree that it is a typo.  Thanks.

I wonder if this line in 3320 is doing what it meant to do:

    test_must_fail git notes merge z 2>&1 >out &&
    test_i18ngrep "Automatic notes merge failed" out &&
    grep -v "A notes merge into refs/notes/x is already in-progress in" out

