From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: set BASH_XTRACEFD automatically
Date: Tue, 10 May 2016 15:06:59 -0700
Message-ID: <xmqqd1otmut8.fsf@gitster.mtv.corp.google.com>
References: <cover.1462888768.git.johannes.schindelin@gmx.de>
	<alpine.DEB.2.20.1605101607180.4092@virtualbox>
	<xmqqshxpofqh.fsf@gitster.mtv.corp.google.com>
	<20160510205800.GC19958@sigill.intra.peff.net>
	<xmqqpostmxah.fsf@gitster.mtv.corp.google.com>
	<20160510213218.GA27028@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 11 00:07:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Fo6-0003IO-E9
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 00:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbcEJWHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 18:07:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751739AbcEJWHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 18:07:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 02AD51A82C;
	Tue, 10 May 2016 18:07:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZM9Xt5tax/njX74gTIDr4TMtObo=; b=FcOD7+
	smpyazObuTfYJkrh096JS9/Ty0bIi1/lH/aiW5t5S84a6MJN/PhdpP3Bo+dKH4hy
	Oy3uVOd3RIX33aTEofMiPi12qGvF4n9VEWE7Hjd3zFDx0WTHSPSlbLo7biYTALCR
	mqnW5g/Nf2qp+tGK03ympw0B5Gfwd7K/8AeWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fYtNde9sS2UbiyRZplwwj6fjQDqBH8VO
	sSE4pRu69QK+uznL3QYd0V+8TGVDFEO9lLquRVu6qoPqzZjbhaXUKg9OciliHxQn
	imWyBIomZ8Vr/hVh5AN+wV1u3zDxRVPolnHaIoyOzYpD2pNhTe3hpurvQwbnGHfL
	ADnVSDApwoU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECFF21A82B;
	Tue, 10 May 2016 18:07:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FC031A827;
	Tue, 10 May 2016 18:07:01 -0400 (EDT)
In-Reply-To: <20160510213218.GA27028@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 10 May 2016 17:32:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 858EF808-16FB-11E6-A078-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294200>

Jeff King <peff@peff.net> writes:

> The patch itself is a trivial-looking one-liner, but there
> are a few subtleties worth mentioning:
>
>   - the variable is _not_ exported; the "set -x" is local to
>     our process, and so the tracefd should match
>
>   - this line has to come after we do the redirection for fd
>     4, as bash will otherwise complain during the variable
>     assignment
>
>   - likewise, we cannot ever unset this variable, as it
>     would close descriptor 4
>
>   - setting it once here is sufficient to cover both the
>     regular "-x" case (which implies "--verbose"), as well
>     as "--verbose-only=1". This works because the latter
>     flips "set -x" off and on for particular tests (if it
>     didn't, we would get tracing for all tests, as going to
>     descriptor 4 effectively circumvents the verbose flag).

Thanks.  Some of them may deserve to be next to the one-liner to
prevent people from making changes that tickle them?

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/README      | 6 +++---
>  t/test-lib.sh | 1 +
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/t/README b/t/README
> index 1dc908e..76a0daa 100644
> --- a/t/README
> +++ b/t/README
> @@ -84,9 +84,9 @@ appropriately before running "make".
>  
>  -x::
>  	Turn on shell tracing (i.e., `set -x`) during the tests
> -	themselves. Implies `--verbose`. Note that this can cause
> -	failures in some tests which redirect and test the
> -	output of shell functions. Use with caution.
> +	themselves. Implies `--verbose`. Note that in non-bash shells,
> +	this can cause failures in some tests which redirect and test
> +	the output of shell functions. Use with caution.
>  
>  -d::
>  --debug::
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 286c5f3..482ec11 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -321,6 +321,7 @@ then
>  else
>  	exec 4>/dev/null 3>/dev/null
>  fi
> +BASH_XTRACEFD=4
>  
>  test_failure=0
>  test_count=0
