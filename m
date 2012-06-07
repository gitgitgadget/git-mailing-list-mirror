From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv2] rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 10:40:38 +0200
Message-ID: <4FD06906.1080007@kdbg.org>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 07 10:40:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScYGw-0006Tw-VA
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 10:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759741Ab2FGIkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 04:40:45 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:36599 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755979Ab2FGIkm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 04:40:42 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 22E9C130044;
	Thu,  7 Jun 2012 10:40:38 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8D02D19F37F;
	Thu,  7 Jun 2012 10:40:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199381>

Am 06.06.2012 12:34, schrieb Lucien Kong:
> This patch provides a way to automatically add these "exec" lines
> between each commit applications. For instance, running 'git rebase -i
> --exec "make test"' lets you check that intermediate commits are
> compilable.

While I won't be a heavy user of this feature, I think it has some merit
as a porcelain feature, particularly because it is rather cumbersome to
achieve the same effect as in the given example without plumbing commands.

> +-x <cmd>::
> +--exec <cmd>::
...
> ++
> +This has to be used along with the `--interactive` option explicitly.
...
> +
> +If the option '-i' is missing, The command will return a message
> +error. If there is no <cmd> specified behind --exec, the command will
> +return a message error and the usage page of 'git rebase'.

The important part (that -x needs -i) of this paragraph are already
spelled out above, and the exact error behavior does not need a
description in the manual. Drop this paragraph.

BTW, I don't think it is a good idea to dump the usage if -x was used
without -i.

> +# Add commands after a pick or after a squash/fixup serie
> +# in the todo list.
> +add_exec_commands () {
> +	OIFS=$IFS
> +	IFS=$LF
> +	for i in $cmd
> +	do
> +		tmp=$(sed "/^pick .*/i\
> +				exec $i" "$1")

Does this white-space before 'exec' not end up in the  todo list?

I think it is wise to use introduce sed expressions by using -e. This
applies to all 'sed' invocations that this patch introduces (also in the
test-suite).

> +		echo "$tmp" >"$1"

Some 'echo' implementations expand escape sequences in the supplied
texts. To avoid it (this is user-supplied text!), do this:

		printf "%s\n" "$tmp" >"$1"

> +		tmp=$(sed '1d' "$1")
> +		echo "$tmp" >"$1"
> +		echo "exec $i" >>"$1"

Ditto.

> +	done
> +	IFS=$OIFS
> +}

> +	-x)
> +		test 2 -le "$#" || usage
> +		cmd="${cmd:+"$cmd$LF"} $2"

The quoting here is *very* odd. The outer dquotes do extend their effect
into the replacement word after the :+ operator. I am surprised that so
many shells grok it. ash does not, by the way. Also, you don't need the
space anymore. Therefore:

		cmd="${cmd:+$cmd$LF}$2"

> +		shift
> +		;;

> +test_expect_success 'running "git rebase -i --exec git show HEAD"' '
> +	git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
> +	(
> +		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
> +		export FAKE_LINES &&
> +		git rebase -i HEAD~2 >expected
> +	) &&
> +	sed '1,9d' expected >expect &&

Here and everywhere else: Single quotes do not nest :-) use dquotes (and
-e).

> +	mv expect expected &&

Why not

	( ... git rebase ... >expect ) &&
	sed -e ... expect >expected &&

without the mv?

You could even line up the commands in a pipeline, but since the first
one contains a git command, it is better not to do that because breakage
of the git command would not be detected if it is not the last command
in the pipeline.

> +test_expect_success 'rebase --exec without -i shows error message' '
> +	git reset --hard execute &&
> +	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
> +	echo "--exec option must be used with --interactive option\n" >expected &&
> +	test_cmp expected actual

Sooner or later this text will be translated. Therefore:

	test_i18ncmp ...

-- Hannes
