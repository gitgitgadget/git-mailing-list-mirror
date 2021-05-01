Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F18FC433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41187611AB
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhEAPAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 11:00:52 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:49892 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhEAPAw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 11:00:52 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 May 2021 11:00:51 EDT
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:49d0:89c2:bcae:a3bf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 7CD3645557A;
        Sat,  1 May 2021 16:53:17 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1619880797; bh=LIPSV/yqQuiciKHZSsJI/c2YDz1jYy9vqpRX/bel0ws=;
        h=From:To:Cc:Subject:Date;
        b=iBp9I7eplGcEgYALdjcH+GbxW/TliYehMeXpT08PPNARrCijInH/wmx54k1AXuJnf
         5lWr4wvqYEa2UIsxT+5X1cLM6jk3MSJXXtphMyNTZr4oiUktB6yMmpoJzip/cMxIAU
         P2v/znhkbghSp2+BHdWCGbLBgaloTLYsIVWn0bHU=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH] maintenance: use systemd timers on Linux
Date:   Sat,  1 May 2021 16:52:20 +0200
Message-Id: <20210501145220.2082670-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.31.1
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

In order to schedule git maintenance, we need two unit template files:
* ~/.config/systemd/user/git-maintenance@.service
  to define the command to be started by systemd and
* ~/.config/systemd/user/git-maintenance@.timer
  to define the schedule at which the command should be run.

Those units are templates that are parametrized by the frequency.

Based on those templates, 3 timers are started:
* git-maintenance@hourly.timer
* git-maintenance@daily.timer
* git-maintenance@weekly.timer

The command launched by those three timers are the same than with the
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
 Documentation/git-maintenance.txt |  49 ++++++++
 builtin/gc.c                      | 188 +++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh            |  51 ++++++++
 3 files changed, 287 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 80ddd33ceb..30443b417a 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -279,6 +279,55 @@ schedule to ensure you are executing the correct binaries in your
 schedule.
 
 
+BACKGROUND MAINTENANCE ON LINUX SYSTEMD SYSTEMD
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
+
+3 timers listed.
+Pass --all to see loaded but inactive timers, too.
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
+creating a drop-in file
+`~/.config/systemd/user/git-maintenance@.service.d/*.conf`.
+
+`git maintenance stop` will stop the user systemd timers and delete
+the above mentioned files.
+
+For more details, see systemd.timer(5)
+
+
 BACKGROUND MAINTENANCE ON MACOS SYSTEMS
 ---------------------------------------
 
diff --git a/builtin/gc.c b/builtin/gc.c
index ef7226d7bc..913fcfc882 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1872,6 +1872,25 @@ static int schtasks_update_schedule(int run_maintenance, int fd, const char *cmd
 		return schtasks_remove_tasks(cmd);
 }
 
+static int is_crontab_available(const char *cmd)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
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
+
+	return 1;
+}
+
 #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
 #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
 
@@ -1959,10 +1978,164 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
 	return result;
 }
 
+static int is_systemd_timer_available(const char *cmd)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	strvec_split(&child.args, cmd);
+	strvec_pushl(&child.args, "--user", "list-timers", NULL);
+	child.no_stdin = 1;
+	child.no_stdout = 1;
+	child.no_stderr = 1;
+	child.silent_exec_failure = 1;
+
+	if (start_command(&child))
+		return 0;
+	if (finish_command(&child))
+		return 0;
+
+	return 1;
+}
+
+static char *systemd_timer_timer_filename()
+{
+	const char *filename = "~/.config/systemd/user/git-maintenance@.timer";
+	char *expanded = expand_user_path(filename, 0);
+	if (!expanded)
+		die(_("failed to expand path '%s'"), filename);
+
+	return expanded;
+}
+
+static char *systemd_timer_service_filename()
+{
+	const char *filename =
+		"~/.config/systemd/user/git-maintenance@.service";
+	char *expanded = expand_user_path(filename, 0);
+	if (!expanded)
+		die(_("failed to expand path '%s'"), filename);
+
+	return expanded;
+}
+
+static int systemd_timer_enable_unit(int enable,
+				     enum schedule_priority schedule,
+				     const char *cmd)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+	const char *frequency = get_frequency(schedule);
+
+	strvec_split(&child.args, cmd);
+	strvec_push(&child.args, "--user");
+	if (enable)
+		strvec_push(&child.args, "enable");
+	else
+		strvec_push(&child.args, "disable");
+	strvec_push(&child.args, "--now");
+	strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
+
+	if (start_command(&child))
+		die(_("failed to run systemctl"));
+	return finish_command(&child);
+}
+
+static int systemd_timer_delete_unit_templates()
+{
+	char *filename = systemd_timer_timer_filename();
+	unlink(filename);
+	free(filename);
+
+	filename = systemd_timer_service_filename();
+	unlink(filename);
+	free(filename);
+
+	return 0;
+}
+
+static int systemd_timer_delete_units(const char *cmd)
+{
+	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY, cmd) ||
+	       systemd_timer_enable_unit(0, SCHEDULE_DAILY, cmd) ||
+	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY, cmd) ||
+	       systemd_timer_delete_unit_templates();
+}
+
+static int systemd_timer_write_unit_templates(const char *exec_path)
+{
+	char *filename;
+	FILE *file;
+	const char *unit;
+
+	filename = systemd_timer_timer_filename();
+	if (safe_create_leading_directories(filename))
+		die(_("failed to create directories for '%s'"), filename);
+	file = xfopen(filename, "w");
+	free(filename);
+
+	unit = "[Unit]\n"
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
+	filename = systemd_timer_service_filename();
+	if (safe_create_leading_directories(filename))
+		die(_("failed to create directories for '%s'"), filename);
+	file = xfopen(filename, "w");
+	free(filename);
+
+	unit = "[Unit]\n"
+	       "Description=Optimize Git repositories data\n"
+	       "\n"
+	       "[Service]\n"
+	       "Type=oneshot\n"
+	       "ExecStart=\"%1$s/git\" --exec-path=\"%1$s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
+	       "LockPersonality=yes\n"
+	       "MemoryDenyWriteExecute=yes\n"
+	       "NoNewPrivileges=yes\n"
+	       "RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6\n"
+	       "RestrictNamespaces=yes\n"
+	       "RestrictRealtime=yes\n"
+	       "RestrictSUIDSGID=yes\n"
+	       "SystemCallArchitectures=native\n"
+	       "SystemCallFilter=@system-service\n";
+	fprintf(file, unit, exec_path);
+	fclose(file);
+
+	return 0;
+}
+
+static int systemd_timer_setup_units(const char *cmd)
+{
+	const char *exec_path = git_exec_path();
+
+	return systemd_timer_write_unit_templates(exec_path) ||
+	       systemd_timer_enable_unit(1, SCHEDULE_HOURLY, cmd) ||
+	       systemd_timer_enable_unit(1, SCHEDULE_DAILY, cmd) ||
+	       systemd_timer_enable_unit(1, SCHEDULE_WEEKLY, cmd);
+}
+
+static int systemd_timer_update_schedule(int run_maintenance, int fd,
+					 const char *cmd)
+{
+	if (run_maintenance)
+		return systemd_timer_setup_units(cmd);
+	else
+		return systemd_timer_delete_units(cmd);
+}
+
 #if defined(__APPLE__)
 static const char platform_scheduler[] = "launchctl";
 #elif defined(GIT_WINDOWS_NATIVE)
 static const char platform_scheduler[] = "schtasks";
