From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] solaris test results
Date: Thu, 21 Feb 2008 21:26:44 -0800
Message-ID: <7vr6f5pnmz.fsf@gitster.siamese.dyndns.org>
References: <20080220235944.GA6278@coredump.intra.peff.net>
 <7vk5kz171q.fsf@gitster.siamese.dyndns.org>
 <20080221004146.GA6682@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 06:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSQRi-00048r-VV
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 06:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbYBVF1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 00:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbYBVF1E
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 00:27:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbYBVF1A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 00:27:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1144F35D4;
	Fri, 22 Feb 2008 00:26:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AB74D35CE; Fri, 22 Feb 2008 00:26:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74690>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 20, 2008 at 04:34:25PM -0800, Junio C Hamano wrote:
>
>> >   - Sun's diff doesn't understand "-u". I was able to use GNU diff.
>> >     Since comparing actual and expected output is so common, we could
>> >     potentially abstract this with a "test_cmp()" function and use
>> >     something platform specific. It's probably not worth the trouble, as
>> >     it impacts only the test suite, and only on systems with a totally
>> >     broken diff.
>> 
>> It is unfair to call diff without -u "totally broken".  It is
>> not even in POSIX yet IIRC.
>
> Fair enough (and you are right that it is not even POSIX). Is it
> something we want to work around? We "diff -u" quite a bit in the test
> suite.

Here is a possible solution.

