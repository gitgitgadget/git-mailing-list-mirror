From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 26/37] merge-recursive: Avoid doubly merging rename/add conflict contents
Date: Mon, 20 Sep 2010 02:28:59 -0600
Message-ID: <1284971350-30590-27-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblJ-0006R4-KI
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910Ab0ITI21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:27 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49332 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906Ab0ITI2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:24 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1146755pwi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=l3ECINW1xjblV062xNyj2xwlt+akNe3jbS0wfy10NW8=;
        b=lP9GW7iezIIF7jfVR0ZffWEngmYUAuvJzHb5CRYmQQhacqrCw0f3y0uGHDbZJFPSVj
         0u9T95qMwTnLqkVaEpzUBIxvYIjXauchpRIiK/YplziNygxp5VGAIxsi15nS5Sr5oG8Y
         ciftaaXS5DcfgRPe7yMSIb+NRGZ77uAUQbvz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cndLyAGZl0OY/Y1aRM7bMG+33AsCdBYaVlqKsvLxHqyztAMyCu22f+iZBJ5nKRZT3n
         O494ErgJ2dMwGOqMNziZgRbpVKE9iS1ILVB2Q69L7sAEsd+9v0/2GDTdpDf2uzCR71Fm
         KQ/QzgVdQO89pL+7RZMplIPwvhMQeLYVb3DK4=
Received: by 10.142.52.8 with SMTP id z8mr7410140wfz.33.1284971304662;
        Mon, 20 Sep 2010 01:28:24 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.22
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156589>

When a commit moves A to B while another commit created B (or moved C to
B), and these two different commits serve as different merge-bases for a
later merge, c94736a (merge-recursive: don't segfault while handling
rename clashes 2009-07-30) added some special code to avoid segfaults.
Since that commit, the two versions of B are merged in place (which could
be potentially conflicting) and the intermediate result is used as the
virtual ancestor.

However, right before this special merge, try_merge was turned on, meaning
that process_renames() would try an alternative merge that ignores the
'add' part of the conflict, and, if the merge is clean, store that as the
new virtual ancestor.  This could cause incorrect merging of criss-cross
merges; it would typically result in just recording a slightly confusing
merge base, but in some cases it could cause silent acceptance of one side
of a merge as the final resolution when a conflict should have been
flagged.

When we do a special merge for such a rename/add conflict between
merge-bases, turn try_merge off to avoid an inappropriate second merge.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                 |    1 +
 t/t6036-recursive-corner-cases.sh |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5f528c1..178bbd8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1061,6 +1061,7 @@ static int process_renames(struct merge_options *o,
 						    mfi.sha,
 						    mfi.mode,
 						    ren1_dst);
+					try_merge = 0;
 				} else {
 					new_path = unique_path(o, ren1_dst, branch2);
 					output(o, 1, "Adding as %s instead", new_path);
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 6c2b2bf..a2e5c5c 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -120,7 +120,7 @@ test_expect_success 'setup criss-cross + rename merges with basic modification'
 	git tag R2
 '
 
-test_expect_failure 'merge criss-cross + rename merges with basic modification' '
+test_expect_success 'merge criss-cross + rename merges with basic modification' '
 	git reset --hard &&
 	git checkout L2^0 &&
 
@@ -202,7 +202,7 @@ test_expect_success 'setup differently handled merges of rename/add conflict' '
 	git tag E
 '
 
-test_expect_failure 'git detects differently handled merges conflict' '
+test_expect_success 'git detects differently handled merges conflict' '
 	git reset --hard &&
 	git checkout D^0 &&
 
-- 
1.7.3.271.g16009
