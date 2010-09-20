From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 03/37] t6032: Add a test checking for excessive output from merge
Date: Mon, 20 Sep 2010 02:28:36 -0600
Message-ID: <1284971350-30590-4-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjO-0005rH-Ip
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455Ab0ITI1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:27:37 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63878 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab0ITI1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:37 -0400
Received: by pxi10 with SMTP id 10so1072016pxi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9p5FoD21M8zSkYYL1fT0DzoOQhuJEkWC6A88JXD/8Fg=;
        b=eTXM/Qc14LwnldgE8pWpOlXsEIwU/8P4Bh5I8SdctlA+x4DUcLuVT1xIVrFlqidDov
         JvtTpvF66ejHsiAeH6n+Gten7HG7NdJEfpSTLmUAqlTHMtFmWdGVkjRf5TzmgaJG4iq2
         paRxcImW6Yegdq8aS9mrrNlBrSG7mEKotgma4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IJwT+7DxpreS4JyOGazgR6X2E+obdEDYKfdX/CN2blygrct/CPbR+JnlQJlZ4X2Ew9
         OhbT5DGcnlaogxd5bgK7MX3ga8SizPjgBC7EJinv3iL75ICILEDYL05orkMRdX+Rly5J
         jZ6/XdMGZiHapFoohsobh0X0TcojERjMuD4EU=
Received: by 10.142.209.15 with SMTP id h15mr7343099wfg.271.1284971256581;
        Mon, 20 Sep 2010 01:27:36 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156560>

Previous D/F fixes I submitted (5a2580d and ae74548) had caused merge to
become excessively spammy, which was fixed in 96ecac6 (merge-recursive:
Avoid excessive output for and reprocessing of renames 2010-08-20).  Add a
new test to avoid repeating that mistake with my several upcoming changes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6032-merge-large-rename.sh |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/t/t6032-merge-large-rename.sh b/t/t6032-merge-large-rename.sh
index eac5eba..fdb6c25 100755
--- a/t/t6032-merge-large-rename.sh
+++ b/t/t6032-merge-large-rename.sh
@@ -70,4 +70,34 @@ test_expect_success 'set merge.renamelimit to 5' '
 test_rename 5 ok
 test_rename 6 fail
 
+test_expect_success 'setup large simple rename' '
+	git config --unset merge.renamelimit &&
+	git config --unset diff.renamelimit &&
+
+	git reset --hard initial &&
+	for i in $(count 200); do
+		make_text foo bar baz >$i
+	done &&
+	git add . &&
+	git commit -m create-files &&
+
+	git branch simple-change &&
+	git checkout -b simple-rename &&
+
+	mkdir builtin &&
+	git mv [0-9]* builtin/ &&
+	git commit -m renamed &&
+
+	git checkout simple-change &&
+	>unrelated-change &&
+	git add unrelated-change &&
+	git commit -m unrelated-change
+'
+
+test_expect_success 'massive simple rename does not spam added files' '
+	unset GIT_MERGE_VERBOSITY &&
+	git merge --no-stat simple-rename | grep -v Removing >output &&
+	test 5 -gt "$(wc -l < output)"
+'
+
 test_done
-- 
1.7.3.271.g16009
