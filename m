From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 4/6] merge_recursive: Fix renames across paths below D/F conflicts
Date: Fri,  9 Jul 2010 07:10:54 -0600
Message-ID: <1278681056-31460-5-git-send-email-newren@gmail.com>
References: <1278681056-31460-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, agladysh@gmail.com,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 09 15:03:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXDEw-000077-Sj
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 15:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756211Ab0GINDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 09:03:17 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45877 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab0GINDK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 09:03:10 -0400
Received: by pwi5 with SMTP id 5so806555pwi.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 06:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jbesr4b0k4bWlnypE8JHR7xaIMxPjlTXqbgSFSm4tmE=;
        b=u0gh2tZSrRi+C32tCMAGxaqKNez7NvTZTzy6G+fdmZAlRdS0DSeE6uo4eEkfyyhxtX
         fMZ2co3vyHhFaM3GVAJF8ZqQ6B1v2PWG/tkLkllXTf//4Tm2sTbHs/76zEhaUnIgZncM
         AB3005zel0mzfJdAUxBrzNpmu2TwYRVx7JwMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CzbHD/C9wLTaKRnURHlDaN6eEHHU4HvrPMXsfJIitruVNKxCDclrR89KmfL9Mgflh3
         lA31ZIdmO9wDxpmKUxB9Hg/DReoTXuo8isru3szqRepEV6WGNNbbvm3gcrcT8gX/o/47
         ze1aiyHBStO7D9hpZqXFLf/P5D1c1qOVCvDsY=
Received: by 10.142.134.7 with SMTP id h7mr11678049wfd.247.1278680588624;
        Fri, 09 Jul 2010 06:03:08 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id b1sm700259rvn.2.2010.07.09.06.03.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 06:03:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1.23.gafea6
In-Reply-To: <1278681056-31460-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150664>

The rename logic in process_renames() handles renames and merging of file
contents and then marks files as processed.  However, there may be higher
stage entries left in the index for other reasons (e.g., due to D/F
conflicts).  By checking for such cases and marking the entry as not
processed, it allows process_entry() later to look at it and handle those
higher stages.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c               |   15 +++++++++++++--
 t/t3509-cherry-pick-merge-df.sh |    2 +-
 t/t6020-merge-df.sh             |    2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 7d0c27d..8f4b7d4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1019,14 +1019,25 @@ static int process_renames(struct merge_options *o,
 
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
+					for (i = 1; i <= 3; i++) {
+						if (!ren1->dst_entry->stages[i].mode)
+							continue;
+						ren1->dst_entry->processed = 0;
+						break;
+					}
+				} else {
 					if (mfi.merge || !mfi.clean)
 						output(o, 1, "Renaming %s => %s", ren1_src, ren1_dst);
 					if (mfi.merge)
diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index 7c05e16..6e7ef84 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -26,7 +26,7 @@ test_expect_success 'Setup rename across paths each below D/F conflicts' '
 	git commit -m f1
 '
 
-test_expect_failure 'Cherry-pick succeeds with rename across D/F conflicts' '
+test_expect_success 'Cherry-pick succeeds with rename across D/F conflicts' '
 	git reset --hard &&
 	git checkout master^0 &&
 	git cherry-pick branch
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
1.7.1.1.23.gafea6