This is a fairly mechanical substitution (grepping for "git diff -u"
and "diff -u", and replacing them with test_compare_expect.

Some tests get the order of comparison wrong (should always be
"diff expect current" to make the error stand out in -v output),
but I did not update them.  That would be for later rounds,
perhaps, if we decide to do this.

-- >8 --
Subject: [PATCH] tests: test_compare_expect helper function

We tend to use "diff -u" for comparing expected output from
actual, but diff on some platforms lack "-u" (it is not in POSIX
yet).

This mechanically replaces "diff -u expected actual" with
test_compare_expect helper function.

Test scripts can be run with --no-diff-u option, to use "git
diff -u --no-index" for comparison instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0003-attributes.sh              |    2 +-
 t/t0022-crlf-rename.sh             |    2 +-
 t/t1300-repo-config.sh             |    2 +-
 t/t2200-add-update.sh              |    2 +-
 t/t3001-ls-files-others-exclude.sh |    2 +-
 t/t3030-merge-recursive.sh         |   42 ++++++++++++++++++------------------
 t/t3050-subprojects-fetch.sh       |    4 +-
 t/t3060-ls-files-with-tree.sh      |    2 +-
 t/t3201-branch-contains.sh         |    6 ++--
 t/t3404-rebase-interactive.sh      |    4 +-
 t/t3405-rebase-malformed.sh        |    4 +-
 t/t3406-rebase-message.sh          |    2 +-
 t/t3701-add-interactive.sh         |    4 +-
 t/t3902-quoted.sh                  |   16 ++++++------
 t/t3903-stash.sh                   |    2 +-
 t/t4023-diff-rename-typechange.sh  |    6 ++--
 t/t4024-diff-optimize-common.sh    |    2 +-
 t/t4025-hunk-header.sh             |    2 +-
 t/t4201-shortlog.sh                |    2 +-
 t/t5505-remote.sh                  |    6 ++--
 t/t5510-fetch.sh                   |    2 +-
 t/t5512-ls-remote.sh               |    8 +++---
 t/t5515-fetch-merge-logic.sh       |    2 +-
 t/t6004-rev-list-path-optim.sh     |    2 +-
 t/t6009-rev-list-parent.sh         |    2 +-
 t/t6027-merge-binary.sh            |    4 +-
 t/t7010-setup.sh                   |   18 +++++++-------
 t/t7501-commit.sh                  |   14 ++++++------
 t/t7502-commit.sh                  |   14 ++++++------
 t/t7502-status.sh                  |    2 +-
 t/t7600-merge.sh                   |    2 +-
 t/t8003-blame.sh                   |    4 +-
 t/t9001-send-email.sh              |    2 +-
 t/t9116-git-svn-log.sh             |   24 ++++++++++----------
 t/t9200-git-cvsexportcommit.sh     |   14 ++++++------
 t/t9300-fast-import.sh             |    2 +-
 t/test-lib.sh                      |   27 +++++++++++++++++++++++
 37 files changed, 142 insertions(+), 115 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 47f08a4..8d85acb 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -11,7 +11,7 @@ attr_check () {
 
 	git check-attr test -- "$path" >actual &&
 	echo "$path: test: $2" >expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 }
 
diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 430a1d1..651ce2f 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -26,7 +26,7 @@ test_expect_success 'diff -M' '
 	git diff-tree -M -r --name-status HEAD^ HEAD |
 	sed -e "s/R[0-9]*/RNUM/" >actual &&
 	echo "RNUM	sample	elpmas" >expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 4928a57..e0e95ce 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -465,7 +465,7 @@ weird
 EOF
 
 test_expect_success "section was removed properly" \
-	"git diff -u expect .git/config"
+	"test_compare_expect expect .git/config"
 
 rm .git/config
 
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 24f892f..75abda1 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -62,7 +62,7 @@ test_expect_success 'cache tree has not been corrupted' '
 	sed -e "s/ 0	/	/" >expect &&
 	git ls-tree -r $(git write-tree) |
 	sed -e "s/ blob / /" >current &&
-	diff -u expect current
+	test_compare_expect expect current
 
 '
 
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index b4297ba..0b9d2ea 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -97,7 +97,7 @@ cat > expect << EOF
 EOF
 
 test_expect_success 'git-status honours core.excludesfile' \
-	'diff -u expect output'
+	'test_compare_expect expect output'
 
 test_expect_success 'trailing slash in exclude allows directory match(1)' '
 
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 607f57f..edfdbfd 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -43,7 +43,7 @@ test_expect_success 'setup 1' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 '
 
 test_expect_success 'setup 2' '
@@ -61,7 +61,7 @@ test_expect_success 'setup 2' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_compare_expect expected actual &&
 
 	echo goodbye >>a &&
 	o2=$(git hash-object a) &&
@@ -82,7 +82,7 @@ test_expect_success 'setup 2' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 '
 
 test_expect_success 'setup 3' '
@@ -100,7 +100,7 @@ test_expect_success 'setup 3' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_compare_expect expected actual &&
 
 	rm -f b && mkdir b && echo df-1 >b/c && git add b/c &&
 	o3=$(git hash-object b/c) &&
@@ -119,7 +119,7 @@ test_expect_success 'setup 3' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 '
 
 test_expect_success 'setup 4' '
@@ -137,7 +137,7 @@ test_expect_success 'setup 4' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_compare_expect expected actual &&
 
 	rm -f a && mkdir a && echo df-2 >a/c && git add a/c &&
 	o4=$(git hash-object a/c) &&
@@ -156,7 +156,7 @@ test_expect_success 'setup 4' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 '
 
 test_expect_success 'setup 5' '
@@ -174,7 +174,7 @@ test_expect_success 'setup 5' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_compare_expect expected actual &&
 
 	rm -f b &&
 	echo remove-conflict >a &&
@@ -195,7 +195,7 @@ test_expect_success 'setup 5' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -214,7 +214,7 @@ test_expect_success 'setup 6' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o0 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_compare_expect expected actual &&
 
 	rm -fr d && echo df-3 >d && git add d &&
 	o6=$(git hash-object d) &&
@@ -233,7 +233,7 @@ test_expect_success 'setup 6' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o6 0	d"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 '
 
 test_expect_success 'merge-recursive simple' '
@@ -265,7 +265,7 @@ test_expect_success 'merge-recursive result' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -297,7 +297,7 @@ test_expect_success 'merge-recursive remove conflict' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -318,7 +318,7 @@ test_expect_success 'merge-recursive result' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -352,7 +352,7 @@ test_expect_success 'merge-recursive d/f conflict result' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -386,7 +386,7 @@ test_expect_success 'merge-recursive d/f conflict result the other way' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -420,7 +420,7 @@ test_expect_success 'merge-recursive d/f conflict result' '
 		echo "100644 $o0 1	d/e"
 		echo "100644 $o1 2	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -454,7 +454,7 @@ test_expect_success 'merge-recursive d/f conflict result' '
 		echo "100644 $o0 1	d/e"
 		echo "100644 $o1 3	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -480,7 +480,7 @@ test_expect_success 'reset and bind merge' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual &&
+	test_compare_expect expected actual &&
 
 	git read-tree --prefix=a1/ master &&
 	git ls-files -s >actual &&
@@ -498,7 +498,7 @@ test_expect_success 'reset and bind merge' '
 		echo "100644 $o0 0	c"
 		echo "100644 $o1 0	d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 
 	git read-tree --prefix=z/ master &&
 	git ls-files -s >actual &&
@@ -520,7 +520,7 @@ test_expect_success 'reset and bind merge' '
 		echo "100644 $o0 0	z/c"
 		echo "100644 $o1 0	z/d/e"
 	) >expected &&
