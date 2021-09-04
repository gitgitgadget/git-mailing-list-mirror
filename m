Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60766C433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 20:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF186054E
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 20:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhIDU5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 16:57:08 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:45806 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234533AbhIDU5H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 16:57:07 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:3dbf:67a8:d86:1503])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id C1E1A4F5461;
        Sat,  4 Sep 2021 22:55:29 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1630788930; bh=f0e2m5bSUrjp9qniI36J/ULWpsI91p2QbhCBuZPyUSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=m50OPzlH29YX85KPMZXMRFdj0wnYpEE4gXKyTArUjYLEOBwgJN1djXcuu0eEzPwSw
         4qS+OMxe+5D/L1lV6HaQWdpW+JI7GUy0O0wU4EaYGGq8e3Z+RL5bDsms4MNm1thoeY
         Wecw4Vv5hcIZsxQkQDycxcZ3PP3aiS0z0xV9n9Ys=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v10 2/3] maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
Date:   Sat,  4 Sep 2021 22:54:59 +0200
Message-Id: <20210904205500.13074-3-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904205500.13074-1-lenaic@lhuard.fr>
References: <20210827210255.12565-1-lenaic@lhuard.fr>
 <20210904205500.13074-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Depending on the system, different schedulers can be used to schedule
the hourly, daily and weekly executions of `git maintenance run`:
* `launchctl` for MacOS,
* `schtasks` for Windows and
* `crontab` for everything else.

`git maintenance run` now has an option to let the end-user explicitly
choose which scheduler he wants to use:
`--scheduler=auto|crontab|launchctl|schtasks`.

When `git maintenance start --scheduler=XXX` is run, it not only
registers `git maintenance run` tasks in the scheduler XXX, it also
removes the `git maintenance run` tasks from all the other schedulers to
ensure we cannot have two schedulers launching concurrent identical
tasks.

The default value is `auto` which chooses a suitable scheduler for the
system.

`git maintenance stop` doesn't have any `--scheduler` parameter because
this command will try to remove the `git maintenance run` tasks from all
the available schedulers.

Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
---
 Documentation/git-maintenance.txt |   9 +
 builtin/gc.c                      | 365 ++++++++++++++++++++++++------
 t/t7900-maintenance.sh            |  55 ++++-
 3 files changed, 354 insertions(+), 75 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 1e738ad398..576290b5c6 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -179,6 +179,15 @@ OPTIONS
 	`maintenance.<task>.enabled` configured as `true` are considered.
 	See the 'TASKS' section for the list of accepted `<task>` values.
 
+--scheduler=auto|crontab|launchctl|schtasks::
+	When combined with the `start` subcommand, specify the scheduler
+	for running the hourly, daily and weekly executions of
+	`git maintenance run`.
+	Possible values for `<scheduler>` are `auto`, `crontab` (POSIX),
+	`launchctl` (macOS), and `schtasks` (Windows).
+	When `auto` is specified, the appropriate platform-specific
+	scheduler is used. Default is `auto`.
+
 
 TROUBLESHOOTING
 ---------------
diff --git a/builtin/gc.c b/builtin/gc.c
index 6ce5ca4512..4e3bee5c9a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1529,6 +1529,93 @@ static const char *get_frequency(enum schedule_priority schedule)
 	}
 }
 
