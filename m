From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 1/2] t1200: cleanup and modernize test style
Date: Wed,  4 Nov 2009 22:33:52 -0800
Message-ID: <1257402833-4741-1-git-send-email-bebarino@gmail.com>
References: <1257282328-6491-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 07:34:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5vv9-0007tH-Vq
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 07:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbZKEGdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 01:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbZKEGdx
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 01:33:53 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:40586 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbZKEGdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 01:33:52 -0500
Received: by yxe17 with SMTP id 17so7054367yxe.33
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 22:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0p5n1JMawtMwS/Kc744LgcLlDQj6hVoGvhOYwLOUrs8=;
        b=lpTOGdlXeOZ9WwfooOE13cCuXDCZramQ1sTS+VNYlhos86TI+fjvNMpmfoDSOPPpGz
         gU3O02mqd9GwOVBVuAm+eeYEdfkZF98QRhKQnPrFYOxQLJ/lwEf8SDS7OXX2YR/ZabN6
         13FbeRrwQX0XaH/w7gQYtxF61IHTOAbkptn8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KH9MX15oPFrVB7SQQaqDFWNFWSlMQTMjIdxcbtSj170XNULeEDduiDPeBM6MkFe/X4
         Vmfy9tlnWz221d53676OxaM4CNwUZ3p7RY/wrGt0othZwlq6tgcispxtKWywzgHzgok9
         ZnvzEvo7BSD4MxLEyB/oYkg9DlDVqV6k6ddvg=
Received: by 10.150.129.13 with SMTP id b13mr4434377ybd.304.1257402837599;
        Wed, 04 Nov 2009 22:33:57 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 5sm663946ywd.53.2009.11.04.22.33.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 22:33:56 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Wed, 04 Nov 2009 22:33:53 -0800
X-Mailer: git-send-email 1.6.5.2.143.g8cc62
In-Reply-To: <1257282328-6491-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132201>

Many parts of the tests in t1200 are run outside the test harness,
circumventing the usefulness of -v and spewing messages to stdout when
-v isn't used. Fix these problems by modernizing the test a bit.

An extra test_done has existed since commit 6a74642 (git-commit --amend:
two fixes., 2006-04-20) leading to the last 6 tests never being run.
Remove it and teach the resolve merge test about fast-forward merges.
Also fix the last test's incorrect find command and prune before
checking for unpacked objects so we remove the unreachable conflict-marked
blob.

Finally, we remove the TODO notes, because fetch, push, and clone have
their own tests since t1200 was introduced and we're not going to add
them here 4 years later.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

 Since v1:
  * Fixed the last test

 t/t1200-tutorial.sh |  134 +++++++++++++++++++++++++++++----------------------
 1 files changed, 76 insertions(+), 58 deletions(-)

diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 67e637b..c57c9d5 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -7,14 +7,18 @@ test_description='A simple turial in the form of a test case'
 
 . ./test-lib.sh
 
-echo "Hello World" > hello
-echo "Silly example" > example
+test_expect_success 'blob'  '
+	echo "Hello World" > hello &&
+	echo "Silly example" > example &&
 
-git update-index --add hello example
+	git update-index --add hello example &&
 
-test_expect_success 'blob' "test blob = \"$(git cat-file -t 557db03)\""
+	test blob = "$(git cat-file -t 557db03)"
+'
 
-test_expect_success 'blob 557db03' "test \"Hello World\" = \"$(git cat-file blob 557db03)\""
+test_expect_success 'blob 557db03' '
+	test "Hello World" = "$(git cat-file blob 557db03)"
+'
 
 echo "It's a new day for git" >>hello
 cat > diff.expect << EOF
@@ -26,25 +30,33 @@ index 557db03..263414f 100644
  Hello World
 +It's a new day for git
 EOF
-git diff-files -p > diff.output
-test_expect_success 'git diff-files -p' 'cmp diff.expect diff.output'
-git diff > diff.output
-test_expect_success 'git diff' 'cmp diff.expect diff.output'
-
-tree=$(git write-tree 2>/dev/null)
 
-test_expect_success 'tree' "test 8988da15d077d4829fc51d8544c097def6644dbb = $tree"
+test_expect_success 'git diff-files -p' '
+	git diff-files -p > diff.output &&
+	cmp diff.expect diff.output
+'
 
-output="$(echo "Initial commit" | git commit-tree $(git write-tree) 2>&1 > .git/refs/heads/master)"
+test_expect_success 'git diff' '
+	git diff > diff.output &&
+	cmp diff.expect diff.output
+'
 
-git diff-index -p HEAD > diff.output
-test_expect_success 'git diff-index -p HEAD' 'cmp diff.expect diff.output'
+test_expect_success 'tree' '
+	tree=$(git write-tree 2>/dev/null)
+	test 8988da15d077d4829fc51d8544c097def6644dbb = $tree
+'
 
-git diff HEAD > diff.output
-test_expect_success 'git diff HEAD' 'cmp diff.expect diff.output'
+test_expect_success 'git diff-index -p HEAD' '
+	echo "Initial commit" | \
+	git commit-tree $(git write-tree) 2>&1 > .git/refs/heads/master &&
+	git diff-index -p HEAD > diff.output &&
+	cmp diff.expect diff.output
+'
 
