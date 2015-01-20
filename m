From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_color: fix return value for numeric color values 0-8
Date: Tue, 20 Jan 2015 15:57:13 -0800
Message-ID: <xmqqvbk1ypie.fsf@gitster.dls.corp.google.com>
References: <xmqqmw5n5z8i.fsf@gitster.dls.corp.google.com>
	<CACBZZX5s1rZ3exktbisseJSjF8-0=8ByMpBpARy6h+=iP7wEyA@mail.gmail.com>
	<20150120221447.GB18778@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 00:57:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDifm-0005q2-BV
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 00:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbbATX5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 18:57:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750775AbbATX5V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 18:57:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1039432982;
	Tue, 20 Jan 2015 18:57:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=59y6mdm4g6+r5ecAg23yriUGffI=; b=d1QoJO
	tyJe9fcG2laL+vmadQ1HWR73PJRd78eMgSFYNj4mHalOUZHRPjiKA3NPG6+dgJDR
	DXB2zOa2+YwMaqHVksdXbMHGdhaMW+brL6ju+ZtLsIDuxky8pb9DsB6g33qXYF50
	ktrdSXgXQr2xx18NGSeBiPib0wF32LG5urmdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X1pwWR6LhDsjKS0qL8AOX2s2kHGF7tPk
	18Va2/7Fu1GNJpGFuB1iM/6u7raFlJmzduhOKaY/AfjAp0HM3AX1+sdFvPv715DL
	acWXHbgkDQ4TGVBYNoNnFiNbEwSrx1IGbShvubBGvHRbd8xOCCysRnBFfuwukj+a
	gtBJ19omZEY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0563A32981;
	Tue, 20 Jan 2015 18:57:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 724EC3297E;
	Tue, 20 Jan 2015 18:57:14 -0500 (EST)
In-Reply-To: <20150120221447.GB18778@peff.net> (Jeff King's message of "Tue,
	20 Jan 2015 17:14:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0E96A538-A100-11E4-BB9A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262703>

Jeff King <peff@peff.net> writes:

> Eek. Definitely an unintended regression. The fix is below. Thanks for
> reporting (and especially for catching during the -rc period!).
>
> You should not need it, but for reference, using "0" is the same as
> "black" (both in old git and new).
>
> -- >8 --
> When commit 695d95d refactored the color parsing, it missed
> a "return 0" when parsing literal numbers 0-8 (which
> represent basic ANSI colors), leading us to report these
> colors as an error.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Thanks; somebody should have caught this before we applied and
merged to 'master', but the process obviously did not work well.

Sorry and thanks.

>  color.c          | 1 +
>  t/t4026-color.sh | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/color.c b/color.c
> index 809b359..9027352 100644
> --- a/color.c
> +++ b/color.c
> @@ -112,6 +112,7 @@ static int parse_color(struct color *out, const char *name, int len)
>  		} else if (val < 8) {
>  			out->type = COLOR_ANSI;
>  			out->value = val;
> +			return 0;
>  		} else if (val < 256) {
>  			out->type = COLOR_256;
>  			out->value = val;
> diff --git a/t/t4026-color.sh b/t/t4026-color.sh
> index 267c43b..4d20fea 100755
> --- a/t/t4026-color.sh
> +++ b/t/t4026-color.sh
> @@ -60,6 +60,10 @@ test_expect_success 'absurdly long color specification' '
>  	  "[1;2;4;5;7;22;24;25;27;38;2;255;255;255;48;2;255;255;255m"
>  '
>  
> +test_expect_success '0-7 are aliases for basic ANSI color names' '
> +	color "0 7" "[30;47m"
> +'
> +
>  test_expect_success '256 colors' '
>  	color "254 bold 255" "[1;38;5;254;48;5;255m"
>  '
