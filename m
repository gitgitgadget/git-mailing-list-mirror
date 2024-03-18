Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E75025C
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775077; cv=none; b=Z/7zfVgcnmNvZV7lpixsI74Jj5AGlEXPdHc9pUG6A59fNlzdCaAwcfMoiwF+pDtPfYazOcY5H1lhkNx87MorHtXbmmRfz2NYuuPZgTRbik1jrlQjl+9/H49Sj5wyvAKnfQYlAW9skEGujdbeCuuOUnxS5fh3b4E5OMpIrAWGjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775077; c=relaxed/simple;
	bh=hQJdyI1FW3/O2gdS25cOQ26XZBJfL1yC/YMG3bMCQwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb7UC4BPk4jzojTpBjdzH5LrZ+WnZwqhQ0xHX4lf5/+yEfkDzO+RdwUoWMPEc2K/Apuz8shjKHeRP5tBHcv9OGr17I7B6lva//EEraNIBzPndGEHGkg5K/6eVwSVP666FZZQFSexRdUvSrxEAhw0Wzf2IhulZ+ttVZ0evFmTpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=0UlRJ5P4; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="0UlRJ5P4"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:fc9:9524:11d1:7aa4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 7A589602E8;
	Mon, 18 Mar 2024 16:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710775070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQCSqWFeEerRsW+ShSca65VwwQFftW4dsUYORqM4KEk=;
	b=0UlRJ5P4UWGeqHzIQhMjLbHQIELeXP52MoIwA/AjYsU7AWKDNWeMrYwfFv7uKABXT3HONb
	8FuQGfGtRVKb1AO5XhCtUr7R6YXjmXvNfJdI/nmTt+wtZWqQQ3mDWYNYdFxdzDlY+KJs20
	4QcULf4FPMswMch5XejmdGWB+FYnyZFqcAw1PidrOrNqxGbXqTlVmodsODyBv/qhQrZHKa
	ua6Hb1zrGRzXz5CeNyDJCgo2c7QaZ4rnBhlIBxwCAFLcLv6Uqo0nTppncschqEzBYJ8AAo
	CHbuhK85xXcFAN0VbDPvnHPFcWP/9N19vRiZW7t5ga6RpiQBm/125/SPQRpgfg==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Max Gautier <mg@max.gautier.name>
Subject: [RFC PATCH 3/5] maintenance: use packaged systemd units
Date: Mon, 18 Mar 2024 16:07:21 +0100
Message-ID: <20240318151701.26644-5-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318151701.26644-2-mg@max.gautier.name>
References: <20240318151701.26644-2-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove the code writing the units
- Simplify calling systemctl
  - systemctl does not error out when disabling units which aren't
    enabled, nor when enabling already enabled units
  - call systemctl only once, with all the units.
- Add clean-up code for leftover units in $XDG_CONFIG_HOME created by
  previous versions of git, taking care of preserving actual user
  override (by checking the start of the file).

Signed-off-by: Max Gautier <mg@max.gautier.name>
---
 builtin/gc.c | 293 ++++++++-------------------------------------------
 1 file changed, 45 insertions(+), 248 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index cb80ced6cb..981db8e297 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2308,276 +2308,73 @@ static char *xdg_config_home_systemd(const char *filename)
 	return xdg_config_home_for("systemd/user", filename);
 }
 
