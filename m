From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 6/7] git-reflog: add create and exists functions
Date: Thu, 25 Jun 2015 20:29:07 -0400
Message-ID: <1435278548-3790-6-git-send-email-dturner@twopensource.com>
References: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jun 26 02:30:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8HWj-0005HM-MS
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 02:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbbFZA3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 20:29:48 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36557 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbbFZA3j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 20:29:39 -0400
Received: by iecvh10 with SMTP id vh10so65738845iec.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 17:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1ndeVt8P5ukdf/vXqUH6Z16lbKklW/ekkL9ANc82KbQ=;
        b=by233KElWblAYr1CXd4IiCatoBvpr2CFqp0Rq9dRYUt/hmXkhQOtIM5f8iJPvgw7Fu
         cVLIhBLBXGyyv42AnqNcDzwgMPktGsscRbo3WmvZWDUImztOd1bevj5EhXreQfjb9fw4
         ArFf2auqYgedMOq8j6GIKnFQVn4vvAT0dsTWcvZEUgzae4dbANhPc34mDoO7IowT9Y7A
         FTqGK6Cxn3WUtnqPiVx6r+MQMjeC/7wcmHa/J3RMPTav5S8KEery6cZJfo+SMUgQyRbM
         AfVxU4f/FKCKlBmOZehecyXFzq1qCs/HZGspb+U8ryoFRju8qOAT/evfYoX3oMOy0Kie
         qIOg==
X-Gm-Message-State: ALoCoQl5RWJ9G1rTfmcovNYPgRjjaIzC3XY8MmjKTA+KypiH84SdH/4xV+vUDuIjXGXNK4Br4tzw
X-Received: by 10.50.66.167 with SMTP id g7mr430691igt.22.1435278578289;
        Thu, 25 Jun 2015 17:29:38 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id i85sm20714344iod.41.2015.06.25.17.29.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 17:29:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272754>

These are necessary because alternate ref backends might store reflogs
somewhere other than .git/logs.  Code that now directly manipulates
.git/logs should instead go through git-reflog.

In a moment, we will use these functions to make git stash work with
alternate ref backends.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/reflog.c       | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t1411-reflog-show.sh | 12 ++++++++
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index c2eb8ff..7fe31fa 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -13,6 +13,10 @@ static const char reflog_expire_usage[] =
 "git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
 static const char reflog_delete_usage[] =
 "git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
+static const char reflog_create_usage[] =
+"git reflog create <refs>...";
+static const char reflog_exists_usage[] =
+"git reflog exists <ref>";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
@@ -699,12 +703,79 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+static int cmd_reflog_create(int argc, const char **argv, const char *prefix)
+{
+	int i, status = 0, start = 0;
+	struct strbuf err = STRBUF_INIT;
+	int temp;
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
+	temp = log_all_ref_updates;
+	log_all_ref_updates = 1;
+	for (i = start; i < argc; i++) {
+		if (check_refname_format(argv[i], REFNAME_ALLOW_ONELEVEL))
+			die("invalid ref format: %s", argv[i]);
+	}
+	for (i = start; i < argc; i++) {
+		if (safe_create_reflog(argv[i], &err, 1)) {
+			error("could not create reflog %s: %s", argv[i],
+			      err.buf);
+			status = 1;
+			strbuf_release(&err);
+		}
+	}
+	log_all_ref_updates = temp;
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
+	if (argc - start != 1)
+		usage(reflog_exists_usage);
+
+	if (check_refname_format(argv[start], REFNAME_ALLOW_ONELEVEL))
+		die("invalid ref format: %s", argv[start]);
+	return !reflog_exists(argv[start]);
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
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 6f47c0d..6e1abe7 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -166,4 +166,16 @@ test_expect_success 'git log -g -p shows diffs vs. parents' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reflog exists works' '
+	git reflog exists refs/heads/master &&
+	! git reflog exists refs/heads/nonexistent
+'
+
+test_expect_success 'reflog create works' '
+	git update-ref non-refs-dir HEAD &&
+	! git reflog exists non-refs-dir &&
+	git reflog create non-refs-dir &&
+	git reflog exists non-refs-dir
+'
+
 test_done
-- 
2.0.4.314.gdbf7a51-twtrsrc
