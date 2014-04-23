From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Wed, 23 Apr 2014 15:51:28 -0400
Message-ID: <CAPig+cTK8i6rGYmum0m-wCmTUE4oqMVEdryiAt29vJXYdgSuYQ@mail.gmail.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
	<1398154767-1276-4-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 21:51:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3Ch-0005EW-9n
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869AbaDWTvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:51:31 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:40927 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbaDWTv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:51:29 -0400
Received: by mail-yk0-f175.google.com with SMTP id 131so1235427ykp.34
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Owt4N1nczPUW74yJg5IhMsPH3Esay/38Jy9LQJ0RrLM=;
        b=Eu+QIQL3SGdlbx4/vqQS6834gS5jBDMJkBl4kZLS1r0oTjuHIZRFO2fNZsmr/nScZo
         CpR8Te4ZHPnr4+T+fq4/Z9xRF9SM5KEm1k70F+6+lHXKQ5hVjZKEbHpJEDgZn74KJHvH
         8qsa5Hd/+npWXBHp708q6S3djpYqtmx/OvTeEhSc0dceoW/l4aLkGxqOnocm91XokBKw
         npNLp8Z14/moZSZATWgYXry+OepRYkz7hZM8xA7P3TZGikzNsd9f5pJWHrpWH3yrLqOS
         dKpIH9CCrV2eC4cm9NepP/KeeEgEzZAm2yniBg4yIq6FXfOSJhWRaxZzNsQAkp/9+5Bc
         HZRw==
X-Received: by 10.236.194.169 with SMTP id m29mr14691269yhn.121.1398282688392;
 Wed, 23 Apr 2014 12:51:28 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Wed, 23 Apr 2014 12:51:28 -0700 (PDT)
In-Reply-To: <1398154767-1276-4-git-send-email-ilya.bobyr@gmail.com>
X-Google-Sender-Auth: g95Da8k-Ea1WkgUB_OP__2GvxSE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246873>

On Tue, Apr 22, 2014 at 4:19 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
> Allow better control of the set of tests that will be executed for a
> single test suite.  Mostly useful while debugging or developing as it
> allows to focus on a specific test.
>
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
> diff --git a/t/README b/t/README
> index 6b93aca..2dac619 100644
> --- a/t/README
> +++ b/t/README
> +As noted above, the test set is built going though items left to
> +right, so this:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1-4 !3'
> +
> +will run tests 1, 2, and 4.
> +
> +You may use negation with ranges.  The following will run all
> +test as a test suite except from 7 upto 11:

s/upto/up to/
...or...
s/upto/through/

> +    $ sh ./t9200-git-cvsexport-commit.sh --run='!7-11'
> +
> +Some tests in a test suite rely on the previous tests performing
> +certain actions, specifically some tests are designated as
> +"setup" test, so you cannot _arbitrarily_ disable one test and
> +expect the rest to function correctly.
> +--run is mostly useful when you want to focus on a specific test
> +and know what you are doing.  Or when you want to run up to a
> +certain test.
>
>
>  Naming Tests
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index ae8874e..e2589cc 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -84,6 +97,18 @@ check_sub_test_lib_test () {
>         )
>  }
>
> +check_sub_test_lib_test_err () {
> +       name="$1" # stdin is the expected output output from the test
> +       # expecte error output is in descriptor 3

s/expecte/expected/

> +       (
> +               cd "$name" &&
> +               sed -e 's/^> //' -e 's/Z$//' >expect.out &&
> +               test_cmp expect.out out &&
> +               sed -e 's/^> //' -e 's/Z$//' <&3 >expect.err &&
> +               test_cmp expect.err err
> +       )
> +}
> +
>  test_expect_success 'pretend we have a fully passing test suite' "
>         run_sub_test_lib_test full-pass '3 passing tests' <<-\\EOF &&
>         for i in 1 2 3
> @@ -333,6 +358,329 @@ test_expect_success 'GIT_SKIP_TESTS sh pattern' "
> +test_expect_success '--run invalid range start' "
> +       run_sub_test_lib_test_err run-inv-range-start \
> +               '--run invalid range start' \
> +               --run='a-5' <<-\\EOF &&
> +       test_expect_success \"passing test #1\" 'true'
> +       test_done
> +       EOF
> +       check_sub_test_lib_test_err run-inv-range-start \
> +               <<-\\EOF_OUT 3<<-\\EOF_ERR
> +       > FATAL: Unexpected exit with code 1
> +       EOF_OUT
> +       > error: --run: range start should contain only digits: 'a-5'

This reads rather strangely, as if it's attempting to give an example
(after the colon) of a valid digit range, but then shows something
that is not valid. Rewording it slightly can eliminate the ambiguity:

    error: --run: invalid non-numeric range start: 'a-5'

> +       EOF_ERR
> +"
> +
> +test_expect_success '--run invalid range end' "
> +       run_sub_test_lib_test_err run-inv-range-end \
> +               '--run invalid range end' \
> +               --run='1-z' <<-\\EOF &&
> +       test_expect_success \"passing test #1\" 'true'
> +       test_done
> +       EOF
> +       check_sub_test_lib_test_err run-inv-range-end \
> +               <<-\\EOF_OUT 3<<-\\EOF_ERR
> +       > FATAL: Unexpected exit with code 1
> +       EOF_OUT
> +       > error: --run: range end should contain only digits: '1-z'

