From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 2/2] tests: Remove some direct access to .git/logs
Date: Mon, 27 Jul 2015 18:57:08 -0400
Message-ID: <1438037829-2642-2-git-send-email-dturner@twopensource.com>
References: <1438037829-2642-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 00:57:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJrKs-0000LM-Ir
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 00:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbbG0W51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 18:57:27 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33549 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbbG0W51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 18:57:27 -0400
Received: by qged69 with SMTP id d69so63311880qge.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 15:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DvBIkalbelA34AgHBVXV3M5XJ+sbClMxWk+E1bNoG9E=;
        b=QU8Z5jLzGWLnvqF/5Vcw+TOx9FkJZmWsEUqwA3yfEJMCEjB2BuWrLNUJNjzKnHq8K4
         hyw46b7zJBvHFMbiZHX4yvoviEbFUTahi2yngK6xF0ugp+A9sBMAtlIz5vOwbGfTdD6N
         mNApOmnnzKCREYnth89aeqSNstQOd4zkwthxPSrD/xz322gvGm/TJsC/RZYqiqLryjHI
         +rarIAj/ipTqcoeMhcicy4OMfZnAViQLjS0jhMegZ8PpE2sW7caJOa4FhqrJlbn9OEYO
         iEJDr86QAdsXk/5BfvWOLwOSRm5ERpsu9wTZRLn2io0prBp5bfLkN5zAf1WvLvOS7lyp
         Wnuw==
X-Gm-Message-State: ALoCoQmeF1n+MRYnm5a1x6/5VBo3NVctb+asHIunErPJsOFYXIRE3bxCzivWbfmdDwYnaeykMlVu
X-Received: by 10.140.86.137 with SMTP id p9mr44984788qgd.89.1438037846147;
        Mon, 27 Jul 2015 15:57:26 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id k135sm10054542qhc.31.2015.07.27.15.57.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 15:57:25 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438037829-2642-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274720>

Alternate refs backends might store reflogs somewhere other than
.git/logs.  Change most test code that directly accesses .git/logs to
instead use git reflog commands.

There are still a few tests which need direct access to reflogs: to
check reflog permissions, to manually create reflogs from scratch, to
save/restore reflogs, to check the format of raw reflog data, and to
remove not just reflog contents, but the reflogs themselves. All cases
which don't need direct access have been modified.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 t/t1400-update-ref.sh         |  5 ++---
 t/t1410-reflog.sh             | 24 ++++++++++++++++--------
 t/t1411-reflog-show.sh        |  2 +-
 t/t1503-rev-parse-verify.sh   |  9 +++------
 t/t3200-branch.sh             | 12 ++++++------
 t/t3210-pack-refs.sh          |  2 +-
 t/t3404-rebase-interactive.sh | 10 +++++-----
 t/t3903-stash.sh              |  2 +-
 t/t5312-prune-corruption.sh   |  2 +-
 t/t6501-freshen-objects.sh    |  2 +-
 10 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d787bf5..8bf1559 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -155,12 +155,11 @@ test_expect_success "(not) changed .git/$m" "
 '
 rm -f .git/$m
 
-: a repository with working tree always has reflog these days...
-: >.git/logs/refs/heads/master
+rm -f .git/logs/refs/heads/master
 test_expect_success \
 	"create $m (logged by touch)" \
 	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
-	 git update-ref HEAD '"$A"' -m "Initial Creation" &&
+	 git update-ref --create-reflog HEAD '"$A"' -m "Initial Creation" &&
 	 test '"$A"' = $(cat .git/'"$m"')'
 test_expect_success \
 	"update $m (logged by touch)" \
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 779d4e3..b79049f 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -100,7 +100,8 @@ test_expect_success setup '
 
 	check_fsck &&
 
-	test_line_count = 4 .git/logs/refs/heads/master
+	git reflog refs/heads/master >output &&
+	test_line_count = 4 output
 '
 
 test_expect_success rewind '
@@ -116,7 +117,8 @@ test_expect_success rewind '
 
 	check_have A B C D E F G H I J K L &&
 
-	test_line_count = 5 .git/logs/refs/heads/master
+	git reflog refs/heads/master >output &&
+	test_line_count = 5 output
 '
 
 test_expect_success 'corrupt and check' '
@@ -134,7 +136,8 @@ test_expect_success 'reflog expire --dry-run should not touch reflog' '
 		--stale-fix \
 		--all &&
 