-#define SYSTEMD_UNIT_FORMAT "git-maintenance@%s.%s"
-
-static int systemd_timer_delete_timer_file(enum schedule_priority priority)
-{
-	int ret = 0;
-	const char *frequency = get_frequency(priority);
-	char *local_timer_name = xstrfmt(SYSTEMD_UNIT_FORMAT, frequency, "timer");
-	char *filename = xdg_config_home_systemd(local_timer_name);
-
-	if (unlink(filename) && !is_missing_file_error(errno))
-		ret = error_errno(_("failed to delete '%s'"), filename);
-
-	free(filename);
-	free(local_timer_name);
-	return ret;
-}
-
-static int systemd_timer_delete_service_template(void)
-{
-	int ret = 0;
-	char *local_service_name = xstrfmt(SYSTEMD_UNIT_FORMAT, "", "service");
-	char *filename = xdg_config_home_systemd(local_service_name);
-	if (unlink(filename) && !is_missing_file_error(errno))
-		ret = error_errno(_("failed to delete '%s'"), filename);
-
-	free(filename);
-	free(local_service_name);
-	return ret;
-}
-
-/*
- * Write the schedule information into a git-maintenance@<schedule>.timer
- * file using a custom minute. This timer file cannot use the templating
- * system, so we generate a specific file for each.
- */
-static int systemd_timer_write_timer_file(enum schedule_priority schedule,
-					  int minute)
-{
-	int res = -1;
-	char *filename;
-	FILE *file;
-	const char *unit;
-	char *schedule_pattern = NULL;
-	const char *frequency = get_frequency(schedule);
-	char *local_timer_name = xstrfmt(SYSTEMD_UNIT_FORMAT, frequency, "timer");
-
-	filename = xdg_config_home_systemd(local_timer_name);
-
-	if (safe_create_leading_directories(filename)) {
-		error(_("failed to create directories for '%s'"), filename);
-		goto error;
-	}
-	file = fopen_or_warn(filename, "w");
-	if (!file)
-		goto error;
-
-	switch (schedule) {
-	case SCHEDULE_HOURLY:
-		schedule_pattern = xstrfmt("*-*-* 1..23:%02d:00", minute);
-		break;
-
-	case SCHEDULE_DAILY:
-		schedule_pattern = xstrfmt("Tue..Sun *-*-* 0:%02d:00", minute);
-		break;
-
-	case SCHEDULE_WEEKLY:
-		schedule_pattern = xstrfmt("Mon 0:%02d:00", minute);
-		break;
-
-	default:
-		BUG("Unhandled schedule_priority");
-	}
-
-	unit = "# This file was created and is maintained by Git.\n"
-	       "# Any edits made in this file might be replaced in the future\n"
-	       "# by a Git command.\n"
-	       "\n"
-	       "[Unit]\n"
-	       "Description=Optimize Git repositories data\n"
-	       "\n"
-	       "[Timer]\n"
-	       "OnCalendar=%s\n"
-	       "Persistent=true\n"
-	       "\n"
-	       "[Install]\n"
-	       "WantedBy=timers.target\n";
-	if (fprintf(file, unit, schedule_pattern) < 0) {
-		error(_("failed to write to '%s'"), filename);
-		fclose(file);
-		goto error;
-	}
-	if (fclose(file) == EOF) {
-		error_errno(_("failed to flush '%s'"), filename);
-		goto error;
-	}
-
-	res = 0;
-
-error:
-	free(schedule_pattern);
-	free(local_timer_name);
-	free(filename);
-	return res;
-}
-
-/*
- * No matter the schedule, we use the same service and can make use of the
- * templating system. When installing git-maintenance@<schedule>.timer,
- * systemd will notice that git-maintenance@.service exists as a template
- * and will use this file and insert the <schedule> into the template at
- * the position of "%i".
- */
-static int systemd_timer_write_service_template(const char *exec_path)
-{
-	int res = -1;
-	char *filename;
-	FILE *file;
-	const char *unit;
-	char *local_service_name = xstrfmt(SYSTEMD_UNIT_FORMAT, "", "service");
-
-	filename = xdg_config_home_systemd(local_service_name);
-	if (safe_create_leading_directories(filename)) {
-		error(_("failed to create directories for '%s'"), filename);
-		goto error;
-	}
-	file = fopen_or_warn(filename, "w");
-	if (!file)
-		goto error;
-
-	unit = "# This file was created and is maintained by Git.\n"
-	       "# Any edits made in this file might be replaced in the future\n"
-	       "# by a Git command.\n"
-	       "\n"
-	       "[Unit]\n"
-	       "Description=Optimize Git repositories data\n"
-	       "\n"
-	       "[Service]\n"
-	       "Type=oneshot\n"
-	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
-	       "LockPersonality=yes\n"
-	       "MemoryDenyWriteExecute=yes\n"
-	       "NoNewPrivileges=yes\n"
-	       "RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6 AF_VSOCK\n"
-	       "RestrictNamespaces=yes\n"
-	       "RestrictRealtime=yes\n"
-	       "RestrictSUIDSGID=yes\n"
-	       "SystemCallArchitectures=native\n"
-	       "SystemCallFilter=@system-service\n";
-	if (fprintf(file, unit, exec_path, exec_path) < 0) {
-		error(_("failed to write to '%s'"), filename);
-		fclose(file);
-		goto error;
-	}
-	if (fclose(file) == EOF) {
-		error_errno(_("failed to flush '%s'"), filename);
-		goto error;
-	}
-
-	res = 0;
-
-error:
-	free(local_service_name);
-	free(filename);
-	return res;
-}
-
-static int systemd_timer_enable_unit(int enable,
-				     enum schedule_priority schedule,
-				     int minute)
+static int systemd_set_units_state(int enable)
 {
 	const char *cmd = "systemctl";
 	struct child_process child = CHILD_PROCESS_INIT;
-	const char *frequency = get_frequency(schedule);
-
-	/*
-	 * Disabling the systemd unit while it is already disabled makes
-	 * systemctl print an error.
-	 * Let's ignore it since it means we already are in the expected state:
-	 * the unit is disabled.
-	 *
-	 * On the other hand, enabling a systemd unit which is already enabled
-	 * produces no error.
-	 */
-	if (!enable)
-		child.no_stderr = 1;
-	else if (systemd_timer_write_timer_file(schedule, minute))
-		return -1;
 
 	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&child.args, cmd);