-	git diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index 34f26a8..15fbdf3 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -26,7 +26,7 @@ test_expect_success clone '
 		cd cloned &&
 		(git rev-parse HEAD; git ls-files -s) >../actual
 	) &&
-	diff -u expected actual
+	test_compare_expect expected actual
 '
 
 test_expect_success advance '
@@ -46,7 +46,7 @@ test_expect_success fetch '
 		git pull &&
 		(git rev-parse HEAD; git ls-files -s) >../actual
 	) &&
-	diff -u expected actual
+	test_compare_expect expected actual
 '
 
 test_done
diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index 68eb266..ece38d0 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -66,6 +66,6 @@ test_expect_success 'git -ls-files --with-tree should succeed from subdir' '
 cd ..
 test_expect_success \
     'git -ls-files --with-tree should add entries from named tree.' \
-    'diff -u expected output'
+    'test_compare_expect expected output'
 
 test_done
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 9ef593f..a711f54 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -31,7 +31,7 @@ test_expect_success 'branch --contains=master' '
 	{
 		echo "  master" && echo "* side"
 	} >expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
@@ -41,7 +41,7 @@ test_expect_success 'branch --contains master' '
 	{
 		echo "  master" && echo "* side"
 	} >expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
@@ -51,7 +51,7 @@ test_expect_success 'branch --contains=side' '
 	{
 		echo "* side"
 	} >expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 62e65d7..76927f8 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -146,8 +146,8 @@ EOF
 test_expect_success 'stop on conflicting pick' '
 	git tag new-branch1 &&
 	! git rebase -i master &&
-	diff -u expect .git/.dotest-merge/patch &&
-	diff -u expect2 file1 &&
+	test_compare_expect expect .git/.dotest-merge/patch &&
+	test_compare_expect expect2 file1 &&
 	test 4 = $(grep -v "^#" < .git/.dotest-merge/done | wc -l) &&
 	test 0 = $(grep -ve "^#" -e "^$" < .git/.dotest-merge/git-rebase-todo |
 		wc -l)
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index e4e2e64..8bb412e 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -41,8 +41,8 @@ test_expect_success rebase '
 	git rebase master side &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >F1 &&
 
-	diff -u F0 F1 &&
-	diff -u F F0
+	test_compare_expect F0 F1 &&
+	test_compare_expect F F0
 '
 
 test_done
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 332b2b2..9753939 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -37,7 +37,7 @@ test_expect_success 'rebase -m' '
 	git rebase -m master >report &&
 	sed -n -e "/^Already applied: /p" \
 		-e "/^Committed: /p" report >actual &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index c8dc1ac..1bb2aae 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -24,7 +24,7 @@ EOF
 test_expect_success 'diff works (initial)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/new file/,/content/p" <output >diff &&
-	diff -u expected diff
+	test_compare_expect expected diff
 '
 test_expect_success 'revert works (initial)' '
 	git add file &&
@@ -57,7 +57,7 @@ EOF
 test_expect_success 'diff works (commit)' '
 	(echo d; echo 1) | git add -i >output &&
 	sed -ne "/^index/,/content/p" <output >diff &&
-	diff -u expected diff
+	test_compare_expect expected diff
 '
 test_expect_success 'revert works (commit)' '
 	git add file &&
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 73da45f..02eb9ff 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -78,28 +78,28 @@ EOF
 
 test_expect_success 'check fully quoted output from ls-files' '
 
-	git ls-files >current && diff -u expect.quoted current
+	git ls-files >current && test_compare_expect expect.quoted current
 
 '
 
 test_expect_success 'check fully quoted output from diff-files' '
 
 	git diff --name-only >current &&
-	diff -u expect.quoted current
+	test_compare_expect expect.quoted current
 
 '
 
 test_expect_success 'check fully quoted output from diff-index' '
 
 	git diff --name-only HEAD >current &&