-#rm hello
-#test_expect_success 'git read-tree --reset HEAD' "git read-tree --reset HEAD ; test \"hello: needs update\" = \"$(git update-index --refresh)\""
+test_expect_success 'git diff HEAD' '
+	git diff HEAD > diff.output &&
+	cmp diff.expect diff.output
+'
 
 cat > whatchanged.expect << EOF
 commit VARIABLE
@@ -69,39 +81,45 @@ index 0000000..557db03
 +Hello World
 EOF
 
-git whatchanged -p --root | \
-	sed -e "1s/^\(.\{7\}\).\{40\}/\1VARIABLE/" \
+test_expect_success 'git whatchanged -p --root' '
+	git whatchanged -p --root | \
+		sed -e "1s/^\(.\{7\}\).\{40\}/\1VARIABLE/" \
 		-e "2,3s/^\(.\{8\}\).*$/\1VARIABLE/" \
-> whatchanged.output
-test_expect_success 'git whatchanged -p --root' 'cmp whatchanged.expect whatchanged.output'
-
-git tag my-first-tag
-test_expect_success 'git tag my-first-tag' 'cmp .git/refs/heads/master .git/refs/tags/my-first-tag'
+	> whatchanged.output &&
+	cmp whatchanged.expect whatchanged.output
+'
 
-# TODO: test git clone
+test_expect_success 'git tag my-first-tag' '
+	git tag my-first-tag &&
+	cmp .git/refs/heads/master .git/refs/tags/my-first-tag
+'
 
-git checkout -b mybranch
-test_expect_success 'git checkout -b mybranch' 'cmp .git/refs/heads/master .git/refs/heads/mybranch'
+test_expect_success 'git checkout -b mybranch' '
+	git checkout -b mybranch &&
+	cmp .git/refs/heads/master .git/refs/heads/mybranch
+'
 
 cat > branch.expect <<EOF
   master
 * mybranch
 EOF
 
-git branch > branch.output
-test_expect_success 'git branch' 'cmp branch.expect branch.output'
+test_expect_success 'git branch' '
+	git branch > branch.output &&
+	cmp branch.expect branch.output
+'
 
-git checkout mybranch
-echo "Work, work, work" >>hello
-git commit -m 'Some work.' -i hello
+test_expect_success 'git resolve now fails' '
+	git checkout mybranch &&
+	echo "Work, work, work" >>hello &&
+	git commit -m "Some work." -i hello &&
 
-git checkout master
+	git checkout master &&
 
-echo "Play, play, play" >>hello
-echo "Lots of fun" >>example
-git commit -m 'Some fun.' -i hello example
+	echo "Play, play, play" >>hello &&
+	echo "Lots of fun" >>example &&
+	git commit -m "Some fun." -i hello example &&
 
-test_expect_success 'git resolve now fails' '
 	test_must_fail git merge -m "Merge work in mybranch" mybranch
 '
 
@@ -112,10 +130,6 @@ Play, play, play
 Work, work, work
 EOF
 
-git commit -m 'Merged "mybranch" changes.' -i hello
-
-test_done
-
 cat > show-branch.expect << EOF
 * [master] Merged "mybranch" changes.
  ! [mybranch] Some work.
@@ -124,21 +138,26 @@ cat > show-branch.expect << EOF
 *+ [mybranch] Some work.
 EOF
 
-git show-branch --topo-order master mybranch > show-branch.output
-test_expect_success 'git show-branch' 'cmp show-branch.expect show-branch.output'
-
-git checkout mybranch
+test_expect_success 'git show-branch' '
+	git commit -m "Merged \"mybranch\" changes." -i hello &&
+	git show-branch --topo-order master mybranch > show-branch.output &&
+	cmp show-branch.expect show-branch.output
+'
 
 cat > resolve.expect << EOF
-Updating from VARIABLE to VARIABLE
+Updating VARIABLE..VARIABLE
+Fast forward (no commit created; -m option ignored)
  example |    1 +
  hello   |    1 +
  2 files changed, 2 insertions(+), 0 deletions(-)
 EOF
 
-git merge -s "Merge upstream changes." master | \
-	sed -e "1s/[0-9a-f]\{40\}/VARIABLE/g" >resolve.output
-test_expect_success 'git resolve' 'cmp resolve.expect resolve.output'
+test_expect_success 'git resolve' '
+	git checkout mybranch &&
+	git merge -m "Merge upstream changes." master | \
+		sed -e "1s/[0-9a-f]\{7\}/VARIABLE/g" >resolve.output &&
+	cmp resolve.expect resolve.output
+'
 
 cat > show-branch2.expect << EOF
 ! [master] Merged "mybranch" changes.
@@ -147,17 +166,16 @@ cat > show-branch2.expect << EOF
 -- [master] Merged "mybranch" changes.
 EOF
 
-git show-branch --topo-order master mybranch > show-branch2.output
-test_expect_success 'git show-branch' 'cmp show-branch2.expect show-branch2.output'
-
-# TODO: test git fetch
-
-# TODO: test git push
+test_expect_success 'git show-branch (part 2)' '
+	git show-branch --topo-order master mybranch > show-branch2.output &&
+	cmp show-branch2.expect show-branch2.output
+'
 
 test_expect_success 'git repack' 'git repack'
 test_expect_success 'git prune-packed' 'git prune-packed'
 test_expect_success '-> only packed objects' '
-	! find -type f .git/objects/[0-9a-f][0-9a-f]
+	git prune && # Remove conflict marked blobs
+	! find .git/objects/[0-9a-f][0-9a-f] -type f
 '
 
 test_done
-- 
1.6.5.2.143.g8cc62
