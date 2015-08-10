From: Jeff King <peff@peff.net>
Subject: [PATCH 03/17] t5700: modernize style
Date: Mon, 10 Aug 2015 05:32:30 -0400
Message-ID: <20150810093229.GC30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:32:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjRf-0002lm-JX
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbbHJJcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:32:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:42807 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753768AbbHJJce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:32:34 -0400
Received: (qmail 30745 invoked by uid 102); 10 Aug 2015 09:32:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:32:35 -0500
Received: (qmail 3027 invoked by uid 107); 10 Aug 2015 09:32:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:32:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:32:30 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275569>

The early part of this test is rather old, and does not
follow our usual style guidelines. In particular:

  - the tests liberally chdir, and expect out-of-test "cd"
    commands to return them to a sane state

  - test commands aren't indented at all

  - there are a lot of minor formatting nits, like the
    opening quote of the test block on the wrong line,
    spaces after ">", etc

This patch fixes the style issues, and uses a few helper
functions, along with subshells and "git -C", to avoid
changing the cwd of the main script.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5700-clone-reference.sh | 193 +++++++++++++++++++--------------------------
 1 file changed, 81 insertions(+), 112 deletions(-)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 3e783fc..51d131a 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -10,49 +10,51 @@ base_dir=`pwd`
 
 U=$base_dir/UPLOAD_LOG
 
