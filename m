From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1700: make test pass with index-v4
Date: Fri, 20 Mar 2015 10:23:57 -0700
Message-ID: <xmqqsiczfuqa.fsf@gitster.dls.corp.google.com>
References: <1426864165-7334-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:24:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ0ec-0007D8-2S
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbbCTRYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 13:24:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51560 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751704AbbCTRYF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 13:24:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E125D40411;
	Fri, 20 Mar 2015 13:23:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RUVrN2BAbF8RG/g76+q7RSIk2Qg=; b=LjD2SA
	2bvlSoExKc+bHgxLYItFlhUaTdNn3s7eXjRchewBWGV6reXx/uSj59E89DCQDIk3
	29tno5EPPZwaVKF6y6sRJw0ScvCjpNarrjE4oSgoFGGl0Z0SNl/a4z/d1uBdGGAT
	r7nsjhg2nMBKnnK8xOoXehUWqT91hJBmEa03k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XDsa+4qn8wZdi3CixfKPZ2P4Pr0nsH8x
	gt/I8MSTD0M6VMJi9UleMglOvvU0kRTQ+0LdfDvnq+p4FjoC3Msnqx5VajKVNVns
	6qKOz51IH8jEzOY6hXYw+67+9gHCK05FBYF+fNfmSk4Nk+rc3AdCPuYo3CfxDxCh
	K5BmW4mZFvE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D909740410;
	Fri, 20 Mar 2015 13:23:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BBE24040F;
	Fri, 20 Mar 2015 13:23:59 -0400 (EDT)
In-Reply-To: <1426864165-7334-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Fri, 20 Mar 2015 16:09:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E52804F4-CF25-11E4-80E0-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265913>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> The different index versions have different sha-1 checksums.  Those
> checksums are checked in t1700, which makes it fail when run with index
> v4.  Fix it.

I am more interested to see how you managed to use index v4 in the
tests be described next to "when run with index v4".  I thought we
were controling these things fairly tightly (e.g. we disable hooks,
move $HOME to avoid getting affected by your personal settings,
etc.).

Thanks.


> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  t/t1700-split-index.sh | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 94fb473..92f7298 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -10,9 +10,18 @@ sane_unset GIT_TEST_SPLIT_INDEX
>  test_expect_success 'enable split index' '
>  	git update-index --split-index &&
>  	test-dump-split-index .git/index >actual &&
> +	indexversion=$(test-index-version <.git/index) &&
> +	if test "$indexversion" = "4"
> +	then
> +		own=432ef4b63f32193984f339431fd50ca796493569
> +		base=508851a7f0dfa8691e9f69c7f055865389012491
> +	else
> +		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
> +		base=39d890139ee5356c7ef572216cebcd27aa41f9df
> +	fi &&
>  	cat >expect <<EOF &&
> -own 8299b0bcd1ac364e5f1d7768efb62fa2da79a339
> -base 39d890139ee5356c7ef572216cebcd27aa41f9df
> +own $own
> +base $base
>  replacements:
>  deletions:
>  EOF
> @@ -30,7 +39,7 @@ EOF
>  
>  	test-dump-split-index .git/index | sed "/^own/d" >actual &&
>  	cat >expect <<EOF &&
> -base 39d890139ee5356c7ef572216cebcd27aa41f9df
> +base $base
>  100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
>  replacements:
>  deletions:
