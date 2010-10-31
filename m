From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/10] t6022 (renaming merge): chain test commands with &&
Date: Sun, 31 Oct 2010 02:34:44 -0500
Message-ID: <20101031073444.GD11483@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino>
 <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 08:35:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCSRS-0004sv-1B
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 08:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab0JaHe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 03:34:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37675 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0JaHe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 03:34:56 -0400
Received: by iwn10 with SMTP id 10so5663126iwn.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fcW3eYNn5U5iAsHq9b4bSRr4/+fJRURSbzNtQhNdaJ0=;
        b=bF0ClIUD2UypXzGp1fOB+XbldtjhXKi2iTSf3IJKDIDZwkERRIzPwXytdt/WLqlCck
         9SpZAGlEODz4TnNX5H4hYatuZYRZyAqYKMpfIu/Jv1cqWKt5BnMYWStC+g/WMTLnZS98
         UaYSRJILpNH8ohBmPc38teP5xNvdttnPaTJSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gpN6rxHJZg+jskr0BpSBb3Nbco4XR9vKZSEVcG4zptOQ384O2LPTvn+LgAY7llgBt0
         fR/IxM++YPt7Q0ABDOKKiJsLgqQ9J8nm/NNrcW8Emc5jzhxhPgmzciBki/5hkrHRZF0i
         eEhqx8C9dL9tW6Z7ZErIr4cm2bE1EtT+n3Vac=
Received: by 10.42.215.12 with SMTP id hc12mr3441224icb.325.1288510495655;
        Sun, 31 Oct 2010 00:34:55 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id 34sm6442275ibi.14.2010.10.31.00.34.51
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 00:34:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031072640.GA11483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160422>

Using 'return' in an attempt to end a test assertion can have
unpredictable results (probably escaping from test_run_ and breaking
its bookkeeping).  Redo the control flow using helpers like
test_expect_code and git diff --exit-code, so each test assertion can
follow the usual form

	command that should succeed &&
	command that should succeed &&
	command that should succeed &&
	...

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6022-merge-rename.sh |  282 +++++++++++++++-------------------------------
 1 files changed, 92 insertions(+), 190 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index b66544b..83efc7a 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -94,245 +94,147 @@ git checkout master'
 
 test_expect_success 'pull renaming branch into unrenaming one' \
 '
-	git show-branch
-	git pull . white && {
-		echo "BAD: should have conflicted"
-		return 1
-	}
-	git ls-files -s
-	test "$(git ls-files -u B | wc -l)" -eq 3 || {
-		echo "BAD: should have left stages for B"
-		return 1
-	}
-	test "$(git ls-files -s N | wc -l)" -eq 1 || {
-		echo "BAD: should have merged N"
-		return 1
-	}
+	git show-branch &&
+	test_expect_code 1 git pull . white &&
+	git ls-files -s &&
+	git ls-files -u B >b.stages &&
+	test_line_count = 3 b.stages &&
+	git ls-files -s N >n.stages &&
+	test_line_count = 1 n.stages &&
 	sed -ne "/^g/{
 	p
 	q
-	}" B | grep master || {
-		echo "BAD: should have listed our change first"
-		return 1
-	}
-	test "$(git diff white N | wc -l)" -eq 0 || {
-		echo "BAD: should have taken colored branch"
-		return 1
-	}
+	}" B | grep master &&
+	git diff --exit-code white N
 '
 
 test_expect_success 'pull renaming branch into another renaming one' \
 '
-	rm -f B
-	git reset --hard
-	git checkout red
-	git pull . white && {
-		echo "BAD: should have conflicted"
-		return 1
-	}
-	test "$(git ls-files -u B | wc -l)" -eq 3 || {
-		echo "BAD: should have left stages"
-		return 1
-	}
-	test "$(git ls-files -s N | wc -l)" -eq 1 || {
-		echo "BAD: should have merged N"
-		return 1
-	}
+	rm -f B &&
+	git reset --hard &&
+	git checkout red &&
+	test_expect_code 1 git pull . white &&
+	git ls-files -u B >b.stages &&
+	test_line_count = 3 b.stages &&
+	git ls-files -s N >n.stages &&
+	test_line_count = 1 n.stages &&
 	sed -ne "/^g/{
 	p
 	q
