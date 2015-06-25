From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 5/6] git-reflog: add create and exists functions
Date: Thu, 25 Jun 2015 16:45:09 -0400
Message-ID: <1435265110-6414-5-git-send-email-dturner@twopensource.com>
References: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jun 25 22:45:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8E1s-0006E5-6v
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 22:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbbFYUpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 16:45:42 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34923 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbbFYUpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 16:45:31 -0400
Received: by igblr2 with SMTP id lr2so539119igb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 13:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pUEcnrPAFTwM7GL38FfQWGpvaFN76PAoirVNtUWfZMc=;
        b=MIchtK70acU6EoPPbrZR9GxJrWGnl6dmxi46Gr13g5ynvm1yIH3SLm6cB9f5rxOZE3
         d12zpK0UuXiTxYgm36495chiE1uTx9uAt1Tlf3g7d9jlKrD3mhYkqcN3bQDHFPprTL1f
         +7YVpXdvaBd6hf+q/XEC2Zw14ptNQwdUH7C69cRzQDqVq2+3+TF/dXVSCk1xC2AZPDfr
         Qr2rMVXLPRycbKsxcMCkGKAscARdSGoPGeqLuMun3v2sGQSOVoTHkqASsXIXyvWBMaO/
         qwpPLyi8y1AlDUZvgoemKWveLHvLufI8CZ02X5rQADwHfDpEuu1GDQXXAzAz2RnuhSOP
         T3hQ==
X-Gm-Message-State: ALoCoQmUW8ATIvoQD8VFn0bNacSmrh5eICEborb6iTNeieH3l9Zm/X5xH5ph/1hhOaMJwdPbx7iL
X-Received: by 10.107.12.72 with SMTP id w69mr63327864ioi.10.1435265130192;
        Thu, 25 Jun 2015 13:45:30 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id fv2sm4042683igb.22.2015.06.25.13.45.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 13:45:29 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435265110-6414-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272730>

These are necessary because ref backends manage reflogs. In a moment,
we will use these functions to make git stash work with alternate
ref backends.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/reflog.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index c2eb8ff..a64158d 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -13,6 +13,10 @@ static const char reflog_expire_usage[] =
 "git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
 static const char reflog_delete_usage[] =
 "git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
+static const char reflog_create_usage[] =
+"git reflog create <refs>...";
+static const char reflog_exists_usage[] =
+"git reflog exists <refs>...";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
@@ -699,12 +703,79 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+static int cmd_reflog_create(int argc, const char **argv, const char *prefix)
+{
+	int i, status = 0, start = 0;
+	struct strbuf err = STRBUF_INIT;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		else if (arg[0] == '-')
+			usage(reflog_create_usage);
+		else
+			break;
+	}
+
+	start = i;
+
+	if (argc - start < 1)
+		return error("Nothing to create?");
+
+	for (i = start ; i < argc; i++) {
+		if (check_refname_format(argv[i], REFNAME_ALLOW_ONELEVEL))
+			die("invalid ref format: %s", argv[i]);
+	}
+	for (i = start ; i < argc; i++) {
+		if (safe_create_reflog(argv[i], &err)) {
+			error("could not create reflog %s: %s", argv[i],
+			      err.buf);
+			status = 1;
+			strbuf_release(&err);
+		}
+	}
+	return status;
+}
+
+static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
+{
+	int i, status = 0, start = 0;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		else if (arg[0] == '-')
+			usage(reflog_exists_usage);
+		else
+			break;
+	}
+
+	start = i;
+
+	if (argc - start < 1)
+		return error("Nothing to check?");
+
+	for (i = start ; i < argc; i++) {
+		if (check_refname_format(argv[i], REFNAME_ALLOW_ONELEVEL))
+			die("invalid ref format: %s", argv[i]);
+		if (!reflog_exists(argv[i]))
+			status = 1;
+	}
+	return status;
+}
+
 /*
  * main "reflog"
  */
 
 static const char reflog_usage[] =
-"git reflog [ show | expire | delete ]";
+"git reflog [ show | expire | delete | create | exists ]";
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
@@ -724,5 +795,11 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "delete"))
 		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
 
+	if (!strcmp(argv[1], "create"))
+		return cmd_reflog_create(argc - 1, argv + 1, prefix);
+
+	if (!strcmp(argv[1], "exists"))
+		return cmd_reflog_exists(argc - 1, argv + 1, prefix);
+
 	return cmd_log_reflog(argc, argv, prefix);
 }
-- 
2.0.4.314.gdbf7a51-twtrsrc
