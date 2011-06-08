From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 01/48] t6039: Add a testcase where git deletes an untracked file
Date: Wed,  8 Jun 2011 01:30:31 -0600
Message-ID: <1307518278-23814-2-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:28:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDCD-0005Hn-Ho
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab1FHH2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:28:53 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:37577 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216Ab1FHH2w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:28:52 -0400
Received: by pxi2 with SMTP id 2so191910pxi.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=bu8/1zmO8uKjzKlGo/oJQdkXP8YyLvTcX08c2Uyniew=;
        b=OgpLssz+gGEr0olnXHmuff7S6eed6VZxhdXjCL7MdD52KTpwKJTtEfYX9Ge0UqxDGL
         crFOvGgp7/oqGbHlT8STLw/tAA7HsAu1H42VAdvcEreUR2L/XvvQ5UpXIvSQBWeewzm7
         YJJXWBH3Y8h7pFug2w7O2JoWLIynKkwVDk8Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QjaaXL/qvmZze4suSK2Brdb7VVHyYTttqxREEq07Xxhhp62m65tnOEyNGRxRwj8jsW
         q2vclZgsaxziiCdKX7IsszIwkDVgsp0F47DC8/74wisZL0h+U5SR6MaowzjuVlay5PsI
         IiF5gmPNsBl0wxhaelBRA2rTEqCaczTlxBZH8=
Received: by 10.68.17.225 with SMTP id r1mr680379pbd.71.1307518131696;
        Wed, 08 Jun 2011 00:28:51 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.28.49
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:28:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175297>

Current git will nuke an untracked file during a rename/delete conflict if
(a) there is an untracked file whose name matches the source of a rename
and (b) the merge is done in a certain direction.  Add a simple testcase
demonstrating this bug.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh    |    2 +-
 t/t6039-merge-rename-corner-cases.sh |   36 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletions(-)
 create mode 100755 t/t6039-merge-rename-corner-cases.sh

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 871577d..319b6fa 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='recursive merge corner cases'
+test_description='recursive merge corner cases involving criss-cross merges'
 
 . ./test-lib.sh
 
diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
new file mode 100755
index 0000000..5054459
--- /dev/null
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description="recursive merge corner cases w/ renames but not criss-crosses"
+# t6036 has corner cases that involve both criss-cross merges and renames
+
+. ./test-lib.sh
+
+test_expect_success 'setup rename/delete + untracked file' '
+	echo "A pretty inscription" >ring &&
+	git add ring &&
+	test_tick &&
+	git commit -m beginning &&
+
+	git branch people &&
+	git checkout -b rename-the-ring &&
+	git mv ring one-ring-to-rule-them-all &&
+	test_tick &&
+	git commit -m fullname &&
+
+	git checkout people &&
+	git rm ring &&
+	echo gollum >owner &&
+	git add owner &&
+	test_tick &&
+	git commit -m track-people-instead-of-objects &&
+	echo "Myyy PRECIOUSSS" >ring
+'
+
+test_expect_failure "Does git preserve Gollum's precious artifact?" '
+	test_must_fail git merge -s recursive rename-the-ring &&
+
+	# Make sure git did not delete an untracked file
+	test -f ring
+'
+
+test_done
-- 
1.7.6.rc0.62.g2d69f