-	test_line_count = 5 .git/logs/refs/heads/master &&
+	git reflog refs/heads/master >output &&
+	test_line_count = 5 output &&
 
 	check_fsck "missing blob $F"
 '
@@ -147,7 +150,8 @@ test_expect_success 'reflog expire' '
 		--stale-fix \
 		--all &&
 
-	test_line_count = 2 .git/logs/refs/heads/master &&
+	git reflog refs/heads/master >output &&
+	test_line_count = 2 output &&
 
 	check_fsck "dangling commit $K"
 '
@@ -213,7 +217,8 @@ test_expect_success 'delete' '
 test_expect_success 'rewind2' '
 
 	test_tick && git reset --hard HEAD~2 &&
-	test_line_count = 4 .git/logs/refs/heads/master
+	git reflog refs/heads/master >output &&
+	test_line_count = 4 output
 '
 
 test_expect_success '--expire=never' '
@@ -222,7 +227,8 @@ test_expect_success '--expire=never' '
 		--expire=never \
 		--expire-unreachable=never \
 		--all &&
-	test_line_count = 4 .git/logs/refs/heads/master
+	git reflog refs/heads/master >output &&
+	test_line_count = 4 output
 '
 
 test_expect_success 'gc.reflogexpire=never' '
@@ -230,7 +236,8 @@ test_expect_success 'gc.reflogexpire=never' '
 	git config gc.reflogexpire never &&
 	git config gc.reflogexpireunreachable never &&
 	git reflog expire --verbose --all &&
-	test_line_count = 4 .git/logs/refs/heads/master
+	git reflog refs/heads/master >output &&
+	test_line_count = 4 output
 '
 
 test_expect_success 'gc.reflogexpire=false' '
@@ -238,7 +245,8 @@ test_expect_success 'gc.reflogexpire=false' '
 	git config gc.reflogexpire false &&
 	git config gc.reflogexpireunreachable false &&
 	git reflog expire --verbose --all &&
-	test_line_count = 4 .git/logs/refs/heads/master &&
+	git reflog refs/heads/master >output &&
+	test_line_count = 4 output &&
 
 	git config --unset gc.reflogexpire &&
 	git config --unset gc.reflogexpireunreachable
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 6f47c0d..d568b35 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -138,7 +138,7 @@ test_expect_success '--date magic does not override explicit @{0} syntax' '
 : >expect
 test_expect_success 'empty reflog file' '
 	git branch empty &&
-	: >.git/logs/refs/heads/empty &&
+	git reflog expire --expire=all refs/heads/empty &&
 
 	git log -g empty >actual &&
 	test_cmp expect actual
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 823fe1d..ab27d0d 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -85,8 +85,7 @@ test_expect_success 'fails silently when using -q' '
 
 test_expect_success 'fails silently when using -q with deleted reflogs' '
 	ref=$(git rev-parse HEAD) &&
-	: >.git/logs/refs/test &&
-	git update-ref -m "message for refs/test" refs/test "$ref" &&
+	git update-ref --create-reflog -m "message for refs/test" refs/test "$ref" &&
 	git reflog delete --updateref --rewrite refs/test@{0} &&
 	test_must_fail git rev-parse -q --verify refs/test@{0} >error 2>&1 &&
 	test_must_be_empty error
@@ -94,16 +93,14 @@ test_expect_success 'fails silently when using -q with deleted reflogs' '
 
 test_expect_success 'fails silently when using -q with not enough reflogs' '
 	ref=$(git rev-parse HEAD) &&
-	: >.git/logs/refs/test2 &&
-	git update-ref -m "message for refs/test2" refs/test2 "$ref" &&
+	git update-ref --create-reflog -m "message for refs/test2" refs/test2 "$ref" &&
 	test_must_fail git rev-parse -q --verify refs/test2@{999} >error 2>&1 &&
 	test_must_be_empty error
 '
 
 test_expect_success 'succeeds silently with -q and reflogs that do not go far back enough in time' '
 	ref=$(git rev-parse HEAD) &&
