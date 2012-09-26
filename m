From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
 test suite for detecting heap corruption
Date: Wed, 26 Sep 2012 22:16:39 +0200
Message-ID: <506362A7.5090108@lsrfire.ath.cx>
References: <1347641662-3596-1-git-send-email-gitter.spiros@gmail.com> <7v392k5w7u.fsf@alter.siamese.dyndns.org> <7vligc19d1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 22:17:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGy2o-00020R-KF
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 22:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab2IZURI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 16:17:08 -0400
Received: from india601.server4you.de ([85.25.151.105]:43424 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab2IZURH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 16:17:07 -0400
Received: from [192.168.2.105] (p579BE364.dip.t-dialin.net [87.155.227.100])
	by india601.server4you.de (Postfix) with ESMTPSA id A5039138;
	Wed, 26 Sep 2012 22:17:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vligc19d1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206442>

Sorry for being late.  Just wanted to try out this new feature and
ended up reading this old thread.

Am 15.09.2012 01:18, schrieb Junio C Hamano:
>   t/perf/perf-lib.sh |  1 +
>   t/test-lib.sh      | 26 ++++++++++++++++++++------
>   2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git i/t/perf/perf-lib.sh w/t/perf/perf-lib.sh
> index a1361e5..1d0bb9d 100644
> --- i/t/perf/perf-lib.sh
> +++ w/t/perf/perf-lib.sh
> @@ -42,6 +42,7 @@ else
>  fi
>   
>  TEST_NO_CREATE_REPO=t
> +TEST_NO_MALLOC_=t

Why the trailing underscore?  Perhaps add "CHECK" before the equal sign?

>   . ../test-lib.sh
>   
> diff --git i/t/test-lib.sh w/t/test-lib.sh
> index b0c0c84..aad4606 100644
> --- i/t/test-lib.sh
> +++ w/t/test-lib.sh
> @@ -95,12 +95,24 @@ export EDITOR
>  
>  # Add libc MALLOC and MALLOC_PERTURB test
>  # only if we are not executing the test with valgrind
> -expr "$GIT_TEST_OPTS" : ".*\(--valgrind\)" >/dev/null || {
> -	MALLOC_CHECK_=3
> -	export MALLOC_CHECK_
> -	MALLOC_PERTURB_="$( expr \( $$ % 255 \) + 1)"
> -	export MALLOC_PERTURB_
> -}
> +if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
> +   test -n "TEST_NO_MALLOC_"

Without a $, you'll get nothing. ;-)

('test -n "string"' is always true, unlike 'test -n "$variable"'.)

> +then
> +	setup_malloc_check () {
> +		: nothing
> +	}
> +	teardown_malloc_check () {
> +		: nothing
> +	}
> +else
> +	setup_malloc_check () {
> +		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
> +		export MALLOC_CHECK_ MALLOC_PERTURB_
> +	}
> +	teardown_malloc_check () {
> +		unset MALLOC_CHECK_ MALLOC_PERTURB_
> +	}

Would it make sense to restore the previous values?  Hrm, can't think of a use case.

> +fi
>   
>  # Protect ourselves from common misconfiguration to export
>  # CDPATH into the environment
> @@ -311,7 +323,9 @@ test_run_ () {
>  
>  	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
>  	then
> +		setup_malloc_check
>  		test_eval_ "$test_cleanup"
> +		teardown_malloc_check
>  	fi
>  	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"
>  	then

-- >8 --
Subject: [PATCH] MALLOC_CHECK: enable it, unless disabled explicitly

The malloc checks in tests are currently disabled.  Actually evaluate
the variable for turning them off and enable them if it's unset.

Also use this opportunity to give it the more descriptive and
consistent name TEST_NO_MALLOC_CHECK.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/perf/perf-lib.sh | 2 +-
 t/test-lib.sh      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 1d0bb9d..a816fbc 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -42,7 +42,7 @@ else
 fi
 
 TEST_NO_CREATE_REPO=t
-TEST_NO_MALLOC_=t
+TEST_NO_MALLOC_CHECK=t
 
 . ../test-lib.sh
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bff3d75..617d831 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -105,7 +105,7 @@ export EDITOR
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
-   test -n "TEST_NO_MALLOC_"
+   test -n "$TEST_NO_MALLOC_CHECK"
 then
 	setup_malloc_check () {
 		: nothing
-- 
1.7.12