+/*
+ * get_schedule_cmd` reads the GIT_TEST_MAINT_SCHEDULER environment variable
+ * to mock the schedulers that `git maintenance start` rely on.
+ *
+ * For test purpose, GIT_TEST_MAINT_SCHEDULER can be set to a comma-separated
+ * list of colon-separated key/value pairs where each pair contains a scheduler
+ * and its corresponding mock.
+ *
+ * * If $GIT_TEST_MAINT_SCHEDULER is not set, return false and leave the
+ *   arguments unmodified.
+ *
+ * * If $GIT_TEST_MAINT_SCHEDULER is set, return true.
+ *   In this case, the *cmd value is read as input.
+ *
+ *   * if the input value *cmd is the key of one of the comma-separated list
+ *     item, then *is_available is set to true and *cmd is modified and becomes
+ *     the mock command.
+ *
+ *   * if the input value *cmd isn’t the key of any of the comma-separated list
+ *     item, then *is_available is set to false.
+ *
+ * Ex.:
+ *   GIT_TEST_MAINT_SCHEDULER not set
+ *     +-------+-------------------------------------------------+
+ *     | Input |                     Output                      |
+ *     | *cmd  | return code |       *cmd        | *is_available |
+ *     +-------+-------------+-------------------+---------------+
+ *     | "foo" |    false    | "foo" (unchanged) |  (unchanged)  |
+ *     +-------+-------------+-------------------+---------------+
+ *
+ *   GIT_TEST_MAINT_SCHEDULER set to “foo:./mock_foo.sh,bar:./mock_bar.sh”
+ *     +-------+-------------------------------------------------+
+ *     | Input |                     Output                      |
+ *     | *cmd  | return code |       *cmd        | *is_available |
+ *     +-------+-------------+-------------------+---------------+
+ *     | "foo" |    true     |  "./mock.foo.sh"  |     true      |
+ *     | "qux" |    true     | "qux" (unchanged) |     false     |
+ *     +-------+-------------+-------------------+---------------+
+ */
+static int get_schedule_cmd(const char **cmd, int *is_available)
+{
+	char *testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
+	struct string_list_item *item;
+	struct string_list list = STRING_LIST_INIT_NODUP;
+
+	if (!testing)
+		return 0;
+
+	if (is_available)
+		*is_available = 0;
+
+	string_list_split_in_place(&list, testing, ',', -1);
+	for_each_string_list_item(item, &list) {
+		struct string_list pair = STRING_LIST_INIT_NODUP;
+
+		if (string_list_split_in_place(&pair, item->string, ':', 2) != 2)
+			continue;
+
+		if (!strcmp(*cmd, pair.items[0].string)) {
+			*cmd = pair.items[1].string;
+			if (is_available)
+				*is_available = 1;
+			string_list_clear(&list, 0);
+			UNLEAK(testing);
+			return 1;
+		}
+	}
+
+	string_list_clear(&list, 0);
+	free(testing);
+	return 1;
+}
+
+static int is_launchctl_available(void)
+{
+	const char *cmd = "launchctl";
+	int is_available;
+	if (get_schedule_cmd(&cmd, &is_available))
+		return is_available;
+
+#ifdef __APPLE__
+	return 1;
+#else
+	return 0;
+#endif
+}
+
 static char *launchctl_service_name(const char *frequency)
 {
 	struct strbuf label = STRBUF_INIT;
@@ -1555,19 +1642,17 @@ static char *launchctl_get_uid(void)
 	return xstrfmt("gui/%d", getuid());
 }
 
-static int launchctl_boot_plist(int enable, const char *filename, const char *cmd)
+static int launchctl_boot_plist(int enable, const char *filename)
 {
+	const char *cmd = "launchctl";
 	int result;
 	struct child_process child = CHILD_PROCESS_INIT;
 	char *uid = launchctl_get_uid();
 
+	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&child.args, cmd);
-	if (enable)
-		strvec_push(&child.args, "bootstrap");
-	else
-		strvec_push(&child.args, "bootout");
-	strvec_push(&child.args, uid);
-	strvec_push(&child.args, filename);
+	strvec_pushl(&child.args, enable ? "bootstrap" : "bootout", uid,
+		     filename, NULL);
 
 	child.no_stderr = 1;
 	child.no_stdout = 1;
@@ -1581,26 +1666,26 @@ static int launchctl_boot_plist(int enable, const char *filename, const char *cm
 	return result;
 }
 
-static int launchctl_remove_plist(enum schedule_priority schedule, const char *cmd)
+static int launchctl_remove_plist(enum schedule_priority schedule)
 {
 	const char *frequency = get_frequency(schedule);
 	char *name = launchctl_service_name(frequency);
 	char *filename = launchctl_service_filename(name);
-	int result = launchctl_boot_plist(0, filename, cmd);
+	int result = launchctl_boot_plist(0, filename);
 	unlink(filename);
 	free(filename);
 	free(name);
 	return result;
 }
 
