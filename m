Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370E1A731
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="icQzCxsk"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD0269A
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 03:41:39 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AC6D530137;
	Thu,  9 Nov 2023 06:41:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N41m0SvCNTR+5RDOKP143oEpYoH+uk/oFGugMV
	CW+7o=; b=icQzCxskgKgrnXUOJbUZr3qrC0JUhppE9DzwO09hrz2mnv5yRIW3yQ
	XgmJmHX5X7TlCNrmEdT2lEp5rPG/4TlUpW0xpA/PJ0EWLqGebS8bUGEq+4bMEMJo
	x+elSKNWSMi5zXb2aLoiu1NGe9vadYqc89LHqo+CDYSVrSas4A33w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A45AA30136;
	Thu,  9 Nov 2023 06:41:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 321543012D;
	Thu,  9 Nov 2023 06:41:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] global: convert trivial usages of `test <expr>
 -a/-o <expr>`
In-Reply-To: <c5e627eb3fef0df162da56723093a03bfd2321fb.1699526999.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 9 Nov 2023 11:53:31 +0100")
References: <cover.1699526999.git.ps@pks.im>
	<c5e627eb3fef0df162da56723093a03bfd2321fb.1699526999.git.ps@pks.im>
Date: Thu, 09 Nov 2023 20:41:33 +0900
Message-ID: <xmqqpm0jyx02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EF9CF2AE-7EF4-11EE-852D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index e54492f8271..e4d31cbbd6a 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -11,7 +11,7 @@ LF='
>  if test -f version
>  then
>  	VN=$(cat version) || VN="$DEF_VER"
> -elif test -d ${GIT_DIR:-.git} -o -f .git &&
> +elif ( test -d ${GIT_DIR:-.git} || test -f .git ) &&

I do not think this is strictly necessary.

Because the command line parser of "test" comes from left, notices
"-d" and takes the next one to check if it is a directory.  There is
no value in ${GIT_DIR} can make "test -d ${GIT_DIR} -o ..." fail the
same way as the problem Peff pointed out during the discussion.

I do not need a subshell for grouping, either.  Plain {} should do
(but you may need a LF or semicolon after the statement)..

> diff --git a/configure.ac b/configure.ac
> index 276593cd9dd..d1a96da14eb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -94,7 +94,7 @@ AC_DEFUN([GIT_PARSE_WITH_SET_MAKE_VAR],
>  [AC_ARG_WITH([$1],
>   [AS_HELP_STRING([--with-$1=VALUE], $3)],
>   if test -n "$withval"; then
> -  if test "$withval" = "yes" -o "$withval" = "no"; then
> +  if test "$withval" = "yes" || test "$withval" = "no"; then

This is correct and is in line with the way generated ./configure
protects "if $withval is yes or no, then do this" against a funny
value like "-f" in "$withval" breaking the parsing.

> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index e0c5d3b0de6..43b5fec7320 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -489,13 +489,13 @@ find_existing_splits () {
>  			;;
>  		END)
>  			debug "Main is: '$main'"
> -			if test -z "$main" -a -n "$sub"
> +			if test -z "$main" && test -n "$sub"

This should be OK as-is, for the same reason "-d" operator would not
be broken by arbitrary operand..

>  			then
>  				# squash commits refer to a subtree
>  				debug "  Squash: $sq from $sub"
>  				cache_set "$sq" "$sub"
>  			fi
> -			if test -n "$main" -a -n "$sub"
> +			if test -n "$main" && test -n "$sub"

Ditto.

>  			then
>  				debug "  Prior: $main -> $sub"
>  				cache_set $main $sub
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index e7786775a90..b952e5024b4 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -31,7 +31,7 @@ unset GIT_CONFIG_NOSYSTEM
>  GIT_CONFIG_SYSTEM="$TEST_DIRECTORY/perf/config"
>  export GIT_CONFIG_SYSTEM
>  
> -if test -n "$GIT_TEST_INSTALLED" -a -z "$PERF_SET_GIT_TEST_INSTALLED"
> +if test -n "$GIT_TEST_INSTALLED" && test -z "$PERF_SET_GIT_TEST_INSTALLED"

Ditto.

>  then
>  	error "Do not use GIT_TEST_INSTALLED with the perf tests.
>  
> diff --git a/t/perf/run b/t/perf/run
> index 34115edec35..486ead21980 100755
> --- a/t/perf/run
> +++ b/t/perf/run
> @@ -91,10 +91,10 @@ set_git_test_installed () {
>  run_dirs_helper () {
>  	mydir=${1%/}
>  	shift
> -	while test $# -gt 0 -a "$1" != -- -a ! -f "$1"; do
> +	while test $# -gt 0 && test "$1" != -- && test ! -f "$1"; do

As "$1" could be anything (including an insanity like "-n"), this
change is prudent.

>  		shift
>  	done
> -	if test $# -gt 0 -a "$1" = --; then
> +	if test $# -gt 0 && test "$1" = --; then

Ditto.

>  		shift
>  	fi
>  
> @@ -124,7 +124,7 @@ run_dirs_helper () {
>  }
>  
>  run_dirs () {
> -	while test $# -gt 0 -a "$1" != -- -a ! -f "$1"; do
> +	while test $# -gt 0 && test "$1" != -- && test ! -f "$1"; do
>  		run_dirs_helper "$@"
>  		shift
>  	done
> @@ -180,7 +180,8 @@ run_subsection () {
>  	GIT_PERF_AGGREGATING_LATER=t
>  	export GIT_PERF_AGGREGATING_LATER
>  
> -	if test $# = 0 -o "$1" = -- -o -f "$1"; then
> +	if test $# = 0 || test "$1" = -- || test -f "$1"
> +	then

Ditto.

>  		set -- . "$@"
>  	fi
>  
> diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
> index 669ebaf68be..9fbf90cee7c 100755
> --- a/t/valgrind/valgrind.sh
> +++ b/t/valgrind/valgrind.sh
> @@ -23,7 +23,7 @@ memcheck)
>  	VALGRIND_MAJOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
>  	VALGRIND_MINOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*[0-9]*\.\([0-9]*\)')
>  	test 3 -gt "$VALGRIND_MAJOR" ||
> -	test 3 -eq "$VALGRIND_MAJOR" -a 4 -gt "$VALGRIND_MINOR" ||
> +	( test 3 -eq "$VALGRIND_MAJOR" && test 4 -gt "$VALGRIND_MINOR" ) ||

This should be OK as-is; once "3 --eq" is parsed the parameter
reference would not be taken as anything but just a value.

>  	TOOL_OPTIONS="$TOOL_OPTIONS --track-origins=yes"
>  	;;
>  *)
