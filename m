From: David Turner <dturner@twopensource.com>
Subject: [PATCH] merge-recursive.c: Fix case-changing merge bug
Date: Thu, 01 May 2014 20:21:09 -0400
Organization: Twitter
Message-ID: <1398990069.19099.5.camel@stross>
References: <CAE+yK_m_bPt2pS6MQOrpvVDuLAJf8NFxYOgM8i98tU6-gLcTDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 02:21:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg1ER-0004WY-0V
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbaEBAVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 20:21:13 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:60702 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbaEBAVM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 20:21:12 -0400
Received: by mail-qg0-f41.google.com with SMTP id j107so4059135qga.0
        for <git@vger.kernel.org>; Thu, 01 May 2014 17:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=ViY9CmlZvcxBSSrAWvyuP94plA3qP7q01KkuZ1qyDDs=;
        b=O6NQS+wPfGlog6tF5j8WgvYODZ7kOoZyB7RdTVkv9UmaeQcN092FgHHbMPfjbiCGjC
         lKgmc2Drr2fR7XXq9U1+n1p3EgEdr2jfiWygUdKPpVpOz1sLLVhvUIba/rHw2PtB6OiL
         CO2IhwbY6VSq8spjJUEWBur+r8jsYUgmy8X7Mw2kZhgkdyguYNdPApXb1mNqyASLvc7+
         5TrWOCw972bYrH+z7y17mWZk7cySm1/lNtv5khHf2pSp+z/g9JCn6DLtPjFpd6Y7LEOd
         eVrfJJSsCIwLMe7L6L/hUdwfT/u6hm3y8LwHlQP/zT7JWMajgs1xg1aa7r15KwBR6K44
         puIQ==
X-Gm-Message-State: ALoCoQnBw5EYPG7Ouf2y6OB6Psvl1m5/vInLGXCAXl00cMJyxN/vhtIxZRhSnTVyWpAse3mAOIt6
X-Received: by 10.229.179.65 with SMTP id bp1mr18112886qcb.11.1398990071955;
        Thu, 01 May 2014 17:21:11 -0700 (PDT)
Received: from [172.17.3.229] ([38.104.173.198])
        by mx.google.com with ESMTPSA id r14sm37200417qga.4.2014.05.01.17.21.10
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 01 May 2014 17:21:11 -0700 (PDT)
In-Reply-To: <CAE+yK_m_bPt2pS6MQOrpvVDuLAJf8NFxYOgM8i98tU6-gLcTDw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247910>

On a case-insensitive filesystem, when merging, a file would be
wrongly deleted from the working tree if an incoming commit had
renamed it changing only its case.  When merging a rename, the file
with the old name would be deleted -- but since the filesystem
considers the old name to be the same as the new name, the new
file would in fact be deleted.

We avoid this by not deleting files that have a case-clone in the
index at stage 0.

Signed-off-by: David Turner <dturner@twitter.com>
---
 merge-recursive.c           |  6 ++++++
 t/t7063-merge-ignorecase.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100755 t/t7063-merge-ignorecase.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index 4177092..cab16fa 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -589,6 +589,12 @@ static int remove_file(struct merge_options *o, int clean,
 			return -1;
 	}
 	if (update_working_directory) {
+		if (ignore_case) {
+			struct cache_entry *ce;
+			ce = cache_file_exists(path, strlen(path), ignore_case);
+			if (ce && ce_stage(ce) == 0)
+				return 0;
+		}
 		if (remove_path(path))
 			return -1;
 	}
diff --git a/t/t7063-merge-ignorecase.sh b/t/t7063-merge-ignorecase.sh
new file mode 100755
index 0000000..6d4959f
--- /dev/null
+++ b/t/t7063-merge-ignorecase.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='git-merge with case-changing rename on case-insensitive file system'
+
+. ./test-lib.sh
+
+if ! test_have_prereq CASE_INSENSITIVE_FS
+then
+	skip_all='skipping case insensitive tests - case sensitive file system'
+	test_done
+fi
+
+test_expect_success 'merge with case-changing rename with ignorecase=true' '
+	test $(git config core.ignorecase) = true &&
+	touch TestCase &&
+	git add TestCase &&
+	git commit -m "add TestCase" &&
+	git checkout -b with-camel &&
+	touch foo &&
+	git add foo &&
+	git commit -m "intervening commit" &&
+	git checkout master &&
+	git rm TestCase &&
+	touch testcase &&
+	git add testcase &&
+	git commit -m "rename to testcase" &&
+	git checkout with-camel &&
+	git merge master -m "merge" &&
+	test -e testcase
+'
+
+test_done
-- 
