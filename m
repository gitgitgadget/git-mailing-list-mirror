Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04519C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0FD611BD
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhETWYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 18:24:34 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:51708 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231417AbhETWYd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 18:24:33 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a0d:e487:12f:f769:9e2d:d907:5e8f:73c3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 4186346FB76;
        Fri, 21 May 2021 00:23:04 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1621549387; bh=DXd7FEpj2v01InOf9FJJP1xEgdeTpRkDmtebolevfWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bX3beE2ii2ymZQRUpbEoza+Xvz8EePQbG8GEs9vkoFTfmVSHohnI5B04id+D7TvYS
         gTii7RJr00JjoYSjrYpYLCAktr9JQTPXn+16ReYjWDsfMgpqkHRxxwmXgzyRNL2UNN
         hw8JISoV4TwcBrA1ggPUHauBsFd59cYXYlbnvJLU=
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
Subject: [PATCH v3 4/4] maintenance: optionally use systemd timers on Linux
Date:   Fri, 21 May 2021 00:13:59 +0200
Message-Id: <20210520221359.75615-5-lenaic@lhuard.fr>
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

The existing mechanism for scheduling background maintenance is done
through cron. On Linux systems managed by systemd, systemd provides an
alternative to schedule recurring tasks: systemd timers.

The main motivations to implement systemd timers in addition to cron
are:
* cron is optional and Linux systems running systemd might not have it
  installed.
* The execution of `crontab -l` can tell us if cron is installed but not
  if the daemon is actually running.
* With systemd, each service is run in its own cgroup and its logs are
  tagged by the service inside journald. With cron, all scheduled tasks
  are running in the cron daemon cgroup and all the logs of the
  user-scheduled tasks are pretended to belong to the system cron
  service.
  Concretely, a user that doesn’t have access to the system logs won’t
  have access to the log of its own tasks scheduled by cron whereas he
  will have access to the log of its own tasks scheduled by systemd
  timer.
  Although `cron` attempts to send email, that email may go unseen by
  the user because these days, local mailboxes are not heavily used
  anymore.

In order to schedule git maintenance, we need two unit template files:
* ~/.config/systemd/user/git-maintenance@.service
  to define the command to be started by systemd and
* ~/.config/systemd/user/git-maintenance@.timer
  to define the schedule at which the command should be run.

Those units are templates that are parameterized by the frequency.

Based on those templates, 3 timers are started:
* git-maintenance@hourly.timer
* git-maintenance@daily.timer
* git-maintenance@weekly.timer

The command launched by those three timers are the same as with the
other scheduling methods:

git for-each-repo --config=maintenance.repo maintenance run
--schedule=%i

with the full path for git to ensure that the version of git launched
for the scheduled maintenance is the same as the one used to run
`maintenance start`.

The timer unit contains `Persistent=true` so that, if the computer is
powered down when a maintenance task should run, the task will be run
when the computer is back powered on.

Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
---
 Documentation/git-maintenance.txt |  57 +++++++++-
 builtin/gc.c                      | 181 ++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            |  66 ++++++++++-
 3 files changed, 294 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 7c4bb38a2f..50179e010f 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -181,16 +181,19 @@ OPTIONS
 	`maintenance.<task>.enabled` configured as `true` are considered.
 	See the 'TASKS' section for the list of accepted `<task>` values.
 
---scheduler=auto|crontab|launchctl|schtasks::
+--scheduler=auto|crontab|systemd-timer|launchctl|schtasks::
 	When combined with the `start` subcommand, specify the scheduler
 	to use to run the hourly, daily and weekly executions of
 	`git maintenance run`.
 	The possible values for `<scheduler>` depend on the system: `crontab`
-	is available on POSIX systems, `launchctl` is available on
-	MacOS and `schtasks` is available on Windows.
+	is available on POSIX systems, `systemd-timer` is available on Linux
+	systems, `launchctl` is available on MacOS and `schtasks` is available
+	on Windows.
 	By default or when `auto` is specified, a suitable scheduler for
 	the system is used. On MacOS, `launchctl` is used. On Windows,
-	`schtasks` is used. On all other systems, `crontab` is used.
+	`schtasks` is used. On Linux, `systemd-timer` is used if user systemd
+	timers are available, otherwise, `crontab` is used. On all other systems,
+	`crontab` is used.
 
 
 TROUBLESHOOTING
