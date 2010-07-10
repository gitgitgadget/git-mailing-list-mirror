From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH 1/2] add basic tests for merge-tree
Date: Sat, 10 Jul 2010 01:53:50 +0100
Message-ID: <1278723231-24802-2-git-send-email-wmpalmer@gmail.com>
References: <1278723231-24802-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 10 02:54:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXOKu-0002K5-FT
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 02:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396Ab0GJAyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 20:54:23 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65329 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab0GJAyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 20:54:22 -0400
Received: by mail-ww0-f44.google.com with SMTP id 24so5477771wwb.1
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 17:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eQn2pXLPs82auJlGw0etfdFxs6/EE/dE059lZqbQvgs=;
        b=vh3pL+gzCf/QVIFij+fPElzAfaacJF0YBvIZ6/EZGPB5YkwJM3qSb5kL3BHKaQRhfP
         tQaPp7Yf3zNT5rkQhNtqaTbqYreMZqMVX5NlrhXGpTbGnb1ESVkTeuR1tMZ5MwIAijfU
         LBvUQDcteAnjI1jBkJGTJy5eSlI2jhzClsgS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lSRGWptNLA2woanh072ugsOfTj/NPLS7xYRD56xKAVMNsFRaRWPd4JoLUGINtBsIC0
         ZyaMbwQFSHouwDf7zjUcouR42byGGJB8k8OJtjF3tKW2oJzXfqPwYuDVOh6YnxKm65F0
         C+XdGu356oNxFOBpKtx8yNmq0Aah11TvMtQMI=
Received: by 10.227.72.197 with SMTP id n5mr9081334wbj.198.1278723256770;
        Fri, 09 Jul 2010 17:54:16 -0700 (PDT)
Received: from localhost.localdomain (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id i25sm10539963wbi.4.2010.07.09.17.54.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 17:54:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.703.g42c01
In-Reply-To: <1278723231-24802-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150703>

merge-tree had no test cases, so here we add some very basic tests for
it, including one known-breakage.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 t/t4300-merge-tree.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100755 t/t4300-merge-tree.sh

diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
new file mode 100755
index 0000000..afcb89d
--- /dev/null
+++ b/t/t4300-merge-tree.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Will Palmer
+#
+
+test_description='git merge-tree'
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit "initial"
+'
+
+test_expect_success 'both added same' '
+	git reset --hard initial
+	test_commit "same-A" "ONE" "AAA" 
+
+	git reset --hard initial
+	test_commit "same-B" "ONE" "AAA"
+
+	git merge-tree initial same-A same-B
+'
+
+test_expect_success 'both added conflict' '
+	git reset --hard initial
+	test_commit "diff-A" "ONE" "AAA" 
+
+	git reset --hard initial
+	test_commit "diff-B" "ONE" "BBB"
+
+	git merge-tree initial diff-A diff-B
+'
+
+test_expect_failure 'nothing similar' '
+	git reset --hard initial
+	test_commit "no-common-A" "ONE" "AAA" 
+
+	git reset --hard initial
+	test_commit "no-common-B" "TWO" "BBB"
+
+	git merge-tree initial no-common-A no-common-B
+'
+
+test_done
-- 
1.7.1.703.g42c01
