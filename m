From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/12] t5520: failing test for pull --all with no configured upstream
Date: Thu, 07 May 2015 10:38:04 -0700
Message-ID: <xmqq3838qoeb.fsf@gitster.dls.corp.google.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-11-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 19:38:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqPkZ-0006Za-40
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 19:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbbEGRiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 13:38:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752117AbbEGRiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 13:38:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF1524D537;
	Thu,  7 May 2015 13:38:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xkW0ULc+EvixK+l1EAao4+AzlrU=; b=ufVtb/
	QYiW8yl5otxj0AR07yN4xK3osyCN7vcIv88h6o7C2PG3i8qPk+Hj3rLrHJzFjLuZ
	8WujA7S3jgvGwa4mnOZywXrFPOVqVlzhSGyGjS2AWWIMXNL6sE2phVetbMyN/vNt
	Eb0wL+EpB0aI6lcPiJpMiRpmzfNuamx8qroeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JiVyB/zYgPzC1V5O5NP5Y/M4V/rNMoR8
	hxREouDUL/74OKYNP81sI5wtuPzS1oRRRoQztIyGl5FxVvwNetGf90VxyR1qRKAh
	kN2+4BYpqsBeFJKLyalkHKhV0cpmhr/rXQneo7mT1m7rcvDYnL5v2QbbJ7dc72om
	92IFRkOAcDg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D5FC34D536;
	Thu,  7 May 2015 13:38:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 169114D535;
	Thu,  7 May 2015 13:38:06 -0400 (EDT)
In-Reply-To: <1430988248-18285-11-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Thu, 7 May 2015 16:44:06 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1B41FC2-F4DF-11E4-8712-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268562>

Paul Tan <pyokagan@gmail.com> writes:

> error_on_no_merge_candidates() does not consider the case where "$#"
> includes command-line flags that are passed to git-fetch.
>
> As such, when the current branch has no configured upstream, and there
> are no merge candidates because of that, git-pull --all erroneously reports
> that we are pulling from "--all", as it believes that the first argument
> is the remote name.

Interesting.

I do not think "pull [origin] --all" makes much sense for the same
reason why we error out when you say "pull [origin] --tag", so I am
not sure "There is no tracking information" is the right diag we
would want to give the user, but I agree that "--all" is not a
remote name.

Does the same comment as 11/12 applies to this as well?

>
> Add a failing test that shows this case.
>
> Reported-by: Stephen Robin <stephen.robin@gmail.com>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     * Added this test to the patch series.
>
>  t/t5520-pull.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index d97a575..b93b735 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -153,6 +153,18 @@ test_expect_success 'fail if no configuration for current branch' '
>  	test `cat file` = file
>  '
>  
> +test_expect_failure 'pull --all: fail if no configuration for current branch' '
> +	git remote add test_remote . &&
> +	test_when_finished "git remote remove test_remote" &&
> +	git checkout -b test copy^ &&
> +	test_when_finished "git checkout -f copy && git branch -D test" &&
> +	test_config branch.test.remote test_remote &&
> +	test `cat file` = file &&
> +	test_must_fail git pull --all 2>out &&
> +	test_i18ngrep "There is no tracking information" out &&
> +	test `cat file` = file
> +'
> +
>  test_expect_success 'fail if upstream branch does not exist' '
>  	git checkout -b test copy^ &&
>  	test_when_finished "git checkout -f copy && git branch -D test" &&
