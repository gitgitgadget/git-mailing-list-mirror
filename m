From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/5] t/t3511: demonstrate breakage in cherry-pick -s
Date: Wed, 14 Nov 2012 17:37:51 -0800
Message-ID: <1352943474-15573-2-git-send-email-drafnel@gmail.com>
References: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
Cc: Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 02:38:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYoPT-0006mb-2C
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 02:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992547Ab2KOBiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 20:38:10 -0500
Received: from mail-ye0-f174.google.com ([209.85.213.174]:42040 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992516Ab2KOBiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 20:38:09 -0500
Received: by mail-ye0-f174.google.com with SMTP id m12so243438yen.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 17:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nHndPjBPu47TaprPufMfJO/t5V952LN04HVJ0uhZISg=;
        b=KuChDi3nzm6E1OxahY0UUfyv25hA3P+ScrSQdZrsUJdViFs848xOGl/03K966joSyy
         TE9IqS5CLldR0R0+lU8Smtl3bxefZb5/G8V83aogtCcZtc28O/0LC1Fh53BpaBByX8aV
         jJJICfi1VzefvrCpW2zmQWo3dpbZqN3ncINMfAF0iqTyGVCI/hv3jaDqZ35TukFcFb0W
         xd8U+h56Ar+HDBtRk8bpffU1QIfgpwUflMc/+e3na7fMvYnie/fGanjtoz/fAmTMi/6/
         aa/kswWX/yXZtkKfYQZmFzxRhEkOT3gGtJO2g4Qk1G/Ror82BbVRLKgxlzpy+He/8sse
         R0EA==
Received: by 10.236.81.204 with SMTP id m52mr28094933yhe.55.1352943488862;
        Wed, 14 Nov 2012 17:38:08 -0800 (PST)
Received: from charliebrown.corp.google.com ([216.239.55.194])
        by mx.google.com with ESMTPS id y9sm4775632anh.20.2012.11.14.17.38.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 17:38:08 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209782>

The cherry-pick -s functionality is currently broken in two ways.

   1. handling of rfc2822 continuation lines has a bug, and the
      continuation lines are not handled correctly.
   2. the "(cherry picked from ...)" lines are commonly appended to the
      end of the s-o-b footer and should be detected as part of the footer.
      They should not cause a new line to be inserted before the new s-o-b
      is added.

      i.e. we should produce this:

         Signed-off-by: A.U. Thor <author@example.com>
         (cherry picked from )
         Signed-off-by: C O Mmitter <committer@example.com>

      not

         Signed-off-by: A.U. Thor <author@example.com>
         (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)

         Signed-off-by: C O Mmitter <committer@example.com>

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 t/t3511-cherry-pick-x.sh | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100755 t/t3511-cherry-pick-x.sh

diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
new file mode 100755
index 0000000..b4e5c65
--- /dev/null
+++ b/t/t3511-cherry-pick-x.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+
+test_description='Test cherry-pick -x and -s'
+
+. ./test-lib.sh
+
+pristine_detach () {
+	git cherry-pick --quit &&
+	git checkout -f "$1^0" &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x
+}
+
+non_rfc2822_mesg='base with footer
+
+Commit message body is here.'
+
+rfc2822_mesg="$non_rfc2822_mesg
+
+Signed-off-by: A.U. Thor
+ <author@example.com>
+Signed-off-by: B.U. Thor <buthor@example.com>"
+
+rfc2822_cherry_mesg="$rfc2822_mesg
+(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
+Tested-by: C.U. Thor <cuthor@example.com>"
+
+
+test_expect_success setup '
+	git config advice.detachedhead false &&
+	echo unrelated >unrelated &&
+	git add unrelated &&
+	test_commit initial foo a &&
+	test_commit "$non_rfc2822_mesg" foo b non-rfc2822-base &&
+	git reset --hard initial &&
+	test_commit "$rfc2822_mesg" foo b rfc2822-base &&
+	git reset --hard initial &&
+	test_commit "$rfc2822_cherry_mesg" foo b rfc2822-cherry-base &&
+	pristine_detach initial &&
+	test_commit conflicting unrelated
+'
+
+test_expect_success 'cherry-pick -s inserts blank line after non-rfc2822 footer' '
+	pristine_detach initial &&
+	git cherry-pick -s non-rfc2822-base &&
+	cat <<-EOF >expect &&
+		$non_rfc2822_mesg
+
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'cherry-pick -s not confused by rfc2822 continuation line' '
+	pristine_detach initial &&
+	git cherry-pick -s rfc2822-base &&
+	cat <<-EOF >expect &&
+		$rfc2822_mesg
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'cherry-pick treats -s "(cherry picked from..." line as part of footer' '
+	pristine_detach initial &&
+	git cherry-pick -s rfc2822-cherry-base &&
+	cat <<-EOF >expect &&
+		$rfc2822_cherry_mesg
+		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.0
