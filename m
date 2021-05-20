Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310D5C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067CE60FE5
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhETWY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 18:24:27 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:51682 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231382AbhETWY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 18:24:26 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a0d:e487:12f:f769:9e2d:d907:5e8f:73c3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 0020646FB72;
        Fri, 21 May 2021 00:22:57 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1621549380; bh=zLwHQ2Ebg6Is517npsjUEiDGGb8R4WyxEz1rSxqPX/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ll74IyRzd4wFaB7co+PF/fqqaIOKCMJUCgJIQB43SdZlz9apztvuhg6P+5IdEtPbj
         nkd6y7I0JxLNrhpbWh0WdWfp/KTYEYy8obUa6+j+DST8ZdX9vB0PEZeLmycxsY7LZB
         5Z8ybP0AyBSw1N7iWm8G0fzZFH9+3THNF0t6PyLI=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v3 2/4] maintenance: introduce ENABLE/DISABLE for code clarity
Date:   Fri, 21 May 2021 00:13:57 +0200
Message-Id: <20210520221359.75615-3-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520221359.75615-1-lenaic@lhuard.fr>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first parameter of `XXX_update_schedule` and alike functions is a
boolean specifying if the tasks should be scheduled or unscheduled.

Using an `enum` with `ENABLE` and `DISABLE` values can make the code
clearer.

Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
---
 builtin/gc.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ef7226d7bc..0caf8d45c4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1570,19 +1570,21 @@ static char *launchctl_get_uid(void)
 	return xstrfmt("gui/%d", getuid());
 }
 
-static int launchctl_boot_plist(int enable, const char *filename, const char *cmd)
+enum enable_or_disable {
+	DISABLE,
+	ENABLE
+};
+
+static int launchctl_boot_plist(enum enable_or_disable enable,
+				const char *filename, const char *cmd)
 {
 	int result;
 	struct child_process child = CHILD_PROCESS_INIT;
 	char *uid = launchctl_get_uid();
 
 	strvec_split(&child.args, cmd);
-	if (enable)
-		strvec_push(&child.args, "bootstrap");
-	else
-		strvec_push(&child.args, "bootout");
-	strvec_push(&child.args, uid);
-	strvec_push(&child.args, filename);
+	strvec_pushl(&child.args, enable == ENABLE ? "bootstrap" : "bootout",
+		     uid, filename, NULL);
 
 	child.no_stderr = 1;
 	child.no_stdout = 1;
@@ -1601,7 +1603,7 @@ static int launchctl_remove_plist(enum schedule_priority schedule, const char *c
 	const char *frequency = get_frequency(schedule);
 	char *name = launchctl_service_name(frequency);
 	char *filename = launchctl_service_filename(name);
-	int result = launchctl_boot_plist(0, filename, cmd);
+	int result = launchctl_boot_plist(DISABLE, filename, cmd);
 	unlink(filename);
 	free(filename);
 	free(name);
@@ -1684,8 +1686,8 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 	fclose(plist);
 
 	/* bootout might fail if not already running, so ignore */
-	launchctl_boot_plist(0, filename, cmd);
-	if (launchctl_boot_plist(1, filename, cmd))
+	launchctl_boot_plist(DISABLE, filename, cmd);
+	if (launchctl_boot_plist(ENABLE, filename, cmd))
 		die(_("failed to bootstrap service %s"), filename);
 
 	free(filename);
@@ -1702,12 +1704,17 @@ static int launchctl_add_plists(const char *cmd)
 		launchctl_schedule_plist(exec_path, SCHEDULE_WEEKLY, cmd);
 }
 
-static int launchctl_update_schedule(int run_maintenance, int fd, const char *cmd)
+static int launchctl_update_schedule(enum enable_or_disable run_maintenance,
+				     int fd, const char *cmd)
 {
-	if (run_maintenance)
+	switch (run_maintenance) {
+	case ENABLE:
 		return launchctl_add_plists(cmd);
-	else
+	case DISABLE:
 		return launchctl_remove_plists(cmd);
+	default:
+		BUG("invalid enable_or_disable value");
+	}
 }
 
 static char *schtasks_task_name(const char *frequency)
@@ -1864,18 +1871,24 @@ static int schtasks_schedule_tasks(const char *cmd)
 		schtasks_schedule_task(exec_path, SCHEDULE_WEEKLY, cmd);
 }
 
-static int schtasks_update_schedule(int run_maintenance, int fd, const char *cmd)
+static int schtasks_update_schedule(enum enable_or_disable run_maintenance,
+				    int fd, const char *cmd)
 {
-	if (run_maintenance)
+	switch (run_maintenance) {
+	case ENABLE:
 		return schtasks_schedule_tasks(cmd);
-	else
+	case DISABLE:
 		return schtasks_remove_tasks(cmd);
+	default:
+		BUG("invalid enable_or_disable value");
+	}
 }
 
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
 #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
 
-static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
+static int crontab_update_schedule(enum enable_or_disable run_maintenance,
+				   int fd, const char *cmd)
 {
 	int result = 0;
 	int in_old_region = 0;
@@ -1925,7 +1938,7 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
 			fprintf(cron_in, "%s\n", line.buf);
 	}
 
-	if (run_maintenance) {
+	if (run_maintenance == ENABLE) {
 		struct strbuf line_format = STRBUF_INIT;
 		const char *exec_path = git_exec_path();
 
-- 
2.31.1

