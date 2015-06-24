From: David Turner <dturner@twopensource.com>
Subject: [PATCH 5/6] git-reflog: add create and exists functions
Date: Wed, 24 Jun 2015 15:16:27 -0400
Message-ID: <1435173388-8346-6-git-send-email-dturner@twopensource.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jun 24 21:17:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qAi-0000QE-7S
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbbFXTRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:17:16 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36514 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbbFXTRC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:17:02 -0400
Received: by iecvh10 with SMTP id vh10so39936874iec.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uE7m7ShR65D3RZO0ZqKfiVePqkFe/Q2CH+eiyICqen4=;
        b=jgkdLzJVg8py+kKhSWSACx51EKxz4vnS0ieVWXpMz7pieWIkU2mtREHuPJRRwiX8pD
         kU0GEBlf64ol/BQ7VhE7egJ5m+hejJm+AJOq1o9t51tTSi84nEJWviOQtssQNC2fMO4t
         Uwz7t9AzVxQ3C+MM/1oP1R3805e6Ey6iz2kYUlHoMWHY7QFHqQNM0W1ffCO6cAs/ZqMp
         fpyhJeKNQc3gDIy/wU2fS9RtY5089WOvtzGEHWkf8dSRu2YKBQCiNwpGGEZXfzY/Zjlj
         cZTAYBxlzFnASRq3E9fRLsNANWdqwm8YZASkCQu03N3seV7P/UoKfeOwDg5srMhScy9n
         v4cQ==
X-Gm-Message-State: ALoCoQmpmx/fMcF9IS6dBO//7pdRsZ1Sd6837qFBBkZ+eFsHpv33+Yb8AIN9TWjMPDt2PNpvkvmB
X-Received: by 10.42.135.69 with SMTP id o5mr3603040ict.47.1435173421717;
        Wed, 24 Jun 2015 12:17:01 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id p8sm1644609iga.13.2015.06.24.12.17.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2015 12:17:00 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272585>

These are necessary because ref backends manage reflogs. In a moment,
we will use these functions to make git stash work with alternate
ref backends.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/reflog.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index c2eb8ff..3cf7d3d 100644
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
@@ -699,12 +703,81 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+static int cmd_reflog_create(int argc, const char **argv, const char *prefix)
+{
+	int i, status = 0, start = 0;
+	struct strbuf err = STRBUF_INIT;
+	struct strbuf logfile = STRBUF_INIT;
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
+		if (create_reflog(argv[i], &logfile, &err)) {
+			error("could not create reflog %s: %s", argv[i],
+			      err.buf);
+			status = 1;
+			strbuf_release(&err);
+		}
+		strbuf_release(&logfile);
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
@@ -724,5 +797,11 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
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
