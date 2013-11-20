From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7507-*.sh: Fix test #8 (could not run '"$FAKE_EDITOR"')
Date: Wed, 20 Nov 2013 09:22:31 -0800
Message-ID: <xmqqsiur6l9k.fsf@gitster.dls.corp.google.com>
References: <528CE716.8060307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens.Lehmann@web.de, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Nov 20 18:23:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjBUO-000733-6s
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 18:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607Ab3KTRWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 12:22:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754541Ab3KTRWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 12:22:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8860531A7;
	Wed, 20 Nov 2013 12:22:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EaRR6NzSQy8aCujucublZPxrkj8=; b=H+G1t3
	lo1Tu4lGqFpbo1repsKybaYNRtx0Vwc5rLADlCMMhtSenuaPrpRofUjr9uiSKExI
	1cfsdBUhHJV0WH8AtmWCuKGnhCDHheiKS+YbTjIX1GmNtpVN6OEKfyvYVjXi0lWm
	BaOpC+AZIOs/xq0jfIH8pmQvT0cvYDz91ATO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=geS0WQzicUN5QazHszjkciynItWoVxCq
	E2cKZBCajjx5S32dap4LEKZPE7t7hWKUDQfKGV1cGbxuMBKOVRG0LmxbccXf+sGC
	gGElJCG6JWD8DqzF6CyUs1BqSg07tLLzljQzFMQXFWovF0e2IBU1zw3XzRpt4t35
	ZVbxXKyqDYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2A9A531A6;
	Wed, 20 Nov 2013 12:22:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E08553198;
	Wed, 20 Nov 2013 12:22:35 -0500 (EST)
In-Reply-To: <528CE716.8060307@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Wed, 20 Nov 2013 16:45:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 58BDD98A-5208-11E3-9B82-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238083>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Jens,
>
> commit 61b6a633 ("commit -v: strip diffs and submodule shortlogs
> from the commit message", 19-11-2013) in 'pu' fails the new test
> it added to t7507.
>
> I didn't spend too long looking at the problem, so take this patch
> as nothing more than a quick suggestion for a possible solution! :-P
> [The err file contained something like: "There was a problem with the
> editor '"$FAKE_EDITOR"'"].
>
> Having said that, this fixes it for me ...

Well spotted.  test_must_fail being a shell function, not a command,
we shouldn't have used the "VAR=val cmd" one-shot environment
assignment for portability.

Even though this happens to be the last test in the script, using
test_set_editor to permanently affect the choice of editor for tests
that follow is not generally a good idea.  It would be safer to do
this, I would have to say:

		git commit -a -m "submodule commit"
	) &&
        (
		GIT_EDITOR=cat &&
                export GIT_EDITOR &&
                test_must_fail git commit -a -v 2>err
	) &&
        test_i18ngrep "Aborting ..."

Thanks.

> ATB,
> Ramsay Jones
>
>  t/t7507-commit-verbose.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 09c1150..49cfb3c 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -79,7 +79,8 @@ test_expect_success 'submodule log is stripped out too with -v' '
>  		echo "more" >>file &&
>  		git commit -a -m "submodule commit"
>  	) &&
> -	GIT_EDITOR=cat test_must_fail git commit -a -v 2>err &&
> +	test_set_editor cat &&
> +	test_must_fail git commit -a -v 2>err &&
>  	test_i18ngrep "Aborting commit due to empty commit message." err
>  '
