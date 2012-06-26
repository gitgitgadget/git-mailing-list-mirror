From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 5/5] rebase [-m]: calculate patches in upstream correctly
Date: Tue, 26 Jun 2012 07:51:58 -0700
Message-ID: <1340722318-24392-6-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 16:52:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjX8Q-0006Bd-RD
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 16:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945Ab2FZOwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 10:52:41 -0400
Received: from mail-vb0-f74.google.com ([209.85.212.74]:47228 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757806Ab2FZOwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 10:52:40 -0400
Received: by vbnl22 with SMTP id l22so573788vbn.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=NMp9LnzjoZh2Eqwc1+Xnydw9EuwaDT2ZsLDDWtwd6vY=;
        b=K4FU2z6nrPtl3S9py5xz4AQ/IFmdgFoPOhUD/Ks4gD/LVlwgCPL+a7xOGn7VCPQ7K3
         Za71Y3/cnNZxgl3jkF4HG5zy8uaXiK8HVAz8J5/j/o+D5zFca9mvLc7lrzik4HNCsubN
         DWpf+k/ei572nFvDoLDuQjg8HRrROtcbwGS84d8wzo7kwNJaoWEGL4wZqsS8CuHTAEs6
         95/+v3bEAyNh77oIIoI4IhZCsxpm2Y9tWhJKN5DNwG0x31JsKEiN+pMvVTuyvlzWltLr
         8aTlSEI4NlXizc3Mz3rmtZ8mlDj1WjdknuerEqZ8LyWjglGwIF4+6mgyLB7TrbVIuhOY
         uy7A==
Received: by 10.236.156.196 with SMTP id m44mr28478682yhk.9.1340722359259;
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: by 10.236.156.196 with SMTP id m44mr28478671yhk.9.1340722359217;
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id v25si16955035yhm.0.2012.06.26.07.52.39
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 11184100049;
	Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id C3273C19F8; Tue, 26 Jun 2012 07:52:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.3.327.g2980b
In-Reply-To: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQk7Zc3xEbchTMT/iVuSVdgigC0LRNTvSSm5oAB0sTP2F1b936Yz65Ceri0uEndn5KtZTQOuVg3PuQH0+ujLs3BYjwgaXMdSIFgQSjwmj0P89QJDglLU5GJbbE7yUKvdOQMae10T5a3W2iizaqu+gY78OSit4htozHjbjpU9yPHvn4DUBjL3L3OzTxQclo+82/W0HaNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200648>

Plain 'git rebase' (without -m/-i/-p) applies the patches from

  git format-patch --ignore-if-in-upstream $upstream..$orig_head

, while 'git rebase -m' finds the commits using

  git rev-list $upstream..$orig_head

As Knut Franke reported in [1], the fact that there is no
--ignore-if-in-upstream or equivalent when using merge-based rebase
means that unnecessary conflicts can arise due to commits
cherry-picked between $orig_head and $upstream.

There is a second problem with the above method of calculating the
upstream commits. Copying the example history from [1]:

      .-c
     /
a---b---d---e---f
         \
          .-g---E

Commit E is here a cherry-pick of e. If we now run 'git rebase --onto
c f E', the revisions that will be applied onto 'c' are given by 'git
format-patch --ignore-if-in-upstream f..E'. In this case that would be
only 'g' and NOT 'E'.

To solve both of the above problems, we want to find the commits in
$upstream..$orig_head that are not cherry-picked in
$upstream..$onto. There is unfortunately no direct way of finding
these commits using 'git rev-list', so we will have to resort to using
'git cherry' and filter for lines starting with '+'.

To reduce the risk of 'git rebase' and 'git rebase -m' behaving
differently (with respect to the commits chosen) in the future,
perform the calculation already in git-rebase.sh.

As a side-effect, we also avoid the cost of formatting patches.

Test case updates for 'rebase -m' by Knut, the rest by Martin.

 [1] http://thread.gmane.org/gmane.comp.version-control.git/161917

Helped-by: Knut Franke <Knut.Franke@gmx.de>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--am.sh         |    6 ++----
 git-rebase--merge.sh      |    2 +-
 git-rebase.sh             |    7 +------
 t/t3401-rebase-partial.sh |   17 +++++++++++++++++
 t/t3406-rebase-message.sh |   14 +++++++-------
 5 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 392ebc9..89e0ab4 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -16,7 +16,6 @@ skip)
 	;;
 esac
 
-test -n "$rebase_root" && root_flag=--root
 
 if test -n "$keep_empty"
 then
@@ -26,9 +25,8 @@ then
 	# makes this easy
 	git cherry-pick --allow-empty "$revisions"
 else
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		--src-prefix=a/ --dst-prefix=b/ \
-		--no-renames $root_flag "$revisions" |
+	echo "$revisions" |
+	sed -e 's/\([0-9a-f]\{40\}\)/From \1 Mon Sep 17 00:00:00 2001/' |
 	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"
 fi && move_to_original_branch
 
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index b10f2cf..7ea33e3 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -131,7 +131,7 @@ echo "$onto_name" > "$state_dir/onto_name"
 write_basic_state
 
 msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$revisions"`
+for cmt in $revisions
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$state_dir/cmt.$msgnum"
diff --git a/git-rebase.sh b/git-rebase.sh
index 6df06c4..47e75cb 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -522,11 +522,6 @@ then
 	exit 0
 fi
 
-if test -n "$rebase_root"
-then
-	revisions="$onto..$orig_head"
-else
-	revisions="$upstream..$orig_head"
-fi
+revisions="$(git cherry $onto $orig_head $upstream | sed -ne 's/^+ //p')"
 
 run_specific_rebase
diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 7ba1797..ce555fa 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -42,4 +42,21 @@ test_expect_success 'rebase --merge topic branch that was partially merged upstr
 	test_path_is_missing .git/rebase-merge
 '
 
+test_expect_success 'rebase --onto does not re-apply patches in $onto' '
+	git checkout C &&
+	test_commit C2 C.t &&
+	git checkout -B my-topic-branch master &&
+	test_commit D &&
+	git rebase --onto C2 A2 &&
+	test "$(git log --format=%s C2..)" = D
+'
+
+test_expect_success 'rebase --onto does not lose patches in $upstream' '
+	git rebase --onto A2 D &&
+	test "$(git log --format=%s A2..)" = "D
+C2
+C
+B"
+'
+
 test_done
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 6898377..3eecc66 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -5,8 +5,10 @@ test_description='messages from rebase operation'
 . ./test-lib.sh
 
 quick_one () {
-	echo "$1" >"file$1" &&
-	git add "file$1" &&
+	fileno=$2
+	test -z "$fileno" && fileno=$1
+	echo "$1" >"file$fileno" &&
+	git add "file$fileno" &&
 	test_tick &&
 	git commit -m "$1"
 }
@@ -16,21 +18,19 @@ test_expect_success setup '
 	git branch topic &&
 	quick_one X &&
 	quick_one A &&
-	quick_one B &&
+	quick_one B A &&
 	quick_one Y &&
 
 	git checkout topic &&
 	quick_one A &&
-	quick_one B &&
+	quick_one B A &&
 	quick_one Z &&
 	git tag start
 
 '
 
 cat >expect <<\EOF
-Already applied: 0001 A
-Already applied: 0002 B
-Committed: 0003 Z
+Committed: 0001 Z
 EOF
 
 test_expect_success 'rebase -m' '
-- 
1.7.9.3.327.g2980b