-	diff -u expect.quoted current
+	test_compare_expect expect.quoted current
 
 '
 
 test_expect_success 'check fully quoted output from diff-tree' '
 
 	git diff --name-only HEAD^ HEAD >current &&
-	diff -u expect.quoted current
+	test_compare_expect expect.quoted current
 
 '
 
@@ -111,28 +111,28 @@ test_expect_success 'setting core.quotepath' '
 
 test_expect_success 'check fully quoted output from ls-files' '
 
-	git ls-files >current && diff -u expect.raw current
+	git ls-files >current && test_compare_expect expect.raw current
 
 '
 
 test_expect_success 'check fully quoted output from diff-files' '
 
 	git diff --name-only >current &&
-	diff -u expect.raw current
+	test_compare_expect expect.raw current
 
 '
 
 test_expect_success 'check fully quoted output from diff-index' '
 
 	git diff --name-only HEAD >current &&
-	diff -u expect.raw current
+	test_compare_expect expect.raw current
 
 '
 
 test_expect_success 'check fully quoted output from diff-tree' '
 
 	git diff --name-only HEAD^ HEAD >current &&
-	diff -u expect.raw current
+	test_compare_expect expect.raw current
 
 '
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 9a9a250..4f5e579 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -34,7 +34,7 @@ EOF
 test_expect_success 'parents of stash' '
 	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
 	git diff stash^2..stash > output &&
-	diff -u output expect
+	test_compare_expect output expect
 '
 
 test_expect_success 'apply needs clean working directory' '
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 255604e..177e78a 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -57,7 +57,7 @@ test_expect_success 'cross renames to be detected for regular files' '
 		echo "R100	foo	bar"
 		echo "R100	bar	foo"
 	} | sort >expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
@@ -68,7 +68,7 @@ test_expect_success 'cross renames to be detected for typechange' '
 		echo "R100	foo	bar"
 		echo "R100	bar	foo"
 	} | sort >expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
@@ -79,7 +79,7 @@ test_expect_success 'moves and renames' '
 		echo "R100	foo	bar"
 		echo "T100	foo"
 	} | sort >expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index 3c66102..318ce54 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -150,7 +150,7 @@ test_expect_success 'diff -U0' '
 	do
 		git diff -U0 file-?$n
 	done | zc >actual &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
diff --git a/t/t4025-hunk-header.sh b/t/t4025-hunk-header.sh
index 9ba06b7..542bf30 100755
--- a/t/t4025-hunk-header.sh
+++ b/t/t4025-hunk-header.sh
@@ -37,7 +37,7 @@ test_expect_success 'hunk header truncation with an overly long line' '
 		echo " A $N$N$N$N$N$N$N$N$N2"
 		echo " L  $N$N$N$N$N$N$N$N$N1"
 	) >expected &&
-	diff -u actual expected
+	test_compare_expect actual expected
 
 '
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 6d12efb..f9859bc 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -45,6 +45,6 @@ A U Thor (5):
 
 EOF
 
-test_expect_success 'shortlog wrapping' 'diff -u expect out'
+test_expect_success 'shortlog wrapping' 'test_compare_expect expect out'
 
 test_done
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 636aec2..cf20ec4 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -25,7 +25,7 @@ setup_repository () {
 tokens_match () {
 	echo "$1" | tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
 	echo "$2" | tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
-	diff -u expect actual
+	test_compare_expect expect actual
 }
 
 check_remote_track () {
@@ -74,7 +74,7 @@ test_expect_success 'add another remote' '
 	sed -e "/^refs\/remotes\/origin\//d" \
 	    -e "/^refs\/remotes\/second\//d" >actual &&
 	>expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 )
 '
 
@@ -93,7 +93,7 @@ test_expect_success 'remove remote' '
 	git for-each-ref "--format=%(refname)" refs/remotes |
 	sed -e "/^refs\/remotes\/origin\//d" >actual &&
 	>expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 )
 '
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9b948c1..17add89 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -249,7 +249,7 @@ test_expect_success 'bundle should record HEAD correctly' '
 	do
 		echo "$(git rev-parse --verify $h) $h"
 	done >expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 6ec5f7c..60def72 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -24,28 +24,28 @@ test_expect_success setup '
 test_expect_success 'ls-remote --tags .git' '
 
 	git ls-remote --tags .git >actual &&
-	diff -u expected.tag actual
+	test_compare_expect expected.tag actual
 
 '
 
 test_expect_success 'ls-remote .git' '
 
 	git ls-remote .git >actual &&
