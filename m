From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Thu, 27 Mar 2014 23:36:31 -0400
Message-ID: <CAPig+cQeS6PAZN0nN_0LBfnFF_bGxC000cPSQFdSTVaHQD_haw@mail.gmail.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
	<1395916370-1404-1-git-send-email-ilya.bobyr@gmail.com>
	<1395916370-1404-4-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 04:36:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTNaw-00054O-5a
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 04:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757281AbaC1Dge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 23:36:34 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:51348 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251AbaC1Dgc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 23:36:32 -0400
Received: by mail-yk0-f179.google.com with SMTP id 9so291551ykp.24
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 20:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=L3hz7pkqDjFVyjN8nyjLuw/KcT2Hj5Aas+gbnG5hLPw=;
        b=MtnqiFul3Sbky9J+6ntXJLRdOcsF38dKYmN8wCq942JeWu7apS0FkVnPNpeOTWbgrE
         Pkn/hDMJL1n2hx//bpgMPgEJCNT+FwyF7C5dB2geZuEqKIuVNxNqNiCGk5CefddDa6VY
         XIqqrYg3yUm8/1pl5qT4TzOD8P48EX3wCpso/P5GgTAQcxyU0yEpJ+uJHif2O1B0regR
         N6tDWY4/8ur8SPKWfvyGtqEeVh3fW4J/O7I2KFMuuDXa1zvuKclMcZ4fEaG1ETvKsNNT
         Gmj8vmHHv52UT5TEGIh84qOsAyLCGssxApQ4vtRmaGNuPj/Lwn0GFc8yVgqfdpZ1sCEP
         SXAw==
X-Received: by 10.236.139.70 with SMTP id b46mr7903471yhj.63.1395977791668;
 Thu, 27 Mar 2014 20:36:31 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 27 Mar 2014 20:36:31 -0700 (PDT)
In-Reply-To: <1395916370-1404-4-git-send-email-ilya.bobyr@gmail.com>
X-Google-Sender-Auth: BQfldlFu_L_THIiy_dJMLQn33wY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245356>

On Thu, Mar 27, 2014 at 6:32 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
> Allow better control of the set of tests that will be executed for a
> single test suite.  Mostly useful while debugging or developing as it
> allows to focus on a specific test.
>
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
> ---
>  No changes from the previous version.
>
>  t/README         |   65 ++++++++++++++-
>  t/t0000-basic.sh |  233 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  t/test-lib.sh    |   85 ++++++++++++++++++++
>  3 files changed, 379 insertions(+), 4 deletions(-)
>
> diff --git a/t/README b/t/README
> index 6b93aca..c911f89 100644
> --- a/t/README
> +++ b/t/README
> @@ -100,6 +100,10 @@ appropriately before running "make".
>         This causes additional long-running tests to be run (where
>         available), for more exhaustive testing.
>
> +-r,--run=<test numbers>::

Perhaps <test-selection> or something similar would be closer to the truth.

> +       This causes only specific tests to be included or excluded.  See

This is phrased somewhat oddly, as if you had already been talking
about tests being included or excluded, and that this option merely
changes that selection. Perhaps something like:

    Run only the subset of tests indicated by <test-selection>.

