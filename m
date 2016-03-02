From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 4/4] config: add '--show-origin' option to print the
 origin of a config value
Date: Wed, 2 Mar 2016 18:33:36 +0100
Message-ID: <56D723F0.7020106@kdbg.org>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
 <1455873362-66998-5-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, Johannes.Schindelin@gmx.de
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 02 18:33:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abAef-0001U4-Nn
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 18:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbcCBRdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 12:33:41 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:64395 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbcCBRdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 12:33:39 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qFj9F3jvGz5tlJ;
	Wed,  2 Mar 2016 18:33:37 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 2DF37521F;
	Wed,  2 Mar 2016 18:33:36 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1455873362-66998-5-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288134>

Am 19.02.2016 um 10:16 schrieb larsxschneider@gmail.com:
> +test_expect_success '--show-origin with --list' '
> +	cat >expect <<-EOF &&
> +		file:$HOME/.gitconfig	user.global=true
> +		file:$HOME/.gitconfig	user.override=global
> +		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include

On Windows, this injects POSIX-style paths in the expected output, but 
git.exe produces mangled paths (with a drive letter). The pattern I use 
to fix this is:

		file:$(pwd)/.gitconfig	user.override=global

> +		file:$INCLUDE_DIR/absolute.include	user.absolute=include
> +		file:.git/config	user.local=true
> +		file:.git/config	user.override=local
> +		file:.git/config	include.path=../include/relative.include
> +		file:.git/../include/relative.include	user.relative=include
> +		cmdline:	user.cmdline=true
> +	EOF
> +	git -c user.cmdline=true config --list --show-origin >output &&
> +	test_cmp expect output
> +'
...
> +test_expect_success 'set up custom config file' '
> +	CUSTOM_CONFIG_FILE="file\" (dq) and spaces.conf" &&
> +	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
> +		[user]
> +			custom = true
> +	EOF

This fails on Windows, because the shell cannot create a file containing 
a double-quote character.

IIUC, the test serves two purposes: (1) to test C-style quoting of the 
output and (2) non-standard configuration files. We'll have to separate 
that so that we can test at least (2) on Windows with "regular" file 
name. We cannot test (1) because the only case where quoting is used is 
when the file name contains a double-quote character.

> +'
> +
> +test_expect_success '--show-origin escape special file name characters' '
> +	cat >expect <<-\EOF &&
> +		file:"file\" (dq) and spaces.conf"	user.custom=true
> +	EOF
> +	git config --file "$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
> +	test_cmp expect output
> +'
...
> +test_expect_success '--show-origin blob ref' '
> +	cat >expect <<-\EOF &&
> +		blob:"master:file\" (dq) and spaces.conf"	user.custom=true
> +	EOF
> +	git add "$CUSTOM_CONFIG_FILE" &&

Is this dual-purpose as well or just re-using the files established 
earlier in the test suite?

> +	git commit -m "new config file" &&
> +	git config --blob=master:"$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
> +	test_cmp expect output
> +'
> +
>   test_done
> --
> 2.5.1
>
