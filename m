From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 06/12] git p4: standardize submit cancel due to unchanged template
Date: Thu, 16 Aug 2012 19:35:08 -0400
Message-ID: <1345160114-27654-7-git-send-email-pw@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:37:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29d0-0004Qs-4K
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300Ab2HPXhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:37:19 -0400
Received: from honk.padd.com ([74.3.171.149]:47769 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab2HPXhS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:37:18 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 66881D27;
	Thu, 16 Aug 2012 16:37:17 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 2FF53313FD; Thu, 16 Aug 2012 19:37:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.111.g96f7c73
In-Reply-To: <1345160114-27654-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When editing the submit template, if no change was made to it,
git p4 offers a prompt "Submit anyway?".  Answering "no" cancels
the submit.

Previously, a "no" answer behaves like a "[s]kip" answer to the
failed-patch prompt, in that it proceeded to try to apply the
rest of the commits.  Instead, put users back into the new
"[s]kip / [c]ontinue" loop so that they can decide.  This makes
both cases of patch failure behave identically.

The return code of git p4 after a "no" answer is now the same
as that for a "skip" due to failed patch; update a test to
understand this.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                          | 4 +++-
 t/t9805-git-p4-skip-submit-edit.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 1d5194d..075f477 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1262,6 +1262,7 @@ class P4Submit(Command, P4UserMap):
 
         if self.edit_template(fileName):
             # read the edited message and submit
+            ret = True
             tmpFile = open(fileName, "rb")
             message = tmpFile.read()
             tmpFile.close()
@@ -1285,6 +1286,7 @@ class P4Submit(Command, P4UserMap):
 
         else:
             # skip this patch
+            ret = False
             print "Submission cancelled, undoing p4 changes."
             for f in editedFiles:
                 p4_revert(f)
@@ -1293,7 +1295,7 @@ class P4Submit(Command, P4UserMap):
                 os.remove(f)
 
         os.remove(fileName)
-        return True  # success
+        return ret
 
     # Export git tags as p4 labels. Create a p4 label and then tag
     # with that.
diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index fb3c8ec..ff2cc79 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -38,7 +38,7 @@ test_expect_success 'no config, unedited, say no' '
 		cd "$git" &&
 		echo line >>file1 &&
 		git commit -a -m "change 3 (not really)" &&
-		printf "bad response\nn\n" | git p4 submit &&
+		printf "bad response\nn\n" | test_expect_code 1 git p4 submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count = 2 wc
 	)
-- 
1.7.11.4