@@ -290,6 +293,52 @@ schedule to ensure you are executing the correct binaries in your
 schedule.
 
 
+BACKGROUND MAINTENANCE ON LINUX SYSTEMD SYSTEMS
+-----------------------------------------------
+
+While Linux supports `cron`, depending on the distribution, `cron` may
+be an optional package not necessarily installed. On modern Linux
+distributions, systemd timers are superseding it.
+
+If user systemd timers are available, they will be used as a replacement
+of `cron`.
+
+In this case, `git maintenance start` will create user systemd timer units
+and start the timers. The current list of user-scheduled tasks can be found
+by running `systemctl --user list-timers`. The timers written by `git
+maintenance start` are similar to this:
+
+-----------------------------------------------------------------------
+$ systemctl --user list-timers
+NEXT                         LEFT          LAST                         PASSED     UNIT                         ACTIVATES
+Thu 2021-04-29 19:00:00 CEST 42min left    Thu 2021-04-29 18:00:11 CEST 17min ago  git-maintenance@hourly.timer git-maintenance@hourly.service
+Fri 2021-04-30 00:00:00 CEST 5h 42min left Thu 2021-04-29 00:00:11 CEST 18h ago    git-maintenance@daily.timer  git-maintenance@daily.service
+Mon 2021-05-03 00:00:00 CEST 3 days left   Mon 2021-04-26 00:00:11 CEST 3 days ago git-maintenance@weekly.timer git-maintenance@weekly.service
+-----------------------------------------------------------------------
+
+One timer is registered for each `--schedule=<frequency>` option.
+
+The definition of the systemd units can be inspected in the following files:
+
+-----------------------------------------------------------------------
+~/.config/systemd/user/git-maintenance@.timer
+~/.config/systemd/user/git-maintenance@.service
+~/.config/systemd/user/timers.target.wants/git-maintenance@hourly.timer
+~/.config/systemd/user/timers.target.wants/git-maintenance@daily.timer
+~/.config/systemd/user/timers.target.wants/git-maintenance@weekly.timer
+-----------------------------------------------------------------------
+
+`git maintenance start` will overwrite these files and start the timer
+again with `systemctl --user`, so any customization should be done by
+creating a drop-in file, i.e. a `.conf` suffixed file in the
+`~/.config/systemd/user/git-maintenance@.service.d` directory.
+
+`git maintenance stop` will stop the user systemd timers and delete
+the above mentioned files.
+
+For more details, see `systemd.timer(5)`.
+
+
 BACKGROUND MAINTENANCE ON MACOS SYSTEMS
 ---------------------------------------
 
diff --git a/builtin/gc.c b/builtin/gc.c
index bf21cec059..d2432ee04f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2079,10 +2079,174 @@ static int crontab_update_schedule(enum enable_or_disable run_maintenance,
 	return result;
 }
 
