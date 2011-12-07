From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] t7501 (commit): modernize style
Date: Wed, 7 Dec 2011 08:50:23 -0600
Message-ID: <20111207145022.GD30157@elie.hsd1.il.comcast.net>
References: <4EDDD0E4.6040003@st.com>
 <87fwgxwvn9.fsf@gmail.com>
 <7vobvlfowk.fsf@alter.siamese.dyndns.org>
 <7vk469fm9j.fsf@alter.siamese.dyndns.org>
 <20111207144217.GA30157@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vijay Lakshminarayanan <laksvij@gmail.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 15:50:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYIpN-0000ON-QL
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 15:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273Ab1LGOu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 09:50:29 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59554 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab1LGOu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 09:50:28 -0500
Received: by iakc1 with SMTP id c1so1033533iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 06:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GA0QdzmzABeR9NAne/p4rpmzC8LbQuZ/+RvfpvIilzU=;
        b=EBNOmLLpAEST61/lfgB8TYY7Mx/JwymzdX9SrwxyhyCfo3g88Ut9gu+PjmMuqRwiuk
         jUCZjYFp/WiW7tOi0ISdPrTyF+nlCkl6fBZlRYu15LZyev4U+l6QICS4r36cxRGZpfNQ
         +RHpesXEvbY6TpOT4aMyWlqUttOVOzGgJ9l2s=
Received: by 10.231.80.17 with SMTP id r17mr4373783ibk.62.1323269428050;
        Wed, 07 Dec 2011 06:50:28 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id v18sm7601936ibh.4.2011.12.07.06.50.27
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 06:50:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111207144217.GA30157@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186460>

Put the opening quote starting each test on the same line as the
test_expect_* invocation.  While at it:

- guard commands that prepare test input for individual tests in
  the same test_expect_success, so their scope is clearer and
  errors at that stage can be caught;
- use the compare_diff_patch helper function when comparing patches;
- use single-quotes in preference to double-quotes and <<\EOF in
  preference to <<EOF, to save readers the trouble of looking for
  variable interpolations;
- lift the setting of the $author variable used throughout the
  test script to the top of the test script;
- include "setup" in the titles of test assertions that prepare for
  later ones to make it more obvious which tests can be skipped;
- use test_must_fail instead of "if ...; then:; else false; fi",
  for clarity and to catch segfaults when they happen;
- break up some pipelines into separate commands that read and write
  to ordinary files, and test the exit status at each stage;
- chain commands with &&.  Breaks in a test assertion's && chain can
  potentially hide failures from earlier commands in the chain;
- combine two initial tests that do not make as much sense alone.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Miscellaneous cleanups.

 t/t7501-commit.sh |  278 ++++++++++++++++++++++++++---------------------------
 1 files changed, 136 insertions(+), 142 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 9c507b08..bf025df6 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -8,39 +8,39 @@
 
 test_description='git commit'
 . ./test-lib.sh
+. "$TEST_DIRECTORY/diff-lib.sh"
+
+author='The Real Author <someguy@his.email.org>'
 
 test_tick
 
-test_expect_success \
-	"initial status" \
-	"echo 'bongo bongo' >file &&
-	 git add file"
-
-test_expect_success "Constructing initial commit" '
+test_expect_success 'initial status' '
+	echo bongo bongo >file &&
+	git add file &&
 	git status >actual &&
 	test_i18ngrep "Initial commit" actual
 '
 
-test_expect_success \
-	"fail initial amend" \
-	"test_must_fail git commit --amend"
+test_expect_success 'fail initial amend' '
+	test_must_fail git commit --amend
+'
 
-test_expect_success \
-	"initial commit" \
-	"git commit -m initial"
+test_expect_success 'setup: initial commit' '
+	git commit -m initial
+'
 
-test_expect_success \
-	"invalid options 1" \
-	"test_must_fail git commit -m foo -m bar -F file"
+test_expect_success '-m and -F do not mix' '
+	test_must_fail git commit -m foo -m bar -F file
+'
 
-test_expect_success \
-	"invalid options 2" \
-	"test_must_fail git commit -C HEAD -m illegal"
+test_expect_success '-m and -C do not mix' '
+	test_must_fail git commit -C HEAD -m illegal
+'
 
