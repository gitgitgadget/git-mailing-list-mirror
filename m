From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the
 test suite for detecting heap corruption
Date: Fri, 14 Sep 2012 16:18:50 -0700
Message-ID: <7vligc19d1.fsf@alter.siamese.dyndns.org>
References: <1347641662-3596-1-git-send-email-gitter.spiros@gmail.com>
 <7v392k5w7u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 01:19:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCfAq-0000bX-4g
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 01:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760286Ab2INXSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 19:18:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59430 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754423Ab2INXSx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 19:18:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04D878958;
	Fri, 14 Sep 2012 19:18:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C0d4MBKqt1MFMbAhlm2pp8OmuTk=; b=d2bjW3
	MTGN/hqxLglEVX9ZYRF3kEIYqr+0XDCCdqAXtMHuJM6yywgg3L51kFA+Iq9CpL+Y
	U95s8eqm3CflA96t9tMwD3neI0UgPfRtE3oHpJ8q+HVFIm433wnCq4nvvYxQLRtk
	WxZNi+U2Uabz3sNhsSj9Zcva5bxYxXkk6Q6II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wfdjSN9EUZtBuggr7adYzJKuulme1BXb
	P7L8y049K2TW//UA9BMWvBxeiOzoJI1RTag4FyNl8kQRbmFtV+uP/br9D23inWPn
	e6XXc+VMtyuxoREQ2siJ+vKu1WQ30vHWRZKDAxckfjJXICb17aX/XqdR1ntjl2Rb
	+8/No/YTzbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5C1F8957;
	Fri, 14 Sep 2012 19:18:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 350F18956; Fri, 14 Sep 2012
 19:18:52 -0400 (EDT)
In-Reply-To: <7v392k5w7u.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 14 Sep 2012 10:51:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BE92782-FEC2-11E1-A4A2-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205541>

Junio C Hamano <gitster@pobox.com> writes:

> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> Recent versions of Linux libc (later than 5.4.23) and glibc (2.x)
>> include a malloc() implementation which is tunable via environment
>> variables. When MALLOC_CHECK_ is set, a special (less efficient)
>> implementation is used which is designed to be tolerant against
>> simple errors, such as double calls of free() with the same argument,
>> or overruns of a single byte (off-by-one bugs). When MALLOC_CHECK_
>> is set to 3, a diagnostic message is printed on stderr
>> and the program is aborted.
>> ...
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>> This the third reroll of the original patch.
>
> Well written.  I have one suggestion and a question, though.

After looking at it a bit more, there are a few more things I would
suggest, in the form of an squashable patch on top.

Points to note:

 - When test-lib.sh is used from perf-lib, we would not want to be
   affected with MALLOC_CHECK_; we would want to run as vanilla as
   possible in that case.

 - We are interested in checking "git" and whatever we test using
   the test harness, i.e. what comes inside test_expect_success.
   Setting MALLOC_CHECK_ at the beginning will cover a lot more than
   what we want to test.

 - That "165" thing I mentioned earlier.

 - Update the "expr" expression to make sure the --valgrind we catch
   is indeed an option, not a substring of something else.  Also
   there is no need to capture the substring.

 t/perf/perf-lib.sh |  1 +
 t/test-lib.sh      | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git i/t/perf/perf-lib.sh w/t/perf/perf-lib.sh
index a1361e5..1d0bb9d 100644
--- i/t/perf/perf-lib.sh
+++ w/t/perf/perf-lib.sh
@@ -42,6 +42,7 @@ else
 fi
 
 TEST_NO_CREATE_REPO=t
+TEST_NO_MALLOC_=t
 
 . ../test-lib.sh
 
diff --git i/t/test-lib.sh w/t/test-lib.sh
index b0c0c84..aad4606 100644
--- i/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -95,12 +95,24 @@ export EDITOR
 
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
-expr "$GIT_TEST_OPTS" : ".*\(--valgrind\)" >/dev/null || {
-	MALLOC_CHECK_=3
-	export MALLOC_CHECK_
-	MALLOC_PERTURB_="$( expr \( $$ % 255 \) + 1)"
-	export MALLOC_PERTURB_
-}
+if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
+   test -n "TEST_NO_MALLOC_"
+then
+	setup_malloc_check () {
+		: nothing
+	}
+	teardown_malloc_check () {
+		: nothing
+	}
+else
+	setup_malloc_check () {
+		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
+		export MALLOC_CHECK_ MALLOC_PERTURB_
+	}
+	teardown_malloc_check () {
+		unset MALLOC_CHECK_ MALLOC_PERTURB_
+	}
+fi
 
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
@@ -311,7 +323,9 @@ test_run_ () {
 
 	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
 	then
+		setup_malloc_check
 		test_eval_ "$test_cleanup"
+		teardown_malloc_check
 	fi
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"
 	then
