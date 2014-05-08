From: dturner@twopensource.com
Subject: [PATCH 1/2] merge-recursive.c: Fix case-changing merge.
Date: Thu,  8 May 2014 10:23:33 -0700
Message-ID: <1399569814-20644-2-git-send-email-dturner@twopensource.com>
References: <536B4680.1010806@web.de>
 <1399569814-20644-1-git-send-email-dturner@twopensource.com>
Cc: gitster@pobox.com, David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 19:24:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiS3J-0002Zs-A8
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 19:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbaEHRYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 13:24:07 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:45107 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106AbaEHRYF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 13:24:05 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so3079559qga.6
        for <git@vger.kernel.org>; Thu, 08 May 2014 10:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uVIMGJnJvNVtRR3NlNtB90zk1pkHrpqqFPCA/moSdxI=;
        b=fYw5o9tVrn7g2jkGm3dQN+hXnCPXCg2xh2kNCgBn7khbG+9mzEB2ik0/kW0R3sGB7t
         Iojcw0iXjSxpgiD4M90iOq5Yw2iSQ8pZCv/LDJwuyY0q0sX768NeUv/rqqpO0kjLbk1Q
         f2E2+a7AScqFFe/mBNeUSFPCf1aUroG0aM6WNbJvHIZrFfOnkbT9vTvdmm3Tg8xwlCxK
         2K+LVbpijUQ4RoZXbGmJHoXuGk1oeI+xL2KNw63qFPzmeTLKeU5VJznxuXKaJD3Eui+4
         z1z9dQ8CoVfOVAViD+mjARP4Rwmz0KI3e95iLDS4oacuT+KS4jeevyhZ9Bunajj2tlh6
         qL5g==
X-Gm-Message-State: ALoCoQkPu+9zcKP8WMrjQgrj2LzwkV+Z4zQcy8qLDD3hCpbKRCImRGXh8hT3LbcRjz6oFuwZ3tee
X-Received: by 10.140.47.18 with SMTP id l18mr6753013qga.9.1399569844409;
        Thu, 08 May 2014 10:24:04 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id w8sm2339093qag.30.2014.05.08.10.24.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 May 2014 10:24:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.33.g27630aa
In-Reply-To: <1399569814-20644-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248425>

From: David Turner <dturner@twitter.com>

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
 merge-recursive.c           |  6 +++++
 t/t6039-merge-ignorecase.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100755 t/t6039-merge-ignorecase.sh

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
diff --git a/t/t6039-merge-ignorecase.sh b/t/t6039-merge-ignorecase.sh
new file mode 100755
index 0000000..dfc9f17
--- /dev/null
+++ b/t/t6039-merge-ignorecase.sh
@@ -0,0 +1,53 @@
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
+test_expect_success 'merge with case-changing rename' '
+	test $(git config core.ignorecase) = true &&
+	>TestCase &&
+	git add TestCase &&
+	git commit -m "add TestCase" &&
+	git tag baseline
+	git checkout -b with-camel &&
+	>foo &&
+	git add foo &&
+	git commit -m "intervening commit" &&
+	git checkout master &&
+	git rm TestCase &&
+	>testcase &&
+	git add testcase &&
+	git commit -m "rename to testcase" &&
+	git checkout with-camel &&
+	git merge master -m "merge" &&
+	test_path_is_file testcase
+'
+
+test_expect_success 'merge with case-changing rename on both sides' '
+	git checkout master &&
+	git reset --hard baseline &&
+	git branch -D with-camel &&
+	git checkout -b with-camel &&
+	git mv --force TestCase testcase &&
+	git commit -m "recase on branch" &&
+	>foo &&
+	git add foo &&
+	git commit -m "intervening commit" &&
+	git checkout master &&
+	git rm TestCase &&
+	>testcase &&
+	git add testcase &&
+	git commit -m "rename to testcase" &&
+	git checkout with-camel &&
+	git merge master -m "merge" &&
+	test_path_is_file testcase
+'
+
+test_done
-- 
2.0.0.rc0.33.g27630aa
