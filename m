From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 10/19] pull: support pull.ff config
Date: Sun, 14 Jun 2015 16:41:57 +0800
Message-ID: <1434271326-11349-11-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:43:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43Vn-0006Uq-GN
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbbFNInS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:18 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34358 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbFNIm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:42:57 -0400
Received: by pdbki1 with SMTP id ki1so51407383pdb.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dRS1wXWvybZOAxwNHogzEio+BplyzwoS3qp7tbQeF8Y=;
        b=fZuZxPfP5T4FSzonYFh+9OKZE4TDrTUdxeOLIcf9ktHgWrut50wtWjNx2Byq0WlWL1
         wpJEdEBPHIVhC5kH/vFEp4BZhY8ccftYvPTiN0GcmKKSfvMzIwPnIWeAMQ93m0JcgCCs
         PEiRw+BduWRZnGVCskuK8CqkKt3r4AOdhCBXMo7tmenahA77hgfqxVm9Dc/R9MMRQYCV
         bua5pxAtV7WO4LmqKsqrxKvZueu9BJUSizZ7vacek53WoRzo0H3VgJDFHHBji7XWJH4l
         AN9fcJUjr++v7vo7d2eRj6NYMUc/EQYIgy9liqoPeyomEEcVncMDiFy+wSFSCPGCZSSU
         WR6g==
X-Received: by 10.70.93.69 with SMTP id cs5mr37688960pdb.165.1434271376411;
        Sun, 14 Jun 2015 01:42:56 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.42.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:42:55 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271625>

Since b814da8 (pull: add pull.ff configuration, 2014-01-15), git-pull.sh
would lookup the configuration value of "pull.ff", and set the flag
"--ff" if its value is "true", "--no-ff" if its value is "false" and
"--ff-only" if its value is "only".

Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v3
    
    * style fixes

 builtin/pull.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 83691fc..0ddb964 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -167,6 +167,32 @@ static void argv_push_force(struct argv_array *arr)
 }
 
 /**
+ * If pull.ff is unset, returns NULL. If pull.ff is "true", returns "--ff". If
+ * pull.ff is "false", returns "--no-ff". If pull.ff is "only", returns
+ * "--ff-only". Otherwise, if pull.ff is set to an invalid value, die with an
+ * error.
+ */
+static const char *config_get_ff(void)
+{
+	const char *value;
+
+	if (git_config_get_value("pull.ff", &value))
+		return NULL;
+
+	switch (git_config_maybe_bool("pull.ff", value)) {
+	case 0:
+		return "--no-ff";
+	case 1:
+		return "--ff";
+	}
+
+	if (!strcmp(value, "only"))
+		return "--ff-only";
+
+	die(_("Invalid value for pull.ff: %s"), value);
+}
+
+/**
  * Appends merge candidates from FETCH_HEAD that are not marked not-for-merge
  * into merge_heads.
  */
@@ -397,6 +423,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
+	if (!opt_ff)
+		opt_ff = xstrdup_or_null(config_get_ff());
+
 	if (run_fetch(repo, refspecs))
 		return 1;
 
-- 
2.1.4
