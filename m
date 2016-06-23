Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C912D1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 20:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbcFWUMO (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 16:12:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbcFWUMO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2016 16:12:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C9B1E27366;
	Thu, 23 Jun 2016 16:12:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DhNCLvtItd2W
	JxHi7CP9tWAiW0A=; b=uzUiBJz7TFz7ZHjq0GhCRdhhMnd3BRGPBLLCJvP1OIYu
	sliCilfdY1Zl5BycxBte93m5KULav1CoaUotYOit41Pbt5SylWTUtQAbGzhMk+m0
	op6UF237HTJqEzuXM99RBYfoRpkUJLfPJBgjexNv0Jir48hJvtCiOYzjtSKJGPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aCnSbt
	GEP6dJm2ag61XWJ14EAj7IyXGCJr+Kzhij02WFC/U6TCgZssl0WY3zxUmU+jkA1s
	SFrUcq5PvTYF/3j1Eq+snaEJFONDjiqTAJs6i5Lb/g+5Lh0JGFVsn+27D9+4g26n
	zmWuZUx8kU+nrSaEyqUblaM7lLUuCCDDvTVWU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C22DB27365;
	Thu, 23 Jun 2016 16:12:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4935827363;
	Thu, 23 Jun 2016 16:12:12 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 04/11] grep/icase: avoid kwsset on literal non-ascii strings
References: <20160623162907.23295-1-pclouds@gmail.com>
	<20160623162907.23295-5-pclouds@gmail.com>
Date:	Thu, 23 Jun 2016 13:12:10 -0700
In-Reply-To: <20160623162907.23295-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Thu, 23 Jun 2016 18:29:00 +0200")
Message-ID: <xmqq37o3is11.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C5793636-397E-11E6-BC5D-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>  static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>  {
> +	int icase, ascii_only;
>  	int err;
>  
>  	p->word_regexp = opt->word_regexp;
>  	p->ignore_case = opt->ignore_case;
> +	icase	       = opt->regflags & REG_ICASE || p->ignore_case;
> +	ascii_only     = !has_non_ascii(p->pattern);
>  
>  	if (opt->fixed) {
>  		p->fixed = 1;
> -	} else if (is_fixed(p->pattern, p->patternlen))
> +	} else if ((!icase || ascii_only) &&
> +		   is_fixed(p->pattern, p->patternlen))
>  		p->fixed = 1;

... we are not told to do "fixed" explicitly with "-F", and that is
safe for a literal pattern if the pattern is only ascii (with or
without -i) but not safe with "-i" when dealing with non-ascii
pattern.

Makes perfect sense.

>  	else
>  		p->fixed = 0;
> diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
> new file mode 100755
> index 0000000..b78a774
> --- /dev/null
> +++ b/t/t7812-grep-icase-non-ascii.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +
> +test_description='grep icase on non-English locales'
> +
> +. ./lib-gettext.sh
> +
> +test_expect_success GETTEXT_LOCALE 'setup' '
> +	test_write_lines "TILRAUN: Halló Heimur!" >file &&
> +	git add file &&
> +	LC_ALL="$is_IS_locale" &&
> +	export LC_ALL
> +'
> +
> +test_have_prereq GETTEXT_LOCALE &&
> +test-regex "HALLÓ" "Halló" ICASE &&
> +test_set_prereq REGEX_LOCALE
> +
> +test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
> +	git grep -i "TILRAUN: Halló Heimur!" &&
> +	git grep -i "TILRAUN: HALLÓ HEIMUR!"
> +'
> +
> +test_done