-	diff -u expected.all actual
+	test_compare_expect expected.all actual
 
 '
 
 test_expect_success 'ls-remote --tags self' '
 
 	git ls-remote --tags self >actual &&
-	diff -u expected.tag actual
+	test_compare_expect expected.tag actual
 
 '
 
 test_expect_success 'ls-remote self' '
 
 	git ls-remote self >actual &&
-	diff -u expected.all actual
+	test_compare_expect expected.all actual
 
 '
 
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 31c1081..85ff226 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -148,7 +148,7 @@ do
 		} >"$actual" &&
 		if test -f "$expect"
 		then
-			git diff -u "$expect" "$actual" &&
+			test_compare_expect "$expect" "$actual" &&
 			rm -f "$actual"
 		else
 			# this is to help developing new tests.
diff --git a/t/t6004-rev-list-path-optim.sh b/t/t6004-rev-list-path-optim.sh
index 80d7198..0624cc4 100755
--- a/t/t6004-rev-list-path-optim.sh
+++ b/t/t6004-rev-list-path-optim.sh
@@ -45,7 +45,7 @@ test_expect_success 'further setup' '
 test_expect_success 'path optimization 2' '
 	( echo "$side"; echo "$initial" ) >expected &&
 	git rev-list HEAD -- a >actual &&
-	diff -u expected actual
+	test_compare_expect expected actual
 '
 
 test_done
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index be3d238..763934a 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -31,7 +31,7 @@ test_expect_failure 'one is ancestor of others and should not be shown' '
 
 	git rev-list one --not four >result &&
 	>expect &&
-	diff -u expect result
+	test_compare_expect expect result
 
 '
 
diff --git a/t/t6027-merge-binary.sh b/t/t6027-merge-binary.sh
index a7358f7..0731022 100755
--- a/t/t6027-merge-binary.sh
+++ b/t/t6027-merge-binary.sh
@@ -45,7 +45,7 @@ test_expect_success resolve '
 		false
 	else
 		git ls-files -s >current
-		diff -u current expect
+		test_compare_expect current expect
 	fi
 '
 
@@ -60,7 +60,7 @@ test_expect_success recursive '
 		false
 	else
 		git ls-files -s >current
-		diff -u current expect
+		test_compare_expect current expect
 	fi
 '
 
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index e809e0e..8351841 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -18,7 +18,7 @@ test_expect_success 'git add (absolute)' '
 	git add "$D/a/b/c/d" &&
 	git ls-files >current &&
 	echo a/b/c/d >expect &&
-	diff -u expect current
+	test_compare_expect expect current
 
 '
 
@@ -32,7 +32,7 @@ test_expect_success 'git add (funny relative)' '
 	) &&
 	git ls-files >current &&
 	echo a/e/f >expect &&
-	diff -u expect current
+	test_compare_expect expect current
 
 '
 
@@ -43,7 +43,7 @@ test_expect_success 'git rm (absolute)' '
 	git rm -f --cached "$D/a/b/c/d" &&
 	git ls-files >current &&
 	echo a/e/f >expect &&
-	diff -u expect current
+	test_compare_expect expect current
 
 '
 
@@ -57,7 +57,7 @@ test_expect_success 'git rm (funny relative)' '
 	) &&
 	git ls-files >current &&
 	echo a/b/c/d >expect &&
-	diff -u expect current
+	test_compare_expect expect current
 
 '
 
@@ -67,7 +67,7 @@ test_expect_success 'git ls-files (absolute)' '
 	git add a &&
 	git ls-files "$D/a/e/../b" >current &&
 	echo a/b/c/d >expect &&
-	diff -u expect current
+	test_compare_expect expect current
 
 '
 
@@ -80,7 +80,7 @@ test_expect_success 'git ls-files (relative #1)' '
 		git ls-files "../b/c"
 	)  >current &&
 	echo c/d >expect &&
-	diff -u expect current
+	test_compare_expect expect current
 
 '
 
@@ -93,7 +93,7 @@ test_expect_success 'git ls-files (relative #2)' '
 		git ls-files --full-name "../e/f"
 	)  >current &&
 	echo a/e/f >expect &&
-	diff -u expect current
+	test_compare_expect expect current
 
 '
 
