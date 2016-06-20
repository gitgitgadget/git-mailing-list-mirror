Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E26E1FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 19:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbcFTTQN (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 15:16:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753033AbcFTTQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 15:16:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 855A926BC0;
	Mon, 20 Jun 2016 15:09:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GdTdY6ECeQH6PKtNS28RMkw7EB8=; b=l+gFRv
	lys1/2tRHLgbn6j+/ripDzIwFaP4+6gW0olcjwAns3cmr3O9oMwl+mutx/Xf1Qzq
	gBtbDutP6H2zQ7CI+5TmKOKuXbzWs4WZEtHY3RvqrLKAA1FN4jVNgGzqB7PEAiu4
	5WM3miXrcyYTnV2X8DVKh3ubg7YsWTpYUZ8R4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z6lZ6+N4bn/uUGAZUAxq2P930qawCDB7
	GbIpYSw7sKTpn75zf0ThTXorSr0E9IdBX3D+Xb7qZpPgq9i+flPlEMOtKkm2GMRD
	Wy7HEf6J40+Yb4dpGQ1qisuMtlQD9Rm6MLji6W1OEjm6pPDxK7NimE9/WeRxDP+p
	9UwulkNLOe8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7ECC026BBF;
	Mon, 20 Jun 2016 15:09:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 076E826BBE;
	Mon, 20 Jun 2016 15:09:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: work around t2300's assuming non-Windows paths
References: <cover.1466246919.git.johannes.schindelin@gmx.de>
	<a8bebe126bcd047720a13e90b85b8dccb7231187.1466246919.git.johannes.schindelin@gmx.de>
Date:	Mon, 20 Jun 2016 12:09:24 -0700
In-Reply-To: <a8bebe126bcd047720a13e90b85b8dccb7231187.1466246919.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sat, 18 Jun 2016 12:49:11 +0200
	(CEST)")
Message-ID: <xmqqmvmfu17f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 815D7C48-371A-11E6-A8E4-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On Windows, we have to juggle two different schemes of representing
> paths: the native, Windows paths (the only ones known to the main
> Git executable) on the one hand, and POSIX-ish ones used by the Bash
> through MSYS2's POSIX emulation layer on the other hand.
>
> A Windows path looks like this: C:\git-sdk-64\usr\src\git. In modern
> Windows, it is almost always legal to use forward slashes as directory
> separators, which is the reason why the Git executable itself would use
> the path C:/git-sdk-64/usr/src/git instead. The equivalent POSIX-ish
> path would be: /c/git-sdk-64/usr/src/git.
>
> This patch works around the assumption of t2300-cd-to-toplevel.sh that
> `git --exec-path` spits out a POSIX-ish path, by converting the output
> accordingly.

Hmm, I am confused.  `git --exec-path` _is_ meant to "spit out" a
path that is usable when prepended/appended to $PATH [1], and it
does _not_ have to be POSIX-ish path.  It is totally up to the port
to adjust it to the platform's convention how the $PATH environment
variable is understood.

If $PATH cannot take C:/git-sdk-64/usr/src/git but does understand
/c/git-sdk-64/usr/src/git, perhaps "git --exec-path" should be
emitting the latter in the first place?


[Footnote]

*1* That after all was how we handled the painful 1.6 "'git-cmd' to
'git cmd'" transition (cf. $gmane/93793).



> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t2300-cd-to-toplevel.sh | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
> index cccd7d9..c8de6d8 100755
> --- a/t/t2300-cd-to-toplevel.sh
> +++ b/t/t2300-cd-to-toplevel.sh
> @@ -4,11 +4,19 @@ test_description='cd_to_toplevel'
>  
>  . ./test-lib.sh
>  
> +EXEC_PATH="$(git --exec-path)"
> +test_have_prereq !MINGW ||
> +case "$EXEC_PATH" in
> +[A-Za-z]:/*)
> +	EXEC_PATH="/${EXEC_PATH%%:*}${EXEC_PATH#?:}"
> +	;;
> +esac
> +
>  test_cd_to_toplevel () {
>  	test_expect_success $3 "$2" '
>  		(
>  			cd '"'$1'"' &&
> -			PATH="$(git --exec-path):$PATH" &&
> +			PATH="$EXEC_PATH:$PATH" &&
>  			. git-sh-setup &&
>  			cd_to_toplevel &&
>  			[ "$(pwd -P)" = "$TOPLEVEL" ]
