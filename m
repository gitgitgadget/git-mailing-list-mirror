From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC] Interactive-rebase doesn't pick all children of "upstream"
Date: Sat, 21 May 2011 01:51:18 -0400
Message-ID: <1305957078-19111-2-git-send-email-andrew.kw.w@gmail.com>
References: <20110517161234.GA21388@sigill.intra.peff.net>
 <1305957078-19111-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 08:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNg4H-000538-OP
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 08:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab1EUGxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 02:53:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64449 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab1EUGxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 02:53:42 -0400
Received: by iwn34 with SMTP id 34so3529294iwn.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 23:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=CGqgObrh3Ptj6d+ZJpJf9jfcjQ7idsUzoxTFFrc/ESs=;
        b=o8PV1FMuL7RGguYsqHaj/LCOiOPiXMkXkccqdaWz13YyF1p6qtOojz+2NiNJ4KhZTE
         HFqCfPL3MIjBUXidibXFp/D04CEgxNjwcXisa+AUJFAhgaLyAY6yJJ7pvB/NwyZO+qJ2
         Z/5KHxBS3SbE+jsZBXrlyalrmwQBKFiX979ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sihRZR0Y9Arrql6US8ndSczdQ9Ix1jL4zgC5trP3erTTqR1XG81giMEwugdIEhm+Xk
         QVZtL03iK0UzxTV2QmlQfwOF1Ml9R9ls3/+qHytC89g58MDTEmKd6Zh6dmf7Uz1wG5gC
         ztioQqeVL0X57AE0CKq/BWPXslNjd4G3LHKGU=
Received: by 10.42.115.193 with SMTP id l1mr5900956icq.472.1305960821657;
        Fri, 20 May 2011 23:53:41 -0700 (PDT)
Received: from localhost.localdomain (24-246-58-202.cable.teksavvy.com [24.246.58.202])
        by mx.google.com with ESMTPS id xe5sm1665579icb.22.2011.05.20.23.53.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 May 2011 23:53:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2.316.gd7d8c.dirty
In-Reply-To: <1305957078-19111-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174093>

Consider this graph:

        D---E    (topic, HEAD)
       /   /
  A---B---C      (master)
   \
    F            (topic2)

and the following three commands:
  1. git rebase -i A
  2. git rebase -i --onto F B
  3. git rebase -i B

Currently, (1) and (2) will pick B, D, C, and E onto A and F,
respectively.  However, (3) will only pick D and E onto B.  This
behavior of (3) is inconsistent with (1) and (2).

This also creates a bug if we do:
  4. git rebase -i C

In (4), E is never picked. And since interactive-rebase resets "HEAD" to
"onto", E is lost after the interactive-rebase.

This patch fixes the inconsistency and bug by ensuring that all children
of upstream are always picked.

Two of the tests contain a scenario like (3).  Since the new behavior
added more commits for picking, these tests need to be updated to edit
the "todo" list properly.
---
 git-rebase--interactive.sh               |    7 +++++--
 t/t3404-rebase-interactive.sh            |    2 +-
 t/t3411-rebase-preserve-around-merges.sh |    2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 41ba96a..b6d1e5b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -711,7 +711,7 @@ then
 	# parents to rewrite and skipping dropped commits would
 	# prematurely end our probe
 	merges_option=
-	first_after_upstream="$(git rev-list --reverse --first-parent $upstream..$orig_head | head -n 1)"
+	commits_after_upstream="$(git rev-list --reverse --parents $upstream..$orig_head | sane_grep " $upstream" | cut -d' ' -s -f1)"
 else
 	merges_option="--no-merges --cherry-pick"
 fi
@@ -744,7 +744,10 @@ do
 			preserve=t
 			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
 			do
-				if test -f "$rewritten"/$p -a \( $p != $onto -o $sha1 = $first_after_upstream \)
+				if test -f "$rewritten"/$p && (
+					test $p != $onto ||
+					expr "$commits_after_upstream" ":" ".*$sha1.*"
+					)
 				then
 					preserve=f
 				fi
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7d8147b..c3cddcd 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -295,7 +295,7 @@ test_expect_success 'preserve merges with -p' '
 '
 
 test_expect_success 'edit ancestor with -p' '
-	FAKE_LINES="1 edit 2 3 4" git rebase -i -p HEAD~3 &&
+	FAKE_LINES="1 2 edit 3 4" git rebase -i -p HEAD~3 &&
 	echo 2 > unrelated-file &&
 	test_tick &&
 	git commit -m L2-modified --amend unrelated-file &&
diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
index 14a23cd..ace8e54 100755
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -37,7 +37,7 @@ test_expect_success 'setup' '
 #        -- C1 --
 #
 test_expect_success 'squash F1 into D1' '
-	FAKE_LINES="1 squash 3 2" git rebase -i -p B1 &&
+	FAKE_LINES="1 squash 4 2 3" git rebase -i -p B1 &&
 	test "$(git rev-parse HEAD^2)" = "$(git rev-parse C1)" &&
 	test "$(git rev-parse HEAD~2)" = "$(git rev-parse B1)" &&
 	git tag E2
-- 
1.7.5.2.316.gd7d8c.dirty
