Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B949F21279
	for <e@80x24.org>; Thu, 11 Aug 2016 22:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbcHKWo6 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 18:44:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751204AbcHKWo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 18:44:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C25632D8D;
	Thu, 11 Aug 2016 18:44:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vFqnqZu5gEudMkLj0aBGFAzTzok=; b=rGP+OL
	VDzyouWaxjurpaomFXUbycg5PxhF1PNOQv48WA17kRjJJIwXAns99NTP+Zjn7GsY
	4gIwz8sLCsrevo/9GNfccATq4L3I91vCdAMsUEDAjhSSAWEKLPbbrz3q0JMNzdFU
	PNXbWVyi2XXSCu59TR528g4tWXuyz5+jcX6FM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CN50BtRKva/5BJIPPI5AB3Fk/BCpV7tb
	JekdOu7NvTKXGrdriav1Fua5gHZ1e1voBK2gA5iIF3ZzSEBbVCYWKes3xwUwc1f8
	HHYFxtDQGW5FVzequYXnGtkq/WMxIuaQNfbIaf9P3UAftZ7E63dP8pWaz2KhoM3G
	rKKB5ul803Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8369C32D8C;
	Thu, 11 Aug 2016 18:44:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5C9732D8B;
	Thu, 11 Aug 2016 18:44:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>,
	Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" + "pull.rebase = preserve" - "user.email"
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
	<xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
	<20160729181121.GB14953@sigill.intra.peff.net>
	<xmqq1t2cnvco.fsf@gitster.mtv.corp.google.com>
	<20160729223134.GA22591@sigill.intra.peff.net>
Date:	Thu, 11 Aug 2016 15:44:52 -0700
In-Reply-To: <20160729223134.GA22591@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Jul 2016 18:31:35 -0400")
Message-ID: <xmqqvaz7x6vv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3997D9C0-6015-11E6-B9FF-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Earlier, Peff sent this patch (slightly buried in a discussion) on
"rebase -i" in <20160729223134.GA22591@sigill.intra.peff.net>.

> Subject: rebase-interactive: drop early check for valid ident
>
> Since the very inception of interactive-rebase in 1b1dce4
> (Teach rebase an interactive mode, 2007-06-25), there has
> been a preemptive check, before looking at any commits, to
> see whether the user has a valid name/email combination.
>
> This is convenient, because it means that we abort the
> operation before even beginning (rather than just
> complaining that we are unable to pick a particular commit).
>
> However, it does the wrong thing when the rebase does not
> actually need to generate any new commits (e.g., a
> fast-forward with no commits to pick, or one where the base
> stays the same, and we just pick the same commits without
> rewriting anything). In this case it may complain about the
> lack of ident, even though one would not be needed to
> complete the operation.
>
> This may seem like mere nit-picking, but because interactive
> rebase underlies the "preserve-merges" rebase, somebody who
> has set "pull.rebase" to "preserve" cannot make even a
> fast-forward pull without a valid ident, as we bail before
> even realizing the fast-forward nature.
>
> This commit drops the extra ident check entirely. This means
> we rely on individual commands that generate commit objects
> to complain. So we will continue to notice and prevent cases
> that actually do create commits, but with one important
> difference: we fail while actually executing the "pick"
> operations, and leave the rebase in a conflicted, half-done
> state.
>
> In some ways this is less convenient, but in some ways it is
> more so; the user can then manually commit or even "git
> rebase --continue" after setting up their ident (or
> providing it as a one-off on the command line).
>
> Reported-by: Dakota Hawkins <dakotahawkins@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

To which, I responded (referring to the last paragraph):

    Yup, that is the controvercial bit, and I suspect Dscho's original
    was siding for the "set up ident first, as you will need it anyway
    eventually", so I'll let others with viewpoints different from us to
    chime in first before picking it up.

Do you have a preference either way to help us decide if we want to
take this change or not?

Thanks.

>  git-rebase--interactive.sh |  3 ---
>  t/t7517-per-repo-email.sh  | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index ded4595..f0f4777 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1180,9 +1180,6 @@ To continue rebase after editing, run:
>  	;;
>  esac
>  
> -git var GIT_COMMITTER_IDENT >/dev/null ||
> -	die "$(gettext "You need to set your committer info first")"
> -
>  comment_for_reflog start
>  
>  if test ! -z "$switch_to"
> diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
> index 337e6e3..2a22fa7 100755
> --- a/t/t7517-per-repo-email.sh
> +++ b/t/t7517-per-repo-email.sh
> @@ -36,4 +36,51 @@ test_expect_success 'succeeds cloning if global email is not set' '
>  	git clone . clone
>  '
>  
> +test_expect_success 'set up rebase scenarios' '
> +	# temporarily enable an actual ident for this setup
> +	test_config user.email foo@example.com &&
> +	test_commit new &&
> +	git branch side-without-commit HEAD^ &&
> +	git checkout -b side-with-commit HEAD^ &&
> +	test_commit side
> +'
> +
> +test_expect_success 'fast-forward rebase does not care about ident' '
> +	git checkout -B tmp side-without-commit &&
> +	git rebase master
> +'
> +
> +test_expect_success 'non-fast-forward rebase refuses to write commits' '
> +	test_when_finished "git rebase --abort || true" &&
> +	git checkout -B tmp side-with-commit &&
> +	test_must_fail git rebase master
> +'
> +
> +test_expect_success 'fast-forward rebase does not care about ident (interactive)' '
> +	git checkout -B tmp side-without-commit &&
> +	git rebase -i master
> +'
> +
> +test_expect_success 'non-fast-forward rebase refuses to write commits (interactive)' '
> +	test_when_finished "git rebase --abort || true" &&
> +	git checkout -B tmp side-with-commit &&
> +	test_must_fail git rebase -i master
> +'
> +
> +test_expect_success 'noop interactive rebase does not care about ident' '
> +	git checkout -B tmp side-with-commit &&
> +	git rebase -i HEAD^
> +'
> +
> +test_expect_success 'fast-forward rebase does not care about ident (preserve)' '
> +	git checkout -B tmp side-without-commit &&
> +	git rebase -p master
> +'
> +
> +test_expect_success 'non-fast-forward rebase refuses to write commits (preserve)' '
> +	test_when_finished "git rebase --abort || true" &&
> +	git checkout -B tmp side-with-commit &&
> +	test_must_fail git rebase -p master
> +'
> +
>  test_done