-static int launchctl_remove_plists(const char *cmd)
+static int launchctl_remove_plists(void)
 {
-	return launchctl_remove_plist(SCHEDULE_HOURLY, cmd) ||
-		launchctl_remove_plist(SCHEDULE_DAILY, cmd) ||
-		launchctl_remove_plist(SCHEDULE_WEEKLY, cmd);
+	return launchctl_remove_plist(SCHEDULE_HOURLY) ||
+	       launchctl_remove_plist(SCHEDULE_DAILY) ||
+	       launchctl_remove_plist(SCHEDULE_WEEKLY);
 }
 
-static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule, const char *cmd)
+static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule)
 {
 	FILE *plist;
 	int i;
@@ -1669,8 +1754,8 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 	fclose(plist);
 
 	/* bootout might fail if not already running, so ignore */
-	launchctl_boot_plist(0, filename, cmd);
-	if (launchctl_boot_plist(1, filename, cmd))
+	launchctl_boot_plist(0, filename);
+	if (launchctl_boot_plist(1, filename))
 		die(_("failed to bootstrap service %s"), filename);
 
 	free(filename);
@@ -1678,21 +1763,35 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 	return 0;
 }
 
-static int launchctl_add_plists(const char *cmd)
+static int launchctl_add_plists(void)
 {
 	const char *exec_path = git_exec_path();
 
-	return launchctl_schedule_plist(exec_path, SCHEDULE_HOURLY, cmd) ||
-		launchctl_schedule_plist(exec_path, SCHEDULE_DAILY, cmd) ||
-		launchctl_schedule_plist(exec_path, SCHEDULE_WEEKLY, cmd);
+	return launchctl_schedule_plist(exec_path, SCHEDULE_HOURLY) ||
+	       launchctl_schedule_plist(exec_path, SCHEDULE_DAILY) ||
+	       launchctl_schedule_plist(exec_path, SCHEDULE_WEEKLY);
 }
 
-static int launchctl_update_schedule(int run_maintenance, int fd, const char *cmd)
+static int launchctl_update_schedule(int run_maintenance, int fd)
 {
 	if (run_maintenance)
-		return launchctl_add_plists(cmd);
+		return launchctl_add_plists();
 	else
-		return launchctl_remove_plists(cmd);
+		return launchctl_remove_plists();
+}
+
+static int is_schtasks_available(void)
+{
+	const char *cmd = "schtasks";
+	int is_available;
+	if (get_schedule_cmd(&cmd, &is_available))
+		return is_available;
+
+#ifdef GIT_WINDOWS_NATIVE
+	return 1;
+#else
+	return 0;
+#endif
 }
 
 static char *schtasks_task_name(const char *frequency)
@@ -1702,13 +1801,15 @@ static char *schtasks_task_name(const char *frequency)
 	return strbuf_detach(&label, NULL);
 }
 
-static int schtasks_remove_task(enum schedule_priority schedule, const char *cmd)
+static int schtasks_remove_task(enum schedule_priority schedule)
 {
+	const char *cmd = "schtasks";
 	int result;
 	struct strvec args = STRVEC_INIT;
 	const char *frequency = get_frequency(schedule);
 	char *name = schtasks_task_name(frequency);
 
+	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&args, cmd);
 	strvec_pushl(&args, "/delete", "/tn", name, "/f", NULL);
 
@@ -1719,15 +1820,16 @@ static int schtasks_remove_task(enum schedule_priority schedule, const char *cmd
 	return result;
 }
 
-static int schtasks_remove_tasks(const char *cmd)
+static int schtasks_remove_tasks(void)
 {
-	return schtasks_remove_task(SCHEDULE_HOURLY, cmd) ||
-		schtasks_remove_task(SCHEDULE_DAILY, cmd) ||
-		schtasks_remove_task(SCHEDULE_WEEKLY, cmd);
+	return schtasks_remove_task(SCHEDULE_HOURLY) ||
+	       schtasks_remove_task(SCHEDULE_DAILY) ||
+	       schtasks_remove_task(SCHEDULE_WEEKLY);
 }
 
