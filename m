From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Sun, 09 Jun 2013 11:30:01 -0700
Message-ID: <7vd2rvqgra.fsf@alter.siamese.dyndns.org>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:30:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkNZ-00055F-NZ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab3FISaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:30:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751Ab3FISaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:30:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BE7124DC4;
	Sun,  9 Jun 2013 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B3lSq6YLSQJ+ZVuY0ojlAy5w7K8=; b=GM2qPP
	kcgwugGJLYbtXa+m5OjniwNWIZKqR4P6QDSMvu+CpVTNsNzY0lrxOvnIXw1HJ1Zm
	dcjXG2JozlkZp24ueHfWAsjUmK90ZpoiyjAHilMTzudaOrVzW0XEXsdKhk8feV39
	hYdxmXz8nXOFFgchS3t1EEPN8PsXhL5WaN9IU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lpvYMxCNqjUMMGfKfPe54e1fzJkyCJRh
	3ZnBKrarIgFSKUBU86RQ9w2/Xvs+k3ognt+RZJzezc+EmCVAjXNGRZS9jHw5FZfQ
	cxrkKM+GDXTn8GLirLeb1vP2GqlKe3EB//6RJ3W9VudSJ/f0vFBotAH8sR7JWbVi
	JUyjkekqeqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60DFE24DC2;
	Sun,  9 Jun 2013 18:30:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6543C24DBF;
	Sun,  9 Jun 2013 18:30:03 +0000 (UTC)
In-Reply-To: <CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 8 Jun 2013 09:44:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99E511F0-D132-11E2-A6E6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227088>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jun 8, 2013 at 3:32 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Let's show the output so it's clear why it failed.
>
> I think you can always look into trash-directory.t3400 and figure why.
> But if you show this, I think you should use test_cmp to make it clear
> what is not wanted. Something like
>
> : >expected &&
> test_cmp expected output.out

There are quite many places that do this "output must be empty" in
the test suite, so it may deserve a special case perhaps like this
one.

-- >8 --
Subject: [PATCH] test: test_output_must_be_empty helper

There are quite a lot places where an output file is expected to be
empty, and we fail the test when it is not.  The output from running
the test script with -i -v can be helped if we showed the unexpected
contents at that point.

We could of course do

    >expected.empty && test_cmp expected.empty actual

but this is commmon enough to be done with a dedicated helper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0040-parse-options.sh      | 46 +++++++++++++++++++++----------------------
 t/t3400-rebase.sh             |  2 +-
 t/t3903-stash.sh              | 10 +++++-----
 t/t5521-pull-options.sh       | 26 ++++++++++++------------
 t/t5702-clone-options.sh      |  2 +-
 t/t7102-reset.sh              |  2 +-
 t/t7400-submodule-basic.sh    |  6 +++---
 t/t9402-git-cvsserver-refs.sh | 12 +++++------
 t/test-lib-functions.sh       | 12 +++++++++++
 9 files changed, 65 insertions(+), 53 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 244a43c..e2f5be0 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -50,7 +50,7 @@ EOF
 
 test_expect_success 'test help' '
 	test_must_fail test-parse-options -h > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_i18ncmp expect output
 '
 
@@ -75,7 +75,7 @@ check() {
 	shift &&
 	sed "s/^$what .*/$what $expect/" <expect.template >expect &&
 	test-parse-options $* >output 2>output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 }
 
@@ -86,7 +86,7 @@ check_i18n() {
 	shift &&
 	sed "s/^$what .*/$what $expect/" <expect.template >expect &&
 	test-parse-options $* >output 2>output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_i18ncmp expect output
 }
 
@@ -99,7 +99,7 @@ check_unknown() {
 	esac &&
 	cat expect.err >>expect &&
 	test_must_fail test-parse-options $* >output 2>output.err &&
-	test ! -s output &&
+	test_output_must_be_empty output &&
 	test_cmp expect output.err
 }
 
@@ -112,7 +112,7 @@ check_unknown_i18n() {
 	esac &&
 	cat expect.err >>expect &&
 	test_must_fail test-parse-options $* >output 2>output.err &&
-	test ! -s output &&
+	test_output_must_be_empty output &&
 	test_i18ncmp expect output.err
 }
 
