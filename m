From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 04/48] t6039: Add a testcase where undetected rename causes silent file deletion
Date: Wed,  8 Jun 2011 01:30:34 -0600
Message-ID: <1307518278-23814-5-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:32:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDFw-0007ZU-Ab
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab1FHHcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:32:31 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43667 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498Ab1FHH26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:28:58 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so118978pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=vVpJkcV4M6Cx8N8+SahRLw2bIVC5bHxR89LHwyA43ws=;
        b=VBapamS0GSRhyXypMQoufkHRUmTHJfR2Jl1FD2B30rshkCsFssiJ3nPAVkKoohUSPk
         nJXQmV4wEN9as+OyB/4XbYZ91XS4SOmrj284n+Slup5PP/TNcp6Bf4ux5Ek+FsbH1A22
         DhjOJBhm8VUs2M9fBP58XWi/HSnbnakrQ70rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mZd0zzn0G81TUafHjW39Bv9vdq3j4A2DUrVKdyWAhWIpjbZFv7BlvMV2BksmFMQjv1
         I3+lo7fxNZyXXHy6dU3Q7u/lCU/9g8HEOvzFT5MTy0dLk5yjde36qC4FSxQUMehrYgLq
         L60bGuFW+b21F8AflR/fdqMCM14DiwFx2AjYk=
Received: by 10.68.27.130 with SMTP id t2mr621125pbg.230.1307518137952;
        Wed, 08 Jun 2011 00:28:57 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.28.55
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:28:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175344>

There are cases where history should merge cleanly, and which current git
does merge cleanly despite not detecting a rename; however the merge
currently nukes files that should not be removed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6039-merge-rename-corner-cases.sh |   65 ++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index f338fb4..db5560c 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -133,4 +133,69 @@ test_expect_failure 'missed conflict if rename not detected' '
 	test_must_fail git merge -s recursive D^0
 '
 
+# Tests for undetected rename/add-source causing a file to erroneously be
+# deleted (and for mishandled rename/rename(1to1) causing the same issue).
+#
+# This test uses a rename/rename(1to1)+add-source conflict (1to1 means the
+# same file is renamed on both sides to the same thing; it should trigger
+# the 1to2 logic, which it would do if the add-source didn't cause issues
+# for git's rename detection):
+#   Commit A: new file: a
+#   Commit B: rename a->b
+#   Commit C: rename a->b, add unrelated a
+
+test_expect_success 'setup undetected rename/add-source causes data loss' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n" >a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a b &&
+	echo foobar >a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_failure 'detect rename/add-source and preserve all data' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test -f a &&
+	test -f b &&
+
+	test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
+	test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
+'
+
+test_expect_failure 'detect rename/add-source and preserve all data, merge other way' '
+	git checkout C^0 &&
+
+	git merge -s recursive B^0 &&
+
+	test 2 -eq $(git ls-files -s | wc -l) &&
+	test 2 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test -f a &&
+	test -f b &&
+
+	test $(git rev-parse HEAD:b) = $(git rev-parse A:a) &&
+	test $(git rev-parse HEAD:a) = $(git rev-parse C:a)
+'
+
 test_done
-- 
1.7.6.rc0.62.g2d69f
