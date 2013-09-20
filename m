From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/2] perf-lib: add test_perf_cleanup target
Date: Sat, 21 Sep 2013 00:14:26 +0200
Message-ID: <87d2o3gmyl.fsf@gmail.com>
References: <1379419842-32627-1-git-send-email-t.gummerer@gmail.com> <1379419842-32627-2-git-send-email-t.gummerer@gmail.com> <xmqq7gefz6m0.fsf@gitster.dls.corp.google.com> <87fvt1ghr4.fsf@gmail.com> <xmqqk3icu3u8.fsf@gitster.dls.corp.google.com> <xmqqtxhgsi5p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, trast@inf.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 21 00:14:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN8yE-0006pG-9C
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 00:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab3ITWOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 18:14:34 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:41805 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab3ITWOd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 18:14:33 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so888404pbc.36
        for <git@vger.kernel.org>; Fri, 20 Sep 2013 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=luGNgDOtMUy2lBBDigMWGZVss8Da7LUExF59723ZMWQ=;
        b=qjJdON2oDqKHJAhhhq7P+ejpYHaM46IrzZYPYmcmlzhy8jrDP57zt1CDW4sgSeF0OY
         tQTV9eaf4tCtzwtvoPaZ9uEtTen4nqDJ8TU1VEc7z9lrtPz8DA/r5Ucokt/5pwJhPfQN
         MYm6Tt2fYKAZlCkQS8vGFp0tq4Ak5LkWZpmMHU+Vo04pBDpUZaeoQ0sl8OhyEaO2OsVx
         IelR295+xyMGOFW2zCOU8f9jtf7MF5/5YNAAARRihevN7zAKsahvPpD7IV0gQkfausT9
         kWhV0uq3fRT2nKi30r5wiyK3B46aX5R6WEs4CcrJ7W8c5EIRs6eDym98hYyAkdzmycai
         gsXQ==
X-Received: by 10.68.181.68 with SMTP id du4mr10444704pbc.18.1379715271883;
        Fri, 20 Sep 2013 15:14:31 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPSA id sy10sm21347469pac.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 15:14:31 -0700 (PDT)
In-Reply-To: <xmqqtxhgsi5p.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235084>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>>
>>> When one performance test fails, the testing is aborted and the cleanup
>>> commands are not executed anymore, leaving the trash directory in the
>>> failed state.
>>
>> Ah, that I overlooked. In that case, the comments in my previous
>> message do not apply.
>
> Having said that, it was unclear to me why we would want a new
> test_perf_cleanup added.
>
> The name is misleading (does it define only clean-up actions?) to
> say the least, and one way of fixing it would be to call it
> test_perf_with_cleanup.

It defines any actions you want to happen after each round of tests that
should not be timed.  Usually that would mean any action that resets a
modified repository to its original state.  I'm not really sure about
the name, but test_perf_with_cleanup seems good to me.

> I wondered why this clean-up section cannot be an optional parameter
> to test_perf, but that would not fly well because we won't know if
> 3-arg form is with one prerequisite and no clean-up, or no prereq
> with a clean-up, so perhaps adding a new function may be the best
> you could do.

Yeah, that was my first thought too, but as you explained that's not
possible.  Just thinking out loud, we could drop the prerequisite check
for performance tests, as no performance tests currently use it.  Future
performance tests may use it though and it would be inconsistent with
the rest of the test-suite.

> But in the longer term, I think we would be better off to allow two
> styles (one traditional, another modern) and add new features only
> to the "modern" (aka "more easily extensible") form:
>
> 	test_perf [PREREQ] BODY
> 	test_perf [--prereq PREREQ] [--cleanup CLEANUP] ... BODY
>
> perhaps like this (this is without --cleanup but it should be
> obvious how to add a support for it to the command line parser).