@@ -149,7 +149,7 @@ test_expect_success 'short options' '
 	test-parse-options -s123 -b -i 1729 -b -vv -n -F my.file \
 	> output 2> output.err &&
 	test_cmp expect output &&
-	test ! -s output.err
+	test_output_must_be_empty output.err
 '
 
 cat > expect << EOF
@@ -168,7 +168,7 @@ test_expect_success 'long options' '
 	test-parse-options --boolean --integer 1729 --boolean --string2=321 \
 		--verbose --verbose --no-dry-run --abbrev=10 --file fi.le\
 		--obsolete > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
@@ -199,7 +199,7 @@ EOF
 test_expect_success 'intermingled arguments' '
 	test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
 		> output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
@@ -217,13 +217,13 @@ EOF
 
 test_expect_success 'unambiguously abbreviated option' '
 	test-parse-options --int 2 --boolean --no-bo > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
 	test-parse-options --int=2 > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
@@ -246,7 +246,7 @@ EOF
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
 	test-parse-options --st 123 > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
@@ -256,7 +256,7 @@ EOF
 
 test_expect_success 'detect possible typos' '
 	test_must_fail test-parse-options -boolean > output 2> output.err &&
-	test ! -s output &&
+	test_output_must_be_empty output &&
 	test_cmp typo.err output.err
 '
 
@@ -266,7 +266,7 @@ EOF
 
 test_expect_success 'detect possible typos' '
 	test_must_fail test-parse-options -ambiguous > output 2> output.err &&
-	test ! -s output &&
+	test_output_must_be_empty output &&
 	test_cmp typo.err output.err
 '
 
@@ -285,7 +285,7 @@ EOF
 
 test_expect_success 'keep some options as arguments' '
 	test-parse-options --quux > output 2> output.err &&
-        test ! -s output.err &&
+	test_output_must_be_empty output.err &&
         test_cmp expect output
 '
 
@@ -305,7 +305,7 @@ EOF
 test_expect_success 'OPT_DATE() and OPT_SET_PTR() work' '
 	test-parse-options -t "1970-01-01 00:00:01 +0000" --default-string \
 		foo -q > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
@@ -324,7 +324,7 @@ EOF
 
 test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
 	test-parse-options --length=four -b -4 > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
@@ -352,13 +352,13 @@ EOF
 
 test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
 	test-parse-options --set23 -bbbbb --no-or4 > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
 	test-parse-options --set23 -bbbbb --neg-or4 > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
@@ -376,19 +376,19 @@ EOF
 
 test_expect_success 'OPT_BIT() works' '
 	test-parse-options -bb --or4 > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_NEGBIT() works' '
 	test-parse-options -bb --no-neg-or4 > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
 	test-parse-options + + + + + + > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
@@ -406,7 +406,7 @@ EOF
 
 test_expect_success 'OPT_NUMBER_CALLBACK() works' '
 	test-parse-options -12345 > output 2> output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
@@ -424,7 +424,7 @@ EOF
 
 test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
 	test-parse-options --no-ambig >output 2>output.err &&
-	test ! -s output.err &&
+	test_output_must_be_empty output.err &&
 	test_cmp expect output
 '
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 1de0ebd..e198419 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -179,7 +179,7 @@ test_expect_success 'default to @{upstream} when upstream arg is missing' '
 test_expect_success 'rebase -q is quiet' '
 	git checkout -b quiet topic &&
 	git rebase -q master >output.out 2>&1 &&
-	test ! -s output.out
+	test_output_must_be_empty output.out
 '
 
 test_expect_success 'Rebase a commit that sprinkles CRs in' '
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5dfbda7..ebd838a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -200,17 +200,17 @@ test_expect_success 'apply -q is quiet' '
 	echo foo > file &&
 	git stash &&
 	git stash apply -q > output.out 2>&1 &&
-	test ! -s output.out
+	test_output_must_be_empty output.out
 '
 
 test_expect_success 'save -q is quiet' '
 	git stash save --quiet > output.out 2>&1 &&
-	test ! -s output.out
+	test_output_must_be_empty output.out
 '
 
 test_expect_success 'pop -q is quiet' '
 	git stash pop -q > output.out 2>&1 &&