-	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
-		     "--now", NULL);
-	strvec_pushf(&child.args, SYSTEMD_UNIT_FORMAT, frequency, "timer");
+
+	strvec_pushl(&child.args, "--user", "--force", "--now",
+			enable ? "enable" : "disable",
+			"git-maintenance@hourly.timer",
+			"git-maintenance@daily.timer",
+			"git-maintenance@weekly.timer", NULL);
+	/*
+	** --force override existing conflicting symlinks
+	** We need it because the units have changed location (~/.config ->
+	** /usr/lib)
+	*/
 
 	if (start_command(&child))
 		return error(_("failed to start systemctl"));
 	if (finish_command(&child))
-		/*
-		 * Disabling an already disabled systemd unit makes
-		 * systemctl fail.
-		 * Let's ignore this failure.
-		 *
-		 * Enabling an enabled systemd unit doesn't fail.
-		 */
-		if (enable)
-			return error(_("failed to run systemctl"));
+		return error(_("failed to run systemctl"));
 	return 0;
 }
 
-/*
- * A previous version of Git wrote the timer units as template files.
- * Clean these up, if they exist.
- */
-static void systemd_timer_delete_stale_timer_templates(void)
+static void systemd_delete_user_unit(char const *unit)
 {
-	char *timer_template_name = xstrfmt(SYSTEMD_UNIT_FORMAT, "", "timer");
-	char *filename = xdg_config_home_systemd(timer_template_name);
+	char const	file_start_stale[] =	"# This file was created and is"
+						" maintained by Git.";
+	char		file_start_user[sizeof(file_start_stale)] = {'\0'};
+
+	char *filename = xdg_config_home_systemd(unit);
+	int handle = open(filename, O_RDONLY);
 
-	if (unlink(filename) && !is_missing_file_error(errno))
+	/*
+	** Check this is actually our file and we're not removing a legitimate
+	** user override.
+	*/
+	if (handle == -1 && !is_missing_file_error(errno))
 		warning(_("failed to delete '%s'"), filename);
+	else {
+		read(handle, file_start_user, sizeof(file_start_stale) - 1);
+		close(handle);
+		if (strcmp(file_start_stale, file_start_user) == 0) {
+			if (unlink(filename) == 0)
+				warning(_("deleted stale unit file '%s'"), filename);
+			else if (!is_missing_file_error(errno))
+				warning(_("failed to delete '%s'"), filename);
+		}
+	}
 
 	free(filename);
-	free(timer_template_name);
-}
-
-static int systemd_timer_delete_unit_files(void)
-{
-	systemd_timer_delete_stale_timer_templates();
-
-	/* Purposefully not short-circuited to make sure all are called. */
-	return systemd_timer_delete_timer_file(SCHEDULE_HOURLY) |
-	       systemd_timer_delete_timer_file(SCHEDULE_DAILY) |
-	       systemd_timer_delete_timer_file(SCHEDULE_WEEKLY) |
-	       systemd_timer_delete_service_template();
-}
-
-static int systemd_timer_delete_units(void)
-{
-	int minute = get_random_minute();
-	/* Purposefully not short-circuited to make sure all are called. */
-	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY, minute) |
-	       systemd_timer_enable_unit(0, SCHEDULE_DAILY, minute) |
-	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY, minute) |
-	       systemd_timer_delete_unit_files();
-}
-
-static int systemd_timer_setup_units(void)
-{
-	int minute = get_random_minute();
-	const char *exec_path = git_exec_path();
-
-	int ret = systemd_timer_write_service_template(exec_path) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_HOURLY, minute) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_DAILY, minute) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY, minute);
-
-	if (ret)
-		systemd_timer_delete_units();
-	else
-		systemd_timer_delete_stale_timer_templates();
-
-	return ret;
 }
 
 static int systemd_timer_update_schedule(int run_maintenance, int fd UNUSED)
 {
-	if (run_maintenance)
-		return systemd_timer_setup_units();
-	else
-		return systemd_timer_delete_units();
+	/*
+	 * A previous version of Git wrote the units in the user configuration
+	 * directory. Clean these up, if they exist.
+	 */
+	systemd_delete_user_unit("git-maintenance@hourly.timer");
+	systemd_delete_user_unit("git-maintenance@daily.timer");
+	systemd_delete_user_unit("git-maintenance@weekly.timer");
+	systemd_delete_user_unit("git-maintenance@.timer");
+	systemd_delete_user_unit("git-maintenance@.service");
+	return systemd_set_units_state(run_maintenance);
 }
 
 enum scheduler {
-- 
2.44.0

