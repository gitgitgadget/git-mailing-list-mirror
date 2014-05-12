From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUGFIX/RFC] git-show: fix 'git show -s' to not add extra terminator after merge commit
Date: Mon, 12 May 2014 09:59:39 -0700
Message-ID: <xmqqk39qu96o.fsf@gitster.dls.corp.google.com>
References: <20140511232505.GA29104@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon May 12 20:46:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjvFM-0005Uv-0h
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 20:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbaELSqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 14:46:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51940 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbaELSqi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 14:46:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C84CD15E20;
	Mon, 12 May 2014 14:46:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=daRCBI/6weL1Zr/4AWSSn72ONm0=; b=UlQIsWcx/5j3OwZwRyxB
	Tl3s1qL1+VDvwbyjE8vaYs8PZtuwQR+lHbW3IwPfLLuKPxq5ZTxpwW5GCbryYrPU
	/P6fpqwgENnx9HxXCRCQsJciWJnhN31DJkkwwRzcgvfW0+Af25g49R7oJYjKc5oZ
	G3jQmnbgSQ/Ybk/yEeY9lBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=r1SNG2RxhIut1ePxammnU9aVgi14yExiGMf5nQbOkzdlsC
	RoAdke+3y0fwyCX8bdFqx93dHjZTEvcWhFQRc3ZKkKP6X+w6VhVhC5u8iZh2X4HN
	RdtxneQrFlfQL0Cf7n7CpsSnPTcFt6vbbSJMTEDtdaS/V4hNZxiyBpxWzgKk4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCD5415E1F;
	Mon, 12 May 2014 14:46:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DF91115DFF;
	Mon, 12 May 2014 14:46:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B8AD22B2-DA05-11E3-BC71-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248719>

Max Kirillov <max@max630.net> writes:

> When "git show -s" is called for merge commit it prints extra newline
> between any merge commit and the next one. This looks especially ugly for
> --oneline and other single-line formats. Looks very much like a bug.

Yeah, it is not limited to one-line formats.  For example:

    $ git show -s v2.0.0-rc3^0 v2.0.0-rc3^1

ends with an extra blank line before you see your prompt, but if you
swap the revs:

    $ git show -s v2.0.0-rc3^1 v2.0.0-rc3^0

you do not get the extra blank line.  Instead, you have an extra
blank in between.  And I agree that these extra blank lines look
very much like a bug.

> This actually has broken some number of existing tests
> (their fix not included), and might break some existing
> scripts which already expect this extra newline.
>
> So, is it yet not too late to fix this?

I would prefer to see it fixed eventually.

I haven't checked if the new extra check uses the right condition
yet, but from a cursory look and with a few examples I tried
manually, the version with your change seems to behave a lot more
sensibly.

A good way to double-check may be to see the fixes to the tests to
correct their wrong expectations, and if the updated expectation is
sensible.  That way, we will find if the observations we made (your
problem description and my two examples above, and a few examples I
tried manually) covered all what matters, or if there are cases
where they indeed were expecting some sensible results which this
change would break that we missed.  Offhand, I doubt we would find
any case where these extra blank lines are sensible expectations,
though.

>  combine-diff.c  | 2 +-
>  t/t7007-show.sh | 8 ++++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/combine-diff.c b/combine-diff.c
> index 3b92c448..d2924de 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1331,7 +1331,7 @@ void diff_tree_combined(const unsigned char *sha1,
>  		if (show_log_first && i == 0) {
>  			show_log(rev);
>  
> -			if (rev->verbose_header && opt->output_format)
> +			if (rev->verbose_header && opt->output_format && opt->output_format != DIFF_FORMAT_NO_OUTPUT)

Please wrap this long line, perhaps like:

			if (rev->verbose_header && opt->output_format &&
			    opt->output_format != DIFF_FORMAT_NO_OUTPUT)


>  				printf("%s%c", diff_line_prefix(opt),
>  				       opt->line_termination);
>  		}
> diff --git a/t/t7007-show.sh b/t/t7007-show.sh
> index e41fa00..d76c7db 100755
> --- a/t/t7007-show.sh
> +++ b/t/t7007-show.sh
> @@ -25,6 +25,7 @@ test_expect_success 'set up a bit of history' '
>  	git checkout -b side HEAD^^ &&
>  	test_commit side2 &&
>  	test_commit side3
> +	test_merge merge main3
>  '
>  
>  test_expect_success 'showing two commits' '
> @@ -109,8 +110,11 @@ test_expect_success 'showing range' '
>  '
>  
>  test_expect_success '-s suppresses diff' '
> -	echo main3 >expect &&
> -	git show -s --format=%s main3 >actual &&
> +	cat >expect <<-EOF &&
> +	merge
> +	main3
> +	EOF

Please make it a habit to quote the EOF marker when you are not
placing things that require variable substitutions, to tell the
readers that they can coast their eyes over the here-document
without having to worry about them.  For a short here-document
like this, it does not matter, but these things have a habit of
getting imitated without thinking by others, and it is better to be
defensive and consistent.  I.e.

	cat >expect <<-\EOF &&
        merge
        main3
        EOF

> +	git show -s --format=%s merge main3 >actual &&
>  	test_cmp expect actual
>  '
