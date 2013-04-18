From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] stash: tighten IS_STASH_LIKE logic
Date: Thu, 18 Apr 2013 13:08:37 +0530
Message-ID: <1366270717-19929-1-git-send-email-artagnon@gmail.com>
Cc: Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 18 09:37:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USjPE-0006iP-LD
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 09:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965937Ab3DRHhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 03:37:14 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:61178 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270Ab3DRHhN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 03:37:13 -0400
Received: by mail-da0-f50.google.com with SMTP id g9so222719dad.9
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 00:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=hnYDc5pLVJXX3+B5atgnW24NXyAhYTG2S1emo07xnNI=;
        b=DjkMcnODsea05HH65Z3KpXIyS6HXvPXXsZL8BIcnY3eFfmjmtHuuRoh4xk8B+yLbVu
         JIBGI0I0cKYlpNQbpm+melTUERHZssTkmOKqKXZAwBL/sLXrGzg29j/fhRQpbWzv0rlW
         kZ7/yhpQq/Bqv1iclveBntPhvjM+P4y1VsGyXyiMXE5RUO0mgLfhSW+HRfSjEiXKbxyF
         9iWdXXk/8pcGJMOB4k3x+M3UQzAh+jOYp5c6QI5F+OHU2LAN8nSzDNT4BRSbzzS/HT/s
         odR8GkxFteQXgoYsbkWaEMxOX3vUk1o2VP1aCz1a9AYWNawl7qZXYqwakv7k3B3RdA4X
         ciOg==
X-Received: by 10.69.0.200 with SMTP id ba8mr12944768pbd.4.1366270632595;
        Thu, 18 Apr 2013 00:37:12 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id mt13sm8956061pbc.15.2013.04.18.00.37.10
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 00:37:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.423.g4fb5c0a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221618>

Currently, 'git stash show' and 'git stash apply' can show/apply any
merge commit, as the test for setting IS_STASH_LIKE simply asserts if
the commit is a merge.  Improve the situation by asserting if the
index_commit and the worktree_commit are based off the same commit, by
checking that $REV^1 is equal to $REV^2^1.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-stash.sh     |  3 ++-
 t/t3903-stash.sh | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index bbefdf6..d0428a8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -366,13 +366,14 @@ parse_flags_and_rev()
 	}
 
 	i_commit=$(git rev-parse --quiet --verify $REV^2 2>/dev/null) &&
-	set -- $(git rev-parse $REV $REV^1 $REV: $REV^1: $REV^2: 2>/dev/null) &&
+	set -- $(git rev-parse $REV $REV^1 $REV: $REV^1: $REV^2: $REV^2^1 2>/dev/null) &&
 	s=$1 &&
 	w_commit=$1 &&
 	b_commit=$2 &&
 	w_tree=$3 &&
 	b_tree=$4 &&
 	i_tree=$5 &&
+	test $b_commit = $6 &&
 	IS_STASH_LIKE=t &&
 	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
 	IS_STASH_REF=t
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5dfbda7..11bcd72 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -637,4 +637,15 @@ test_expect_success 'stash where working directory contains "HEAD" file' '
 	test_cmp output expect
 '
 
+test_expect_success 'show refuses to show any random merge commit' '
+	git stash clear &&
+	git reset --hard &&
+	git checkout -b quux &&
+	test_commit bar &&
+	git checkout - &&
+	test_commit foo &&
+	git merge quux &&
+	test_must_fail git stash show HEAD
+'
+
 test_done
-- 
1.8.2.1.423.g4fb5c0a.dirty