-static int schtasks_schedule_task(const char *exec_path, enum schedule_priority schedule, const char *cmd)
+static int schtasks_schedule_task(const char *exec_path, enum schedule_priority schedule)
 {
+	const char *cmd = "schtasks";
 	int result;
 	struct child_process child = CHILD_PROCESS_INIT;
 	const char *xml;
@@ -1736,6 +1838,8 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	char *name = schtasks_task_name(frequency);
 	struct strbuf tfilename = STRBUF_INIT;
 
+	get_schedule_cmd(&cmd, NULL);
+
 	strbuf_addf(&tfilename, "%s/schedule_%s_XXXXXX",
 		    get_git_common_dir(), frequency);
 	tfile = xmks_tempfile(tfilename.buf);
@@ -1840,28 +1944,52 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	return result;
 }
 
-static int schtasks_schedule_tasks(const char *cmd)
+static int schtasks_schedule_tasks(void)
 {
 	const char *exec_path = git_exec_path();
 
-	return schtasks_schedule_task(exec_path, SCHEDULE_HOURLY, cmd) ||
-		schtasks_schedule_task(exec_path, SCHEDULE_DAILY, cmd) ||
-		schtasks_schedule_task(exec_path, SCHEDULE_WEEKLY, cmd);
+	return schtasks_schedule_task(exec_path, SCHEDULE_HOURLY) ||
+	       schtasks_schedule_task(exec_path, SCHEDULE_DAILY) ||
+	       schtasks_schedule_task(exec_path, SCHEDULE_WEEKLY);
 }
 
-static int schtasks_update_schedule(int run_maintenance, int fd, const char *cmd)
+static int schtasks_update_schedule(int run_maintenance, int fd)
 {
 	if (run_maintenance)
-		return schtasks_schedule_tasks(cmd);
+		return schtasks_schedule_tasks();
 	else
-		return schtasks_remove_tasks(cmd);
+		return schtasks_remove_tasks();
+}
+
+static int is_crontab_available(void)
+{
+	const char *cmd = "crontab";
+	int is_available;
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	if (get_schedule_cmd(&cmd, &is_available))
+		return is_available;
+
+	strvec_split(&child.args, cmd);
+	strvec_push(&child.args, "-l");
+	child.no_stdin = 1;
+	child.no_stdout = 1;
+	child.no_stderr = 1;
+	child.silent_exec_failure = 1;
+
+	if (start_command(&child))
+		return 0;
+	/* Ignore exit code, as an empty crontab will return error. */
+	finish_command(&child);
+	return 1;
 }
 
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
 #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
 
-static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
+static int crontab_update_schedule(int run_maintenance, int fd)
 {
+	const char *cmd = "crontab";
 	int result = 0;
 	int in_old_region = 0;
 	struct child_process crontab_list = CHILD_PROCESS_INIT;
@@ -1869,6 +1997,7 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
 	FILE *cron_list, *cron_in;
 	struct strbuf line = STRBUF_INIT;
 
+	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&crontab_list.args, cmd);
 	strvec_push(&crontab_list.args, "-l");
 	crontab_list.in = -1;
@@ -1945,66 +2074,160 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
 	return result;
 }
 
