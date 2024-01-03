Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCEF1BDFF
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V9V0H0On"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D31C1DDB5E;
	Wed,  3 Jan 2024 12:13:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W1uwDyWNj0n3dSp8/VX4W+/aIZoG3Msnja+ugV
	KqD+Q=; b=V9V0H0OnFNCXr6rHaFPxrHxCGiSr0hL0MIMrw/x32wfbXnApHldGeJ
	aCS20XucT35/c2emC38gIkAbtGpHWz1vZYvjfh2C/okTUjfMTbw61t4B3tcRrCo2
	XniWaPCfdMpkOKcRwKxSJvzH30iR11GPmyFGdjkA5QBitv3HBqG/c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 03B941DDB5D;
	Wed,  3 Jan 2024 12:13:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6269A1DDB5C;
	Wed,  3 Jan 2024 12:13:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] write-or-die: make GIT_FLUSH a Boolean environment
 variable
In-Reply-To: <pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Wed, 03 Jan 2024 07:58:28
	+0000")
References: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
	<pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>
Date: Wed, 03 Jan 2024 09:13:46 -0800
Message-ID: <xmqqmstm9w6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 74D8FECC-AA5B-11EE-801B-25B3960A682E-77302942!pb-smtp2.pobox.com

"Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  Documentation/git.txt | 16 +++++++---------
>  write-or-die.c        |  9 +++------
>  2 files changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 2535a30194f..83fd60f2d11 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -724,16 +724,14 @@ for further details.
>  	waiting for someone with sufficient permissions to fix it.
>  
>  `GIT_FLUSH`::
> -// NEEDSWORK: make it into a usual Boolean environment variable
> -	If this environment variable is set to "1", then commands such
> +	If this Boolean environment variable is set to true, then commands such
>  	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
> -	'git check-attr' and 'git check-ignore' will
> -	force a flush of the output stream after each record have been
> -	flushed. If this
> -	variable is set to "0", the output of these commands will be done
> -	using completely buffered I/O.   If this environment variable is
> -	not set, Git will choose buffered or record-oriented flushing
> -	based on whether stdout appears to be redirected to a file or not.
> +	'git check-attr' and 'git check-ignore' will force a flush of the output
> +	stream after each record have been flushed. If this variable is set to
> +	false, the output of these commands will be done using completely buffered
> +	I/O. If this environment variable is not set, Git will choose buffered or
> +	record-oriented flushing based on whether stdout appears to be redirected
> +	to a file or not.

It is somewhat irritating to see that we need to change this many
lines to just change "0" to "false" and "1" to "true".  I wonder if
it becomes easier to grok if we changed the description into a sub
enumeration of three possibilities, but that would be outside the
scope of this change [*].

> diff --git a/write-or-die.c b/write-or-die.c
> index 42a2dc73cd3..a6acabd329f 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -20,15 +20,12 @@ void maybe_flush_or_die(FILE *f, const char *desc)
>  {
>  	static int skip_stdout_flush = -1;
>  	struct stat st;
> -	char *cp;
>  
>  	if (f == stdout) {
>  		if (skip_stdout_flush < 0) {
> -			/* NEEDSWORK: make this a normal Boolean */
> -			cp = getenv("GIT_FLUSH");
> -			if (cp)
> -				skip_stdout_flush = (atoi(cp) == 0);
> -			else if ((fstat(fileno(stdout), &st) == 0) &&
> +			if (!git_env_bool("GIT_FLUSH", -1))
> +				skip_stdout_flush = 1;
> +			else if (!fstat(fileno(stdout), &st) &&
>  				 S_ISREG(st.st_mode))
>  				skip_stdout_flush = 1;
>  			else

The above logic does not look correct to me, primarily because the
return value of git_env_bool() is inspected only once to see if it
is zero, and does not differentiate the "unset" case from other
cases.

Since git_env_bool(k, def) returns

    - "def" (-1 in this case) when k is not exported (in which case
      you need to do the "fstat" dance).

    - 0 when k is exported and has a string that is "false" (in
      which case you would want to set skip_stdout_flush to true).

    - 1 when k is exported and has a string that is "true" (in which
      case you would want to set skip_stdout_flush to false).

    - or dies if the string exported in k is bogus.

shouldn't it be more like

                        skip_stdout_flush = 0; /* assume flushing */
                        switch (git_env_bool("GIT_FLUSH", -1)) {
                        case 0: /* told not to flush */
                                skip_stdout_flush = 1;
                                ;;
                        case -1: /* unspecified */
                                if (!fstat(...) && S_ISREG())
                                        skip_stdout_flush = 1;
                                ;;
                        default: /* told to flush */
                                ;;
                        }

perhaps?


[Footnote]

 * If I were to do this change, and if I were to also improve the
   style of the documentation before I forget, the way I would do so
   probably is with a two-patch series:

    (1) update "0" and "1" in the documentation with "false" and
        "true", without reflowing the text at all, and update the
        code.

    (2) rewrite the documentation to use 3-possibility
        sub-enumeration for values (imitate the way how other
        variables, like `diff.algorithm`, that can choose from a
        set of handful possible values are described).

   These two changes can be done in either order, but perhaps (1) is
   much less controversial change than the other, so I'd probably do
   so first.