-test_expect_success 'preparing first repository' \
-'test_create_repo A && cd A &&
-echo first > file1 &&
-git add file1 &&
-git commit -m initial'
-
-cd "$base_dir"
-
-test_expect_success 'preparing second repository' \
-'git clone A B && cd B &&
-echo second > file2 &&
-git add file2 &&
-git commit -m addition &&
-git repack -a -d &&
-git prune'
-
-cd "$base_dir"
-
-test_expect_success 'cloning with reference (-l -s)' \
-'git clone -l -s --reference B A C'
-
-cd "$base_dir"
-
-test_expect_success 'existence of info/alternates' \
-'test_line_count = 2 C/.git/objects/info/alternates'
-
-cd "$base_dir"
+# create a commit in repo $1 with name $2
+commit_in () {
+	(
+		cd "$1" &&
+		echo "$2" >"$2" &&
+		git add "$2" &&
+		git commit -m "$2"
+	)
+}
+
+# check that there are $2 loose objects in repo $1
+test_objcount () {
+	echo "$2" >expect &&
+	git -C "$1" count-objects >actual.raw &&
+	cut -d' ' -f1 <actual.raw >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'preparing first repository' '
+	test_create_repo A &&
+	commit_in A file1
+'
 
-test_expect_success 'pulling from reference' \
-'cd C &&
-git pull ../B master'
+test_expect_success 'preparing second repository' '
+	git clone A B &&
+	commit_in B file2 &&
+	git -C B repack -ad &&
+	git -C B prune
+'
 
-cd "$base_dir"
+test_expect_success 'cloning with reference (-l -s)' '
+	git clone -l -s --reference B A C
+'
 
-test_expect_success 'that reference gets used' \
-'cd C &&
-echo "0 objects, 0 kilobytes" > expected &&
-git count-objects > current &&
-test_cmp expected current'
+test_expect_success 'existence of info/alternates' '
+	test_line_count = 2 C/.git/objects/info/alternates
+'
 
-cd "$base_dir"
+test_expect_success 'pulling from reference' '
+	git -C C pull ../B master
+'
 
-rm -f "$U.D"
+test_expect_success 'that reference gets used' '
+	test_objcount C 0
+'
 
 test_expect_success 'cloning with reference (no -l -s)' '
 	GIT_TRACE_PACKET=$U.D git clone --reference B "file://$(pwd)/A" D
@@ -63,95 +65,64 @@ test_expect_success 'fetched no objects' '
 	! grep " want" "$U.D"
 '
 
-cd "$base_dir"
-
-test_expect_success 'existence of info/alternates' \
-'test_line_count = 1 D/.git/objects/info/alternates'
-
-cd "$base_dir"
-
-test_expect_success 'pulling from reference' \
-'cd D && git pull ../B master'
-
-cd "$base_dir"
-
-test_expect_success 'that reference gets used' \
-'cd D && echo "0 objects, 0 kilobytes" > expected &&
-git count-objects > current &&
-test_cmp expected current'
-
-cd "$base_dir"
+test_expect_success 'existence of info/alternates' '
+	test_line_count = 1 D/.git/objects/info/alternates
+'
 
-test_expect_success 'updating origin' \
-'cd A &&
-echo third > file3 &&
-git add file3 &&
-git commit -m update &&
-git repack -a -d &&
-git prune'
+test_expect_success 'pulling from reference' '
+	git -C D pull ../B master
+'
 
-cd "$base_dir"
+test_expect_success 'that reference gets used' '
+	test_objcount D 0
+'
 
-test_expect_success 'pulling changes from origin' \
-'cd C &&
-git pull origin'
+test_expect_success 'updating origin' '
+	commit_in A file3 &&
+	git -C A repack -ad &&
+	git -C A prune
+'
 
-cd "$base_dir"
+test_expect_success 'pulling changes from origin' '
+	git -C C pull origin
+'
 
 # the 2 local objects are commit and tree from the merge
-test_expect_success 'that alternate to origin gets used' \
-'cd C &&
-echo "2 objects" > expected &&
-git count-objects | cut -d, -f1 > current &&
-test_cmp expected current'
-
-cd "$base_dir"
-
-test_expect_success 'pulling changes from origin' \
-'cd D &&
-git pull origin'
+test_expect_success 'that alternate to origin gets used' '
+	test_objcount C 2
+'
 
-cd "$base_dir"
+test_expect_success 'pulling changes from origin' '
+	git -C D pull origin
+'
 
 # the 5 local objects are expected; file3 blob, commit in A to add it
 # and its tree, and 2 are our tree and the merge commit.
-test_expect_success 'check objects expected to exist locally' \
-'cd D &&
-echo "5 objects" > expected &&
-git count-objects | cut -d, -f1 > current &&
-test_cmp expected current'
-
-cd "$base_dir"
-
-test_expect_success 'preparing alternate repository #1' \
-'test_create_repo F && cd F &&
-echo first > file1 &&
-git add file1 &&
-git commit -m initial'
-
-cd "$base_dir"
-
-test_expect_success 'cloning alternate repo #2 and adding changes to repo #1' \
-'git clone F G && cd F &&
-echo second > file2 &&
-git add file2 &&
-git commit -m addition'
-
-cd "$base_dir"
+test_expect_success 'check objects expected to exist locally' '
+	test_objcount D 5
+'
 
-test_expect_success 'cloning alternate repo #1, using #2 as reference' \
-'git clone --reference G F H'
+test_expect_success 'preparing alternate repository #1' '
+	test_create_repo F &&
+	commit_in F file1
+'
 
-cd "$base_dir"
+test_expect_success 'cloning alternate repo #2 and adding changes to repo #1' '
+	git clone F G &&
+	commit_in F file2
+'
 
-test_expect_success 'cloning with reference being subset of source (-l -s)' \
-'git clone -l -s --reference A B E'
+test_expect_success 'cloning alternate repo #1, using #2 as reference' '
+	git clone --reference G F H
+'
 
-cd "$base_dir"
+test_expect_success 'cloning with reference being subset of source (-l -s)' '
+	git clone -l -s --reference A B E
+'
 
 test_expect_success 'clone with reference from a tagged repository' '
 	(
-		cd A && git tag -a -m 'tagged' HEAD
+		cd A && git tag -a -m tagged HEAD
 	) &&
 	git clone --reference=A A I
 '
@@ -168,8 +139,6 @@ test_expect_success 'prepare branched repository' '
 	)
 '
 
-rm -f "$U.K"
-
 test_expect_success 'fetch with incomplete alternates' '
 	git init K &&
 	echo "$base_dir/A/.git/objects" >K/.git/objects/info/alternates &&
-- 
2.5.0.414.g670f2a4