I think this makes most sense.  The cleanup part would only be needed
for the perf tests, but the flexibility of this wouldn't hurt.  The
cleanup would then look something like this:

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index b2a277b..4dfdd28 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -176,6 +176,21 @@ test_perf () {
                                test_failure_ "$@"
                                break
                        fi
+                       if ! test -z "$cleanup_action"; then
+                               say >&3 "cleaning up: $cleanup_action"
+                               if test_run_ "$cleanup_action"
+                               then
+                                       if test -z "$verbose"; then
+                                               echo -n " c$i"
+                                       else
+                                               echo "* cleaning up run $i/$GIT_PERF_REPEAT_COUNT:"
+                                       fi
+                               else
+                                       test -z $verbose && echo
+                                       test_failure_ "$@"
+                                       break
+                               fi
+                       fi
                done
                if test -z "$verbose"; then
                        echo " ok"
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 473b21d..4bad14f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -360,6 +360,12 @@ test_expect_parse () {
                        test_prereq=$2
                        shift
                        ;;
+               --cleanup)
+                       test $# -gt 1 ||
+                       error "bug in the test script: --cleanup needs a parameter"
+                       cleanup_action=$2
+                       shift
+                       ;;
                --)
                        shift
                        break

I'll try to send an updated patch series, probably over the weekend with
this suggestions included (It's time to go to bed now).

> The patch to t0008 is primarily to adjust for test labels that begin
> with double-dashes that will be mistaken as a new-style option, but
> it is unnecessarily big because it uses random custom shell functions
> to hide the real calls to underlying test_expect_success X-<.
>
>
>  t/test-lib-functions.sh | 72 ++++++++++++++++++++++++++++++++++++++-----------
>  t/perf/perf-lib.sh      | 17 +++++-------
>  t/t0008-ignores.sh      | 43 +++++++++++++++--------------
>  3 files changed, 87 insertions(+), 45 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index a7e9aac..10202dc 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -342,20 +342,65 @@ test_declared_prereq () {
>  	return 1
>  }
>
> +test_expect_parse () {
> +	whoami=$1
> +	shift
> +	test_expect_new_style=
> +	while case $# in 0) false ;; esac
> +	do
> +		case "$1" in
> +		--prereq)
> +			test $# -gt 1 ||
> +			error "bug in the test script: --prereq needs a parameter"
> +			test_prereq=$2
> +			shift
> +			;;
> +		--)
> +			shift
> +			break
> +			;;
> +		--*)
> +			error "bug in the test script: unknown option '$1'"
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		test_expect_new_style=yes
> +		shift
> +	done
> +
> +	# Traditional "test_expect_what [PREREQ] BODY"
> +	if test -z "$test_expect_new_style"
> +	then
> +		test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
> +	fi
> +
> +	if test $# != 2
> +	then
> +		if test -z "$test_expect_new_style"
> +		then
> +			error "bug in the test script: not 2 or 3 parameters to $whoami"
> +		else
> +			error "bug in the test script: not 2 parameters to $whoami"
> +		fi
> +	fi
> +	test_label=$1 test_body=$2
> +
> +	export test_prereq
> +}
> +
>  test_expect_failure () {
>  	test_start_
> -	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
> -	test "$#" = 2 ||
> -	error "bug in the test script: not 2 or 3 parameters to test-expect-failure"
> -	export test_prereq
> +	test_expect_parse test_expect_failure "$@"
>  	if ! test_skip "$@"
>  	then
> -		say >&3 "checking known breakage: $2"
> -		if test_run_ "$2" expecting_failure
> +		say >&3 "checking known breakage: $test_body"
> +		if test_run_ "$test_body" expecting_failure
>  		then
> -			test_known_broken_ok_ "$1"
> +			test_known_broken_ok_ "$test_label"
>  		else
> -			test_known_broken_failure_ "$1"
> +			test_known_broken_failure_ "$test_label"
>  		fi
>  	fi
>  	test_finish_
> @@ -363,16 +408,13 @@ test_expect_failure () {
>
>  test_expect_success () {
>  	test_start_
> -	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
> -	test "$#" = 2 ||
> -	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
> -	export test_prereq
> +	test_expect_parse test_expect_success "$@"
>  	if ! test_skip "$@"
>  	then
> -		say >&3 "expecting success: $2"
> -		if test_run_ "$2"
> +		say >&3 "expecting success: $test_body"
> +		if test_run_ "$test_body"
>  		then
> -			test_ok_ "$1"
> +			test_ok_ "$test_label"
>  		else
>  			test_failure_ "$@"
>  		fi
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index f4eecaa..6477d38 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -151,23 +151,20 @@ exit $ret' >&3 2>&4
>
>  test_perf () {
>  	test_start_
> -	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
> -	test "$#" = 2 ||
> -	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
> -	export test_prereq
> +	test_expect_parse test_perf "$@"
>  	if ! test_skip "$@"
>  	then
>  		base=$(basename "$0" .sh)
>  		echo "$test_count" >>"$perf_results_dir"/$base.subtests
> -		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
> +		echo "$test_label" >"$perf_results_dir"/$base.$test_count.descr
>  		if test -z "$verbose"; then
> -			printf "%s" "perf $test_count - $1:"
> +			printf "%s" "perf $test_count - $test_label:"
>  		else
> -			echo "perf $test_count - $1:"
> +			echo "perf $test_count - $test_label:"
>  		fi
>  		for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
> -			say >&3 "running: $2"
> -			if test_run_perf_ "$2"
> +			say >&3 "running: $test_body"
> +			if test_run_perf_ "$test_body"
>  			then
>  				if test -z "$verbose"; then
>  					printf " %s" "$i"
> @@ -183,7 +180,7 @@ test_perf () {
>  		if test -z "$verbose"; then
>  			echo " ok"
>  		else
> -			test_ok_ "$1"
> +			test_ok_ "$test_label"
>  		fi
>  		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
>  		"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
>
>
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 96f40fe..795de61 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -106,7 +106,7 @@ test_expect_success_multi () {
>  	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
>  	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
>
> -	test_expect_success $prereq "$testname" '
> +	test_expect_success ${prereq:+--prereq $prereq} -- "$testname" '
>  		expect "$expect" &&
>  		eval "$code"
>  	'
> @@ -116,10 +116,11 @@ test_expect_success_multi () {
>  	then
>  		for quiet_opt in '-q' '--quiet'
>  		do
> -			test_expect_success $prereq "$testname${quiet_opt:+ with $quiet_opt}" "
> -			expect '' &&
> -			$code
> -		"
> +			test_expect_success ${prereq:+--prereq $prereq} -- \
> +				"$testname${quiet_opt:+ with $quiet_opt}" '
> +				expect "" &&
> +				eval "$code"
> +			'
>  		done
>  		quiet_opt=
>  	fi
> @@ -140,7 +141,9 @@ test_expect_success_multi () {
>  				$code
>  			"
>  			opts="$verbose_opt$non_matching_opt"
> -			test_expect_success $prereq "$testname${opts:+ with $opts}" "$test_code"
> +
> +			test_expect_success ${prereq:+--prereq $prereq} -- \
> +				"$testname${opts:+ with $opts}" "$test_code"
>  		done
>  	done
>  	verbose_opt=
> @@ -225,7 +228,7 @@ test_expect_success '-q with multiple args' '
>  	stderr_contains "fatal: --quiet is only valid with a single pathname"
>  '
>
> -test_expect_success '--quiet with multiple args' '
> +test_expect_success -- '--quiet with multiple args' '
>  	expect "" &&
>  	test_check_ignore "--quiet one two" 128 &&
>  	stderr_contains "fatal: --quiet is only valid with a single pathname"
> @@ -235,7 +238,7 @@ for verbose_opt in '-v' '--verbose'
>  do
>  	for quiet_opt in '-q' '--quiet'
>  	do
> -		test_expect_success "$quiet_opt $verbose_opt" "
> +		test_expect_success -- "$quiet_opt $verbose_opt" "
>  			expect '' &&
>  			test_check_ignore '$quiet_opt $verbose_opt foo' 128 &&
>  			stderr_contains 'fatal: cannot have both --quiet and --verbose'
> @@ -243,7 +246,7 @@ do
>  	done
>  done
>
> -test_expect_success '--quiet with multiple args' '
> +test_expect_success -- '--quiet with multiple args' '
>  	expect "" &&
>  	test_check_ignore "--quiet one two" 128 &&
>  	stderr_contains "fatal: --quiet is only valid with a single pathname"
> @@ -559,34 +562,34 @@ sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
>  sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
>  	tr ":\t\n" "\0" >expected-verbose0
>
> -test_expect_success '--stdin' '
> +test_expect_success -- '--stdin' '
>  	expect_from_stdin <expected-default &&
>  	test_check_ignore "--stdin" <stdin
>  '
>
> -test_expect_success '--stdin -q' '
> +test_expect_success -- '--stdin -q' '
>  	expect "" &&
>  	test_check_ignore "-q --stdin" <stdin
>  '
>
> -test_expect_success '--stdin -v' '
> +test_expect_success -- '--stdin -v' '
>  	expect_from_stdin <expected-verbose &&
>  	test_check_ignore "-v --stdin" <stdin
>  '
>
>  for opts in '--stdin -z' '-z --stdin'
>  do
> -	test_expect_success "$opts" "
> +	test_expect_success -- "$opts" "
>  		expect_from_stdin <expected-default0 &&
>  		test_check_ignore '$opts' <stdin0
>  	"
>
> -	test_expect_success "$opts -q" "
> +	test_expect_success -- "$opts -q" "
>  		expect "" &&
>  		test_check_ignore '-q $opts' <stdin0
>  	"
>
> -	test_expect_success "$opts -v" "
> +	test_expect_success -- "$opts -v" "
>  		expect_from_stdin <expected-verbose0 &&
>  		test_check_ignore '-v $opts' <stdin0
>  	"
> @@ -645,7 +648,7 @@ sed -e 's/^"//' -e 's/\\//' -e 's/"$//' expected-default | \
>  sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' expected-verbose | \
>  	tr ":\t\n" "\0" >expected-verbose0
>
> -test_expect_success '--stdin from subdirectory' '
> +test_expect_success -- '--stdin from subdirectory' '
>  	expect_from_stdin <expected-default &&
>  	(
>  		cd a &&
> @@ -653,7 +656,7 @@ test_expect_success '--stdin from subdirectory' '
>  	)
>  '
>
> -test_expect_success '--stdin from subdirectory with -v' '
> +test_expect_success -- '--stdin from subdirectory with -v' '
>  	expect_from_stdin <expected-verbose &&
>  	(
>  		cd a &&
> @@ -661,7 +664,7 @@ test_expect_success '--stdin from subdirectory with -v' '
>  	)
>  '
>
> -test_expect_success '--stdin from subdirectory with -v -n' '
> +test_expect_success -- '--stdin from subdirectory with -v -n' '
>  	expect_from_stdin <expected-all &&
>  	(
>  		cd a &&
> @@ -671,7 +674,7 @@ test_expect_success '--stdin from subdirectory with -v -n' '
>
>  for opts in '--stdin -z' '-z --stdin'
>  do
> -	test_expect_success "$opts from subdirectory" '
> +	test_expect_success -- "$opts from subdirectory" '
>  		expect_from_stdin <expected-default0 &&
>  		(
>  			cd a &&
> @@ -679,7 +682,7 @@ do
>  		)
>  	'
>
> -	test_expect_success "$opts from subdirectory with -v" '
> +	test_expect_success -- "$opts from subdirectory with -v" '
>  		expect_from_stdin <expected-verbose0 &&
>  		(
>  			cd a &&
