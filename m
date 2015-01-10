From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] t1020-subdirectory.sh: check hook pwd, $GIT_PREFIX
Date: Sat, 10 Jan 2015 09:25:18 +0100
Message-ID: <54B0E1EE.2020301@kdbg.org>
References: <1420872598-9609-1-git-send-email-rhansen@bbn.com> <1420872598-9609-3-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 09:25:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9rMT-0007AQ-Om
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 09:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbbAJIZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 03:25:29 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:56809 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751306AbbAJIZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 03:25:29 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3kKDl94jPHz5tlG;
	Sat, 10 Jan 2015 09:25:25 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 27E1D19F813;
	Sat, 10 Jan 2015 09:25:19 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <1420872598-9609-3-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262259>

Am 10.01.2015 um 07:49 schrieb Richard Hansen:
> Make sure hooks are executed at the top-level directory and that
> GIT_PREFIX is set (as documented).
> 
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>  t/t1020-subdirectory.sh | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
> index 2edb4f2..03bb0a2 100755
> --- a/t/t1020-subdirectory.sh
> +++ b/t/t1020-subdirectory.sh
> @@ -128,6 +128,23 @@ test_expect_success !MINGW '!alias expansion' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'hook pwd' '
> +	pwd >expect &&
> +	(
> +		rm -f actual &&
> +		mkdir -p .git/hooks &&
> +		! test -e .git/hooks/post-checkout &&

What is the purpose of this test?

> +		cat <<-\EOF >.git/hooks/post-checkout &&
> +			#!/bin/sh
> +			pwd >actual
> +		EOF
> +		chmod +x .git/hooks/post-checkout &&

Use write_script() to construct a shell script.

> +		(cd dir && git checkout -- two) &&
> +		rm -f .git/hooks/post-checkout

This cleanup would be skipped if the checkout fails for some reason. Use
test_when_finished.

> +	) &&

The outer sub-shell us unnecessary, isn't it?

> +	test_cmp expect actual

If 'git checkout' runs the hook from the wrong directory, there would
not exist a file 'actual' at this point because it was rm -f'd earlier,
and the test would fail. Perhaps it would make sense to document this
failure case by inserting

	test_path_is_file actual &&

before the test_cmp?

Which makes me think: Would the test for existence of 'actual' be
sufficient? Then the test_cmp could be omitted. The advantage is that we
do not depend on how the `pwd` is formatted: With or without symbolic
links in any leading path or c:/foo vs. /c/foo on Windows. (I anticipate
that the test as written fails on Windows because 'expect' is in c:/foo
form and 'actual' is in /c/foo form.)

> +'
> +
>  test_expect_success 'GIT_PREFIX for !alias' '
>  	printf "dir/" >expect &&
>  	(
> @@ -154,6 +171,23 @@ test_expect_success 'GIT_PREFIX for built-ins' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'GIT_PREFIX for hooks' '
> +	printf "dir/" >expect &&
> +	(
> +		rm -f actual &&
> +		mkdir -p .git/hooks &&
> +		! test -e .git/hooks/post-checkout &&
> +		cat <<-\EOF >.git/hooks/post-checkout &&
> +			#!/bin/sh
> +			printf %s "$GIT_PREFIX" >actual
> +		EOF
> +		chmod +x .git/hooks/post-checkout &&
> +		(cd dir && git checkout -- two) &&
> +		rm -f .git/hooks/post-checkout
> +	)  &&

The comments about the sub-shell, write_script, and clean-up apply here,
too.

> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'no file/rev ambiguity check inside .git' '
>  	git commit -a -m 1 &&
>  	(
> 

-- Hannes