+static int is_systemd_timer_available(void)
+{
+	const char *cmd = "systemctl";
+	int is_available;
+	static int cached_result = -1;
+#ifdef __linux__
+	struct child_process child = CHILD_PROCESS_INIT;
+#endif
+
+	if (cached_result != -1)
+		return cached_result;
+
+	if (get_schedule_cmd(&cmd, &is_available))
+		return is_available;
+
+#ifdef __linux__
+	strvec_split(&child.args, cmd);
+	strvec_pushl(&child.args, "--user", "list-timers", NULL);
+	child.no_stdin = 1;
+	child.no_stdout = 1;
+	child.no_stderr = 1;
+	child.silent_exec_failure = 1;
+
+	if (start_command(&child)) {
+		cached_result = 0;
+		return cached_result;
+	}
+	if (finish_command(&child)) {
+		cached_result = 0;
+		return cached_result;
+	}
+	cached_result = 1;
+	return cached_result;
+#else
+	return 0;
+#endif
+}
+
+static char *xdg_config_home_systemd(const char *filename)
+{
+	assert(filename);
+	return xdg_config_home("systemd/user/%s", filename);
+}
+
+static int systemd_timer_enable_unit(int enable,
+				     enum schedule_priority schedule)
+{
+	const char *cmd = "systemctl";
+	struct child_process child = CHILD_PROCESS_INIT;
+	const char *frequency = get_frequency(schedule);
+
+	get_schedule_cmd(&cmd, NULL);
+	strvec_split(&child.args, cmd);
+	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
+		     "--now", NULL);
+	strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
+
+	if (start_command(&child))
+		die(_("failed to run systemctl"));
+	return finish_command(&child);
+}
+
+static int systemd_timer_delete_unit_templates(void)
+{
+	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
+	unlink(filename);
+	free(filename);
+
+	filename = xdg_config_home_systemd("git-maintenance@.service");
+	unlink(filename);
+	free(filename);
+
+	return 0;
+}
+
+static int systemd_timer_delete_units(void)
+{
+	return systemd_timer_enable_unit(DISABLE, SCHEDULE_HOURLY) ||
+	       systemd_timer_enable_unit(DISABLE, SCHEDULE_DAILY) ||
+	       systemd_timer_enable_unit(DISABLE, SCHEDULE_WEEKLY) ||
+	       systemd_timer_delete_unit_templates();
+}
+
+static int systemd_timer_write_unit_templates(const char *exec_path)
+{
+	char *filename;
+	FILE *file;
+	const char *unit;
+
+	filename = xdg_config_home_systemd("git-maintenance@.timer");
+	if (safe_create_leading_directories(filename))
+		die(_("failed to create directories for '%s'"), filename);
+	file = xfopen(filename, "w");
+	FREE_AND_NULL(filename);
+
+	unit = "# This file was created and is maintained by Git.\n"
+	       "# Any edits made in this file might be replaced in the future\n"
+	       "# by a Git command.\n"
+	       "\n"
+	       "[Unit]\n"
+	       "Description=Optimize Git repositories data\n"
+	       "\n"
+	       "[Timer]\n"
+	       "OnCalendar=%i\n"
+	       "Persistent=true\n"
+	       "\n"
+	       "[Install]\n"
+	       "WantedBy=timers.target\n";
+	fputs(unit, file);
+	fclose(file);
+
+	filename = xdg_config_home_systemd("git-maintenance@.service");
+	file = xfopen(filename, "w");
+	free(filename);
+
+	unit = "# This file was created and is maintained by Git.\n"
+	       "# Any edits made in this file might be replaced in the future\n"
+	       "# by a Git command.\n"
+	       "\n"
+	       "[Unit]\n"
+	       "Description=Optimize Git repositories data\n"
+	       "\n"
+	       "[Service]\n"
+	       "Type=oneshot\n"
+	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
+	       "LockPersonality=yes\n"
+	       "MemoryDenyWriteExecute=yes\n"
+	       "NoNewPrivileges=yes\n"
+	       "RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6\n"
+	       "RestrictNamespaces=yes\n"
+	       "RestrictRealtime=yes\n"
+	       "RestrictSUIDSGID=yes\n"
+	       "SystemCallArchitectures=native\n"
+	       "SystemCallFilter=@system-service\n";
+	fprintf(file, unit, exec_path, exec_path);
+	fclose(file);
+
+	return 0;
+}
+
+static int systemd_timer_setup_units(void)
+{
+	const char *exec_path = git_exec_path();
+
+	return systemd_timer_write_unit_templates(exec_path) ||
+	       systemd_timer_enable_unit(ENABLE, SCHEDULE_HOURLY) ||
+	       systemd_timer_enable_unit(ENABLE, SCHEDULE_DAILY) ||
+	       systemd_timer_enable_unit(ENABLE, SCHEDULE_WEEKLY);
+}
+
+static int systemd_timer_update_schedule(enum enable_or_disable run_maintenance,
+					 int fd)
+{
+	switch (run_maintenance) {
+	case ENABLE:
+		return systemd_timer_setup_units();
+	case DISABLE:
+		return systemd_timer_delete_units();
+	default:
+		BUG("invalid enable_or_disable value");
+	}
+}
+
 enum scheduler {
 	SCHEDULER_INVALID = -1,
 	SCHEDULER_AUTO,
 	SCHEDULER_CRON,
+	SCHEDULER_SYSTEMD,
 	SCHEDULER_LAUNCHCTL,
 	SCHEDULER_SCHTASKS,
 };
@@ -2097,6 +2261,11 @@ static const struct {
 		.is_available = is_crontab_available,
 		.update_schedule = crontab_update_schedule,
 	},
