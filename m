From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] test: cope better with use of return for errors
Date: Tue, 09 Aug 2011 10:46:34 +0200
Message-ID: <4E40F3EA.8020406@viscovery.net>
References: <20110321105628.GC16334@sigill.intra.peff.net> <cover.1300872923.git.git@drmicha.warpmail.net> <20110324082108.GA30196@elie> <20110808011341.GA19551@elie.gateway.2wire.net> <20110808011709.GC19551@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarma?= =?ISO-8859-1?Q?son?= 
	<avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 10:46:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqhxb-0000vz-5H
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 10:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266Ab1HIIqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 04:46:45 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43372 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab1HIIqn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 04:46:43 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QqhxL-0000jn-HM; Tue, 09 Aug 2011 10:46:36 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3F4FB1660F;
	Tue,  9 Aug 2011 10:46:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <20110808011709.GC19551@elie.gateway.2wire.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179026>

Am 8/8/2011 3:17, schrieb Jonathan Nieder:
> +test_eval_ () {
> +	# This is a separate function because some tests use
> +	# "return" to end a test_expect_success block early.
> +	eval >&3 2>&4 "$*"
> +}
> +
>  test_run_ () {
>  	test_cleanup=:
>  	expecting_failure=$2
> -	eval >&3 2>&4 "$1"
> +	test_eval_ "$1"
>  	eval_ret=$?
>  
>  	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
>  	then
> -		eval >&3 2>&4 "$test_cleanup"
> +		test_eval_ "$test_cleanup"
>  	fi
>  	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
>  		echo ""

This invalidates at least t3900.29, which accesses an unexpanded $3
from the test script. The patch below fixes this case.

I tried to detect other cases by poisoning test_run_ like this:

-       test_eval_ "$1"
+       test_eval_ :\; :\; :\; :\; :\; "$1"

in the hopes that ":;" is an error at the place that uses $1, $2, etc.
t3900.2[89] are the only tests that are uncovered in this way.

I noticed this because I have a patched test-lib.sh that calls
test_eval_ in a similarly modified manner.

--- >8 ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] t3900: do not reference numbered arguments from the test
 script

The call to test_expect_success is nested inside a function, whose
arguments the test code wants to access. But it is not specified that any
unexpanded $1, $2, $3, etc in the test code will access the surrounding
function's arguments. Rather, they will access the arguments of the
function that happens to eval the test code.

Play safe by placing the argument in a named variable.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3900-i18n-commit.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index c06a5ee..3265fac 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -136,6 +136,7 @@ done
 test_commit_autosquash_flags () {
 	H=$1
 	flag=$2
+	mopt=$3
 	test_expect_success "commit --$flag with $H encoding" '
 		git config i18n.commitencoding $H &&
 		git checkout -b $H-$flag C0 &&
@@ -147,7 +148,7 @@ test_commit_autosquash_flags () {
 		git commit -a -m "intermediate commit" &&
 		test_tick &&
 		echo $H $flag >>F &&
-		git commit -a --$flag HEAD~1 $3 &&
+		git commit -a --$flag HEAD~1 $mopt &&
 		E=$(git cat-file commit '$H-$flag' |
 			sed -ne "s/^encoding //p") &&
 		test "z$E" = "z$H" &&
@@ -160,6 +161,6 @@ test_commit_autosquash_flags () {
 
 test_commit_autosquash_flags eucJP fixup
 
-test_commit_autosquash_flags ISO-2022-JP squash '-m "squash message"'
+test_commit_autosquash_flags ISO-2022-JP squash '-m squash_message'
 
 test_done
-- 
1.7.6.1618.gc932c
