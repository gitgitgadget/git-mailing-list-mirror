From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] rebase --preserve-merges: ignore "merge.log" config
Date: Wed, 21 Aug 2013 20:48:57 +0200
Message-ID: <1377110937-13439-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 20:49:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCDSw-0005Wk-QL
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 20:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab3HUStG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 14:49:06 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:39606 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245Ab3HUStE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 14:49:04 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so457852eak.32
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XHfC/l+DZkl239ZaeHMUVGJvN1h3wwUMqi8Z9MrBUjY=;
        b=CpBmLOzXgqj2Ctbhvs4aMqHfcU/L/jJhkurP4LJxMz6EMtAt9qYJE9z6j6+9TMSbBJ
         18rPYnk7AVLEhisMqUGSEjmv1CeN+U7z4QzlouOTgndPgq84FVrW5PUH3PUBDm7Toflm
         cXxDYRWxf0neGEMSrTLPiRmdILxe8cnopkRl+m4ZWqvt3+kbi+ylQ4+LVv9q4pLUTun5
         CYq0rJvKQXD28KxPkvrMg4kWxRhv1Ys3XXNg/WjDQYb1fpo9Nw6GIumbssW7gKUAm/r0
         1MJ+Lf9JQHdAwgZO+SXtQ5Us/HFhTdU0P9aXTUfKzTypCGwW4aeFuzsNyCNcLfT0SuUh
         wAjw==
X-Received: by 10.14.111.9 with SMTP id v9mr12240308eeg.35.1377110943258;
        Wed, 21 Aug 2013 11:49:03 -0700 (PDT)
Received: from localhost (dslb-178-005-189-036.pools.arcor-ip.net. [178.5.189.36])
        by mx.google.com with ESMTPSA id i1sm11850557eeg.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 11:49:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232714>

When "merge.log" config is set, "rebase --preserve-merges"
will add the log lines to the message of the rebased merge
commit.

A rebase should not modify a commit message automatically.

Teach "git-rebase" to ignore that configuration by passing "--no-log"
to the git-merge call.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 git-rebase--interactive.sh        |  3 ++-
 t/t3409-rebase-preserve-merges.sh | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 83d6d46..4743c59 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -352,8 +352,9 @@ pick_one_preserving_merges () {
 			msg_content="$(commit_message $sha1)"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
+			merge_args="--no-log --no-ff"
 			if ! do_with_author output eval \
-			'git merge --no-ff $strategy_args -m "$msg_content" $new_parents'
+			'git merge $merge_args $strategy_args -m "$msg_content" $new_parents'
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 2e0c364..2454811 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -28,6 +28,8 @@ export GIT_AUTHOR_EMAIL
 #     \--A3    <-- topic2
 #      \
 #       B2     <-- origin/topic
+#
+# Clone 4 (same as Clone 3)
 
 test_expect_success 'setup for merge-preserving rebase' \
 	'echo First > A &&
@@ -64,6 +66,16 @@ test_expect_success 'setup for merge-preserving rebase' \
 		git merge --no-ff topic2
 	) &&
 
+	git clone ./. clone4 &&
+	(
+		cd clone4 &&
+		git checkout -b topic2 origin/topic &&
+		echo Sixth > A &&
+		git commit -a -m "Modify A3" &&
+		git checkout -b topic origin/topic &&
+		git merge --no-ff topic2
+	) &&
+
 	git checkout topic &&
 	echo Fourth >> B &&
 	git commit -a -m "Modify B2"
@@ -96,4 +108,17 @@ test_expect_success 'rebase -p preserves no-ff merges' '
 	)
 '
 
+test_expect_success 'rebase -p ignores merge.log config' '
+	(
+	cd clone4 &&
+	git fetch &&
+	git -c merge.log=1 rebase -p origin/topic &&
+	cat >expected <<-\EOF &&
+
+	EOF
+	git log --format="%b" -1 >current
+	test_cmp expected current
+	)
+'
+
 test_done
-- 
1.8.4.rc4.dirty
