From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 09:14:39 -0700
Message-ID: <7v1wjrby4w.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	<7v8xe0h19a.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140128y46ff6bb6m503eeae00c043ddf@mail.gmail.com>
	<7v6494dwms.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140701h60982fddw3ed8fa71288cb220@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 17:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRW7j-0001Um-K7
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 17:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbXCNQOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbXCNQOn
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 12:14:43 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35428 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230AbXCNQOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 12:14:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314161441.RWWP1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 12:14:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id agEf1W00X1kojtg0000000; Wed, 14 Mar 2007 12:14:40 -0400
In-Reply-To: <81b0412b0703140701h60982fddw3ed8fa71288cb220@mail.gmail.com>
	(Alex Riesen's message of "Wed, 14 Mar 2007 15:01:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42211>

"Alex Riesen" <raa.lkml@gmail.com> writes:

>> To implement --quick correctly, you need to know when it is safe
>> to leave early.  Presence of -S (pickaxe) would most likely mean
>> you shouldn't leave early.
>
> Thanks, that got me thinking. Moved all exit code evaluation
> into diffcore_std, added a field for the code to diff_options,
> and use it if called with --exit-code.

Certainly --quick would be "interesting" and useful to add on
top of your patch.

> diff --git a/builtin-diff-files.c b/builtin-diff-files.c
> index aec8338..2525ae6 100644
> --- a/builtin-diff-files.c
> +++ b/builtin-diff-files.c
> @@ -17,6 +17,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
>  {
>  	struct rev_info rev;
>  	int nongit = 0;
> +	int result;
>  
>  	prefix = setup_git_directory_gently(&nongit);
>  	init_revisions(&rev, prefix);
> @@ -29,5 +30,6 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
>  		argc = setup_revisions(argc, argv, &rev, NULL);
>  	if (!rev.diffopt.output_format)
>  		rev.diffopt.output_format = DIFF_FORMAT_RAW;
> -	return run_diff_files_cmd(&rev, argc, argv);
> +	result = run_diff_files_cmd(&rev, argc, argv);
> +	return rev.diffopt.diff_exit_code ? rev.diffopt.exit_code: result;
>  }

Yuck.  Let's call the former "exit_with_status" (meaning, the
caller instructed us to do that) and the latter "has_changes".

> +test_expect_failure 'git diff-index --cached HEAD^' '
> +	echo text >>b &&
> +	echo 3 >c &&
> +	git add . &&
> +	git diff-index --exit-code --cached HEAD^
> +'

Please:

        test_expect_success '...
                echo ... &&
                git add . &&
                ! git diff-index ...
        '

I recall somebody on the list had a buggy shell that cannot
handle "a && ! b" and tweaked a few tests to work around it.
In that case...

	echo ... &&
        git add . &&
	{
        	git diff-index ...; test $? != 0
	}

> +test_expect_failure 'git diff-files' '
> +	echo 3 >>c &&
> +	git diff-files --exit-code
> +'

Likewise

> +git update-index c || error "update-index failed"

Please do not have command outside test_expect without good
reason.