-	: >.git/logs/refs/test3 &&
-	git update-ref -m "message for refs/test3" refs/test3 "$ref" &&
+	git update-ref --create-reflog -m "message for refs/test3" refs/test3 "$ref" &&
 	git rev-parse -q --verify refs/test3@{1.year.ago} >actual 2>error &&
 	test_must_be_empty error &&
 	echo "$ref" >expect &&
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ddea498..cdaf6f6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -59,7 +59,7 @@ test_expect_success 'git branch -l d/e/f should create a branch and a log' '
 test_expect_success 'git branch -d d/e/f should delete a branch and a log' '
 	git branch -d d/e/f &&
 	test_path_is_missing .git/refs/heads/d/e/f &&
-	test_path_is_missing .git/logs/refs/heads/d/e/f
+	test_must_fail git reflog exists refs/heads/d/e/f
 '
 
 test_expect_success 'git branch j/k should work after branch j has been deleted' '
@@ -82,13 +82,13 @@ test_expect_success 'git branch -m dumps usage' '
 test_expect_success 'git branch -m m m/m should work' '
 	git branch -l m &&
 	git branch -m m m/m &&
-	test_path_is_file .git/logs/refs/heads/m/m
+	git reflog exists refs/heads/m/m
 '
 
 test_expect_success 'git branch -m n/n n should work' '
 	git branch -l n/n &&
 	git branch -m n/n n &&
-	test_path_is_file .git/logs/refs/heads/n
+	git reflog exists refs/heads/n
 '
 
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
@@ -267,12 +267,12 @@ git config branch.s/s.dummy Hello
 
 test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
 	git branch -l s/s &&
-	test_path_is_file .git/logs/refs/heads/s/s &&
+	git reflog exists refs/heads/s/s &&
 	git branch -l s/t &&
-	test_path_is_file .git/logs/refs/heads/s/t &&
+	git reflog exists refs/heads/s/t &&
 	git branch -d s/t &&
 	git branch -m s/s s &&
-	test_path_is_file .git/logs/refs/heads/s
+	git reflog exists refs/heads/s
 '
 
 test_expect_success 'config information was renamed, too' '
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 8aae98d..7b5b6d4 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -169,7 +169,7 @@ test_expect_success 'create packed foo/bar/baz branch' '
 	git branch foo/bar/baz &&
 	git pack-refs --all --prune &&
 	test_path_is_missing .git/refs/heads/foo/bar/baz &&
-	test_path_is_missing .git/logs/refs/heads/foo/bar/baz
+	test_must_fail git reflog exists refs/heads/foo/bar/baz
 '
 
 test_expect_success 'notice d/f conflict with existing directory' '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 467e6c1..4c0675a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -961,13 +961,13 @@ test_expect_success 'rebase -i produces readable reflog' '
 	set_fake_editor &&
 	git rebase -i --onto I F branch-reflog-test &&
 	cat >expect <<-\EOF &&
-	rebase -i (start): checkout I
-	rebase -i (pick): G
-	rebase -i (pick): H
 	rebase -i (finish): returning to refs/heads/branch-reflog-test
+	rebase -i (pick): H
+	rebase -i (pick): G
+	rebase -i (start): checkout I
 	EOF
-	tail -n 4 .git/logs/HEAD |
-	sed -e "s/.*	//" >actual &&
+	git reflog -n4 HEAD |
+	sed "s/[^:]*: //" >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f5f18b7..2142c1f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -672,7 +672,7 @@ test_expect_success 'store updates stash ref and reflog' '
 	! grep quux bazzy &&
 	git stash store -m quuxery $STASH_ID &&
 	test $(cat .git/refs/stash) = $STASH_ID &&
-	grep $STASH_ID .git/logs/refs/stash &&
+	git reflog --format=%H stash| grep $STASH_ID &&
 	git stash pop &&
 	grep quux bazzy
 '
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 8e98b44..da9d599 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -12,7 +12,7 @@ delete objects that cannot be recovered.
 
 test_expect_success 'disable reflogs' '
 	git config core.logallrefupdates false &&
-	rm -rf .git/logs
+	git reflog expire --expire=all --all
 '
 
 test_expect_success 'create history reachable only from a bogus-named ref' '
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 2adf825..cf076dc 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -56,7 +56,7 @@ for repack in '' true; do
 
 	test_expect_success "disable reflogs ($title)" '
 		git config core.logallrefupdates false &&
-		rm -rf .git/logs
+		git reflog expire --expire=all --all
 	'
 
 	test_expect_success "setup basic history ($title)" '
-- 
2.0.4.315.gad8727a-twtrsrc