-	}" B | grep red || {
-		echo "BAD: should have listed our change first"
-		return 1
-	}
-	test "$(git diff white N | wc -l)" -eq 0 || {
-		echo "BAD: should have taken colored branch"
-		return 1
-	}
+	}" B | grep red &&
+	git diff --exit-code white N
 '
 
 test_expect_success 'pull unrenaming branch into renaming one' \
 '
-	git reset --hard
-	git show-branch
-	git pull . master && {
-		echo "BAD: should have conflicted"
-		return 1
-	}
-	test "$(git ls-files -u B | wc -l)" -eq 3 || {
-		echo "BAD: should have left stages"
-		return 1
-	}
-	test "$(git ls-files -s N | wc -l)" -eq 1 || {
-		echo "BAD: should have merged N"
-		return 1
-	}
+	git reset --hard &&
+	git show-branch &&
+	test_expect_code 1 git pull . master &&
+	git ls-files -u B >b.stages &&
+	test_line_count = 3 b.stages &&
+	git ls-files -s N >n.stages &&
+	test_line_count = 1 n.stages &&
 	sed -ne "/^g/{
 	p
 	q
-	}" B | grep red || {
-		echo "BAD: should have listed our change first"
-		return 1
-	}
-	test "$(git diff white N | wc -l)" -eq 0 || {
-		echo "BAD: should have taken colored branch"
-		return 1
-	}
+	}" B | grep red &&
+	git diff --exit-code white N
 '
 
 test_expect_success 'pull conflicting renames' \
 '
-	git reset --hard
-	git show-branch
-	git pull . blue && {
-		echo "BAD: should have conflicted"
-		return 1
-	}
-	test "$(git ls-files -u A | wc -l)" -eq 1 || {
-		echo "BAD: should have left a stage"
-		return 1
-	}
-	test "$(git ls-files -u B | wc -l)" -eq 1 || {
-		echo "BAD: should have left a stage"
-		return 1
-	}
-	test "$(git ls-files -u C | wc -l)" -eq 1 || {
-		echo "BAD: should have left a stage"
-		return 1
-	}
-	test "$(git ls-files -s N | wc -l)" -eq 1 || {
-		echo "BAD: should have merged N"
-		return 1
-	}
+	git reset --hard &&
+	git show-branch &&
+	test_expect_code 1 git pull . blue &&
+	git ls-files -u A >a.stages &&
+	test_line_count = 1 a.stages &&
+	git ls-files -u B >b.stages &&
+	test_line_count = 1 b.stages &&
+	git ls-files -u C >c.stages &&
+	test_line_count = 1 c.stages &&
+	git ls-files -s N >n.stages &&
+	test_line_count = 1 n.stages &&
 	sed -ne "/^g/{
 	p
 	q
-	}" B | grep red || {
-		echo "BAD: should have listed our change first"
-		return 1
-	}
-	test "$(git diff white N | wc -l)" -eq 0 || {
-		echo "BAD: should have taken colored branch"
-		return 1
-	}
+	}" B | grep red &&
+	git diff --exit-code white N
 '
 
 test_expect_success 'interference with untracked working tree file' '
-
-	git reset --hard
-	git show-branch
-	echo >A this file should not matter
-	git pull . white && {
-		echo "BAD: should have conflicted"
-		return 1
-	}
-	test -f A || {
-		echo "BAD: should have left A intact"
-		return 1
-	}
+	git reset --hard &&
+	git show-branch &&
+	echo >A this file should not matter &&
+	test_expect_code 1 git pull . white &&
+	test_path_is_file A
 '
 
 test_expect_success 'interference with untracked working tree file' '
