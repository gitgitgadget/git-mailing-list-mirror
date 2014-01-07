From: Olaf Meeuwissen <olaf.meeuwissen@avasys.jp>
Subject: Re: [PATCH] pager: set LV=-c alongside LESS=FRSX
Date: Tue, 07 Jan 2014 13:09:01 +0900
Message-ID: <87zjn8o2le.fsf@helix.nebula.avasys.jp>
References: <874n6zbqlh.fsf@helix.nebula.avasys.jp> <20140106193339.GH3881@google.com> <874n5ghenr.fsf@helix.nebula.avasys.jp> <20140107021404.GK3881@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Olaf Meeuwissen" <olaf.meeuwissen@avasys.jp>, git@vger.kernel.org
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 05:24:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0OD6-0003OX-I1
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 05:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906AbaAGEYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 23:24:07 -0500
Received: from ucv05.avasys.jp ([210.228.20.165]:56694 "EHLO ekc4.avasys.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755379AbaAGEYG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 23:24:06 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jan 2014 23:24:06 EST
X-AuditID: ac111ccd-b7bbeae000003014-ab-52cb7ddda7e3
Received: from m1b.epkowa.co.jp (m1b.epkowa.co.jp [172.17.100.126])
	by ekc4.avasys.jp (Symantec Brightmail Gateway) with SMTP id 55.39.12308.DDD7BC25; Tue,  7 Jan 2014 13:09:01 +0900 (JST)
Received: from helix.nebula.avasys.jp ([172.17.107.100]) by m1b.epkowa.co.jp with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 7 Jan 2014 13:09:01 +0900
User-agent: mu4e 0.9.9.5; emacs 24.3.1
In-reply-to: <20140107021404.GK3881@google.com>
X-OriginalArrivalTime: 07 Jan 2014 04:09:01.0409 (UTC) FILETIME=[32335510:01CF0B5E]
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240098>

Jonathan Nieder writes:

> On systems with lv configured as the preferred pager (i.e.,
> DEFAULT_PAGER=lv at build time, or PAGER=lv exported in the
> environment) git commands that use color show control codes instead of
> color in the pager:
>
> 	$ git diff
> 	^[[1mdiff --git a/.mailfilter b/.mailfilter^[[m
> 	^[[1mindex aa4f0b2..17e113e 100644^[[m
> 	^[[1m--- a/.mailfilter^[[m
> 	^[[1m+++ b/.mailfilter^[[m
> 	^[[36m@@ -1,11 +1,58 @@^[[m
>
> "less" avoids this problem because git uses the LESS environment
> variable to pass the -R option ('output ANSI color escapes in raw
> form') by default.  Use the LV environment variable to pass 'lv' the
> -c option ('allow ANSI escape sequences for text decoration / color')
> to fix it for lv, too.
>
> Noticed when the default value for color.ui flipped to 'auto' in
> v1.8.4-rc0~36^2~1 (2013-06-10).
>
> Reported-by: Olaf Meeuwissen <olaf.meeuwissen@avasys.jp>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Olaf Meeuwissen wrote[1]:
>
>> Yes, it's called LV and documented in the lv(1) manual page.  Simply
>> search for 'env' ;-)
>
> Ah, thanks.  How about this patch?

I'm not qualified to judge the appropriateness of your patch, but if it
achieves activating the -c option of lv when that is the pager in effect
then that should work for the bulk of the use cases, I'd think.

> [1] http://bugs.debian.org/730527
>
>  Documentation/config.txt |  4 ++++
>  git-sh-setup.sh          |  3 ++-
>  pager.c                  | 11 +++++++++--
>  perl/Git/SVN/Log.pm      |  1 +
>  t/t7006-pager.sh         | 12 ++++++++++++
>  5 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index a405806..ed59853 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -567,6 +567,10 @@ be passed to the shell by Git, which will translate the final
>  command to `LESS=FRSX less -+S`. The environment tells the command
>  to set the `S` option to chop long lines but the command line
>  resets it to the default to fold long lines.
> ++
> +Likewise, when the `LV` environment variable is unset, Git sets it
> +to `-c`.  You can override this setting by exporting `LV` with
> +another value or setting `core.pager` to `lv +c`.
>  
>  core.whitespace::
>  	A comma separated list of common whitespace problems to
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 190a539..fffa3c7 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -159,7 +159,8 @@ git_pager() {
>  		GIT_PAGER=cat
>  	fi
>  	: ${LESS=-FRSX}
> -	export LESS
> +	: ${LV=-c}
> +	export LESS LV
>  
>  	eval "$GIT_PAGER" '"$@"'
>  }
> diff --git a/pager.c b/pager.c
> index 345b0bc..0cc75a8 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -80,8 +80,15 @@ void setup_pager(void)
>  	pager_process.use_shell = 1;
>  	pager_process.argv = pager_argv;
>  	pager_process.in = -1;
> -	if (!getenv("LESS")) {
> -		static const char *env[] = { "LESS=FRSX", NULL };
> +	if (!getenv("LESS") || !getenv("LV")) {
> +		static const char *env[3];
> +		int i = 0;
> +
> +		if (!getenv("LESS"))
> +			env[i++] = "LESS=FRSX";
> +		if (!getenv("LV"))
> +			env[i++] = "LV=-c";
> +		env[i] = NULL;
>  		pager_process.env = env;
>  	}
>  	if (start_command(&pager_process))
> diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
> index 3f8350a..34f2869 100644
> --- a/perl/Git/SVN/Log.pm
> +++ b/perl/Git/SVN/Log.pm
> @@ -117,6 +117,7 @@ sub run_pager {
>  	}
>  	open STDIN, '<&', $rfd or fatal "Can't redirect stdin: $!";
>  	$ENV{LESS} ||= 'FRSX';
> +	$ENV{LV} ||= '-c';
>  	exec $pager or fatal "Can't run pager: $! ($pager)";
>  }
>  
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index ff25908..7fe3367 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -37,6 +37,18 @@ test_expect_failure TTY 'pager runs from subdir' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success TTY 'LESS and LV envvars are set for pagination' '
> +	(
> +		sane_unset LESS LV &&
> +		PAGER="env >pager-env.out" &&
> +		export PAGER &&
> +
> +		test_terminal git log
> +	) &&
> +	grep ^LESS= pager-env.out &&
> +	grep ^LV= pager-env.out
> +'
> +
>  test_expect_success TTY 'some commands do not use a pager' '
>  	rm -f paginated.out &&
>  	test_terminal git rev-list HEAD &&

Hope this helps,
-- 
Olaf Meeuwissen, LPIC-2           FLOSS Engineer -- AVASYS CORPORATION
FSF Associate Member #1962               Help support software freedom
                 http://www.fsf.org/jf?referrer=1962