@@ -126,13 +126,13 @@ test_expect_success 'log using absolute path names' '
 
 	git log a/b/c/d >f1.txt &&
 	git log "$(pwd)/a/b/c/d" >f2.txt &&
-	diff -u f1.txt f2.txt
+	test_compare_expect f1.txt f2.txt
 '
 
 test_expect_success 'blame using absolute path names' '
 	git blame a/b/c/d >f1.txt &&
 	git blame "$(pwd)/a/b/c/d" >f2.txt &&
-	diff -u f1.txt f2.txt
+	test_compare_expect f1.txt f2.txt
 '
 
 test_expect_success 'setup deeper work tree' '
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 361886c..f2d89c0 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -203,7 +203,7 @@ test_expect_success 'sign off (1)' '
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
-	diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -223,7 +223,7 @@ $existing" &&
 		git var GIT_COMMITTER_IDENT |
 		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
 	) >expected &&
-	diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -240,7 +240,7 @@ test_expect_success 'multiple -m' '
 		echo
 		echo three
 	) >expected &&
-	diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -301,12 +301,12 @@ test_expect_success 'same tree (merge and amend merge)' '
 	git merge -s ours side -m "empty ok" &&
 	git diff HEAD^ HEAD >actual &&
 	: >expected &&
-	diff -u expected actual &&
+	test_compare_expect expected actual &&
 
 	git commit --amend -m "empty really ok" &&
 	git diff HEAD^ HEAD >actual &&
 	: >expected &&
-	diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -323,7 +323,7 @@ test_expect_success 'amend using the message from another commit' '
 	git commit --allow-empty --amend -C "$old" &&
 	git show --pretty="format:%ad %s" "$old" >expected &&
 	git show --pretty="format:%ad %s" HEAD >actual &&
-	diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
@@ -341,7 +341,7 @@ test_expect_success 'amend using the message from a commit named with tag' '
 	git commit --allow-empty --amend -C tagged-old &&
 	git show --pretty="format:%ad %s" "$old" >expected &&
 	git show --pretty="format:%ad %s" HEAD >actual &&
-	diff -u expected actual
+	test_compare_expect expected actual
 
 '
 
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index b780fdd..f9616bf 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -85,7 +85,7 @@ test_expect_success 'verbose' '
 	git add negative &&
 	git status -v | sed -ne "/^diff --git /p" >actual &&
 	echo "diff --git a/negative b/negative" >expect &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
@@ -95,7 +95,7 @@ test_expect_success 'cleanup commit messages (verbatim,-t)' '
 	{ echo;echo "# text";echo; } >expect &&
 	git commit --cleanup=verbatim -t expect -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d" |head -n 3 >actual &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
@@ -104,7 +104,7 @@ test_expect_success 'cleanup commit messages (verbatim,-F)' '
 	echo >>negative &&
 	git commit --cleanup=verbatim -F expect -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
@@ -113,7 +113,7 @@ test_expect_success 'cleanup commit messages (verbatim,-m)' '
 	echo >>negative &&
 	git commit --cleanup=verbatim -m "$(cat expect)" -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
@@ -124,7 +124,7 @@ test_expect_success 'cleanup commit messages (whitespace,-F)' '
 	echo "# text" >expect &&
 	git commit --cleanup=whitespace -F text -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
@@ -135,7 +135,7 @@ test_expect_success 'cleanup commit messages (strip,-F)' '
 	echo sample >expect &&
 	git commit --cleanup=strip -F text -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
@@ -150,7 +150,7 @@ test_expect_success 'cleanup commit messages (strip,-F,-e)' '
 	{ echo;echo sample;echo; } >text &&
 	git commit -e -F text -a &&
 	head -n 4 .git/COMMIT_EDITMSG >actual &&
-	diff -u expect actual
+	test_compare_expect expect actual
 
 '
 
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index e006074..9b9c7a7 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -146,7 +146,7 @@ cat <<EOF >expect
 EOF
 test_expect_success 'status of partial commit excluding new file in index' '
 	git status dir1/modified >output &&
-	diff -u expect output
+	test_compare_expect expect output
 '
 
 test_done
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 50c51c8..15efd65 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -108,7 +108,7 @@ create_merge_msgs() {
 }
 
 verify_diff() {
-	if ! diff -u "$1" "$2"
+	if ! test_compare_expect "$1" "$2"
 	then
 		echo "$3"
 		false
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index db51b3a..153f3e2 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -112,7 +112,7 @@ test_expect_success 'blame wholesale copy' '
 		echo mouse-Second
 		echo mouse-Third
 	} >expected &&
