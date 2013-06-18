From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 7/7] rebase -i: write better reflog messages
Date: Wed, 19 Jun 2013 00:25:37 +0530
Message-ID: <1371581737-10013-8-git-send-email-artagnon@gmail.com>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up17h-00036O-V8
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933592Ab3FRS7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:59:08 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:65195 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932976Ab3FRS7C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:59:02 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so4217924pbb.36
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xNTkJIzCxNPSYtfp8ss6u8kHKLm1ww267pjo4ZgG8Aw=;
        b=Gdqf5Mxfx/Yrg8UEr9356DcNOuk4KmoS8IPFbVtaB9v3fl59kd53husptvC8MFNKyq
         m1GaSwuFiJYEzNhX6VTNqaV4jWzfD7LNJFAAFurl3brW8+xlyJQFi7l0iMZOsF0Aldye
         mMA/c2FWpjPHO1ihmXbvJDVyuVd6wh3x5c37nEH0ji8IPxI8UMQa0/kCAS6mDSacFMhc
         Ka/5iAAmMaLyp63eWi69cWM5aMAjJszb5pudOj9JKZ7tccy2rrZP6G/WWBVigb/xGKXs
         04LJOTOdasSSmHTVWHV9XtFDoI55d+sGw6KAU2ub07RU3rCVa+sqQApg9E1g+1KAX8x0
         Skog==
X-Received: by 10.68.244.73 with SMTP id xe9mr18622931pbc.119.1371581941478;
        Tue, 18 Jun 2013 11:59:01 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id ag4sm19432751pbc.20.2013.06.18.11.58.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 11:59:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.455.g5932b31
In-Reply-To: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228303>

Now that the "checkout" invoked internally from "rebase -i" knows to
honor GIT_REFLOG_ACTION, we can start to use it to write a better reflog
message when "rebase -i anotherbranch", "rebase -i --onto branch",
etc. internally checks out the new fork point.  We will write:

  rebase -i (start): checkout master

instead of the old

  rebase -i (start)

[jc: add rebase-reflog test]

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh    | 14 ++++++++++----
 t/t3404-rebase-interactive.sh | 15 +++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f953d8d..8429c87 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -95,12 +95,15 @@ commit_message () {
 	git cat-file commit "$1" | sed "1,/^$/d"
 }
 
-orig_reflog_action="$GIT_REFLOG_ACTION"
+base_reflog_action="$GIT_REFLOG_ACTION"
 
 comment_for_reflog () {
-	case "$orig_reflog_action" in
+	case "$base_reflog_action" in
+	# if GIT_REFLOG_ACTION was set by caller git-rebase, overwrite
+	# it with rebase -i.
 	''|rebase*)
 		GIT_REFLOG_ACTION="rebase -i ($1)"
+		base_reflog_action="$GIT_REFLOG_ACTION"
 		export GIT_REFLOG_ACTION
 		;;
 	esac
@@ -326,6 +329,7 @@ pick_one_preserving_merges () {
 		if [ "$1" != "-n" ]
 		then
 			# detach HEAD to current parent
+			GIT_REFLOG_ACTION="$base_reflog_action: checkout $first_parent"
 			output git checkout $first_parent 2> /dev/null ||
 				die "Cannot move HEAD to $first_parent"
 		fi
@@ -608,10 +612,10 @@ do_next () {
 	newhead=$(git rev-parse HEAD) &&
 	case $head_name in
 	refs/*)
-		message="$GIT_REFLOG_ACTION: $head_name onto $onto" &&
+		message="$base_reflog_action: $head_name onto $onto" &&
 		git update-ref -m "$message" $head_name $newhead $orig_head &&
 		git symbolic-ref \
-		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
+		  -m "$base_reflog_action: returning to $head_name" \
 		  HEAD $head_name
 		;;
 	esac && {
@@ -838,6 +842,7 @@ comment_for_reflog start
 
 if test ! -z "$switch_to"
 then
+	GIT_REFLOG_ACTION="$base_reflog_action: checkout $switch_to"
 	output git checkout "$switch_to" -- ||
 		die "Could not checkout $switch_to"
 fi
@@ -981,6 +986,7 @@ has_action "$todo" ||
 
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
+GIT_REFLOG_ACTION="$base_reflog_action: checkout $onto_name"
 output git checkout $onto || die_abort "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 do_rest
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 79e8d3c..f7d0147 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -934,6 +934,21 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
 	test L = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
+test_expect_success 'rebase -i produces readable reflog' '
+	git reset --hard &&
+	git branch -f branch1 H &&
+	git rebase -i --onto I F branch1 &&
+	cat >expect <<-\EOF &&
+	rebase -i (start): checkout I
+	rebase -i (pick): G
+	rebase -i (pick): H
+	rebase -i (finish): returning to refs/heads/branch1
+	EOF
+	tail -n 4 .git/logs/HEAD |
+	sed -e "s/.*	//" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase -i respects core.commentchar' '
 	git reset --hard &&
 	git checkout E^0 &&
-- 
1.8.3.1.455.g5932b31
