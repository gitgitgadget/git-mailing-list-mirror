From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] t1020: Get rid of 'cd "$HERE"' at the start of each test
Date: Tue, 07 Sep 2010 12:29:20 +0200
Message-ID: <4C861400.2030901@web.de>
References: <4C85357A.8090000@web.de> <7vhbi2tqd0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 12:29:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsvR5-0001Ze-OU
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 12:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452Ab0IGK3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 06:29:34 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35157 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212Ab0IGK3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 06:29:22 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id E327116F9ACDC;
	Tue,  7 Sep 2010 12:29:20 +0200 (CEST)
Received: from [93.246.37.179] (helo=[192.168.178.29])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OsvQW-0005Eh-00; Tue, 07 Sep 2010 12:29:20 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <7vhbi2tqd0.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18xDFvkaEVx0TtdMynhNruY1/XWS5L+9rOl9sMw
	jBIQZg3x1+bbAliDyixdImEduSwJTQ/qKtXfFys1Dg6DcaDwKz
	Hy5xG0d0GmcHgRupG9wQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155692>

To achieve that, all cd commands which weren't inside a subshell had to
be put into a new one.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 07.09.2010 01:16, schrieb Junio C Hamano:
> If we were to do this, shouldn't we be able to lose 'cd "$HERE"' at the
> beginning of each test?  The test after this one does "cd dir" without
> even coming back up and relies on the next one to go back itself,

You are right, patch included. I had to introduce some new subshells
for that and used the new formatting proposed by Jonathan (but I didn't
touch the one introduced by my earlier patch which is reformatted by
Jonathan's "[PATCH 1/7] tests: subshell indentation stylefix", so both
patches won't conflict.


> suggesting that grepping for 'cd ..' may not be sufficient, depending on
> what we are trying to fix.

Yeah, I knew this would only show a part of the problems. But you have
to start somewhere, no? :-)
(My first intention was to systematically search for missing &&, as
those really can be nasty, but my script-fu was not up to that task)


> If we were to insist that no matter how an individual test fail, the test
> that follows it must start in a known location (namely, $TRASH), then we
> might want to use something like the attached patch.  On the other hand,
> we might want to be lenient to a test suite whose one test moves around
> and the test that follows such a test knows that, and also anticipates
> that the previous one _can_ fail and tries recover from that failure (e.g.
> use of 'cd "$HERE"' in the test that follows the above one.

I think we should force that each test finishes somewhere inside $TRASH,
but not necessarily at the top level.

 t/t1020-subdirectory.sh |   91 ++++++++++++++++++++++++++---------------------
 1 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index c36157a..0eb4488 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -16,12 +16,10 @@ test_expect_success setup '
 	cp one original.one &&
 	cp dir/two original.two
 '
-HERE=`pwd`
 LF='
 '

 test_expect_success 'update-index and ls-files' '
-	cd "$HERE" &&
 	git update-index --add one &&
 	case "`git ls-files`" in
 	one) echo pass one ;;
@@ -41,20 +39,20 @@ test_expect_success 'update-index and ls-files' '
 '

 test_expect_success 'cat-file' '
-	cd "$HERE" &&
 	two=`git ls-files -s dir/two` &&
 	two=`expr "$two" : "[0-7]* \\([0-9a-f]*\\)"` &&
 	echo "$two" &&
 	git cat-file -p "$two" >actual &&
 	cmp dir/two actual &&
-	cd dir &&
-	git cat-file -p "$two" >actual &&
-	cmp two actual
+	(
+		cd dir &&
+		git cat-file -p "$two" >actual &&
+		cmp two actual
+	)
 '
 rm -f actual dir/actual

 test_expect_success 'diff-files' '
-	cd "$HERE" &&
 	echo a >>one &&
 	echo d >>dir/two &&
 	case "`git diff-files --name-only`" in
@@ -62,77 +60,88 @@ test_expect_success 'diff-files' '
 	*) echo bad top; exit 1 ;;
 	esac &&
 	# diff should not omit leading paths
-	cd dir &&
-	case "`git diff-files --name-only`" in
-	dir/two"$LF"one) echo pass subdir ;;
-	*) echo bad subdir; exit 1 ;;
-	esac &&
-	case "`git diff-files --name-only .`" in
-	dir/two) echo pass subdir limited ;;
-	*) echo bad subdir limited; exit 1 ;;
-	esac
+	(
+		cd dir &&
+		case "`git diff-files --name-only`" in
+		dir/two"$LF"one) echo pass subdir ;;
+		*) echo bad subdir; exit 1 ;;
+		esac &&
+		case "`git diff-files --name-only .`" in
+		dir/two) echo pass subdir limited ;;
+		*) echo bad subdir limited; exit 1 ;;
+		esac
+	)
 '

 test_expect_success 'write-tree' '
-	cd "$HERE" &&
 	top=`git write-tree` &&
 	echo $top &&
-	cd dir &&
-	sub=`git write-tree` &&
-	echo $sub &&
-	test "z$top" = "z$sub"
+	(
+		cd dir &&
+		sub=`git write-tree` &&
+		echo $sub &&
+		test "z$top" = "z$sub"
+	)
 '

 test_expect_success 'checkout-index' '
-	cd "$HERE" &&
 	git checkout-index -f -u one &&
 	cmp one original.one &&
-	cd dir &&
-	git checkout-index -f -u two &&
-	cmp two ../original.two
+	(
+		cd dir &&
+		git checkout-index -f -u two &&
+		cmp two ../original.two
+	)
 '

 test_expect_success 'read-tree' '
-	cd "$HERE" &&
 	rm -f one dir/two &&
 	tree=`git write-tree` &&
 	git read-tree --reset -u "$tree" &&
 	cmp one original.one &&
 	cmp dir/two original.two &&
-	cd dir &&
-	rm -f two &&
-	git read-tree --reset -u "$tree" &&
-	cmp two ../original.two &&
-	cmp ../one ../original.one
+	(
+		cd dir &&
+		rm -f two &&
+		git read-tree --reset -u "$tree" &&
+		cmp two ../original.two &&
+		cmp ../one ../original.one
+	)
 '

 test_expect_success 'no file/rev ambiguity check inside .git' '
-	cd "$HERE" &&
 	git commit -a -m 1 &&
-	cd "$HERE"/.git &&
-	git show -s HEAD
+	(
+		cd .git &&
+		git show -s HEAD
+	)
 '

 test_expect_success 'no file/rev ambiguity check inside a bare repo' '
-	cd "$HERE" &&
 	git clone -s --bare .git foo.git &&
-	cd foo.git && GIT_DIR=. git show -s HEAD
+	(
+		cd foo.git &&
+		GIT_DIR=. git show -s HEAD
+	)
 '

 # This still does not work as it should...
 : test_expect_success 'no file/rev ambiguity check inside a bare repo' '
-	cd "$HERE" &&
 	git clone -s --bare .git foo.git &&
-	cd foo.git && git show -s HEAD
+	(
+		cd foo.git &&
+		git show -s HEAD
+	)
 '

 test_expect_success SYMLINKS 'detection should not be fooled by a symlink' '
-	cd "$HERE" &&
 	rm -fr foo.git &&
 	git clone -s .git another &&
 	ln -s another yetanother &&
-	cd yetanother/.git &&
-	git show -s HEAD
+	(
+		cd yetanother/.git &&
+		git show -s HEAD
+	)
 '

 test_done
-- 
1.7.3.rc0.182.g5433f
