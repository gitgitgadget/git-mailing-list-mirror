From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] checkout -m: attempt merge when deletion of path
 was staged
Date: Wed, 13 Aug 2014 21:30:11 +0200
Message-ID: <53EBBCC3.4060309@kdbg.org>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com>	<1407878107-22850-1-git-send-email-stefanbeller@gmail.com>	<20140812235731.GD24621@google.com>	<20140813000317.GG24621@google.com>	<xmqqzjf82sc7.fsf@gitster.dls.corp.google.com> <xmqqvbpw2p2x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Johannes.Schindelin@gmx.de, barkalow@iabervon.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 21:30:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHeFa-0005Ra-Nv
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 21:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbaHMTaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 15:30:16 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:56684 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751457AbaHMTaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 15:30:16 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8D9DB130050;
	Wed, 13 Aug 2014 21:30:12 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EB9CF19F431;
	Wed, 13 Aug 2014 21:30:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqvbpw2p2x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255226>

Am 13.08.2014 20:59, schrieb Junio C Hamano:
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 0c9ec0a..cedbb6a 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -223,6 +223,23 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
>  	test_cmp two expect
>  '
>  
> +test_expect_success 'switch to another branch while carrying a deletion' '
> +
> +	git checkout -f master && git reset --hard && git clean -f &&
> +	git rm two &&
> +
> +	test_must_fail git checkout simple 2>errs &&
> +	test_i18ngrep overwritten errs &&
> +
> +	git checkout --merge simple 2>errs &&
> +	! test_i18ngrep overwritten errs &&

This must be written as

	test_i18ngrep ! overwritten errs &&

> +	git ls-files -u &&
> +	test_must_fail git cat-file -t :0:two &&
> +	test "$(git cat-file -t :1:two)" = blob &&
> +	test "$(git cat-file -t :2:two)" = blob &&
> +	test_must_fail git cat-file -t :3:two
> +'
> +
>  test_expect_success 'checkout to detach HEAD (with advice declined)' '
>  
>  	git config advice.detachedHead false &&
> 

I see a few wrong usages in the current code base. Here's a fix.

--- >8 ---
Subject: [PATCH] tests: fix negated test_i18ngrep calls

The helper function test_i18ngrep pretends that it found the expected
results when it is running under GETTEXT_POISON. For this reason, it must
not be used negated like so

   ! test_i18ngrep foo bar

because the test case would fail under GETTEXT_POISON. The function offers
a special syntax to test that a pattern is *not* found:

   test_i18ngrep ! foo bar

Convert incorrect uses to this syntax.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4018-diff-funcname.sh | 8 ++++----
 t/t9800-git-p4-basic.sh  | 2 +-
 t/t9807-git-p4-submit.sh | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 34591c2..1dbaa38 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -52,15 +52,15 @@ do
 		echo "*.java diff=$p" >.gitattributes &&
 		test_expect_code 1 git diff --no-index \
 			A.java B.java 2>msg &&
-		! test_i18ngrep fatal msg &&
-		! test_i18ngrep error msg
+		test_i18ngrep ! fatal msg &&
+		test_i18ngrep ! error msg
 	'
 	test_expect_success "builtin $p wordRegex pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
 		test_expect_code 1 git diff --no-index --word-diff \
 			A.java B.java 2>msg &&
-		! test_i18ngrep fatal msg &&
-		! test_i18ngrep error msg
+		test_i18ngrep ! fatal msg &&
+		test_i18ngrep ! error msg
 	'
 done
 
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 665607c..5b56212 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -145,7 +145,7 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
 		test_expect_code 1 git p4 clone --dest="$git" //depot >errs 2>&1
 	) &&
 	cat errs &&
-	! test_i18ngrep Traceback errs
+	test_i18ngrep ! Traceback errs
 '
 
 # Hide a file from p4d, make sure we catch its complaint.  This won't fail in
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 7fab2ed..1f74a88 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -404,7 +404,7 @@ test_expect_success 'submit --prepare-p4-only' '
 		git p4 submit --prepare-p4-only >out &&
 		test_i18ngrep "prepared for submission" out &&
 		test_i18ngrep "must be deleted" out &&
-		! test_i18ngrep "everything below this line is just the diff" out
+		test_i18ngrep ! "everything below this line is just the diff" out
 	) &&
 	(
 		cd "$cli" &&
-- 
2.0.0.12.gbcf935e
