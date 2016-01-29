From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] convert: legitimately disable clean/smudge filter with an empty override
Date: Fri, 29 Jan 2016 10:20:49 -0800
Message-ID: <xmqqh9hwjlha.fsf@gitster.mtv.corp.google.com>
References: <1454055697-6742-1-git-send-email-larsxschneider@gmail.com>
	<1454055697-6742-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de, sunshine@sunshineco.com,
	peff@peff.net
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 29 19:21:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPDfL-0003ZB-8E
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 19:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933217AbcA2SU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 13:20:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933013AbcA2SUw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 13:20:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 62A373EFF6;
	Fri, 29 Jan 2016 13:20:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2YRod/lb4ERnpRGCD5mppiMWZ2M=; b=ukDt81
	Dbypn2lWNMbwmAMxYDPeP284O/leKpeh+lNfWakLHAB1M3ILDwkI92Gd3eErGDtk
	n0WyK2vMLR67ZvnRW/eclpDqGF6h9hSqAPHt/snFNyh39+WdtSlYHsIBEkBhx3G6
	lplB4WMUV+hxMBQDn/zEcXKz5qENi5NYCaLqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wr9Nh7JphPdST+Ii/J9yv4xU/+f4bQdn
	pX4BgqBE0Gt2Ayl8gvoPaIJbJ1ewpxdVvRvaQc0H8iRyVq0ES/bpsysfb/mODZpj
	C2PQyELJ69wIlqZQwRsQolKmlcSiPG/he5o72DWjQtwJBQoLgbk4H1sPtkYYFuca
	TyA3QK1uorI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C74A3EFF5;
	Fri, 29 Jan 2016 13:20:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9BCA93EFF4;
	Fri, 29 Jan 2016 13:20:50 -0500 (EST)
In-Reply-To: <1454055697-6742-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Fri, 29 Jan 2016 09:21:37
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0695E2AA-C6B5-11E5-8E0B-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285081>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> If the clean/smudge command of a Git filter driver (filter.<driver>.smudge and
> filter.<driver>.clean) is set to an empty string ("") and the filter driver is
> not required (filter.<driver>.required=false) then Git will run successfully.
> However, Git will print an error for every file that is affected by the filter.
>
> Teach Git to consider an empty clean/smudge filter as legitimately disabled
> and do not print an error message if the filter is not required.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  convert.c             |  2 +-
>  t/t0021-conversion.sh | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/convert.c b/convert.c
> index 814e814..02d5f1e 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -395,7 +395,7 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
>  	struct async async;
>  	struct filter_params params;
>  
> -	if (!cmd)
> +	if (!cmd || !*cmd)
>  		return 0;

This is certainly simpler than v1.  I was initially worried about
the fact that slightly changes the semantics around the "required"
variable relative to v1, which said:

	if (ca.drv && ca.drv->clean && *ca.drv->clean) {
        	filter = ca.drv->clean;
                required = ca.drv->required;
	}
	ret |= apply_filter(path, src, len, -1, dst, filter);
        if (!ret && required)
        	die;

but in v2, this part of the code is just as before, i.e.

	if (ca.drv) {
        	filter = ca.drv->clean;
                required = ca.drv->required;
	}
	ret |= apply_filter(path, src, len, -1, dst, filter);
        if (!ret && required)
        	die;

So unlike v1, 'required' is set to true in the function, which is a
good thing, but because in v2, apply_filter knows that an extrernal
filter command that is an empty string is a no-op success, the above
codepath behaves identically to v1 when observed from outside, i.e.
"an empty string given as clean/smudge filter is a no-op success".

Good.

By the way, I find it somewhat annoying to see "legitimately" twice
in the log message.  It makes it sound like there are legitimate way
and not-so-kosher way to disable the filters.  Perhaps something
like this instead?

-- >8 --
convert: treat an empty string for clean/smudge filters as "cat"

Once a lower-priority configuration file defines a clean or smudge
filter, there is no convenient way to override it.  Even though the
configuration mechanism implements "the last one wins" semantics,
you cannot set them to an empty string and expect them to work, as
apply_filter() would try to run the empty string as an external
command and fail.  The conversion is not done, but the function
would still report a failure to convert.

Even though resetting the variable to "cat" (i.e. pass the data back
as-is and report success) is an obvious and a viable way to solve
this, it is wasteful to spawn an external process just as a
workaround.

Instead, teach apply_filter() to treat an empty string given as a
filter means the input must be returned as-is without conversion,
and the operation must always succeed.
-- >8 --

>  
>  	if (!dst)
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 718efa0..7bac2bc 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -252,4 +252,20 @@ test_expect_success "filter: smudge empty file" '
>  	test_cmp expected filtered-empty-in-repo
>  '
>  
> +test_expect_success 'disable filter with empty override' '
> +	test_config_global filter.disable.smudge false &&
> +	test_config_global filter.disable.clean false &&
> +	test_config filter.disable.smudge false &&
> +	test_config filter.disable.clean false &&
> +
> +	echo "*.disable filter=disable" >.gitattributes &&
> +
> +	echo test >test.disable &&
> +	git -c filter.disable.clean= add test.disable 2>err &&
> +	test_must_be_empty err &&
> +	rm -f test.disable &&
> +	git -c filter.disable.smudge= checkout -- test.disable 2>err &&
> +	test_must_be_empty err
> +'
> +
>  test_done
