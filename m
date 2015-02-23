From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: preserve commit messages
Date: Mon, 23 Feb 2015 10:54:53 -0800
Message-ID: <xmqqsidwtq4i.fsf@gitster.dls.corp.google.com>
References: <1424540906.15539.22.camel@scientia.net>
	<f58ae048d7fd468cfdd7f7d369b3b4fc0a564641.1424697676.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 19:56:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPyAk-0005EI-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 19:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbbBWSz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 13:55:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753126AbbBWSzz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 13:55:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C2FF33AECA;
	Mon, 23 Feb 2015 13:55:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CMSyOH2S18tSyNwED0KzRNHZ15U=; b=rmDA++
	A9jBH5abRoauj5IDx206Td7UzAdpRZuQn9A0XQ6nCXYmq7WdDqv78Wd6IFn6OvV0
	3wzKQyN9uUNeiFP7E4E/KuX2K18rcqSU37wfnE7e+WPY7C5206qFKfDDLInoKdUn
	CQtwEpmb8c8xrPKxJeSMTxzJryqAiYfKls9IQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=leJdhVfq8Ho7aVgPo9WgebsBGQK8tBJ4
	1MLPKmwWxKTdyIP/ykO2UBIJ0uiwERkviucsdzHOjXdN2Vq3uFwu3PnVZ9SCnYpK
	pkpieLSwE5mavugNB/9ag+JGjbaZ8uNpuDRX8O63yTijqbYj2WhDhV44jFrC9ZJA
	jI6MOHNMmQU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B80FE3AEC9;
	Mon, 23 Feb 2015 13:55:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 911F13AE8C;
	Mon, 23 Feb 2015 13:54:54 -0500 (EST)
In-Reply-To: <f58ae048d7fd468cfdd7f7d369b3b4fc0a564641.1424697676.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Mon, 23 Feb 2015 14:23:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 746CDDEE-BB8D-11E4-BAFC-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264283>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> sequencer calls "commit" with default options, which implies
> "--cleanup=default" unless the user specified something else in their
> config. This leads to cherry-picked commits getting a cleaned up commit
> message, which is usually not an intended side-effect.
>
> Make the sequencer use "--cleanup=verbatim" so that it preserves commit
> messages independent of the defaults and user config for "commit".

Hmm, wouldn't it introduce a grave regression for users who
explicitly ask to clean crufty messages up (by setting their own
commit.cleanup configuration) if you unconditionally force
"--cleanup=verbatim" here?

>
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>
> Notes:
>     All tests run fine with this changed behavior. I don't know
>     whether this may have any side-effects on other (untested)
>     uses of the sequencer.
>
>  sequencer.c              |  1 +
>  t/t3511-cherry-pick-x.sh | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 77a1266..35fe9d9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -377,6 +377,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  	argv_array_init(&array);
>  	argv_array_push(&array, "commit");
>  	argv_array_push(&array, "-n");
> +	argv_array_push(&array, "--cleanup=verbatim");



>  
>  	if (opts->gpg_sign)
>  		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
> diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
> index f977279..b7dff09 100755
> --- a/t/t3511-cherry-pick-x.sh
> +++ b/t/t3511-cherry-pick-x.sh
> @@ -36,6 +36,20 @@ mesg_with_cherry_footer="$mesg_with_footer_sob
>  (cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
>  Tested-by: C.U. Thor <cuthor@example.com>"
>  
> +mesg_unclean="$mesg_one_line
> +
> +
> +leading empty lines
> +
> +
> +consecutive empty lines
> +
> +# hash tag comment
> +
> +trailing empty lines
> +
> +
> +"
>  
>  test_expect_success setup '
>  	git config advice.detachedhead false &&
> @@ -53,6 +67,10 @@ test_expect_success setup '
>  	test_commit "$mesg_with_footer_sob" foo b mesg-with-footer-sob &&
>  	git reset --hard initial &&
>  	test_commit "$mesg_with_cherry_footer" foo b mesg-with-cherry-footer &&
> +	git reset --hard initial &&
> +	test_config commit.cleanup verbatim &&
> +	test_commit "$mesg_unclean" foo b mesg-unclean &&
> +	test_unconfig commit.cleanup &&
>  	pristine_detach initial &&
>  	test_commit conflicting unrelated
>  '
> @@ -216,4 +234,14 @@ test_expect_success 'cherry-pick -x -s treats "(cherry picked from..." line as p
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'cherry-pick preserves commit message' '
> +	pristine_detach initial &&
> +	printf "$mesg_unclean" >expect &&
> +	git log -1 --pretty=format:%B mesg-unclean >actual &&
> +	test_cmp expect actual &&
> +	git cherry-pick mesg-unclean &&
> +	git log -1 --pretty=format:%B >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
