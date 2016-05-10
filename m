From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] perf: let's disable symlinks on Windows
Date: Tue, 10 May 2016 12:51:53 -0700
Message-ID: <xmqqoa8dofmu.fsf@gitster.mtv.corp.google.com>
References: <cover.1462894344.git.johannes.schindelin@gmx.de>
	<alpine.DEB.2.20.1605101738390.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 10 21:52:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0DhJ-0007LJ-Iv
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 21:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbcEJTv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 15:51:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751288AbcEJTv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 15:51:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE5C5194E3;
	Tue, 10 May 2016 15:51:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UX14ahMCvZEeySm7lKxhrwjLG5E=; b=nwliyU
	3U+gQszWw/3AvyuhaabnkOHJS+wJfE6qATLJU8PdenpyjsqdpUsDIsev65Epvr3/
	5t9U1PNXC4oa/6WdkcHWDqewCpjPUnAqUoXH/Ae6v5uovFQ8KynSQFm1SR7Or0jL
	a2Sk2qUEBAeBd9zdAHLm/U0pAV1LLbmDzcjKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aAHhY38eIxttzrkbuS2HPe3rJ65BziQs
	4zEvtJNW22TARTZfLlTAEqSTtrMnceMBJZHV4Etsj/tqjyGKf6VW6ZOFS2SmYq1m
	04iOyCjp8rFgoxkDKqSsYz2GPx1OdtulHJHnEG0x9/vMDmGa4x3UjeAbnsiZ1sTr
	X7a/TsazI0Q=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6474194E2;
	Tue, 10 May 2016 15:51:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61909194E0;
	Tue, 10 May 2016 15:51:55 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605101738390.4092@virtualbox> (Johannes
	Schindelin's message of "Tue, 10 May 2016 17:41:53 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A5F866B4-16E8-11E6-8271-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294180>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In Git for Windows' SDK, Git's source code is always checked out
> with symlinks disabled. The reason is that POSIX symlinks have no
> accurate equivalent on Windows [*1*]. More precisely, though, it is
> not just Git's source code but *all* source code that is checked
> out with symlinks disabled: core.symlinks is set to false in the
> system-wide gitconfig.
>
> Since the perf tests are run with the system-wide gitconfig *disabled*,
> we have to make sure that the Git repository is initialized correctly
> by configuring core.symlinks explicitly.

Is MINGW the right prerequisite to use here, or is SIMLINKS more
appropriate?

>
> Footnote *1*:
> https://github.com/git-for-windows/git/wiki/Symbolic-Links
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/perf/perf-lib.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index 5cf74ed..e9020d0 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -97,6 +97,10 @@ test_perf_create_repo_from () {
>  		done &&
>  		cd .. &&
>  		git init -q &&
> +		if test_have_prereq MINGW
> +		then
> +			git config core.symlinks false
> +		fi &&
>  		mv .git/hooks .git/hooks-disabled 2>/dev/null
>  	) || error "failed to copy repository '$source' to '$repo'"
>  }