+	[SCHEDULER_SYSTEMD] = {
+		.name = "systemctl",
+		.is_available = is_systemd_timer_available,
+		.update_schedule = systemd_timer_update_schedule,
+	},
 	[SCHEDULER_LAUNCHCTL] = {
 		.name = "launchctl",
 		.is_available = is_launchctl_available,
@@ -2117,6 +2286,9 @@ static enum scheduler parse_scheduler(const char *value)
 		return SCHEDULER_AUTO;
 	else if (!strcasecmp(value, "cron") || !strcasecmp(value, "crontab"))
 		return SCHEDULER_CRON;
+	else if (!strcasecmp(value, "systemd") ||
+		 !strcasecmp(value, "systemd-timer"))
+		return SCHEDULER_SYSTEMD;
 	else if (!strcasecmp(value, "launchctl"))
 		return SCHEDULER_LAUNCHCTL;
 	else if (!strcasecmp(value, "schtasks"))
@@ -2155,6 +2327,15 @@ static void resolve_auto_scheduler(enum scheduler *scheduler)
 	*scheduler = SCHEDULER_SCHTASKS;
 	return;
 
+#elif defined(__linux__)
+	if (is_systemd_timer_available())
+		*scheduler = SCHEDULER_SYSTEMD;
+	else if (is_crontab_available())
+		*scheduler = SCHEDULER_CRON;
+	else
+		die(_("neither systemd timers nor crontab are available"));
+	return;
+
 #else
 	*scheduler = SCHEDULER_CRON;
 	return;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 9eac260307..c8a6f19ebc 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -20,6 +20,18 @@ test_xmllint () {
 	fi
 }
 
+test_lazy_prereq SYSTEMD_ANALYZE '
+	systemd-analyze --help >out &&
+	grep verify out
+'
+
+test_systemd_analyze_verify () {
+	if test_have_prereq SYSTEMD_ANALYZE
+	then
+		systemd-analyze verify "$@"
+	fi
+}
+
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h 2>err &&
 	test_i18ngrep "usage: git maintenance <subcommand>" err &&
@@ -628,14 +640,54 @@ test_expect_success 'start and stop Windows maintenance' '
 	test_cmp expect args
 '
 
+test_expect_success 'start and stop Linux/systemd maintenance' '
+	write_script print-args <<-\EOF &&
+	printf "%s\n" "$*" >>args
+	EOF
+
+	XDG_CONFIG_HOME="$PWD" &&
+	export XDG_CONFIG_HOME &&
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" git maintenance start --scheduler=systemd-timer &&
+
+	# start registers the repo
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
+
+	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" &&
+
+	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
+	test_cmp expect args &&
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" git maintenance stop &&
+
+	# stop does not unregister the repo
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
+
+	test_path_is_missing "systemd/user/git-maintenance@.timer" &&
+	test_path_is_missing "systemd/user/git-maintenance@.service" &&
+
+	printf -- "--user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
+	test_cmp expect args
+'
+
 test_expect_success 'start and stop when several schedulers are available' '
 	write_script print-args <<-\EOF &&
 	printf "%s\n" "$*" | sed "s:gui/[0-9][0-9]*:gui/[UID]:; s:\(schtasks /create .* /xml\).*:\1:;" >>args
 	EOF
 
 	rm -f args &&
-	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=launchctl &&
-	rm -f expect &&
+	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=systemd-timer &&
+	printf -- "systemctl --user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
+	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
+		hourly daily weekly >>expect &&
+	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
+		hourly daily weekly >>expect &&
+	test_cmp expect args &&
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=launchctl &&
+	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
 	for frequency in hourly daily weekly
 	do
 		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
@@ -647,17 +699,19 @@ test_expect_success 'start and stop when several schedulers are available' '
 	test_cmp expect args &&
 
 	rm -f args &&
-	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=schtasks &&
+	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=schtasks &&
+	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
 	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
-		hourly daily weekly >expect &&
+		hourly daily weekly >>expect &&
 	printf "schtasks /create /tn Git Maintenance (%s) /f /xml\n" \
 		hourly daily weekly >>expect &&
 	test_cmp expect args &&
 
 	rm -f args &&
-	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance stop &&
+	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance stop &&
+	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
 	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
-		hourly daily weekly >expect &&
+		hourly daily weekly >>expect &&
 	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
 		hourly daily weekly >>expect &&
 	test_cmp expect args
-- 
2.31.1