> +       section "Skipping Tests" below for "<test numbers>" syntax.
> +
>  --valgrind=<tool>::
>         Execute all Git binaries under valgrind tool <tool> and exit
>         with status 126 on errors (just like regular tests, this will
> @@ -187,10 +191,63 @@ and either can match the "t[0-9]{4}" part to skip the whole
>  test, or t[0-9]{4} followed by ".$number" to say which
>  particular test to skip.
>
> -Note that some tests in the existing test suite rely on previous
> -test item, so you cannot arbitrarily disable one and expect the
> -remainder of test to check what the test originally was intended
> -to check.
> +For an individual test suite --run could be used to specify that
> +only some tests should be run or that some tests should be
> +excluded from a run.
> +
> +--run argument is a list of patterns with optional prefixes that

"The argument for --run is a list...

> +are matched against test numbers within the current test suite.
> +Supported pattern:
> +
> + - A number matches a test with that number.
> +
> + - sh metacharacters such as '*', '?' and '[]' match as usual in
> +   shell.
> +
> + - A number prefixed with '<', '<=', '>', or '>=' matches all
> +   tests 'before', 'before or including', 'after', or 'after or
> +   including' the specified one.

I think you want "and" rather than "or": "before and including",
"after and including".

> +Optional prefixes are:
> +
> + - '+' or no prefix: test(s) matching the pattern are included in
> +   the run.
> +
> + - '-' or '!': test(s) matching the pattern are exluded from the
> +   run.

I've been playing with --run, and I find that test selection is not
especially intuitive. For instance, ">=16 !>24 !20" is easier to
reason about when written instead with ranges, such as "16-19 21-24",
or perhaps "16-24 !20". Open-ended ranges make sense too: "5-" means
tests 5 through the last, and "-5" means tests 1 through 5. (Yes, this
conflicts with your use of '-' to mean negation, but you already have
the perfectly serviceable '!' as an alias for negation.)

> +If --run starts with '+' or unprefixed pattern the initial set of
> +tests to run is empty. If the first pattern starts with '-' or
> +'!' all the tests are added to the initial set.  After initial
> +set is determined every pattern, test number or range is added or
> +excluded from the set one by one, from left to right.
> +
> +For example, common case is to run several setup tests and then a
> +specific test that relies on that setup:

Perhaps be a bit more specific:

    ...run several setup tests (1, 2, 3) and then a
    specific test (21) that relies...

> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1 2 3 21'
> +
> +or:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run='<4 21'

It might be clearer to say "<=3" rather than "<4".

> +To run only tests up to a specific test one could do this:

s/specific test/specific test,/

Also perhaps:

    ...up to a specific test (21), one...

> +    $ sh ./t9200-git-cvsexport-commit.sh --run='!>=21'
> +
> +As noted above test set is build going though patterns left to

s/above/above,/
s/test set/the test set/
s/build/built/

    As noted above, the test set is built...

> +right, so this:
> +
> +    $ sh ./t9200-git-cvsexport-commit.sh --run='<5 !3'
> +
> +will run tests 1, 2, and 4.
> +
> +Some tests in the existing test suite rely on previous test item,
> +so you cannot arbitrarily disable one and expect the remainder of
> +test to check what the test originally was intended to check.
> +--run is mostly useful when you want to focus on a specific test
> +and know what you are doing.  Or when you want to run up to a
> +certain test.
>
>
>  Naming Tests
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index e035f36..63e481a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -191,6 +191,14 @@ do
>                 immediate=t; shift ;;
>         -l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
>                 GIT_TEST_LONG=t; export GIT_TEST_LONG; shift ;;
> +       -r)
> +               shift; test "$#" -ne 0 || {
> +                       echo 'error: -r requires an argument' >&2;
> +                       exit 1;
> +               }
> +               run_list=$1; shift ;;
> +       --run=*)
> +               run_list=$(expr "z$1" : 'z[^=]*=\(.*\)'); shift ;;
>         -h|--h|--he|--hel|--help)
>                 help=t; shift ;;
>         -v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
> @@ -366,6 +374,76 @@ match_pattern_list () {
>         return 1
>  }
>
> +match_run_pattern_list () {
> +       arg="$1"
> +       shift
> +       test -z "$*" && return 0
> +
> +       # If the first patern is negative we include by default.

s/patern/pattern/

> +       include=
> +       case "$1" in
> +               [-!]*) include=t ;;
> +       esac
> +
> +       for pattern_
> +       do
> +               orig_pattern=$pattern_
> +
> +               positive=t
> +               case "$pattern_" in
> +                       [-!]*)
> +                               positive=
> +                               pattern_=${pattern_##?}
> +                               ;;
> +               esac
> +
> +               # Short cut for "obvious" cases
> +               [ "x$include" = "x" -a "x$positive" = "x" ] && continue

Although there are a few exceptions in this script, 'test' is
generally preferred over '['. Also, -a doesn't have great portability,
so && may be better.

    test -z "$include" && test -z "$positive" && continue

> +               [ "x$include" = "xt" -a "x$positive" = "xt" ] && continue

Since you're inside double quotes, you can drop the 'x' prefix:

    test "$include" = t && test "$positive" = t && continue

> +               pattern_op=
> +               case "$pattern_" in
> +                       \<=*)
> +                               pattern_op='-le'
> +                               pattern_=${pattern_##??}
> +                               ;;
> +                       \<*)
> +                               pattern_op='-lt'
> +                               pattern_=${pattern_##?}
> +                               ;;
> +                       \>=*)
> +                               pattern_op='-ge'
> +                               pattern_=${pattern_##??}
> +                               ;;
> +                       \>*)
> +                               pattern_op='-gt'
> +                               pattern_=${pattern_##?}
> +                               ;;
> +               esac
> +
> +               if test -n "$pattern_op"
> +               then
> +                       if expr "z$pattern_" : "z[0-9]*[^0-9]" >/dev/null

Inside double quotes: you can drop the 'z' prefix.

> +                       then
> +                               echo "error: --run: test number contains" \
> +                                       "non-digits: '$orig_pattern'" >&2
> +                               exit 1
> +                       fi
> +                       if test $arg $pattern_op $pattern_
> +                       then
> +                               include=$positive
> +                       fi
> +               else
> +                       case "$arg" in
> +                               $pattern_)
> +                                       include=$positive
> +                       esac
> +               fi
> +       done
> +
> +       test -n "$include"
> +}
> +
>  maybe_teardown_verbose () {
>         test -z "$verbose_only" && return
>         exec 4>/dev/null 3>/dev/null
> @@ -470,6 +548,13 @@ test_skip () {
>                 fi
>                 skipped_reason="missing $missing_prereq${of_prereq}"
>         fi
> +       if test -z "$to_skip" && test -n "$run_list" &&
> +               ! match_run_pattern_list $test_count $run_list
> +       then
> +               to_skip=t
> +               skipped_reason="--run"

A few pure bike-shedding comments (to be ignore if desired):

I still don't understand the need to distinguish between a test
skipped due to --run and and one skipped due to GIT_SKIP_TESTS.

The skip-reason "GIT_SKIP_TESTS" (in patch 2/3) still seems
unnecessarily verbose and loud.

The skip-reason "excluded" (suggested in an earlier review) is short
and sweet, and equally applicable to a test skipped either via --run
or GIT_SKIP_TESTS.

> +       fi
> +
>         case "$to_skip" in
>         t)
>                 say_color skip >&3 "skipping test: $@"
> --
> 1.7.9
>
