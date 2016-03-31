From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-send-pack: fix --all option when used with directory
Date: Thu, 31 Mar 2016 13:28:39 -0700
Message-ID: <xmqq1t6qmlxk.fsf@gitster.mtv.corp.google.com>
References: <1459432509-12934-1-git-send-email-stanislav@assembla.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, dborowitz@google.com
To: stanislav@assembla.com
X-From: git-owner@vger.kernel.org Thu Mar 31 22:29:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljDB-0007RW-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 22:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930AbcCaU2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 16:28:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932260AbcCaU2n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 16:28:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C8D4D52B4A;
	Thu, 31 Mar 2016 16:28:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=50Rtz+sh7hyLo1Zq2u4aKOwRALE=; b=hUMCTE
	9K6u6wO038GL04Q7qgY1urzW57GQSBwJVnMTHqclTbhyOGzfNq3K6SdYN54EfL3/
	4FupOGjtdDh/O05sxirpZP2d0Ou9j5mFlgIquteqGeJQ9XY84CjyyYWiM29pkgJS
	fsC1bIOw2vj0nGUSX++QTtJM5w4s0j/uEYry8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KBfRHQQMY5PNl81CCweDDwY0Y1+A18Fd
	mtc1Hutls8UycxZJvujid5AltmrhQeXN0AdPCi9weQJJhlHerkCXi/SBIUpLGAqO
	CuQKzDzXP6qTxXFMz972PzGYpOD99uWuJwYhdh532htckaK19+DtRFWLh5ymIdRz
	3BJ6dWORWls=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0B1C52B49;
	Thu, 31 Mar 2016 16:28:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3F98352B47;
	Thu, 31 Mar 2016 16:28:41 -0400 (EDT)
In-Reply-To: <1459432509-12934-1-git-send-email-stanislav@assembla.com>
	(stanislav@assembla.com's message of "Thu, 31 Mar 2016 16:55:09
	+0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 283E45F0-F77F-11E5-9FF8-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290462>

stanislav@assembla.com writes:

> From: Stanislav Kolotinskiy <stanislav@assembla.com>
>
> When using git send-pack with --all option
> and a target repository specification ([<host>:]<directory>),
> usage message is being displayed instead of performing
> the actual transmission.
>
> The reason for this issue is that destination and refspecs are being set
> in the same conditional and are populated from argv. When a target
> repository is passed, refspecs is being populated as well with its value.
> This makes the check for refspecs not being NULL to always return true,
> which, in conjunction with the check for --all or --mirror options,
> is always true as well and returns usage message instead of proceeding.
>
> This ensures that send-pack will stop execution only when --all
> or --mirror switch is used in conjunction with any refspecs passed.
>
> Signed-off-by: Stanislav Kolotinskiy <stanislav@assembla.com>
> ---

Thanks, will queue.

>  builtin/send-pack.c  |  2 +-
>  t/t5400-send-pack.sh | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index f6e5d64..19f0577 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -225,7 +225,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	 * --all and --mirror are incompatible; neither makes sense
>  	 * with any refspecs.
>  	 */
> -	if ((refspecs && (send_all || args.send_mirror)) ||
> +	if ((nr_refspecs > 0 && (send_all || args.send_mirror)) ||
>  	    (send_all && args.send_mirror))
>  		usage_with_options(send_pack_usage, options);
>
> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> index 04cea97..305ca7a 100755
> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -128,6 +128,18 @@ test_expect_success 'denyNonFastforwards trumps --force' '
>  	test "$victim_orig" = "$victim_head"
>  '
>
> +test_expect_success 'send-pack --all sends all branches' '
> +	# make sure we have at least 2 branches with different
> +	# values, just to be thorough
> +	git branch other-branch HEAD^ &&
> +
> +	git init --bare all.git &&
> +	git send-pack --all all.git &&
> +	git for-each-ref refs/heads >expect &&
> +	git -C all.git for-each-ref refs/heads >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'push --all excludes remote-tracking hierarchy' '
>  	mkdir parent &&
>  	(
> --
> 2.8.0