Ditto.

> +       EOF_ERR
> +"
> +
> +test_expect_success '--run invalid selector' "
> +       run_sub_test_lib_test_err run-inv-selector \
> +               '--run invalid selector' \
> +               --run='1?' <<-\\EOF &&
> +       test_expect_success \"passing test #1\" 'true'
> +       test_done
> +       EOF
> +       check_sub_test_lib_test_err run-inv-selector \
> +               <<-\\EOF_OUT 3<<-\\EOF_ERR
> +       > FATAL: Unexpected exit with code 1
> +       EOF_OUT
> +       > error: --run: test selector should contain only digits: '1?'

And here:

    error: --run: invalid non-digit in range selector: '1?'

or something.

> +       EOF_ERR
> +"
> +
> +
>  test_set_prereq HAVEIT
>  haveit=no
>  test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index e7d9c51..46ba513 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -366,6 +374,100 @@ match_pattern_list () {
>         return 1
>  }
>
> +match_test_selector_list () {
> +       title="$1"
> +       shift
> +       arg="$1"
> +       shift
> +       test -z "$1" && return 0
> +
> +       # Both commas and spaces are accepted as separators
> +       OLDIFS=$IFS
> +       IFS='   ,'

The comment mentions only space and comma, but the actual assigned IFS
value also treats tabs as separators. Perhaps update the comment to
say "commas and whitespace".

> +       set -- $1
> +       IFS=$OLDIFS
> +
> +       # If the first selector is negative we include by default.
> +       include=
> +       case "$1" in
> +               !*) include=t ;;
> +       esac
> +
> +       for selector
> +       do
> +               orig_selector=$selector
> +
> +

Unnecessary extra blank line.

> +               positive=t
> +               case "$selector" in
> +                       !*)
> +                               positive=
> +                               selector=${selector##?}
> +                               ;;
> +               esac
> +
> +               test -z "$selector" && continue
> +
> +               case "$selector" in
> +                       *-*)
> +                               if expr "z${selector%%-*}" : "z[0-9]*[^0-9]" >/dev/null
> +                               then
> +                                       echo "error: $title: range start should contain only" \
> +                                               "digits: '$orig_selector'" >&2
> +                                       exit 1
> +                               fi
> +                               if expr "z${selector#*-}" : "z[0-9]*[^0-9]" >/dev/null
> +                               then
> +                                       echo "error: $title: range end should contain only" \
> +                                               "digits: '$orig_selector'" >&2
> +                                       exit 1
> +                               fi

Weird ranges like "1-4-6" and "1-!5" will be caught by the "error:
range end" clause. Okay.

> +                               ;;
> +                       *)
> +                               if expr "z$selector" : "z[0-9]*[^0-9]" >/dev/null
> +                               then
> +                                       echo "error: $title: test selector should contain" \
> +                                               "only digits: '$orig_selector'" >&2
> +                                       exit 1
> +                               fi
> +               esac
> +
> +               # Short cut for "obvious" cases
> +               test -z "$include" && test -z "$positive" && continue
> +               test -n "$include" && test -n "$positive" && continue
> +
> +               case "$selector" in
> +                       -*)
> +                               if test $arg -le ${selector#-}
> +                               then
> +                                       include=$positive
> +                               fi
> +                               ;;
> +                       *-)
> +                               if test $arg -ge ${selector%-}
> +                               then
> +                                       include=$positive
> +                               fi
> +                               ;;
> +                       *-*)
> +                               if test ${selector%%-*} -le $arg \
> +                                       -a $arg -le ${selector#*-}

The -a option to 'test' is not portable [1] and is considered obsolete
by POSIX [2]. Use "test foo && test bar" instead.

[1]: http://www.gnu.org/software/autoconf/manual/autoconf.html#index-g_t_0040command_007btest_007d-1793
[2]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html

> +                               then
> +                                       include=$positive
> +                               fi
> +                               ;;
> +                       *)
> +                               if test $arg -eq $selector
> +                               then
> +                                       include=$positive
> +                               fi
> +                               ;;
> +               esac
> +       done
> +
> +       test -n "$include"
> +}
> +
>  maybe_teardown_verbose () {
>         test -z "$verbose_only" && return
>         exec 4>/dev/null 3>/dev/null
> @@ -470,6 +572,13 @@ test_skip () {
>                 fi
>                 skipped_reason="missing $missing_prereq${of_prereq}"
>         fi
> +       if test -z "$to_skip" && test -n "$run_list" &&
> +               ! match_test_selector_list '--run' $test_count "$run_list"
> +       then
> +               to_skip=t
> +               skipped_reason="--run"
> +       fi
> +
>         case "$to_skip" in
>         t)
>                 say_color skip >&3 "skipping test: $@"
> --
> 1.7.9
>