+#elif defined(__linux__)
+static const char platform_scheduler[] = "crontab_or_systemctl";
 #else
 static const char platform_scheduler[] = "crontab";
 #endif
@@ -1986,6 +2159,15 @@ static int update_background_schedule(int enable)
 		cmd = sep + 1;
 	}
 
+	if (!strcmp(scheduler, "crontab_or_systemctl")) {
+		if (is_systemd_timer_available("systemctl"))
+			scheduler = cmd = "systemctl";
+		else if (is_crontab_available("crontab"))
+			scheduler = cmd = "crontab";
+		else
+			die(_("Neither systemd timers nor crontab are available"));
+	}
+
 	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
 		return error(_("another process is scheduling background maintenance"));
 
@@ -1995,10 +2177,14 @@ static int update_background_schedule(int enable)
 		result = schtasks_update_schedule(enable, get_lock_file_fd(&lk), cmd);
 	else if (!strcmp(scheduler, "crontab"))
 		result = crontab_update_schedule(enable, get_lock_file_fd(&lk), cmd);
+	else if (!strcmp(scheduler, "systemctl"))
+		result = systemd_timer_update_schedule(
+			enable, get_lock_file_fd(&lk), cmd);
 	else
-		die("unknown background scheduler: %s", scheduler);
+		die(_("unknown background scheduler: %s"), scheduler);
 
 	rollback_lock_file(&lk);
+	free(lock_path);
 	free(testing);
 	return result;
 }
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2412d8c5c0..dd281789f4 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -20,6 +20,20 @@ test_xmllint () {
 	fi
 }
 
+test_lazy_prereq SYSTEMD_ANALYZE '
+	systemd-analyze --help >out &&
+	grep -w verify out
+'
+
+test_systemd_analyze_verify () {
+	if test_have_prereq SYSTEMD_ANALYZE
+	then
+		systemd-analyze verify "$@"
+	else
+		true
+	fi
+}
+
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h 2>err &&
 	test_i18ngrep "usage: git maintenance <subcommand>" err &&
@@ -615,6 +629,43 @@ test_expect_success 'start and stop Windows maintenance' '
 	test_cmp expect args
 '
 
+test_expect_success 'start and stop Linux/systemd maintenance' '
+	write_script print-args <<-\EOF &&
+	echo $* >>args
+	EOF
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" git maintenance start &&
+
+	# start registers the repo
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
+
+	test_systemd_analyze_verify "$HOME/.config/systemd/user/git-maintenance@.service" &&
+
+	rm -f expect &&
+	for frequency in hourly daily weekly
+	do
+		echo "--user enable --now git-maintenance@${frequency}.timer" >>expect || return 1
+	done &&
+	test_cmp expect args &&
+
+	rm -f args &&
+	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" git maintenance stop &&
+
+	# stop does not unregister the repo
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
+
+	test_path_is_missing "$HOME/.config/systemd/user/git-maintenance@.timer" &&
+	test_path_is_missing "$HOME/.config/systemd/user/git-maintenance@.service" &&
+
+	rm -f expect &&
+	for frequency in hourly daily weekly
+	do
+		echo "--user disable --now git-maintenance@${frequency}.timer" >>expect || return 1
+	done &&
+	test_cmp expect args
+'
+
 test_expect_success 'register preserves existing strategy' '
 	git config maintenance.strategy none &&
 	git maintenance register &&
-- 
2.31.1