+enum scheduler {
+	SCHEDULER_INVALID = -1,
+	SCHEDULER_AUTO,
+	SCHEDULER_CRON,
+	SCHEDULER_LAUNCHCTL,
+	SCHEDULER_SCHTASKS,
+};
+
+static const struct {
+	const char *name;
+	int (*is_available)(void);
+	int (*update_schedule)(int run_maintenance, int fd);
+} scheduler_fn[] = {
+	[SCHEDULER_CRON] = {
+		.name = "crontab",
+		.is_available = is_crontab_available,
+		.update_schedule = crontab_update_schedule,
+	},
+	[SCHEDULER_LAUNCHCTL] = {
+		.name = "launchctl",
+		.is_available = is_launchctl_available,
+		.update_schedule = launchctl_update_schedule,
+	},
+	[SCHEDULER_SCHTASKS] = {
+		.name = "schtasks",
+		.is_available = is_schtasks_available,
+		.update_schedule = schtasks_update_schedule,
+	},
+};
+
+static enum scheduler parse_scheduler(const char *value)
+{
+	if (!value)
+		return SCHEDULER_INVALID;
+	else if (!strcasecmp(value, "auto"))
+		return SCHEDULER_AUTO;
+	else if (!strcasecmp(value, "cron") || !strcasecmp(value, "crontab"))
+		return SCHEDULER_CRON;
+	else if (!strcasecmp(value, "launchctl"))
+		return SCHEDULER_LAUNCHCTL;
+	else if (!strcasecmp(value, "schtasks"))
+		return SCHEDULER_SCHTASKS;
+	else
+		return SCHEDULER_INVALID;
+}
+
+static int maintenance_opt_scheduler(const struct option *opt, const char *arg,
+				     int unset)
+{
+	enum scheduler *scheduler = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	*scheduler = parse_scheduler(arg);
+	if (*scheduler == SCHEDULER_INVALID)
+		return error(_("unrecognized --scheduler argument '%s'"), arg);
+	return 0;
+}
+
+struct maintenance_start_opts {
+	enum scheduler scheduler;
+};
+
+static enum scheduler resolve_scheduler(enum scheduler scheduler)
+{
+	if (scheduler != SCHEDULER_AUTO)
+		return scheduler;
+
 #if defined(__APPLE__)
-static const char platform_scheduler[] = "launchctl";
+	return SCHEDULER_LAUNCHCTL;
+
 #elif defined(GIT_WINDOWS_NATIVE)
-static const char platform_scheduler[] = "schtasks";
+	return SCHEDULER_SCHTASKS;
+
 #else
-static const char platform_scheduler[] = "crontab";
+	return SCHEDULER_CRON;
 #endif
+}
 
-static int update_background_schedule(int enable)
+static void validate_scheduler(enum scheduler scheduler)
 {
-	int result;
-	const char *scheduler = platform_scheduler;
-	const char *cmd = scheduler;
-	char *testing;
+	if (scheduler == SCHEDULER_INVALID)
+		BUG("invalid scheduler");
+	if (scheduler == SCHEDULER_AUTO)
+		BUG("resolve_scheduler should have been called before");
+
+	if (!scheduler_fn[scheduler].is_available())
+		die(_("%s scheduler is not available"),
+		    scheduler_fn[scheduler].name);
+}
+
+static int update_background_schedule(const struct maintenance_start_opts *opts,
+				      int enable)
+{
+	unsigned int i;
+	int result = 0;
 	struct lock_file lk;
 	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
 
-	testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
-	if (testing) {
-		char *sep = strchr(testing, ':');
-		if (!sep)
-			die("GIT_TEST_MAINT_SCHEDULER unparseable: %s", testing);
-		*sep = '\0';
-		scheduler = testing;
-		cmd = sep + 1;
+	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
+		free(lock_path);
+		return error(_("another process is scheduling background maintenance"));
 	}
 
-	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
-		result = error(_("another process is scheduling background maintenance"));
-		goto cleanup;
+	for (i = 1; i < ARRAY_SIZE(scheduler_fn); i++) {
+		if (enable && opts->scheduler == i)
+			continue;
+		if (!scheduler_fn[i].is_available())
+			continue;
+		scheduler_fn[i].update_schedule(0, get_lock_file_fd(&lk));
 	}
 
-	if (!strcmp(scheduler, "launchctl"))
-		result = launchctl_update_schedule(enable, get_lock_file_fd(&lk), cmd);
-	else if (!strcmp(scheduler, "schtasks"))
-		result = schtasks_update_schedule(enable, get_lock_file_fd(&lk), cmd);
-	else if (!strcmp(scheduler, "crontab"))
-		result = crontab_update_schedule(enable, get_lock_file_fd(&lk), cmd);
-	else
-		die("unknown background scheduler: %s", scheduler);
+	if (enable)
+		result = scheduler_fn[opts->scheduler].update_schedule(
+			1, get_lock_file_fd(&lk));
 
 	rollback_lock_file(&lk);
 
-cleanup:
 	free(lock_path);
-	free(testing);
 	return result;
 }
 
