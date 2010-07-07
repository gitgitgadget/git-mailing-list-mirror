From: newren@gmail.com
Subject: [PATCHv3 4/6] merge_recursive: Fix renames across paths below D/F conflicts
Date: Tue,  6 Jul 2010 23:20:32 -0600
Message-ID: <1278480034-22939-5-git-send-email-newren@gmail.com>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 07:13:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWMwr-0002I3-CP
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab0GGFNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 01:13:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61704 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab0GGFNI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 01:13:08 -0400
Received: by mail-gw0-f46.google.com with SMTP id 21so1665527gwj.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 22:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vMBDY0AnT5m6AnYBO0CEa4RlLbxAf6+QmDcGUiA63SU=;
        b=qzdT6F9I1wtRylZsdyB7xWHe8dKsmL95+9ZQ5OQXfLWgNoZe7dJPsYSvgOUCY2Zw22
         okljUVd7v4pS8Oeh2E2VlxTJfuq9F0z+q29dI0Zfnm+1LGdmjk6piYW0W/5Vufo5fksE
         mfPnDx1zCM7uEgDxiFkZKXWRJ765NzzDHPWAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bUV+7y4NYQYy+wxnn6zMIvNI3Ct9YGwva7/YMx8MAgZs1Q0YW/hK7i/QBa9RfDzb9G
         uh12fKsSPGgvrdtjv5tFZ0E+nXk6lRHgBHluweBLnrvdxbbochZxkS6z3zV04Y+MUTR/
         I4T6K9a9bRkBjaUVba8SuU5oJRj0nFFzaMTrI=
Received: by 10.101.177.9 with SMTP id e9mr504206anp.195.1278479588371;
        Tue, 06 Jul 2010 22:13:08 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id h5sm60464675anb.28.2010.07.06.22.13.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 22:13:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.10.g6dbc5
In-Reply-To: <1278480034-22939-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150442>

From: Elijah Newren <newren@gmail.com>

The rename logic in process_renames() handles renames and merging of file
contents and then marks files as processed.  However, there may be higher
stage entries left in the index for other reasons (e.g., due to D/F
conflicts).  By checking for such cases and marking the entry as not
processed, it allows process_entry() later to look at it and handle those
higher stages.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c               |   13 +++++++++++--
 t/t3508-cherry-pick-merge-df.sh |    2 +-
 t/t6020-merge-df.sh             |    2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 865729a..ecddd9e 100644
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
+					/* There may be higher stage entries left
+					 * in the index (e.g. due to a D/F
+					 * conflict) that need to be resolved.
+					 */
+					for (i=1; i<=3; ++i) {
+						if (ren1->dst_entry->stages[i].mode)
+							ren1->dst_entry->processed = 0;
+					}
+				} else {
 					if (mfi.merge || !mfi.clean)
 						output(o, 1, "Renaming %s => %s", ren1_src, ren1_dst);
 					if (mfi.merge)
diff --git a/t/t3508-cherry-pick-merge-df.sh b/t/t3508-cherry-pick-merge-df.sh
index 646a56d..5895ea3 100755
--- a/t/t3508-cherry-pick-merge-df.sh
+++ b/t/t3508-cherry-pick-merge-df.sh
@@ -26,7 +26,7 @@ test_expect_success 'Setup rename across paths each below D/F conflicts' '
 	git commit -m "f1"
 '
 
-test_expect_failure 'Cherry-pick succeeds with rename across D/F conflicts' '
+test_expect_success 'Cherry-pick succeeds with rename across D/F conflicts' '
 	git checkout master &&
 	git cherry-pick branch
 '
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index e71c687..490d397 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -22,7 +22,7 @@ git commit -m "File: dir"'
 
 test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg" B master'
 
-test_expect_failure 'F/D conflict' '
+test_expect_success 'F/D conflict' '
 	git reset --hard &&
 	git checkout master &&
 	rm .git/index &&
-- 
1.7.1.1.10.g2e807
