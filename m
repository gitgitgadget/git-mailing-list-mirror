From: dturner@twopensource.com
Subject: [PATCH 1/2] merge-recursive.c: Fix case-changing merge.
Date: Tue,  6 May 2014 15:59:03 -0700
Message-ID: <1399417144-24864-1-git-send-email-dturner@twopensource.com>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>
Cc: gitster@pobox.com, David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 01:00:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhoLV-0005uU-UE
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 01:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbaEFXAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 19:00:15 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:32826 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbaEFXAO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 19:00:14 -0400
Received: by mail-qa0-f46.google.com with SMTP id w8so183455qac.19
        for <git@vger.kernel.org>; Tue, 06 May 2014 16:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dSnJ6eOGfye9Y9MO87s8hHa4M71voO3pb2wYWEBy2as=;
        b=VN2nwwwXll4o8LY4R3JxEsS76tGuSM2vj6yaHb8UsFcJHriD1tsiOKbQqISXTmYer6
         9piYcOp1Eo8kQy1JiZEOONlSEmwYL8oM2m54lC7AZxfzfy8MFTyQ2laZH76UoUdh+CP9
         /YHicz9W4GaZdvn4YFe2MVL9F0Unh/CF3TsGBBbWeCvxBXlzok6c0QROjr0PqR9hU46K
         uEMLi8qV+5ITM2Zf3u++RfYe+5XewjWw8LAi17qFlcs3RdUJwx6cDsSrN9ukJ0CGeJOz
         NdjRi+SMx8y4bYb31GR9ZMr3CzjsHGp4V22FmUwZ0iLFrevWb5qjZe3F/IzlgjhTbMLK
         iU/A==
X-Gm-Message-State: ALoCoQl5F25jUM6r0Uy92uWTUrmy9tyd6+1LUL9Bhe4OAHNtfBdGU3gWyCsUHEgJtydyL714Wjg3
X-Received: by 10.140.36.149 with SMTP id p21mr55087583qgp.54.1399417213663;
        Tue, 06 May 2014 16:00:13 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id b17sm26150040qaq.25.2014.05.06.16.00.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 May 2014 16:00:11 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.33.g27630aa
In-Reply-To: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248267>

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
index 0000000..ad06752
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
+	> TestCase &&
+	git add TestCase &&
+	git commit -m "add TestCase" &&
+	git tag baseline
+	git checkout -b with-camel &&
+	> foo &&
+	git add foo &&
+	git commit -m "intervening commit" &&
+	git checkout master &&
+	git rm TestCase &&
+	> testcase &&
+	git add testcase &&
+	git commit -m "rename to testcase" &&
+	git checkout with-camel &&
+	git merge master -m "merge" &&
+	test -e testcase
+'
+
+test_expect_success 'merge with case-changing rename on both sides' '
+	git checkout master &&
+	git reset --hard baseline &&
+	git branch -D with-camel &&
+	git checkout -b with-camel &&
+	git mv --force TestCase testcase &&
+	git commit -m "recase on branch" &&
+	> foo &&
+	git add foo &&
+	git commit -m "intervening commit" &&
+	git checkout master &&
+	git rm TestCase &&
+	> testcase &&
+	git add testcase &&
+	git commit -m "rename to testcase" &&
+	git checkout with-camel &&
+	git merge master -m "merge" &&
+	test -e testcase
+'
+
+test_done
-- 
2.0.0.rc0.33.g27630aa