-	diff -u expected current
+	test_compare_expect expected current
 
 '
 
@@ -125,7 +125,7 @@ test_expect_success 'blame wholesale copy and more' '
 		echo cow-Fifth
 		echo mouse-Third
 	} >expected &&
-	diff -u expected current
+	test_compare_expect expected current
 
 '
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 2efaed4..7342780 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -75,7 +75,7 @@ test_expect_success 'Show all headers' '
 		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
 		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
 		>actual-show-all-headers &&
-	diff -u expected-show-all-headers actual-show-all-headers
+	test_compare_expect expected-show-all-headers actual-show-all-headers
 '
 
 z8=zzzzzzzz
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 902ed41..80f3b39 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -55,74 +55,74 @@ printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4
 
 test_expect_success 'test ascending revision range' "
 	git reset --hard trunk &&
-	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r1-r2-r4 -
+	git svn log -r 1:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_compare_expect expected-range-r1-r2-r4 -
 	"
 
 printf 'r4 \nr2 \nr1 \n' > expected-range-r4-r2-r1
 
 test_expect_success 'test descending revision range' "
 	git reset --hard trunk &&
-	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4-r2-r1 -
+	git svn log -r 4:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_compare_expect expected-range-r4-r2-r1 -
 	"
 
 printf 'r1 \nr2 \n' > expected-range-r1-r2
 
 test_expect_success 'test ascending revision range with unreachable revision' "
 	git reset --hard trunk &&
-	git svn log -r 1:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r1-r2 -
+	git svn log -r 1:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_compare_expect expected-range-r1-r2 -
 	"
 
 printf 'r2 \nr1 \n' > expected-range-r2-r1
 
 test_expect_success 'test descending revision range with unreachable revision' "
 	git reset --hard trunk &&
-	git svn log -r 3:1 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r2-r1 -
+	git svn log -r 3:1 | grep '^r[0-9]' | cut -d'|' -f1 | test_compare_expect expected-range-r2-r1 -
 	"
 
 printf 'r2 \n' > expected-range-r2
 
 test_expect_success 'test ascending revision range with unreachable upper boundary revision and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 2:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r2 -
+	git svn log -r 2:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_compare_expect expected-range-r2 -
 	"
 
 test_expect_success 'test descending revision range with unreachable upper boundary revision and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 3:2 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r2 -
+	git svn log -r 3:2 | grep '^r[0-9]' | cut -d'|' -f1 | test_compare_expect expected-range-r2 -
 	"
 
 printf 'r4 \n' > expected-range-r4
 
 test_expect_success 'test ascending revision range with unreachable lower boundary revision and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 3:4 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	git svn log -r 3:4 | grep '^r[0-9]' | cut -d'|' -f1 | test_compare_expect expected-range-r4 -
 	"
 
 test_expect_success 'test descending revision range with unreachable lower boundary revision and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 4:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	git svn log -r 4:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_compare_expect expected-range-r4 -
 	"
 
 printf -- '------------------------------------------------------------------------\n' > expected-separator
 
 test_expect_success 'test ascending revision range with unreachable boundary revisions and no commits' "
 	git reset --hard trunk &&
-	git svn log -r 5:6 | diff -u expected-separator -
+	git svn log -r 5:6 | test_compare_expect expected-separator -
 	"
 
 test_expect_success 'test descending revision range with unreachable boundary revisions and no commits' "
 	git reset --hard trunk &&
-	git svn log -r 6:5 | diff -u expected-separator -
+	git svn log -r 6:5 | test_compare_expect expected-separator -
 	"
 
 test_expect_success 'test ascending revision range with unreachable boundary revisions and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 3:5 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	git svn log -r 3:5 | grep '^r[0-9]' | cut -d'|' -f1 | test_compare_expect expected-range-r4 -
 	"
 
 test_expect_success 'test descending revision range with unreachable boundary revisions and 1 commit' "
 	git reset --hard trunk &&
-	git svn log -r 5:3 | grep '^r[0-9]' | cut -d'|' -f1 | diff -u expected-range-r4 -
+	git svn log -r 5:3 | grep '^r[0-9]' | cut -d'|' -f1 | test_compare_expect expected-range-r4 -
 	"
 
 test_done
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 58c59ed..2677799 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -37,7 +37,7 @@ check_entries () {
 	else
 		printf '%s\n' "$2" | tr '|' '\012' >expected
 	fi
-	diff -u expected actual
+	test_compare_expect expected actual
 }
 
 test_expect_success \
