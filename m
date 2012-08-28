From: Junio C Hamano <gitster@pobox.com>
Subject: Re: I think git show is broken
Date: Tue, 28 Aug 2012 15:36:26 -0700
Message-ID: <7v4nnmzlsl.fsf@alter.siamese.dyndns.org>
References: <503D022B.6070001@redlion.net> <503D046B.7090606@redlion.net>
 <20120828212934.GA396@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthew Caron <Matt.Caron@redlion.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 29 00:36:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6UOi-0008OK-K5
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 00:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab2H1Wga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 18:36:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753231Ab2H1Wg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 18:36:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF32E8881;
	Tue, 28 Aug 2012 18:36:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aeRF5e3nMC4wzVBvNjBCVWQbiCk=; b=IKN3cn
	5+jkR7fnsZWrPZrWCMPiHF+11HMrHPmJrguZtmRhjKVM5XiFuIqrC6t/lV/M3p1W
	0Ot2QTXgQFvgC1zyexu0jod7hOHvDIuqrqBZJezVTWNUEvp9eHpZc0twO2OD41Ke
	Wk63YedKbqAcSMpzqbU6j3NYUtw5ggCTgmac8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CRcfeNcJAudqv7ek3I7T+46cSOFMmMyt
	wNyutKH6KZ0Wvx8zWuvbIKqyPWyMI8k+7ijvs0GH4I6KfPumfc3L2V4/BsKZ2JuE
	2lg5R5bzF318luWhJCyYuqoxfSqkzcucPpwivanDKfeGhwXnQjIGSSr6DE9NKi4s
	KMrb2xwX+uk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC2648880;
	Tue, 28 Aug 2012 18:36:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 084AD887E; Tue, 28 Aug 2012
 18:36:27 -0400 (EDT)
In-Reply-To: <20120828212934.GA396@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 28 Aug 2012 17:29:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE6FCDFA-F160-11E1-AD07-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204456>

Jeff King <peff@peff.net> writes:

> Yes, that is what's going on. But it's still a regression. There was
> some discussion of what --quiet should do here:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/171357
>
> which resulted in a patch that took away --quiet. But then this thread:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/174665
>
> resulted in restoring it as a synonym for "-s". Unfortunately there's a
> bug in that fix, which you are seeing. Patch is below.

Thanks for digging this through to the bottom.

> ...
> However, that commit did not fix it in all cases. It sets
> the flag after setup_revisions is called. Naively, this
> makes sense because you would expect the setup_revisions
> parser to overwrite our output format flag if "-p" or
> another output format flag is seen.
>
> However, that is not how the NO_OUTPUT flag works. We
> actually store it in the bit-field as just another format.
> At the end of setup_revisions, we call diff_setup_done,
> which post-processes the bitfield and clears any other
> formats if we have set NO_OUTPUT. By setting the flag after
> setup_revisions is done, diff_setup_done does not have a
> chance to make this tweak, and we end up with other format
> options still set.
>
> As a result, the flag would have no effect in "git log -p
> --quiet" or "git show --quiet".  Fix it by setting the
> format flag before the call to setup_revisions.

This also means that

	git show --name-status --quiet

will start erroring out, if I am not recalling what diff_setup_done()
does.  Which pretty much means "--quiet" given to the "log" family
is truly a synonym to "-s", as the error condition that triggers is
exactly the same for this:

	git show --name-status -s

which is fine, I think.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/log.c   |  2 +-
>  t/t7007-show.sh | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index ecc2793..c22469c 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -109,9 +109,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
>  			     PARSE_OPT_KEEP_DASHDASH);
>  
> -	argc = setup_revisions(argc, argv, rev, opt);
>  	if (quiet)
>  		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
> +	argc = setup_revisions(argc, argv, rev, opt);
>  
>  	/* Any arguments at this point are not recognized */
>  	if (argc > 1)
> diff --git a/t/t7007-show.sh b/t/t7007-show.sh
> index a40cd36..e41fa00 100755
> --- a/t/t7007-show.sh
> +++ b/t/t7007-show.sh
> @@ -108,4 +108,16 @@ test_expect_success 'showing range' '
>  	test_cmp expect actual.filtered
>  '
>  
> +test_expect_success '-s suppresses diff' '
> +	echo main3 >expect &&
> +	git show -s --format=%s main3 >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--quiet suppresses diff' '
> +	echo main3 >expect &&
> +	git show --quiet --format=%s main3 >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