-test_expect_success \
-	"using paths with -a" \
-	"echo King of the bongo >file &&
-	test_must_fail git commit -m foo -a file"
+test_expect_success 'paths and -a do not mix' '
+	echo King of the bongo >file &&
+	test_must_fail git commit -m foo -a file
+'
 
 test_expect_success PERL 'can use paths with --interactive' '
 	echo bong-o-bong >file &&
@@ -50,120 +50,123 @@ test_expect_success PERL 'can use paths with --interactive' '
 	git reset --hard HEAD^
 '
 
-test_expect_success \
-	"using invalid commit with -C" \
-	"test_must_fail git commit -C bogus"
-
-test_expect_success \
-	"testing nothing to commit" \
-	"test_must_fail git commit -m initial"
-
-test_expect_success \
-	"next commit" \
-	"echo 'bongo bongo bongo' >file && \
-	 git commit -m next -a"
-
-test_expect_success \
-	"commit message from non-existing file" \
-	"echo 'more bongo: bongo bongo bongo bongo' >file && \
-	 test_must_fail git commit -F gah -a"
-
-# Empty except stray tabs and spaces on a few lines.
-sed -e 's/@$//' >msg <<EOF
-		@
-
-  @
-Signed-off-by: hula
-EOF
-test_expect_success \
-	"empty commit message" \
-	"test_must_fail git commit -F msg -a"
-
-test_expect_success \
-	"commit message from file" \
-	"echo 'this is the commit message, coming from a file' >msg && \
-	 git commit -F msg -a"
-
-cat >editor <<\EOF
-#!/bin/sh
-sed -e "s/a file/an amend commit/g" < "$1" > "$1-"
-mv "$1-" "$1"
-EOF
-chmod 755 editor
-
-test_expect_success \
-	"amend commit" \
-	"EDITOR=./editor git commit --amend"
-
-test_expect_success \
-	"passing -m and -F" \
-	"echo 'enough with the bongos' >file && \
-	 test_must_fail git commit -F msg -m amending ."
-
-test_expect_success \
-	"using message from other commit" \
-	"git commit -C HEAD^ ."
-
-cat >editor <<\EOF
-#!/bin/sh
-sed -e "s/amend/older/g"  < "$1" > "$1-"
-mv "$1-" "$1"
-EOF
-chmod 755 editor
-
-test_expect_success \
-	"editing message from other commit" \
-	"echo 'hula hula' >file && \
-	 EDITOR=./editor git commit -c HEAD^ -a"
-
-test_expect_success \
-	"message from stdin" \
-	"echo 'silly new contents' >file && \
-	 echo commit message from stdin | git commit -F - -a"
-
-test_expect_success \
-	"overriding author from command line" \
-	"echo 'gak' >file && \
-	 git commit -m 'author' --author 'Rubber Duck <rduck@convoy.org>' -a >output 2>&1"
-
-test_expect_success \
-	"commit --author output mentions author" \
-	"grep Rubber.Duck output"
-
-test_expect_success PERL \
-	"interactive add" \
-	"echo 7 | git commit --interactive | grep 'What now'"
-
-test_expect_success PERL \
-	"commit --interactive doesn't change index if editor aborts" \
-	"echo zoo >file &&
+test_expect_success 'using invalid commit with -C' '
+	test_must_fail git commit -C bogus
+'
+
+test_expect_success 'nothing to commit' '
+	test_must_fail git commit -m initial
+'
+
+test_expect_success 'setup: non-initial commit' '
+	echo bongo bongo bongo >file &&
+	git commit -m next -a
+'
+
+test_expect_success 'commit message from non-existing file' '
+	echo more bongo: bongo bongo bongo bongo >file &&
+	test_must_fail git commit -F gah -a
+'
+
+test_expect_success 'empty commit message' '
+	# Empty except stray tabs and spaces on a few lines.
+	sed -e "s/@//g" >msg <<-\EOF &&
+		@		@
+		@@
+		@  @
+		@Signed-off-by: hula@
+	EOF
+	test_must_fail git commit -F msg -a
+'
+
+test_expect_success 'setup: commit message from file' '
+	echo this is the commit message, coming from a file >msg &&
+	git commit -F msg -a
+'
+
+test_expect_success 'amend commit' '
+	cat >editor <<-\EOF &&
+	#!/bin/sh
+	sed -e "s/a file/an amend commit/g" < "$1" > "$1-"
+	mv "$1-" "$1"
+	EOF
+	chmod 755 editor &&
+	EDITOR=./editor git commit --amend
+'
+
+test_expect_success '-m and -F do not mix' '
+	echo enough with the bongos >file &&
+	test_must_fail git commit -F msg -m amending .
+'
+
+test_expect_success 'using message from other commit' '
+	git commit -C HEAD^ .
+'
+
+test_expect_success 'editing message from other commit' '
+	cat >editor <<-\EOF &&
+	#!/bin/sh
+	sed -e "s/amend/older/g"  < "$1" > "$1-"
+	mv "$1-" "$1"
+	EOF
+	chmod 755 editor &&
+	echo hula hula >file &&
+	EDITOR=./editor git commit -c HEAD^ -a
+'
+
+test_expect_success 'message from stdin' '
+	echo silly new contents >file &&
+	echo commit message from stdin |
+	git commit -F - -a
+'
+
+test_expect_success 'overriding author from command line' '
+	echo gak >file &&
+	git commit -m author \
+		--author "Rubber Duck <rduck@convoy.org>" -a >output 2>&1 &&
+	grep Rubber.Duck output
+'
+
+test_expect_success PERL 'interactive add' '
+	echo 7 |
+	git commit --interactive |
+	grep "What now"
+'
+
+test_expect_success PERL "commit --interactive doesn't change index if editor aborts" '
+	echo zoo >file &&
 	test_must_fail git diff --exit-code >diff1 &&