-
-	git reset --hard
-	git checkout white
-	git show-branch
-	rm -f A
-	echo >A this file should not matter
-	git pull . red && {
-		echo "BAD: should have conflicted"
-		return 1
-	}
-	test -f A || {
-		echo "BAD: should have left A intact"
-		return 1
-	}
+	git reset --hard &&
+	git checkout white &&
+	git show-branch &&
+	rm -f A &&
+	echo >A this file should not matter &&
+	test_expect_code 1 git pull . red &&
+	test_path_is_file A
 '
 
 test_expect_success 'interference with untracked working tree file' '
-
-	git reset --hard
-	rm -f A M
-	git checkout -f master
-	git tag -f anchor
-	git show-branch
-	git pull . yellow || {
-		echo "BAD: should have cleanly merged"
-		return 1
-	}
-	test -f M && {
-		echo "BAD: should have removed M"
-		return 1
-	}
+	git reset --hard &&
+	rm -f A M &&
+	git checkout -f master &&
+	git tag -f anchor &&
+	git show-branch &&
+	git pull . yellow &&
+	test_path_is_missing M &&
 	git reset --hard anchor
 '
 
 test_expect_success 'updated working tree file should prevent the merge' '
-
-	git reset --hard
-	rm -f A M
-	git checkout -f master
-	git tag -f anchor
-	git show-branch
-	echo >>M one line addition
-	cat M >M.saved
-	git pull . yellow && {
-		echo "BAD: should have complained"
-		return 1
-	}
-	test_cmp M M.saved || {
-		echo "BAD: should have left M intact"
-		return 1
-	}
+	git reset --hard &&
+	rm -f A M &&
+	git checkout -f master &&
+	git tag -f anchor &&
+	git show-branch &&
+	echo >>M one line addition &&
+	cat M >M.saved &&
+	test_expect_code 128 git pull . yellow &&
+	test_cmp M M.saved &&
 	rm -f M.saved
 '
 
 test_expect_success 'updated working tree file should prevent the merge' '
-
-	git reset --hard
-	rm -f A M
-	git checkout -f master
-	git tag -f anchor
-	git show-branch
-	echo >>M one line addition
-	cat M >M.saved
-	git update-index M
-	git pull . yellow && {
-		echo "BAD: should have complained"
-		return 1
-	}
-	test_cmp M M.saved || {
-		echo "BAD: should have left M intact"
-		return 1
-	}
+	git reset --hard &&
+	rm -f A M &&
+	git checkout -f master &&
+	git tag -f anchor &&
+	git show-branch &&
+	echo >>M one line addition &&
+	cat M >M.saved &&
+	git update-index M &&
+	test_expect_code 128 git pull . yellow &&
+	test_cmp M M.saved &&
 	rm -f M.saved
 '
 
 test_expect_success 'interference with untracked working tree file' '
-
-	git reset --hard
-	rm -f A M
-	git checkout -f yellow
-	git tag -f anchor
-	git show-branch
-	echo >M this file should not matter
-	git pull . master || {
-		echo "BAD: should have cleanly merged"
-		return 1
-	}
-	test -f M || {
-		echo "BAD: should have left M intact"
-		return 1
-	}
-	git ls-files -s | grep M && {
-		echo "BAD: M must be untracked in the result"
-		return 1
-	}
+	git reset --hard &&
+	rm -f A M &&
+	git checkout -f yellow &&
+	git tag -f anchor &&
+	git show-branch &&
+	echo >M this file should not matter &&
+	git pull . master &&
+	test_path_is_file M &&
+	! {
+		git ls-files -s |
+		grep M
+	} &&
 	git reset --hard anchor
 '
 
 test_expect_success 'merge of identical changes in a renamed file' '
-	rm -f A M N
+	rm -f A M N &&
 	git reset --hard &&
 	git checkout change+rename &&
 	GIT_MERGE_VERBOSITY=3 git merge change | grep "^Skipped B" &&
-- 
1.7.2.3.557.gab647.dirty