-	test ! -s output.out
+	test_output_must_be_empty output.out
 '
 
 test_expect_success 'pop -q --index works and is quiet' '
@@ -219,13 +219,13 @@ test_expect_success 'pop -q --index works and is quiet' '
 	git stash save --quiet &&
 	git stash pop -q --index > output.out 2>&1 &&
 	test foo = "$(git show :file)" &&
-	test ! -s output.out
+	test_output_must_be_empty output.out
 '
 
 test_expect_success 'drop -q is quiet' '
 	git stash &&
 	git stash drop -q > output.out 2>&1 &&
-	test ! -s output.out
+	test_output_must_be_empty output.out
 '
 
 test_expect_success 'stash -k' '
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index aa31abe..f913166 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -15,19 +15,19 @@ test_expect_success 'git pull -q' '
 	mkdir clonedq &&
 	(cd clonedq && git init &&
 	git pull -q "../parent" >out 2>err &&
-	test ! -s err &&
-	test ! -s out)
+	test_output_must_be_empty err &&
+	test_output_must_be_empty out)
 '
 
 test_expect_success 'git pull -q --rebase' '
 	mkdir clonedqrb &&
 	(cd clonedqrb && git init &&
 	git pull -q --rebase "../parent" >out 2>err &&
-	test ! -s err &&
-	test ! -s out &&
+	test_output_must_be_empty err &&
+	test_output_must_be_empty out &&
 	git pull -q --rebase "../parent" >out 2>err &&
-	test ! -s err &&
-	test ! -s out)
+	test_output_must_be_empty err &&
+	test_output_must_be_empty out)
 '
 
 test_expect_success 'git pull' '
@@ -35,7 +35,7 @@ test_expect_success 'git pull' '
 	(cd cloned && git init &&
 	git pull "../parent" >out 2>err &&
 	test -s err &&
-	test ! -s out)
+	test_output_must_be_empty out)
 '
 
 test_expect_success 'git pull --rebase' '
@@ -43,7 +43,7 @@ test_expect_success 'git pull --rebase' '
 	(cd clonedrb && git init &&
 	git pull --rebase "../parent" >out 2>err &&
 	test -s err &&
-	test ! -s out)
+	test_output_must_be_empty out)
 '
 
 test_expect_success 'git pull -v' '
@@ -51,7 +51,7 @@ test_expect_success 'git pull -v' '
 	(cd clonedv && git init &&
 	git pull -v "../parent" >out 2>err &&
 	test -s err &&
-	test ! -s out)
+	test_output_must_be_empty out)
 '
 
 test_expect_success 'git pull -v --rebase' '
@@ -59,22 +59,22 @@ test_expect_success 'git pull -v --rebase' '
 	(cd clonedvrb && git init &&
 	git pull -v --rebase "../parent" >out 2>err &&
 	test -s err &&
-	test ! -s out)
+	test_output_must_be_empty out)
 '
 
 test_expect_success 'git pull -v -q' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
 	git pull -v -q "../parent" >out 2>err &&
-	test ! -s out &&
-	test ! -s err)
+	test_output_must_be_empty out &&
+	test_output_must_be_empty err)
 '
 
 test_expect_success 'git pull -q -v' '
 	mkdir clonedqv &&
 	(cd clonedqv && git init &&
 	git pull -q -v "../parent" >out 2>err &&
-	test ! -s out &&
+	test_output_must_be_empty out &&
 	test -s err)
 '
 
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 02cb024..d486c9b 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -22,7 +22,7 @@ test_expect_success 'clone -o' '
 test_expect_success 'redirected clone' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
-	test ! -s err
+	test_output_must_be_empty err
 
 '
 test_expect_success 'redirected clone -v' '
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index df82ec9..622feff 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -457,7 +457,7 @@ test_expect_success 'disambiguation (1)' '
 	test_must_fail git diff --quiet -- secondfile &&
 	test -z "$(git diff --cached --name-only)" &&
 	test -f secondfile &&