-	(echo u ; echo '*' ; echo q) |
-	(EDITOR=: && export EDITOR &&
-	 test_must_fail git commit --interactive) &&
+	(echo u ; echo "*" ; echo q) |
+	(
+		EDITOR=: &&
+		export EDITOR &&
+		test_must_fail git commit --interactive
+	) &&
 	git diff >diff2 &&
-	test_cmp diff1 diff2"
+	compare_diff_patch diff1 diff2
+'
 
-cat >editor <<\EOF
-#!/bin/sh
-sed -e "s/good/bad/g" < "$1" > "$1-"
-mv "$1-" "$1"
-EOF
-chmod 755 editor
+test_expect_success 'editor not invoked if -F is given' '
+	cat >editor <<-\EOF &&
+	#!/bin/sh
+	sed -e s/good/bad/g <"$1" >"$1-"
+	mv "$1-" "$1"
+	EOF
+	chmod 755 editor &&
 
-cat >msg <<EOF
-A good commit message.
-EOF
+	echo A good commit message. >msg &&
+	echo moo >file &&
 
-test_expect_success \
-	'editor not invoked if -F is given' '
-	 echo "moo" >file &&
-	 EDITOR=./editor git commit -a -F msg &&
-	 git show -s --pretty=format:"%s" | grep -q good &&
-	 echo "quack" >file &&
-	 echo "Another good message." | EDITOR=./editor git commit -a -F - &&
-	 git show -s --pretty=format:"%s" | grep -q good
-	 '
+	EDITOR=./editor git commit -a -F msg &&
+	git show -s --pretty=format:%s >subject &&
+	grep -q good subject &&
+
+	echo quack >file &&
+	echo Another good message. |
+	EDITOR=./editor git commit -a -F - &&
+	git show -s --pretty=format:%s >subject &&
+	grep -q good subject
+'
 
 test_expect_success 'partial commit that involves removal (1)' '
 
@@ -197,7 +200,6 @@ test_expect_success 'partial commit that involves removal (3)' '
 
 '
 
-author="The Real Author <someguy@his.email.org>"
 test_expect_success 'amend commit to fix author' '
 
 	oldtick=$GIT_AUTHOR_DATE &&
@@ -326,7 +328,6 @@ test_expect_success 'multiple -m' '
 
 '
 
-author="The Real Author <someguy@his.email.org>"
 test_expect_success 'amend commit to fix author' '
 
 	oldtick=$GIT_AUTHOR_DATE &&
@@ -353,15 +354,8 @@ test_expect_success 'git commit <file> with dirty index' '
 
 test_expect_success 'same tree (single parent)' '
 
-	git reset --hard
-
-	if git commit -m empty
-	then
-		echo oops -- should have complained
-		false
-	else
-		: happy
-	fi
+	git reset --hard &&
+	test_must_fail git commit -m empty
 
 '
 
-- 
1.7.8.rc3
