From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] unblock and unignore SIGPIPE
Date: Sat, 20 Sep 2014 10:42:52 +0200
Message-ID: <541D3E0C.4030400@kdbg.org>
References: <1411059429-23868-1-git-send-email-patrick.reynolds@github.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Patrick Reynolds <patrick.reynolds@github.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 10:43:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVGGC-0003Q3-7i
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 10:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbaITInA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2014 04:43:00 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:14326 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbaITIm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2014 04:42:57 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3j0QQy0tlxz5tlM;
	Sat, 20 Sep 2014 10:42:49 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 324D719F43D;
	Sat, 20 Sep 2014 10:42:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <1411059429-23868-1-git-send-email-patrick.reynolds@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257311>

Am 18.09.2014 um 18:57 schrieb Patrick Reynolds:
> Blocked and ignored signals -- but not caught signals -- are inherited
> across exec.  Some callers with sloppy signal-handling behavior can call
> git with SIGPIPE blocked or ignored, even non-deterministically.  When
> SIGPIPE is blocked or ignored, several git commands can run indefinitely,
> ignoring EPIPE returns from write() calls, even when the process that
> called them has gone away.  Our specific case involved a pipe of git
> diff-tree output to a script that reads a limited amount of diff data.
> 
> In an ideal world, git would never be called with SIGPIPE blocked or
> ignored.  But in the real world, several real potential callers, including
> Perl, Apache, and Unicorn, sometimes spawn subprocesses with SIGPIPE
> ignored.  It is easier and more productive to harden git against this
> mistake than to clean it up in every potential parent process.
> 
> Signed-off-by: Patrick Reynolds <patrick.reynolds@github.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 1. Merged Junio's work from pu: moved restore_sigpipe_to_default into
> git.c and restyled the new tests.
> 2. Moved the new tests into t0005.  This meant switching back to `git
> diff` as our data generator, as the sample repo in t0005 doesn't have any
> files for `git ls-files` to output.
> 3. Squashed.
> 
>  git.c              | 22 ++++++++++++++++++++++
>  t/t0005-signals.sh | 22 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/git.c b/git.c
> index 210f1ae..0f03d56 100644
> --- a/git.c
> +++ b/git.c
> @@ -593,6 +593,26 @@ static int run_argv(int *argcp, const char ***argv)
>  	return done_alias;
>  }
>  
> +/*
> + * Many parts of Git have subprograms communicate via pipe, expect the
> + * upstream of the pipe to die with SIGPIPE and the downstream process
> + * even knows to check and handle EPIPE correctly.  Some third-party
> + * programs that ignore or block SIGPIPE for their own reason forget
> + * to restore SIGPIPE handling to the default before spawning Git and
> + * break this carefully orchestrated machinery.
> + *
> + * Restore the way SIGPIPE is handled to default, which is what we
> + * expect.
> + */
> +static void restore_sigpipe_to_default(void)
> +{
> +	sigset_t unblock;
> +
> +	sigemptyset(&unblock);
> +	sigaddset(&unblock, SIGPIPE);
> +	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
> +	signal(SIGPIPE, SIG_DFL);
> +}

This does not build on MinGW due to missing sigaddset() and
sigprocmask(). I've a patch that adds dummies for them (but I ran out of
time to complete it for submission). But then the test cases ...

> +test_expect_success 'a constipated git dies with SIGPIPE' '
> +	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 )
> +	test "$OUT" -eq 141
> +'
> +
> +test_expect_success 'a constipated git dies with SIGPIPE even if parent ignores it' '
> +	OUT=$( ((trap "" PIPE; large_git; echo $? 1>&3) | :) 3>&1 )
> +	test "$OUT" -eq 141
> +'

... fail always because we neither get SIGPIPE (we don't have it on
Windows) nor do we see a write error (e.g. EPIPE) when writing to the
pipe. Should I protect these tests with !MINGW or would it be an option
to drop these tests alltogether?

-- Hannes
