From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 3/5] am --rebasing: get patch body from commit, not from mailbox
Date: Tue, 26 Jun 2012 07:51:56 -0700
Message-ID: <1340722318-24392-4-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 16:53:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjX8R-0006Bd-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 16:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757955Ab2FZOwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 10:52:50 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:48929 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161Ab2FZOwl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 10:52:41 -0400
Received: by lbbgp10 with SMTP id gp10so12067lbb.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=PsA7t1rjWNiBnZrmlQ1K2AR3Hz/3gIlNr288l2NuCdA=;
        b=bZjFVFFroPi6gxDoKO6I1rDuX/sa0yl3uSS62rKfMjlVYeHUm/ADiTuGHafySToV3N
         aJ9fyOYPRvIeHMrTiOEzxtIuURZp0AM5bofXtJZSFHiODqwH1vedwpZllDzzqkdwBT7b
         ghWB/ZO69j2wgWQnlEyeeiPl/9Z8WiXSOKVhM1ziW/eMlqNLNuuFXui3JiXy7UzFD0lN
         vnFNwh8ON5MbOaG+WnRJ5r+WBdwGkrwnLlbnii6NdorsYSDagdpkw8myShlGTg15hC+m
         AzvzuX3Uzfrr9kwE9f/oSqXesnH0aNM4DeRoNTPeW58M4nbpJOho3LAo6yx8EpHszkSX
         9Vog==
Received: by 10.14.94.207 with SMTP id n55mr4863952eef.16.1340722359712;
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: by 10.14.94.207 with SMTP id n55mr4863946eef.16.1340722359585;
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id b15si37904063een.0.2012.06.26.07.52.39
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 37EBC5C0060;
	Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 91EEAC1A3C; Tue, 26 Jun 2012 07:52:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.3.327.g2980b
In-Reply-To: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQka31ZgRiwBsItzlW4hSw1236C6SlfZg6jklilIm3ucb/9rjXPbuO7vHlvlxcFwaiKE5R0tNc250BzrGODxlWiv2TjZszGXiL1xZpzK/hFOaOT6Lr4yEU6VS6bulTJYncoLFAau9NVf1QZNotAFN48Nb5qt1MbEShueq9pQ8cTbcYs7+ZZFSNrkyHIsTRAY4CIzhC6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200649>

Rebasing a commit that contains a diff in the commit message results
in a failure with output such as

  First, rewinding head to replay your work on top of it...
  Applying: My cool patch.
  fatal: sha1 information is lacking or useless
  (app/controllers/settings_controller.rb).
  Repository lacks necessary blobs to fall back on 3-way merge.
  Cannot fall back to three-way merge.
  Patch failed at 0001 My cool patch.

The reason is that 'git rebase' without -p/-i/-m internally calls 'git
format-patch' and pipes the output to 'git am --rebasing', which has
no way of knowing what is a real patch and what is a commit message
that contains a patch.

Make 'git am' while in --rebasing mode get the patch body from the
commit object instead of extracting it from the mailbox.

Patch by Junio, test case and commit log message by Martin.

Reported-by: anikey <arty.anikey@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-am.sh                   |    1 +
 t/t3405-rebase-malformed.sh |   32 ++++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index f8b7a0c..ec8fde1 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -683,6 +683,7 @@ To restore the original branch and stop patching run \"\$cmdline --abort\"."
 			sed -e '1,/^$/d' >"$dotest/msg-clean"
 			echo "$commit" > "$dotest/original-commit"
 			get_author_ident_from_commit "$commit" > "$dotest/author-script"
+			git diff-tree --root --binary "$commit" >"$dotest/patch"
 		else
 			{
 				sed -n '/^Subject/ s/Subject: //p' "$dotest/info"
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index e5ad67c..19eddad 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='rebase should not insist on git message convention'
+test_description='rebase should handle arbitrary git message'
 
 . ./test-lib.sh
 
@@ -12,6 +12,11 @@ It has two paragraphs, but its first paragraph is not friendly
 to oneline summary format.
 EOF
 
+cat >G <<\EOF
+commit log message containing a diff
+EOF
+
+
 test_expect_success setup '
 
 	>file1 &&
@@ -19,8 +24,9 @@ test_expect_success setup '
 	git add file1 file2 &&
 	test_tick &&
 	git commit -m "Initial commit" &&
+	git branch diff-in-message
 
-	git checkout -b side &&
+	git checkout -b multi-line-subject &&
 	cat F >file2 &&
 	git add file2 &&
 	test_tick &&
@@ -28,6 +34,17 @@ test_expect_success setup '
 
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >F0 &&
 
+	git checkout diff-in-message &&
+	echo "commit log message containing a diff" >G &&
+	echo "" >>G
+	cat G >file2 &&
+	git add file2 &&
+	git diff --cached >>G &&
+	test_tick &&
+	git commit -F G &&
+
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >G0 &&
+
 	git checkout master &&
 
 	echo One >file1 &&
@@ -36,13 +53,20 @@ test_expect_success setup '
 	git commit -m "Second commit"
 '
 
-test_expect_success rebase '
+test_expect_success 'rebase commit with multi-line subject' '
 
-	git rebase master side &&
+	git rebase master multi-line-subject &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >F1 &&
 
 	test_cmp F0 F1 &&
 	test_cmp F F0
 '
 
+test_expect_success 'rebase commit with diff in message' '
+	git rebase master diff-in-message &&
+	git cat-file commit HEAD | sed -e "1,/^$/d" >G1 &&
+	test_cmp G0 G1 &&
+	test_cmp G G0
+'
+
 test_done
-- 
1.7.9.3.327.g2980b