-static int maintenance_start(void)
+static const char *const builtin_maintenance_start_usage[] = {
+	N_("git maintenance start [--scheduler=<scheduler>]"),
+	NULL
+};
+
+static int maintenance_start(int argc, const char **argv, const char *prefix)
 {
+	struct maintenance_start_opts opts = { 0 };
+	struct option options[] = {
+		OPT_CALLBACK_F(
+			0, "scheduler", &opts.scheduler, N_("scheduler"),
+			N_("scheduler to trigger git maintenance run"),
+			PARSE_OPT_NONEG, maintenance_opt_scheduler),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_maintenance_start_usage, 0);
+	if (argc)
+		usage_with_options(builtin_maintenance_start_usage, options);
+
+	opts.scheduler = resolve_scheduler(opts.scheduler);
+	validate_scheduler(opts.scheduler);
+
 	if (maintenance_register())
 		warning(_("failed to add repo to global config"));
-
-	return update_background_schedule(1);
+	return update_background_schedule(&opts, 1);
 }
 
 static int maintenance_stop(void)
 {
-	return update_background_schedule(0);
+	return update_background_schedule(NULL, 0);
 }
 
 static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
@@ -2018,7 +2241,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[1], "run"))
 		return maintenance_run(argc - 1, argv + 1, prefix);
 	if (!strcmp(argv[1], "start"))
-		return maintenance_start();
+		return maintenance_start(argc - 1, argv + 1, prefix);
 	if (!strcmp(argv[1], "stop"))
 		return maintenance_stop();
 	if (!strcmp(argv[1], "register"))
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 58f46c77e6..27bce7992c 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -492,8 +492,21 @@ test_expect_success !MINGW 'register and unregister with regex metacharacters' '
 		maintenance.repo "$(pwd)/$META"
 '
 
+test_expect_success 'start --scheduler=<scheduler>' '
+	test_expect_code 129 git maintenance start --scheduler=foo 2>err &&
+	test_i18ngrep "unrecognized --scheduler argument" err &&
+
+	test_expect_code 129 git maintenance start --no-scheduler 2>err &&
+	test_i18ngrep "unknown option" err &&
+
+	test_expect_code 128 \
+		env GIT_TEST_MAINT_SCHEDULER="launchctl:true,schtasks:true" \
+		git maintenance start --scheduler=crontab 2>err &&
+	test_i18ngrep "fatal: crontab scheduler is not available" err
+'
+
 test_expect_success 'start from empty cron table' '
-	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start --scheduler=crontab &&
 
 	# start registers the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
@@ -516,7 +529,7 @@ test_expect_success 'stop from existing schedule' '
 
 test_expect_success 'start preserves existing schedule' '
 	echo "Important information!" >cron.txt &&
-	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start &&
+	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start --scheduler=crontab &&
 	grep "Important information!" cron.txt
 '
 
@@ -545,7 +558,7 @@ test_expect_success 'start and stop macOS maintenance' '
 	EOF
 
 	rm -f args &&
-	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
+	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start --scheduler=launchctl &&
 
 	# start registers the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
@@ -596,7 +609,7 @@ test_expect_success 'start and stop Windows maintenance' '
 	EOF
 
 	rm -f args &&
-	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start &&
+	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start --scheduler=schtasks &&
 
 	# start registers the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
@@ -619,6 +632,40 @@ test_expect_success 'start and stop Windows maintenance' '
 	test_cmp expect args
 '
 
+test_expect_success 'start and stop when several schedulers are available' '
+	write_script print-args <<-\EOF &&
+	printf "%s\n" "$*" | sed "s:gui/[0-9][0-9]*:gui/[UID]:; s:\(schtasks /create .* /xml\).*:\1:;" >>args
+	EOF
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=launchctl &&
+	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
+		hourly daily weekly >expect &&
+	for frequency in hourly daily weekly
+	do
+		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
+		echo "launchctl bootout gui/[UID] $PLIST" >>expect &&
+		echo "launchctl bootstrap gui/[UID] $PLIST" >>expect || return 1
+	done &&
+	test_cmp expect args &&
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=schtasks &&
+	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
+		hourly daily weekly >expect &&
+	printf "schtasks /create /tn Git Maintenance (%s) /f /xml\n" \
+		hourly daily weekly >>expect &&
+	test_cmp expect args &&
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance stop &&
+	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
+		hourly daily weekly >expect &&
+	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
+		hourly daily weekly >>expect &&
+	test_cmp expect args
+'
+
 test_expect_success 'register preserves existing strategy' '
 	git config maintenance.strategy none &&
 	git maintenance register &&
-- 
2.33.0

