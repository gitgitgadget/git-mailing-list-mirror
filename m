From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv5 01/16] test-lib: make test_expect_code a test command
Date: Sun, 3 Oct 2010 09:13:39 -0500
Message-ID: <20101003141339.GB17084@burratino>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
 <1286082644-31595-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 16:17:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2PNG-0000Ze-H1
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 16:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab0JCOQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 10:16:57 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59065 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab0JCOQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 10:16:56 -0400
Received: by qyk36 with SMTP id 36so1739972qyk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kU34cVC1nDmKCPoTSvn22S/Jy3UYYKKwJDsiVK24Pxg=;
        b=mMDc4RLQeAXNq54zYLhLxRl0lWLhaeF7ai8HkDJs+BQcJ+o8jYLL/LtNsDssw/Tl9Y
         NbPuRwnfgT2+UC4Cn/DrUSnnwzV97czioA6uuwBFdznbfO6szbRkgtIxcPLGBhJQMxqE
         DM2AaujntwPBrIOlgedCfUuDe2hKA0pemu3eE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xAIoK/vrB59Qg3M14NrJs2nw3KxT/wWAgRpcZdjqG2speP/6+KMpXb+X4A+tLyipnz
         ZUz1yrxqdCzYR8qitwHFV679qvlriJ/vAll2obnbavq6GYF98Wfh57Drc9CviDmcvC77
         qy27Z55qZCuLClUuRvmPSIGQg3rNDr+w+qi6I=
Received: by 10.224.28.207 with SMTP id n15mr5796216qac.48.1286115416036;
        Sun, 03 Oct 2010 07:16:56 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r38sm4080378qcs.14.2010.10.03.07.16.51
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 07:16:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286082644-31595-2-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157874>

Elijah Newren wrote:

> --- a/t/README
> +++ b/t/README
> @@ -482,6 +475,15 @@ library for your script to use.
>  	    'Perl API' \
>  	    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
>
> + - test_expect_code <exit-code> <git-command>
> +
> +   Run a git command and ensure that it exits with the given exit
> +   code. For example:
> +
> +	test_expect_success 'Merge with d/f conflicts' '
> +		test_expect_code 1 git merge "merge msg" B master
> +	'

Side note: this helper should be safe to use even for non-git
commands.  "Huh?" you might ask. "But test_must_fail and
test_might_fail..."  Well, the distinction is this: test_must_fail and
test_might_fail rely on details of git's funny exit code conventions
--- e.g., that 130 is not a controlled failure and 129 is one ---
while test_expect_code has simpler, more generally valid semantics.

But maybe in practice this helper would only be used for git commands
anyway.

> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -130,22 +130,57 @@ test_expect_success 'tests clean up after themselves' '
[...]
> +test_expect_success 'tests clean up even on failures' "
> +    mkdir failing-cleanup &&
> +    (cd failing-cleanup &&
> +    cat >failing-cleanup.sh <<EOF &&
> +#!$SHELL_PATH

Is $SHELL_PATH allowed to contain a shell metacharacter? (just
curious).

> +
> +test_description='Failing tests with cleanup commands'
> +
> +# Point to the t/test-lib.sh, which isn't in ../ as usual
> +TEST_DIRECTORY=\"$TEST_DIRECTORY\"
> +. \"\$TEST_DIRECTORY\"/test-lib.sh

Quoting issues?  I suspect the first $TEST_DIRECTORY here would
be twice expanded and the second would be once expanded before
failing-cleanup.sh is written.

On the other hand, a $TEST_DIRECTORY with backslashes in it is
asking for trouble for other reasons already.

> +
> +test_expect_success 'tests clean up even after a failure' '
> +    touch clean-after-failure &&
> +    test_when_finished rm clean-after-failure &&
> +    (exit 1)
>  '
>  
> +test_expect_success 'failure to clean up causes the test to fail' '
> +    test_when_finished \"(exit 2)\"

This changes the semantics of the test: before, it checked that
the exit code was propagated out in these failure cases, but now
it just checks that the test fails.

The new semantics are probably more appropriate --- who relies on
the exact exit status from a test script, anyway?

> --- a/t/t1504-ceiling-dirs.sh
> +++ b/t/t1504-ceiling-dirs.sh
[...]
> --- a/t/t6020-merge-df.sh
> +++ b/t/t6020-merge-df.sh
[...]

Nice. :)

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -658,6 +640,28 @@ test_might_fail () {
>  	return 0
>  }
>  
> +# Similar to test_must_fail and test_might_fail, but check that a
> +# given command exited with a given exit code. Meant to be used as:
> +#
> +#	test_expect_success 'Merge with d/f conflicts' '
> +#		test_expect_code 1 git merge "merge msg" B master
> +#	'
> +
> +test_expect_code () {
> +	want_code=$1
> +	shift
> +	"$@"
> +	exit_code=$?
> +	if test $exit_code = $want_code
> +	then
> +		echo >&2 "test_expect_code: command exited with $exit_code: $*"
> +		return 0

This makes the tests noisier on success.  I have no strong feelings
either way about that, but it's probably worth mentioning in the commit
message.

Anyway, for what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
