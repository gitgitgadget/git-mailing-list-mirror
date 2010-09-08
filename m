From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 1/2] t3509: Add rename + D/F conflict testcase that recursive strategy fails
Date: Wed,  8 Sep 2010 00:40:40 -0600
Message-ID: <1283928041-9882-2-git-send-email-newren@gmail.com>
References: <1283928041-9882-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, oinksocket@letterboxes.org,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 08:39:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtEJh-00060v-T2
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 08:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346Ab0IHGjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 02:39:24 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44654 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab0IHGjS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 02:39:18 -0400
Received: by mail-qw0-f46.google.com with SMTP id 6so5346455qwh.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rb7voV8az1Lj+lWRBwR566UQ10upBMdWd/mrnCBG4Zc=;
        b=aQ6D6nURZuUhEsDLCJXoLJAZOXHgJkWjaKqsbxXrWmBdm4VC2En64ZmhhjvjfPCglv
         8KSmM4agPzyAd50F3r4U6HxKvKcYDrlj6Dh1JHQYQTdWex7H6sUbFG3V9KOgn52ykju/
         dnggtv/2MX7ZsfsdeqxY6I2NHvnVsb7irLvJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=msdy0RBEEQXQtQPdXYaAFjcL6y6mOOL5IuGqcOMbUMUB7ihXj+QCJpd475Rp6qXrfg
         N4YWPJhOWzUEqDpYhtx0NtUQ/qwbQTFxKh0AYbWVlJlIzIZLHzspZozbOgTYtFOAh+UV
         cX9E3e3TQZ1nyqB2xZrCYE2PxaDKtgrZokgbg=
Received: by 10.224.62.199 with SMTP id y7mr1602395qah.293.1283927958255;
        Tue, 07 Sep 2010 23:39:18 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t4sm8076432qcs.40.2010.09.07.23.39.16
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 23:39:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc0.8.g2ec3f
In-Reply-To: <1283928041-9882-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155769>

When one side of a file rename matches a directory name on the other side,
the recursive merge strategy will fail.  This is true even if the merge is
trivially resolvable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3509-cherry-pick-merge-df.sh |   66 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index a5ccdbf..eb5826f 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -32,4 +32,70 @@ test_expect_success SYMLINKS 'Cherry-pick succeeds with rename across D/F confli
 	git cherry-pick branch
 '
 
+test_expect_success 'Setup rename with file on one side matching directory name on other' '
+	git checkout --orphan nick-testcase &&
+	git rm -rf . &&
+
+	>empty &&
+	git add empty &&
+	git commit -m "Empty file" &&
+
+	git checkout -b simple &&
+	mv empty file &&
+	mkdir empty &&
+	mv file empty &&
+	git add empty/file &&
+	git commit -m "Empty file under empty dir" &&
+
+	echo content >newfile &&
+	git add newfile &&
+	git commit -m "New file"
+'
+
+test_expect_success 'Cherry-pick succeeds with was_a_dir/file -> was_a_dir (resolve)' '
+	git reset --hard &&
+	git checkout -q nick-testcase^0 &&
+	git cherry-pick --strategy=resolve simple
+'
+
+test_expect_failure 'Cherry-pick succeeds with was_a_dir/file -> was_a_dir (recursive)' '
+	git reset --hard &&
+	git checkout -q nick-testcase^0 &&
+	git cherry-pick --strategy=recursive simple
+'
+
+test_expect_success 'Setup rename with file on one side matching different dirname on other' '
+	git reset --hard &&
+	git checkout --orphan mergeme &&
+	git rm -rf . &&
+
+	mkdir sub &&
+	mkdir othersub &&
+	echo content > sub/file &&
+	echo foo > othersub/whatever &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git rm -rf othersub &&
+	git mv sub/file othersub &&
+	git commit -m "Commit to merge" &&
+
+	git checkout -b newhead mergeme~1 &&
+	>independent-change &&
+	git add independent-change &&
+	git commit -m "Completely unrelated change"
+'
+
+test_expect_success 'Cherry-pick with rename to different D/F conflict succeeds (resolve)' '
+	git reset --hard &&
+	git checkout -q newhead^0 &&
+	git cherry-pick --strategy=resolve mergeme
+'
+
+test_expect_failure 'Cherry-pick with rename to different D/F conflict succeeds (recursive)' '
+	git reset --hard &&
+	git checkout -q newhead^0 &&
+	git cherry-pick --strategy=recursive mergeme
+'
+
 test_done
-- 
1.7.3.rc0.8.g2ec3f
