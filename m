From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] t7800: modernize tests
Date: Sun, 17 Feb 2013 03:21:40 -0800
Message-ID: <20130217112139.GG6759@elie.Belkin>
References: <1360993666-81308-1-git-send-email-davvid@gmail.com>
 <1360993666-81308-2-git-send-email-davvid@gmail.com>
 <1360993666-81308-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 12:22:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U72K4-0002rj-Ph
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 12:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990Ab3BQLVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 06:21:48 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:60134 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960Ab3BQLVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 06:21:47 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so2394644pab.29
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 03:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+UDRBjaZIYVI1c3jwdSofWC6wtnas4mE/8AFtfSuNMU=;
        b=PGDgwINQa5/IFvb1xkXx5VWR0VjFH9eJK4uxb/5oByBjCt2xtTCmQABAkKL2RyGC8l
         +Q0uXEMpMDjnuv5MLO9u14ljXpZ9F9/V1xtI9PEznXIpR3elctcILtrrcmSa5ynKtbeZ
         kkl+sRTRoKcF7agsm4IkkfyBplEjqKQAK7+5ItKfgK28pepKHmc4F2YqCmYeXlymmejd
         Erq8LoUGqHggJvM9hQWowWljmZ8gFEm5vBpUa20VQIdMhFhYRyApqv0UynAGRW0v1U0g
         GrIAouIpJCVIvC+1oHh0mBNgJORQ2j58wxnO/ntIpCstWByZB69i5bofSaBk/LSoX4Fv
         zgSQ==
X-Received: by 10.66.147.234 with SMTP id tn10mr8663075pab.21.1361100105930;
        Sun, 17 Feb 2013 03:21:45 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ab1sm10881965pbd.37.2013.02.17.03.21.43
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Feb 2013 03:21:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1360993666-81308-3-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216390>

David Aguilar wrote:

> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -10,29 +10,11 @@ Testing basic diff tool invocation
[...]
> -restore_test_defaults()
> -{
> -	# Restores the test defaults used by several tests
> -	remove_config_vars
> -	unset GIT_DIFF_TOOL
> -	unset GIT_DIFFTOOL_PROMPT
> -	unset GIT_DIFFTOOL_NO_PROMPT
> -	git config diff.tool test-tool &&
> -	git config difftool.test-tool.cmd 'cat $LOCAL'
> -	git config difftool.bogus-tool.cmd false

Yay. :)

[...]
>  # Ensures that git-difftool ignores bogus --tool values
>  test_expect_success PERL 'difftool ignores bad --tool values' '
>  	diff=$(git difftool --no-prompt --tool=bad-tool branch)
>  	test "$?" = 1 &&
> -	test "$diff" = ""
> +	test -z "$diff"
>  '

Not about this patch: if I add more commands before that "diff",
their exit status would be ignored.  Could this be made more resilient
using test_expect_code?  Something like

	test_expect_code 1 git diff --no-prompt --tool=bad-tool branch >actual &&
	>expect &&
	test_cmp expect actual

[...]
>  # Specify the diff tool using $GIT_DIFF_TOOL
>  test_expect_success PERL 'GIT_DIFF_TOOL variable' '
> -	test_might_fail git config --unset diff.tool &&
> +	difftool_test_setup &&
> +	git config --unset diff.tool &&
> +
>  	GIT_DIFF_TOOL=test-tool &&
>  	export GIT_DIFF_TOOL &&
>  
>  	diff=$(git difftool --no-prompt branch) &&
>  	test "$diff" = "branch" &&
> -
> -	restore_test_defaults
> +	sane_unset GIT_DIFF_TOOL

If this test fails, GIT_DIFF_TOOL would remain set which could take
down later tests, too.  Could it be set in a subprocess (e.g., a
subshell) to avoid that?

	difftool_test_setup &&
	git config --unset diff.tool &&

	echo branch >expect &&
	GIT_DIFF_TOOL=test-tool git difftool --no-prompt branch >actual &&
	test_cmp expect actual

[...]
>  test_expect_success PERL 'GIT_DIFF_TOOL overrides' '
> -	git config diff.tool bogus-tool &&
> -	git config merge.tool bogus-tool &&
> -
> +	difftool_test_setup &&
> +	test_config diff.tool bogus-tool &&
> +	test_config merge.tool bogus-tool &&
>  	GIT_DIFF_TOOL=test-tool &&
>  	export GIT_DIFF_TOOL &&
>  
>  	diff=$(git difftool --no-prompt branch) &&

Likewise.

[...]
>  	GIT_DIFF_TOOL=bogus-tool &&
>  	export GIT_DIFF_TOOL &&
>  
>  	diff=$(git difftool --no-prompt --tool=test-tool branch) &&

Likewise.

[...]
>  test_expect_success PERL 'GIT_DIFFTOOL_NO_PROMPT variable' '
> +	difftool_test_setup &&
>  	GIT_DIFFTOOL_NO_PROMPT=true &&
>  	export GIT_DIFFTOOL_NO_PROMPT &&
>  
>  	diff=$(git difftool branch) &&

Likewise.

[...]
>  test_expect_success PERL 'GIT_DIFFTOOL_PROMPT variable' '
> -	git config difftool.prompt false &&
> +	difftool_test_setup &&
> +	test_config difftool.prompt false &&
>  	GIT_DIFFTOOL_PROMPT=true &&
>  	export GIT_DIFFTOOL_PROMPT &&
>  
>  	prompt=$(echo | git difftool branch | tail -1) &&

Likewise.  This one loses the exit status from 'git difftool',
which could be avoided by writing to temporary files:

	echo >input &&
	GIT_DIFFTOOL_PROMPT=true git difftool branch <input >output &&
	prompt=$(tail -1 <output) &&

[...]
>  test_expect_success PERL 'difftool last flag wins' '
> +	difftool_test_setup &&
>  	diff=$(git difftool --prompt --no-prompt branch) &&
>  	test "$diff" = "branch" &&
>  
> -	restore_test_defaults &&
> -
>  	prompt=$(echo | git difftool --no-prompt --prompt branch | tail -1) &&
[...]

Likewise.

Thanks for cleaning up, and sorry I don't have anything more
substantial to offer.

Hope that helps,
Jonathan