@@ -257,8 +257,8 @@ test_expect_success '-w option should work with relative GIT_DIR' '
       (cd "$GIT_DIR" &&
       GIT_DIR=. git cvsexportcommit -w "$CVSWORK" -c $id &&
       check_entries "$CVSWORK/W" "file1.txt/1.1/|file2.txt/1.1/" &&
-      diff -u "$CVSWORK/W/file1.txt" ../W/file1.txt &&
-      diff -u "$CVSWORK/W/file2.txt" ../W/file2.txt
+      test_compare_expect "$CVSWORK/W/file1.txt" ../W/file1.txt &&
+      test_compare_expect "$CVSWORK/W/file2.txt" ../W/file2.txt
       )
 '
 
@@ -279,9 +279,9 @@ test_expect_success 'check files before directories' '
 	git cvsexportcommit -w "$CVSWORK" -c $id &&
 	check_entries "$CVSWORK/E" "DS/1.1/|newfile5.txt/1.1/" &&
 	check_entries "$CVSWORK" "DS/1.1/|release-notes/1.2/" &&
-	diff -u "$CVSWORK/DS" DS &&
-	diff -u "$CVSWORK/E/DS" E/DS &&
-	diff -u "$CVSWORK/release-notes" release-notes
+	test_compare_expect "$CVSWORK/DS" DS &&
+	test_compare_expect "$CVSWORK/E/DS" E/DS &&
+	test_compare_expect "$CVSWORK/release-notes" release-notes
 
 '
 
@@ -293,7 +293,7 @@ test_expect_success 'commit a file with leading spaces in the name' '
 	id=$(git rev-parse HEAD) &&
 	git cvsexportcommit -w "$CVSWORK" -c $id &&
 	check_entries "$CVSWORK" " space/1.1/|DS/1.1/|release-notes/1.2/" &&
-	diff -u "$CVSWORK/ space" " space"
+	test_compare_expect "$CVSWORK/ space" " space"
 
 '
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index cceedbb..5b5ef19 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -117,7 +117,7 @@ test_expect_success \
 		--import-marks=marks.out \
 		--export-marks=marks.new \
 		</dev/null &&
-	git diff -u expect marks.new'
+	test_compare_expect expect marks.new'
 
 test_tick
 cat >input <<INPUT_END
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 83889c4..73cc867 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -52,6 +52,9 @@ case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
 		;;
 esac
 
+test_use_diff_u=t
+test_compare_stdin_file_=
+
 # Each test should start with something like this, after copyright notices:
 #
 # test_description='Description of this test...
@@ -79,6 +82,8 @@ do
 		verbose=t; shift ;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		quiet=t; shift ;;
+	--no-diff-u)
+		test_use_diff_u=; shift ;;
 	--no-color)
 	    color=; shift ;;
 	--no-python)
@@ -270,6 +275,24 @@ test_expect_code () {
 	echo >&3 ""
 }
 
+# Compare expected output and actual one.  The latter can be
+# '-' to compare the expected with the standard input
+test_compare_expect () {
+	case "$test_use_diff_u" in
+	t)
+		diff -u "$1" "$2" ;;
+	*)
+		case "$test_compare_stdin_file_" in
+		'')
+			test_compare_stdin_file_=/tmp/gittest.$$
+		esac
+		cat "$1" >"$test_compare_stdin_file_.1"
+		cat "$2" >"$test_compare_stdin_file_.2"
+		git diff -u --no-index \
+		"$test_compare_stdin_file_.1" "$test_compare_stdin_file_.2" ;;
+	esac
+}
+
 # Most tests can use the created repository, but some may need to create more.
 # Usage: test_create_repo <directory>
 test_create_repo () {
@@ -288,6 +311,10 @@ test_create_repo () {
 test_done () {
 	trap - exit
 
+	if test -n "$test_compare_stdin_file_"
+	then
+		rm -f "$test_compare_stdin_file_.[12]"
+	fi
 	if test "$test_fixed" != 0
 	then
 		say_color pass "fixed $test_fixed known breakage(s)"
-- 
1.5.4.2.261.g851a5
