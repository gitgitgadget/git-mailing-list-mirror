From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] add function test_must_fail_or_sigpipe and use it to fix flaky tests
Date: Fri, 06 Nov 2015 10:27:02 -0800
Message-ID: <xmqqr3k32dc9.fsf@gitster.mtv.corp.google.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
	<1446800323-2914-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, sschuberth@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, avila.jn@gmail.com, luke@diamand.org,
	dturner@twopensource.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 06 19:27:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuljK-0008DQ-N6
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 19:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbbKFS1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 13:27:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751284AbbKFS1G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 13:27:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0704728465;
	Fri,  6 Nov 2015 13:27:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ewi0BcV0mS9M6UPKQWwer4v8SyE=; b=Jylt+G
	x91zlixa1BhPai0WAM/MqyjrivhseGvKlxm/yQnb1Y6c4VfarzpX9ln7tagWHYeA
	qnldwTTrsrVvBFIfSf2TAXCHhn+uCm3GUnuG+LcbPE+o3mbcIDoM7TTQxLUlaa7G
	7gbKo3he4BPbeV40seVNbf0tlK5IDJlckjt48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gjpeoD7D6fE03dwIS/30MBNq4n4nbRyo
	AXzcIoBOykCnWDWIiAFbRCdSdDQQ3PQk6tGbcsGTCeUD/8de38OOA9HF0v6hfudg
	i8wmxsTijhBkWeTLnVZ208YuDqILDu+is3Immo56bEqCuU90lqCjMKOCBeHfTjHO
	4l9J1ywp4gE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F195428463;
	Fri,  6 Nov 2015 13:27:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5253C28460;
	Fri,  6 Nov 2015 13:27:04 -0500 (EST)
In-Reply-To: <1446800323-2914-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Fri, 6 Nov 2015 09:58:40
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FAAB0616-84B3-11E5-9ABB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280993>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> t5516 "75 - deny fetch unreachable SHA1, allowtipsha1inwant=true" is
> flaky in the following case:
> 1. remote upload-pack finds out "not our ref"
> 2. remote sends a response and closes the pipe
> 3. fetch-pack still tries to write commands to the remote upload-pack
> 4. write call in wrapper.c dies with SIGPIPE
>
> t5504 "9 - push with transfer.fsckobjects" is flaky, too, and returns
> SIGPIPE once in a while. I had to remove the final "To dst..." output
> check because there is no output if the process dies with SIGPIPE.

Thanks for a clear write-up.

> This patch accepts the SIGPIPE exit as legitimate test exit.

It is not this patch that accepts such a failure as legit ;-).

"Accept such a death-with-sigpipe also as OK when we are expecting a
failure", perhaps?



> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index ec22c98..22a941b 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1162,15 +1162,15 @@ do
>  		mk_empty shallow &&
>  		(
>  			cd shallow &&
> -			test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
> -			test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
> +			test_must_fail_or_sigpipe git fetch ../testrepo/.git $SHA1_3 &&
> +			test_must_fail_or_sigpipe git fetch ../testrepo/.git $SHA1_1 &&
>  			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&

These I understand.

>  			git fetch ../testrepo/.git $SHA1_1 &&
>  			git cat-file commit $SHA1_1 &&
> -			test_must_fail git cat-file commit $SHA1_2 &&
> +			test_must_fail_or_sigpipe git cat-file commit $SHA1_2 &&

This I don't.  Under what condition is it sane for this "cat-file
commit" to fail with sigpipe?

>  			git fetch ../testrepo/.git $SHA1_2 &&
>  			git cat-file commit $SHA1_2 &&
> -			test_must_fail git fetch ../testrepo/.git $SHA1_3
> +			test_must_fail_or_sigpipe git fetch ../testrepo/.git $SHA1_3

And this I do.

>  		)
>  	'
>  done
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 73e37a1..19a598e 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -600,6 +600,29 @@ test_must_fail () {
>  	return 0
>  }
>
> +# Similar to test_must_fail, but tolerates sigpipe signal, too.
> +
> +test_must_fail_or_sigpipe () {
> +	"$@"
> +	exit_code=$?
> +	if test $exit_code = 0; then
> +		echo >&2 "test_must_fail: command succeeded: $*"
> +		return 1
> +	elif test $exit_code -ne 141 && \
> +		 test $exit_code -gt 129 && \
> +		 test $exit_code -le 192; then
> +		echo >&2 "test_must_fail: died by signal: $*"
> +		return 1
> +	elif test $exit_code = 127; then
> +		echo >&2 "test_must_fail: command not found: $*"
> +		return 1
> +	elif test $exit_code = 126; then
> +		echo >&2 "test_must_fail: valgrind error: $*"
> +		return 1
> +	fi
> +	return 0
> +}
> +

When you are coming up with this patch, you must have checked the
existing code around this area.  Did you notice that 126 is handled
differently between must_fail and might_fail?  Can you explain and
justify the difference?

One explanation I can think of is that the contributor who did
eeb69131 (tests: notice valgrind error in test_must_fail,
2013-03-31) did not notice that we do essentially the same thing in
might_fail and forgot to add it.  And it is not the fault of that
contributor, but the fault of the duplicated and poorly organized
code back then.

Adding the third variant in the way this patch does is making things
worse by inviting more mistakes.

How about doing something like the attached to consolidate the
existing two into one, and then build this third one on top?

 t/test-lib-functions.sh | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e8d3c0f..54497d6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -560,22 +560,7 @@ test_line_count () {
 # the failure could be due to a segv.  We want a controlled failure.
 
 test_must_fail () {
-	"$@"
-	exit_code=$?
-	if test $exit_code = 0; then
-		echo >&2 "test_must_fail: command succeeded: $*"
-		return 1
-	elif test $exit_code -gt 129 && test $exit_code -le 192; then
-		echo >&2 "test_must_fail: died by signal: $*"
-		return 1
-	elif test $exit_code = 127; then
-		echo >&2 "test_must_fail: command not found: $*"
-		return 1
-	elif test $exit_code = 126; then
-		echo >&2 "test_must_fail: valgrind error: $*"
-		return 1
-	fi
-	return 0
+	test_failure_helper test_must_fail "$@"
 }
 
 # Similar to test_must_fail, but tolerates success, too.  This is
@@ -590,13 +575,29 @@ test_must_fail () {
 # because we want to notice if it fails due to segv.
 
 test_might_fail () {
+	test_failure_helper test_might_fail "$@"
+}
+
+test_failure_helper () {
+	test_expect=$1
+	shift
 	"$@"
 	exit_code=$?
-	if test $exit_code -gt 129 && test $exit_code -le 192; then
-		echo >&2 "test_might_fail: died by signal: $*"
+	if test $test_expect != test_might_fail && test $exit_code = 0
+	then
+		echo >&2 "$test_expect: command succeeded: $*"
+		return 1
+	elif test $exit_code -gt 129 && test $exit_code -le 192
+	then
+		echo >&2 "$test_expect: died by signal: $*"
+		return 1
+	elif test $exit_code = 127
+	then
+		echo >&2 "$test_expect: command not found: $*"
 		return 1
-	elif test $exit_code = 127; then
-		echo >&2 "test_might_fail: command not found: $*"
+	elif test $exit_code = 126
+	then
+		echo >&2 "$test_expect: valgrind error: $*"
 		return 1
 	fi
 	return 0
