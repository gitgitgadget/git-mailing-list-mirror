From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 7/7] t/t7507: tests for broken behavior of status
Date: Mon, 02 May 2016 16:07:22 -0700
Message-ID: <xmqq7ffcqct1.fsf@gitster.mtv.corp.google.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462046616-2582-7-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 01:07:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axMw7-0001XD-GR
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 01:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbcEBXH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 19:07:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755247AbcEBXH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 19:07:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1491119DE3;
	Mon,  2 May 2016 19:07:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=peq5hgwh+q9mpzXxOYRo6We0Qlk=; b=VX0xFf
	XZmxnbpDQ2uOTuz9IV9rsxJx0otrEYaRTRzfSF/JHUSEXXk6tkgTUbobcKebw3Mx
	F23ZD9grimb5kQvG8Y7DSvgWmJ/lQCuUuzRsZEQ494MJWf3hNxCpAg5fZiGi+sv8
	iocJQvuxkvOCNdhgSNjaJl89jXdUoZFdAAR90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p/9+TtVSnXhFFghcct28zmxY0IjdNrm6
	g8hZdFPk/kkTrv/lUxxMwMQL4ZzqrfJ4f5ol942U7rkaYx+pfjen95slxfmfADuj
	BoTDTP/6OevwTbT/Bw2scgajOrXCa5RtJo6pkvo94U7wMgk79+LDn+mpIsLrkP6r
	GOrCdbL1O6w=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AB1E19DE2;
	Mon,  2 May 2016 19:07:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CA4219DE1;
	Mon,  2 May 2016 19:07:24 -0400 (EDT)
In-Reply-To: <1462046616-2582-7-git-send-email-pranit.bauva@gmail.com> (Pranit
	Bauva's message of "Sun, 1 May 2016 01:33:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1B8859A-10BA-11E6-8364-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293300>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Variable named 'verbose' in builtin/commit.c is consumed by git-status
> and git-commit so if a new verbose related behavior is introduced in
> git-commit, then it should not affect the behavior of git-status.
>
> One previous commit (title: commit: add a commit.verbose config
> variable) introduced a new config variable named commit.verbose,
> so care should be taken that it would not affect the behavior of
> status.
>
> Another previous commit (title: "parse-options.c: make OPTION_COUNTUP
> respect "unspecified" values") changes the initial value of verbose
> from 0 to -1. This can cause git-status to display a verbose output even
> when it isn't supposed to.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>
> ---
> This is a split off from the previous patch 6/6 as suggested by Eric
> Sunshine.

If these are documenting what your previous patches broke, then
there test body should describe what should happen, and then if it
is broken, use test_expect_failure, no?

Your first test does "run status with commit.verbose is set, and
make sure the "diff --git" does not appear", which is correct, so if
it does not work, test_expect_failure would be the right thing to
use.

These, especially the latter, look rather unpleasant regressions to
me, and the main commit.verbose change would need to be held back
before they are fixed.

> ---
>  t/t7507-commit-verbose.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 2bb6d8d..00e0c3d 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -144,4 +144,14 @@ do
>  	"
>  done
>  
> +test_expect_success 'status ignores commit.verbose=true' '
> +	git -c commit.verbose=true status >actual &&
> +	! grep "^diff --git" actual
> +'
> +
> +test_expect_success 'status does not verbose without --verbose' '
> +	git status >actual &&
> +	! grep "^diff --git" actual
> +'
> +
>  test_done
