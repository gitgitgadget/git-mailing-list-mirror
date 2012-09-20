From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/6] Refactor mechanics of testing in a sub test-lib
Date: Thu, 20 Sep 2012 14:13:28 -0700
Message-ID: <7vhaqs9z47.fsf@alter.siamese.dyndns.org>
References: <20120919184406.GC19246@atlantic.linksys.moosehall>
 <1348080591-16430-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:13:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEo44-0007aB-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 23:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab2ITVNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 17:13:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab2ITVNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 17:13:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FD1B85DC;
	Thu, 20 Sep 2012 17:13:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=1eFwT08fEqxcm+codNk0c4BTqbw=; b=e7duSsRlmXuN5XyPPKTb
	xqa344ffkmHYXCsvdJLEd4JW88OeixNgYXzTEw9mhQYookwXWgFyyu3WnYXtZO39
	i5nl6fDGWAtbMyPC9mJYhtvIr4BvSQFZSg+LBOysf1ZZUHFOOU2wBcXFvmtwAY3l
	lD4fmAFaWcjZt6TJFiJO67I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=R50o8B72sAPG3Dx+200Dn3j+xEiVyfuKwlgmP546nBjI4A
	uS0pveZMxojzJLuvbOkmx4ac2epxyHnhBrwm5Y83j1E+LijNj6FcPKWu373mzTYF
	471+TtnjkR+HMh+fgczT8A2IVjs2eqYO+ryqgl/nIYMxXyzkmbeLQhxIcCZSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D6CF85DB;
	Thu, 20 Sep 2012 17:13:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D74D85DA; Thu, 20 Sep 2012
 17:13:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 068C4740-0368-11E2-86D6-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206092>

Adam Spiers <git@adamspiers.org> writes:

> This will allow us to test the test framework more thoroughly
> without disrupting the top-level test metrics.
>
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  t/t0000-basic.sh | 67 ++++++++++++++++++++++++--------------------------------
>  1 file changed, 29 insertions(+), 38 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index c6b42de..029e3bd 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -55,39 +55,49 @@ test_expect_failure 'pretend we have a known breakage' '
>  	false
>  '
>  
> -test_expect_success 'pretend we have fixed a known breakage (run in sub test-lib)' "
> -	mkdir passing-todo &&
> -	(cd passing-todo &&
> -	cat >passing-todo.sh <<-EOF &&
> +run_sub_test_lib_test () {
> +	name="$1" descr="$2" # stdin is body of test code
> +	mkdir $name &&
> +	(cd $name &&
> +	cat >$name.sh <<-EOF &&
>  	#!$SHELL_PATH
>  
> -	test_description='A passing TODO test
> +	test_description='$descr (run in sub test-lib)
>  
>  	This is run in a sub test-lib so that we do not get incorrect
>  	passing metrics
>  	'
>  
>  	# Point to the t/test-lib.sh, which isn't in ../ as usual
> -	TEST_DIRECTORY=\"$TEST_DIRECTORY\"
> -	. \"\$TEST_DIRECTORY\"/test-lib.sh
> -
> -	test_expect_failure 'pretend we have fixed a known breakage' '
> -		:
> -	'
> +	TEST_DIRECTORY="$TEST_DIRECTORY"
> +	. "\$TEST_DIRECTORY"/test-lib.sh
> +	EOF

The quoting of $TEST_DIRECTORY in the assignment does not look
correct (imagine a path with a double quote in it).

Removing the assignment and instead exporting TEST_DIRECTORY before
calling name.sh may be a reasonable fix, than trying to quotemeta
the value of $TEST_DIRECTORY here.

I'll re-queue this series in 'pu' with fixes and retitles; please
eyeball them before submitting a reroll.

  b465316 tests: paint unexpectedly fixed known breakages in bold red
  7214717 tests: test the test framework more thoroughly
  03c772a [SQUASH] t/t0000-basic.sh: quoting of TEST_DIRECTORY is screwed up
  99fe0af tests: refactor mechanics of testing in a sub test-lib
  6af90bf tests: paint skipped tests in bold blue
  0b87581 tests: test number comes first in 'not ok $count - $message'
  1c55079 tests: paint known breakages in bold yellow

The third one from the tip looks like the following, to re-indent to
make it readable and then minimally fix the quoting.

Thanks.

 t/t0000-basic.sh | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ee78e68..c3345a9 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -56,33 +56,37 @@ test_expect_failure 'pretend we have a known breakage' '
 '
 
 run_sub_test_lib_test () {
-	name="$1" descr="$2" # stdin is body of test code
+	name="$1" descr="$2" # stdin is the body of the test code
 	mkdir $name &&
-	(cd $name &&
-	cat >$name.sh <<-EOF &&
-	#!$SHELL_PATH
-
-	test_description='$descr (run in sub test-lib)
-
-	This is run in a sub test-lib so that we do not get incorrect
-	passing metrics
-	'
-
-	# Point to the t/test-lib.sh, which isn't in ../ as usual
-	TEST_DIRECTORY="$TEST_DIRECTORY"
-	. "\$TEST_DIRECTORY"/test-lib.sh
-	EOF
-	cat >>$name.sh &&
-	chmod +x $name.sh &&
-	./$name.sh >out 2>err)
+	(
+		cd $name &&
+		cat >$name.sh <<-EOF &&
+		#!$SHELL_PATH
+
+		test_description='$descr (run in sub test-lib)
+
+		This is run in a sub test-lib so that we do not get incorrect
+		passing metrics
+		'
+
+		# Point to the t/test-lib.sh, which isn't in ../ as usual
+		. "\$TEST_DIRECTORY"/test-lib.sh
+		EOF
+		cat >>$name.sh &&
+		chmod +x $name.sh &&
+		export TEST_DIRECTORY &&
+		./$name.sh >out 2>err
+	)
 }
 
 check_sub_test_lib_test () {
-	name="$1" # stdin is expected output from the test
-	(cd $name &&
-	! test -s err &&
-	sed -e 's/^> //' -e 's/Z$//' >expect &&
-	test_cmp expect out)
+	name="$1" # stdin is the expected output from the test
+	(
+		cd $name &&
+		! test -s err &&
+		sed -e 's/^> //' -e 's/Z$//' >expect &&
+		test_cmp expect out
+	)
 }
 
 test_expect_success 'pretend we have fixed a known breakage' "
-- 
1.7.12.1.389.g3dff30b
