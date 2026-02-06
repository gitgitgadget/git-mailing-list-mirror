Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE22E62C3
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770353910; cv=none; b=puYrpdxAw64CjpA35mhl7x1hbt0qbZRTtR1A0knzD9mskM9t4jJ+37RSFqlPfxjyUZlJ/UkJwM+zc8T///rqDMqYll5HgqCTZpZKtoPAZ058U2PysGU2nMjvceRSUXckYqtdMyOg9IKfeXorZcJ7thn+AEYxVFkbltjchPpvL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770353910; c=relaxed/simple;
	bh=j+gKVS6dvD8oQBZv6VK1vaTfrXRskBA17erMxVry2go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tgv7SET4sCGWrGoPoyRFc2qA2V6SwdHFuXWXUbvQML0oMTDwIQv5gUg2rzFNFi5/HUT4uOUPBnMKUg8+tVqsQuTFi7PRw1+DSWMLHEGr8fF4Ozf9X21dCk5LviFT5OM9/GcyNJYe5OvwT2kCvNSPm5c+59AXt0yd7tDiPcgSJAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=LNsNYg+D; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="LNsNYg+D"
Received: from [192.168.43.16] (unknown [37.168.1.79])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8A075B00535;
	Fri,  6 Feb 2026 05:58:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1770353908;
	bh=j+gKVS6dvD8oQBZv6VK1vaTfrXRskBA17erMxVry2go=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LNsNYg+D4crFpEUP1xP60vXIoclnys/qYALiyLn/yWB+kGN5hhT8fpu+rYDM2ES4f
	 P7VCQVVFfuIGI+djJ9E1KIm8Fvr4Vf28PBZsP5X6X5xUcn+Jmke2bcSltv1vnluCXU
	 eTxRfPSZc2lgeFTgoSs9P7J09Tsy2ZFG6xmOLq8zQRHe9AbUxL8IVX1IdqPk78wS/i
	 ttelgaf6yBp8l3U9K+ghJxdlQRhTAmFtTAjGJ60h3Vzq77Xp9KW6iRDye/wxhj/mpT
	 xV8Ngh9cM6hhBVcASKNpk/Vcu23gGytV+Pco3YGJcRHS3t8TIfB/VVVSAtARwfm51t
	 IChBrQW3hrhpQ==
Message-ID: <7204ff93-79d3-44f6-989d-184f00b86a2a@free.fr>
Date: Fri, 6 Feb 2026 05:58:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] config-batch: add NUL-terminated I/O format
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <33faa3f134c81761631c34600477dcbf82e619e5.1770214803.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <33faa3f134c81761631c34600477dcbf82e619e5.1770214803.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/02/2026 à 15:19, Derrick Stolee via GitGitGadget a écrit :
> From: Derrick Stolee <stolee@gmail.com>
> 
> When using automated tools, it is critical to allow for input/output formats
> that include special characters such as spaces and newlines. While the
> existing protocol for 'git config-batch' is human-readable and has some
> capacity for some spaces in certain positions, it is not available for
> spaces in the config key or newlines in the config values.
> 
> Add the '-z' option to signal the use of NUL-terminated strings. To
> understand where commands end regardless of potential future formats, use
> two NUL bytes in a row to terminate a command. To allow for empty string
> values, each token is provided in a <length>:<value> format, making "0:"
> the empty string value.
> 
> Update the existing 'help' and 'get' commands to match this format. Create
> helper methods that make it easy to parse and print in both formats
> simultaneously.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-config-batch.adoc |  57 ++++++++-
>  builtin/config-batch.c              | 188 +++++++++++++++++++++++++---
>  t/t1312-config-batch.sh             |  69 ++++++++++
>  3 files changed, 293 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
> index 1fff68a13c..3c9a3bb763 100644
> --- a/Documentation/git-config-batch.adoc
> +++ b/Documentation/git-config-batch.adoc
> @@ -21,6 +21,15 @@ multiple configuration values, the `git config-batch` command allows a
>  single process to handle multiple requests using a machine-parseable
>  interface across `stdin` and `stdout`.
>  
> +OPTIONS
> +-------
> +
> +`-z`::
> +	If specified, then use the NUL-terminated input and output

This boilerplate preliminary does not convey information, it is simpler
to just jump to the action performed by the option:

Use the _NUL_-terminated input and output…

> +	format instead of the space and newline format. This format is
> +	useful when the strings involved may include spaces or newlines.
> +	See PROTOCOL for more details.
> +
>  PROTOCOL
>  --------
>  By default, the protocol uses line feeds (`LF`) to signal the end of a
> @@ -41,13 +50,13 @@ These are the commands that are currently understood:
>  `help` version 1::
>  	The `help` command lists the currently-available commands in
>  	this version of Git. The output is multi-line, but the first
> -	line provides the count of possible commands via `help count <N>`.
> -	The next `<N>` lines are of the form `help <command> <version>`
> +	line provides the count of possible commands via `help 1 count <N>`.
> +	The next `<N>` lines are of the form `help 1 <command> <version>`
>  	to state that this Git version supports that `<command>` at
>  	version `<version>`. Note that the same command may have multiple
>  	available versions.
>  +
> -Here is the currentl output of the help text at the latest version:
> +Here is the current output of the help text at the latest version:

OK, the typo was fixed here.

>  +
>  ------------
>  help 1 count 2
> @@ -102,6 +111,48 @@ get 1 missing <key> [<value-pattern>|<value>]
>  where `<value-pattern>` or `<value>` is only supplied if provided in
>  the command.
>  
> +NUL-Terminated Format
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +When `-z` is given, the protocol changes in some structural ways.
> +
> +First, each command is terminated with two NUL bytes, providing a clear
> +boundary between commands regardless of future possibilities of new
> +command formats.
> +
> +Second, any time that a space _would_ be used to partition tokens in a
> +command, a NUL byte is used instead. Further, each token is prefixed
> +with `<N>:` where `<N>` is a decimal representation of the length of
> +the string between the `:` and the next NUL byte. Any disagreement in
> +these lengths is treated as a parsing error. This use of a length does

I thought this length encoding was used to allow _NUL_ in the config
values. But here it is considered a parse error.

> +imply that "`0:`" is the representation of an empty string, if relevant.
> +
> +The decimal representation must have at most five numerals, thus the
> +maximum length of a string token can have 99999 characters.
> +
> +For example, the `get` command, version 1, could have any of the
> +following forms:
> +
> +------------
> +3:get NUL 1:1 NUL 5:local NUL 14:key.with space NUL NUL
> +3:get NUL 1:1 NUL 9:inherit NUL 8:test.key NUL 9:arg:regex NUL 6:.*\ .* NUL NUL
> +3:get NUL 1:1 NUL 6:global NUL 8:test.key NUL 15:arg:fixed-value NUL 3:a b NUL NUL
> +------------
> +
> +The output is modified similarly, such as the following output examples,
> +as if the input has a parse error, a valid `help` command, a `get`
> +command that had a match, and a `get` command that did not match.
> +
> +------------
> +15:unknown_command NUL NUL
> +4:help NUL 1:1 NUL 5:count NUL 1:2 NUL NUL
> +4:help NUL 1:1 NUL 4:help NUL 1:1 NUL NUL
> +4:help NUL 1:1 NUL 3:get NUL 1:1 NUL NUL
> +3:get NUL 1:1 NUL 5:found NUL 8:test.key NUL 5:value NUL NUL
> +3:get NUL 1:1 NUL 7:missing NUL 8:test.key NUL NUL
> +------------
> +
> +
>  SEE ALSO
>  --------
>  linkgit:git-config[1]
