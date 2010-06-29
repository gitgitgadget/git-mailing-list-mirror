From: newren@gmail.com
Subject: [PATCH 4/5] merge_recursive: Fix renames across paths below D/F conflicts
Date: Mon, 28 Jun 2010 19:12:15 -0600
Message-ID: <1277773936-12412-5-git-send-email-newren@gmail.com>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, vmiklos@frugalware.org,
	gitster@pobox.com, spearce@spearce.org,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 03:11:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTPM4-0006ry-Pv
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 03:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab0F2BK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 21:10:58 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46078 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab0F2BK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 21:10:57 -0400
Received: by mail-px0-f174.google.com with SMTP id 8so2060482pxi.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 18:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+X8KlV1t6VmypGtXd1UDFsz3bQaxqhVNzfYYyOOJJtI=;
        b=KL1lKyk6z9P6fDBWjhmrQoYl+IOqJyMvnE/WaQPO6TJFYjdL1/RXJ52THPUCvqODk3
         ynzQJpj16vbxu7OREw6Gda5gkry6sxzrln/OFLB72b37xKq5efjt6WtpkT4oUazXy2gv
         BHbPti65MPYTWXEXfVF607GKMIXu+XhZTgSlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PmTCCn/d3MtBXLw0M7melYjTvKbjsU0Sr++79hAPI/7QLin7hTxCQasVekjtOjnR0I
         CuqvpTFGs9uYcSBFUdSJQRS/1Ar1UaqKj3aDgr6l1PbnozZzd8bSCcQ/vhK9mghjExGD
         jbav+94BzFp0S0Sd29FJuB75ZZdqlX3hIfUWg=
Received: by 10.143.27.18 with SMTP id e18mr7093064wfj.41.1277773856935;
        Mon, 28 Jun 2010 18:10:56 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id x34sm8105171wfi.4.2010.06.28.18.10.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 18:10:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.207.ga9fc
In-Reply-To: <1277773936-12412-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149877>

From: Elijah Newren <newren@gmail.com>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
I'm a little uneasy with this change, mainly because I don't fully
understand the rename processing logic (I was actually kind of surprised
when I made these changes and it worked).  Although I verified that
these changes (and my others in this patch series) introduce no new
breakages in the testsuite and even fix a known issue, I'm still not
quite sure I follow the logic well enough to feel fully confident in
this change.  I'm particularly worried I may have neglected some closely
related cases that I should have fixed but which may still be broken.

 merge-recursive.c   |   13 +++++++++++--
 t/t6020-merge-df.sh |    4 ++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8d70fc0..ab0743f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1019,14 +1019,23 @@ static int process_renames(struct merge_options *o,
 
 				if (mfi.clean &&
 				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
-				    mfi.mode == ren1->pair->two->mode)
+				    mfi.mode == ren1->pair->two->mode) {
 					/*
 					 * This messaged is part of
 					 * t6022 test. If you change
 					 * it update the test too.
 					 */
 					output(o, 3, "Skipped %s (merged same as existing)", ren1_dst);
-				else {
+
+					/* If this was a rename across a path involved
+					 * in a D/F conflict, there may be more work to
+					 * do.
+					 */
+					for (i=1; i<=3; ++i) {
+						if (ren1->dst_entry->stages[i].mode)
+							ren1->dst_entry->processed = 0;
+					}
+				} else {
 					if (mfi.merge || !mfi.clean)
 						output(o, 1, "Renaming %s => %s", ren1_src, ren1_dst);
 					if (mfi.merge)
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 99acb89..7278eee 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -22,7 +22,7 @@ git commit -m "File: dir"'
 
 test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg" B master'
 
-test_expect_failure 'F/D conflict' '
+test_expect_success 'F/D conflict' '
 	git reset --hard &&
 	git checkout master &&
 	rm .git/index &&
@@ -72,7 +72,7 @@ test_expect_success 'Setup rename across paths each below D/F conflicts' '
 	git commit -m "f1"
 '
 
-test_expect_failure 'Test rename across paths below D/F conflicts' '
+test_expect_success 'Test rename across paths below D/F conflicts' '
 	git checkout newmaster &&
 	git cherry-pick branch
 '
-- 
1.7.2.rc0.212.g0c601
