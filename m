From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10] ls-files: add eol diagnostics
Date: Mon, 11 Jan 2016 09:48:45 -0800
Message-ID: <xmqq8u3wxb0i.fsf@gitster.mtv.corp.google.com>
References: <1452446203-20693-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon Jan 11 18:48:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIgaK-0005r7-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 18:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760739AbcAKRss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 12:48:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759107AbcAKRsr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 12:48:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E034A39407;
	Mon, 11 Jan 2016 12:48:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZDSb4SUG7GrFqnNx0MQu8sgtKR0=; b=CuTU/3
	3zFTi63YqUDYyEAm3DSGczaSSOqTXr61g6Dc4vPAEEBf28B9QgSDvCpdzi2S3cMa
	PEqnBjYT5c06JtsDxKVbu3aJVlD1Mi4YHIlmjbL/aXdZCr9fVa8gO6TO0YI0AeSH
	P82mB5TTOtDXlJzEJGGdQUESwlMAnoW0Qnl84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J0R9nb+2nSypWf8es22vANDn74s2UJRN
	eSwtbUMpdUDOGYBFO7BNrydL9ZdjcSHkM9AYhmX5bAdyfIxXU+Ehbuw+XC+s6Fhl
	F/q/XYvxi2mL2/3xmpHt7E7y/0UybGWcAPqF76crA2ZABvHyzLR2FuDO632VVfUy
	r9WPxBZkDoI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D6B3439406;
	Mon, 11 Jan 2016 12:48:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 425F839405;
	Mon, 11 Jan 2016 12:48:46 -0500 (EST)
In-Reply-To: <1452446203-20693-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Sun, 10 Jan 2016 18:16:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9022CACA-B88B-11E5-A21D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283683>

tboegi@web.de writes:

> Changes agains pu:
> convert.c: 
>  - Indent switch case
>  - Introduced convert_is_binary() 
>
> ls-files.c:
>  - Early out in write_eolinfo()
>  - Use TAB instead of multiple spaces when -z is used
>
> t0027:
>  - case-esac indentattion
>  - cat EOF | sort, remove "e"
>  - Replace " with '
> Documentation/git-ls-files.txt:
>  -  Try to make things clearer
>  - -z turns SPACES inot TAB

Thanks for a summary.

>  Documentation/git-ls-files.txt |  30 +++++++++++
>  builtin/ls-files.c             |  24 +++++++++
>  convert.c                      | 119 +++++++++++++++++++++++++++++++----------
>  convert.h                      |   3 ++
>  t/t0027-auto-crlf.sh           | 112 +++++++++++++++++++++++++++++++++-----
>  5 files changed, 248 insertions(+), 40 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index e26f01f..03f4770 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git ls-files' [-z] [-t] [-v]
>  		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
>  		(-[c|d|o|i|s|u|k|m])*
> +		[--eol]
>  		[-x <pattern>|--exclude=<pattern>]
>  		[-X <file>|--exclude-from=<file>]
>  		[--exclude-per-directory=<file>]
> @@ -147,6 +148,23 @@ a space) at the start of each line:
>  	possible for manual inspection; the exact format may change at
>  	any time.
>  
> +--eol::
> +	Show <eolinfo> and <eolattr> of files.
> +	<eolinfo> is the file content identification used by Git when
> +	the "text" attribute is "auto" (or not set and core.autocrlf is not false).
> +	<eolinfo> is either "binary", "none", "lf", "crlf" or "mixed" or "".
> ++
> +"" means the file is not a regular file, it is not in the index or
> +not accessable in the working tree.
> ++
> +<eolattr> is the attribute that is used when checking out or committing,
> +it is either "", "-text", "text", "text=auto", "eol=lf", "eol=crlf".
> ++
> +Both the <eolinfo> in the index ("i/<eolinfo>")
> +and in the working tree ("w/<eolinfo>") are shown for regular files,
> +followed by the  ("attr/<eolattr>").
> +Whenever a file is not a regular file, both <eolinfo> and <eolattr> are "".

I think the last line is a subset of what you already said at the
beginning ("" means the file is not...).

> +		if (line_terminator == '\n')
> +			printf("i/%-6s w/%-6s attr/%-9s ", i_txt, w_txt, a_txt);

Can we do something better than these hard-coded constants?  Why
can't the "one HT between each" approach be used for both?

> +		else
> +			printf("i/%s\tw/%s\tattr/%s\t", i_txt, w_txt, a_txt);
> +	}

> +stats_ascii () {
> +	case "$1" in
> +	LF)
> +	echo lf
> +	;;

Indent the "do this thing" part one level down, i.e.

	case A in
        X)
        	do a thing
                ;;
	...
	esac

> @@ -214,6 +239,19 @@ checkout_files () {
>  		fi
>  	done
>  
> +	test_expect_success "ls-files --eol $lfname ${pfx}LF.txt" "
> +		test_when_finished 'rm expect actual' &&
> +		cat <<-EOF | sort >expect &&

Do you have to cat into a pipe?

		sort <<-EOF >expect &&

In general, "don't cat a single thing into a pipe".

> +		i/crlf w/$(stats_ascii $crlfname) ${src}CRLF.txt
> +		i/mixed w/$(stats_ascii $lfmixcrlf) ${src}CRLF_mix_LF.txt
> +		i/lf w/$(stats_ascii $lfname) ${src}LF.txt
> +		i/binary w/$(stats_ascii $lfmixcr) ${src}LF_mix_CR.txt
> +		i/binary w/$(stats_ascii $crlfnul) ${src}CRLF_nul.txt
> +		i/binary w/$(stats_ascii $crlfnul) ${src}LF_nul.txt
> +		EOF
> +		git ls-files --eol $src* | sed -e 's!attr/[=a-z-]*!!g' -e 's/  */ /g' | sort >actual &&

Break the pipeline, like this:

		git ls-files --eol $src* |
		sed -e 's!attr/[=a-z-]*!!g' -e 's/  */ /g' |
		sort >actual &&

> +		test_cmp expect actual
> +	"

Also, does the test body need to be quoted with double quotes,
allowing the substitutions happen _before_ the test runs?  We try to
enclose the last parameter to test_expect_success in single quotes
when possible, as subsitututing the $variables while computing the
arguments to the test_expect_success function historically was a
source of an unpleasant-to-debug bug (e.g. when they made the
resulting eval'ed string become syntactically incorrect).
