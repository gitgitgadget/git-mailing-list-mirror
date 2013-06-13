From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] rebase: use peel_committish() where appropriate
Date: Thu, 13 Jun 2013 23:46:02 +0530
Message-ID: <1371147362-26962-4-git-send-email-artagnon@gmail.com>
References: <1371147362-26962-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnC6C-0008F1-1q
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758874Ab3FMSSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:18:07 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:65034 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758670Ab3FMSSE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:18:04 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so6688987pab.35
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lHCRFnVxwEyR/aKGGX/vwcbel3mYy7xv2xcefB5veeE=;
        b=m5k4aKZQnrpuFkiqfisKWhnRyKE4wdxRERJE6UBYg1p3aHntvji7khBO012TsNdgGY
         iVLy4ey2nf05ZNBV/nNzEfdDqsa7afioYR1NSEEKKgQAZLfHgCRUl2G5p9rMeNRVvB7c
         jcN6nWPT52XeVYfUUPojBuiQy074oBDMCOMuofJh2TEk97cmvdHTon/W+Y7HyME6Ceoy
         iPU8uD3JmjooSTjqziokNqaO4bidmJ9udgO+FoDPIYO7rEmbCD6BiANJt3ShTfkkvXXL
         0uoTB21TJm28niEcHilnTM7sveONMcBbF9AiCem46FnvEEwRwjosqiIudaSo1W1Sfx7p
         K/YA==
X-Received: by 10.66.8.41 with SMTP id o9mr4079924paa.13.1371147483468;
        Thu, 13 Jun 2013 11:18:03 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pm7sm24250605pbb.31.2013.06.13.11.18.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 11:18:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.g31c8856.dirty
In-Reply-To: <1371147362-26962-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227767>

The failing tests in t/rebase and t/rebase-interactive pass as a result.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh                 | 6 +++---
 t/t3400-rebase.sh             | 2 +-
 t/t3404-rebase-interactive.sh | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index d0c11a9..28e8d47 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -434,7 +434,7 @@ then
 		shift
 		;;
 	esac
-	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
+	upstream=$(peel_committish "${upstream_name}") ||
 	die "$(eval_gettext "invalid upstream \$upstream_name")"
 	upstream_arg="$upstream_name"
 else
@@ -470,7 +470,7 @@ case "$onto_name" in
 	fi
 	;;
 *)
-	onto=$(git rev-parse --verify "${onto_name}^0") ||
+	onto=$(peel_committish "$onto_name") ||
 	die "$(eval_gettext "Does not point to a valid commit: \$onto_name")"
 	;;
 esac
@@ -490,7 +490,7 @@ case "$#" in
 	   orig_head=$(git rev-parse -q --verify "refs/heads/$1")
 	then
 		head_name="refs/heads/$1"
-	elif orig_head=$(git rev-parse -q --verify "$1")
+	elif orig_head=$(peel_committish "$1" quiet)
 	then
 		head_name="detached HEAD"
 	else
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 890f159..272f0f5 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -88,7 +88,7 @@ test_expect_success 'rebase fast-forward to master' '
 	test_i18ngrep "Fast-forwarded HEAD to my-topic-branch" out
 '
 
-test_expect_failure 'rebase against revision specified as :/quuxery' '
+test_expect_success 'rebase against revision specified as :/quuxery' '
 	git checkout my-topic-branch^ &&
 	sha1=$(git rev-parse ":/Add B") &&
 	git rebase $sha1 &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ca4ee92..c9a5d56 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -947,7 +947,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
-test_expect_failure 'rebase -i against revision specified as :/quuxery' '
+test_expect_success 'rebase -i against revision specified as :/quuxery' '
 	git checkout branch1 &&
 	sha1=$(git rev-parse ":/J") &&
 	git rebase $sha1 &&
-- 
1.8.3.1.381.g31c8856.dirty