-	test ! -s secondfile
+	test_output_must_be_empty secondfile
 
 '
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2683cba..2779b7e 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -78,7 +78,7 @@ test_expect_success 'submodule add' '
 	(
 		cd addtest &&
 		git submodule add -q "$submodurl" submod >actual &&
-		test ! -s actual &&
+		test_output_must_be_empty actual &&
 		echo "gitdir: ../.git/modules/submod" >expect &&
 		test_cmp expect submod/.git &&
 		(
@@ -308,7 +308,7 @@ test_expect_success 'update should work when path is an empty dir' '
 
 	mkdir init &&
 	git submodule update -q >update.out &&
-	test ! -s update.out &&
+	test_output_must_be_empty update.out &&
 
 	inspect init &&
 	test_cmp expect head-sha1
@@ -696,7 +696,7 @@ test_expect_success 'submodule add --name allows to replace a submodule with ano
 		rm -rf repo &&
 		git rm repo &&
 		git submodule add -q --name repo_new "$submodurl/bare.git" repo >actual &&
-		test ! -s actual &&
+		test_output_must_be_empty actual &&
 		echo "gitdir: ../.git/modules/submod" >expect &&
 		test_cmp expect submod/.git &&
 		(
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index 735a018..84a4309 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -330,7 +330,7 @@ test_expect_success 'validate result of edits [cvswork2]' '
 
 test_expect_success 'validate basic diffs saved during above cvswork2 edits' '
 	test $(grep Index: cvsEdit1.diff | wc -l) = 1 &&
-	test ! -s cvsEdit2-empty.diff &&
+	test_output_must_be_empty cvsEdit2-empty.diff &&
 	test $(grep Index: cvsEdit2-N.diff | wc -l) = 1 &&
 	test $(grep Index: cvsEdit3.diff | wc -l) = 3 &&
 	rm -rf diffSandbox &&
@@ -456,20 +456,20 @@ test_expect_success 'cvs up -r $(git rev-parse v1)' '
 
 test_expect_success 'cvs diff -r v1 -u' '
 	( cd cvswork && cvs -f diff -r v1 -u ) >cvsDiff.out 2>cvs.log &&
-	test ! -s cvsDiff.out &&
-	test ! -s cvs.log
+	test_output_must_be_empty cvsDiff.out &&
+	test_output_must_be_empty cvs.log
 '
 
 test_expect_success 'cvs diff -N -r v2 -u' '
 	( cd cvswork && ! cvs -f diff -N -r v2 -u ) >cvsDiff.out 2>cvs.log &&
-	test ! -s cvs.log &&
+	test_output_must_be_empty cvs.log &&
 	test -s cvsDiff.out &&
 	check_diff cvsDiff.out v2 v1 >check_diff.out 2>&1
 '
 
 test_expect_success 'cvs diff -N -r v2 -r v1.2' '
 	( cd cvswork && ! cvs -f diff -N -r v2 -r v1.2 -u ) >cvsDiff.out 2>cvs.log &&
-	test ! -s cvs.log &&
+	test_output_must_be_empty cvs.log &&
 	test -s cvsDiff.out &&
 	check_diff cvsDiff.out v2 v1.2 >check_diff.out 2>&1
 '
@@ -488,7 +488,7 @@ test_expect_success 'apply early [cvswork3] diff to b3' '
 
 test_expect_success 'check [cvswork3] diff' '
 	( cd cvswork3 && ! cvs -f diff -N -u ) >"$WORKDIR/cvsDiff.out" 2>cvs.log &&
-	test ! -s cvs.log &&
+	test_output_must_be_empty cvs.log &&
 	test -s cvsDiff.out &&
 	test $(grep Index: cvsDiff.out | wc -l) = 3 &&
 	test_cmp cvsDiff.out cvswork3edit.diff &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3fc9cc9..a88e652 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -606,6 +606,18 @@ test_cmp() {
 	$GIT_TEST_CMP "$@"
 }
 
+# Check if the file expected to be empty is indeed empty, and barfs
+# otherwise.
+
+test_output_must_be_empty () {
+	if test -s "$1"
+	then
+		echo "Bad: test_output_must_be_empty '$1', but has the following."
+		cat "$1"
+		return 1
+	fi
+}
+
 # Tests that its two parameters refer to the same revision
 test_cmp_rev () {
 	git rev-parse --verify "$1" >expect.rev &&
-- 
1.8.3-477-gc2fede3
