From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] rebase--merge: fix --skip with two conflicts in a row
Date: Mon, 16 Jun 2014 00:01:25 +0000
Message-ID: <ea5a46c7605a181b6726093e04bc882b013fd504.1402876855.git.sandals@crustytoothpaste.net>
References: <20140615223913.GI368384@vauxhall.crustytoothpaste.net>
Cc: Phillip Susi <psusi@ubuntu.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 02:01:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwKMq-0004Ws-7w
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 02:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbaFPABk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 20:01:40 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48364 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752308AbaFPABj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jun 2014 20:01:39 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7D9362808E;
	Mon, 16 Jun 2014 00:01:37 +0000 (UTC)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <20140615223913.GI368384@vauxhall.crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251702>

If git rebase --merge encountered a conflict, --skip would not work if the
next commit also conflicted.  The msgnum file would never be updated with
the new patch number, so no patch would actually be skipped, resulting in an
inescapable loop.

Update the msgnum file's value as the first thing in call_merge.  This also
avoids an "Already applied" message when skipping a commit.  There is no
visible change for the other contexts in which call_merge is invoked, as the
msgnum file's value remains unchanged in those situations.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-rebase--merge.sh    |  5 +++--
 t/t3402-rebase-merge.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 6d77b3c..d3fb67d 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -53,11 +53,12 @@ continue_merge () {
 }
 
 call_merge () {
-	cmt="$(cat "$state_dir/cmt.$1")"
+	msgnum="$1"
+	echo "$msgnum" >"$state_dir/msgnum"
+	cmt="$(cat "$state_dir/cmt.$msgnum")"
 	echo "$cmt" > "$state_dir/current"
 	hd=$(git rev-parse --verify HEAD)
 	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
-	msgnum=$(cat "$state_dir/msgnum")
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
 	eval GITHEAD_$hd='$onto_name'
 	export GITHEAD_$cmt GITHEAD_$hd
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index be8c1d5..5a27ec9 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -33,6 +33,7 @@ test_expect_success setup '
 	tr "[a-z]" "[A-Z]" <original >newfile &&
 	git add newfile &&
 	git commit -a -m"side edits further." &&
+	git branch second-side &&
 
 	tr "[a-m]" "[A-M]" <original >newfile &&
 	rm -f original &&
@@ -41,6 +42,7 @@ test_expect_success setup '
 	git branch test-rebase side &&
 	git branch test-rebase-pick side &&
 	git branch test-reference-pick side &&
+	git branch test-conflicts side &&
 	git checkout -b test-merge side
 '
 
@@ -138,4 +140,17 @@ test_expect_success 'rebase -s funny -Xopt' '
 	test -f funny.was.run
 '
 
+test_expect_success 'rebase --skip works with two conflicts in a row' '
+	git checkout second-side  &&
+	tr "[A-Z]" "[a-z]" <newfile >tmp &&
+	mv tmp newfile &&
+	git commit -a -m"edit conflicting with side" &&
+	tr "[d-f]" "[D-F]" <newfile >tmp &&
+	mv tmp newfile &&
+	git commit -a -m"another edit conflicting with side" &&
+	test_must_fail git rebase --merge test-conflicts &&
+	test_must_fail git rebase --skip &&
+	git rebase --skip
+'
+
 test_done
-- 
2.0.0
