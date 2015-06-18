From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 10/19] pull: support pull.ff config
Date: Thu, 18 Jun 2015 18:54:03 +0800
Message-ID: <1434624852-6869-11-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:04:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xc3-00018B-Q8
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbbFRK4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:56:04 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36694 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbbFRKzM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:12 -0400
Received: by paceq1 with SMTP id eq1so34539497pac.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f1AdlbO7rWLYrzhcv76FalDmHVv42nZdgt1vdTmJtpQ=;
        b=z3WOmpa0YMFiyczMXb2J3zz7iB4LDQ8TOYrKotN1eC0AMQVjgeJaO4Jkx1yvZWxfSY
         tos+9KsWhmHCyKUKk2OysriVCmZUszSjhbJdWNhgLcRO3R5qCaDz0ZTZXQjCNcutDCMN
         s9yFuo5pgwbMllkX/jQER0nZzFjok92afxEbBa3c0u6djbWjDq0EwKENNAgMMDdr69E4
         qYrAhsiCUKOdKTC5qoVQz1ExZLAmvabJHHzte8+/GEhAkV05nTx6j3h+8vXexmyg4+Qq
         hu+Ge/SpK/l94twvdxd1hEbJ8a95KKA15tY56BsLdYhbJGjZbekx9XoaXYWWqEwHEvsC
         oNsw==
X-Received: by 10.66.233.232 with SMTP id tz8mr19927880pac.77.1434624912070;
        Thu, 18 Jun 2015 03:55:12 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.55.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:10 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271955>

Since b814da8 (pull: add pull.ff configuration, 2014-01-15), git-pull.sh
would lookup the configuration value of "pull.ff", and set the flag
"--ff" if its value is "true", "--no-ff" if its value is "false" and
"--ff-only" if its value is "only".

Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 647bcb9..b61cff5 100644
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
