From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/3] t7502-commit: add summary output tests for empty and merge commits
Date: Mon, 24 May 2010 17:47:31 +0800
Message-ID: <1274694452-4200-3-git-send-email-rctay89@gmail.com>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
 <1274694452-4200-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 24 11:48:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGUGc-0007Tl-6Y
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 11:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab0EXJry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 05:47:54 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:47671 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab0EXJrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 05:47:53 -0400
Received: by mail-pz0-f185.google.com with SMTP id 15so2011588pzk.15
        for <git@vger.kernel.org>; Mon, 24 May 2010 02:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2rXxtNmmcKVTQ4QO411xMeiz/5afS+DdEhMmQZWti3c=;
        b=MbbNnMTyH7yYZAF5KLWPda6GhNVRv8Y6WMA80eDwQaUdNjNYpHqKsik35GtYuEFR7R
         0/d/h+Zh8Wn9QOHGLMCVxhHK5tWug9gHGJAiSRYXNj/3j2yGcjzf2qSulga0uY9mQWDP
         ClzVoVW428Wt4U+Vn4tAF37d8ggHqArDNymmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Rsw4FHLmd2R9Q+YaJ4vfZOu8KW3DMWgaS4Ndhm3kE/mSJeQLHhhFZLZ3HLH62X/j9n
         eM7/JX2XzXySAJ0vxG88roBw0QFrTaw8N8YfMDK+ENI3AMQEVf2tyNjbVoh5WjyPUbW7
         mMJDWkbP9puagaVuH0rfpuuL2wQ/W6t1ZDgXM=
Received: by 10.114.19.19 with SMTP id 19mr4672731was.17.1274694472396;
        Mon, 24 May 2010 02:47:52 -0700 (PDT)
Received: from localhost.localdomain (cm218.zeta152.maxonline.com.sg [116.87.152.218])
        by mx.google.com with ESMTPS id n29sm37041273wae.4.2010.05.24.02.47.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 02:47:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.259.g405af
In-Reply-To: <1274694452-4200-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147618>

After c197702 (pretty: Respect --abbrev option), non-abbreviated hashes
began to appear, leading to failures for these tests.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t7502-commit.sh |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 589e8e6..8a4a277 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -4,10 +4,10 @@ test_description='git commit porcelain-ish'
 
 . ./test-lib.sh
 
-# Arguments: [<prefix] [<commit message>]
+# Arguments: [<prefix] [<commit message>] [<commit options>]
 check_summary_oneline() {
 	test_tick &&
-	git commit -m "$2" | head -1 > act &&
+	echo "$3" | xargs git commit -m "$2" | head -1 > act &&
 
 	# branch name
 	SUMMARY_PREFIX="$(git name-rev --name-only HEAD)" &&
@@ -36,6 +36,31 @@ test_expect_success 'output summary format' '
 	check_summary_oneline "" "a change"
 '
 
+test_expect_failure 'output summary format for commit with an empty diff' '
+
+	check_summary_oneline "" "empty" "--allow-empty"
+'
+
+test_expect_failure 'output summary format for merges' '
+
+	git checkout -b recursive-base &&
+	test_commit base file1 &&
+
+	git checkout -b recursive-a recursive-base &&
+	test_commit commit-a file1 &&
+
+	git checkout -b recursive-b recursive-base &&
+	test_commit commit-b file1 &&
+
+	# conflict
+	git checkout recursive-a &&
+	test_must_fail git merge recursive-b &&
+	# resolve the conflict
+	echo commit-a > file1 &&
+	git add file1 &&
+	check_summary_oneline "" "Merge"
+'
+
 test_expect_success 'the basics' '
 
 	# this is needed for the "partial removal" test to pass
-- 
1.7.1.189.g07419
