Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743F43AB5
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145644; cv=none; b=lH2BaIEwnXLz1xjRIaq16OdfCybQZSq5YjytGkkNnAQRHFwlJcz5njp5tMuyYcEnHU3AIxokpMVw+dLrHmFLDRV+1MZNaslqRhwQpkooJ+nccqY4HgT36WNeV1e8yhyiXFmsDuviw3xBz5dj1tQFkHmCwrj6f2wR19PpLxvklx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145644; c=relaxed/simple;
	bh=KBnJjcNeQ8HdBzKlNznQaZxCYjl2eESCO6RL1y5LSnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fc/7E3rH1FSw1ggeRdGzuj4YwdKsQF29Yq27k/KpuV9jimZWTedVCRzQ3e8UvZuCneCAD/k9Fqt2pYO0PWUxJnL672tI2+KTIMC6GE/iKkCXikhCia4PNuVT45jxhOneTbS4AM5eqEjgI5eFbnVxDW7X+L6qWAMkjVy6H4sVUe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=z446zH/M; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="z446zH/M"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id B8DC460378;
	Fri, 22 Mar 2024 23:13:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711145633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coSFnLM/k7UrOljaS9qVSC5W2bhn+aE42EoWJNx/dhI=;
	b=z446zH/M7rt4EDtfmRaGvUjJmXEtMRdaISP4HR/2N9KMu4qJPCkHfdj3X5httkfBS5nqV4
	rpnuiB2Deu7f86l3ARDOeKGm7Keo62NtEYjkkdvB3yDZnkeZK0eXdhgyW5ugpUe/hWyV63
	A5cQyRNLoGJfUJLA57V4wtMxAzcQvFlXkU/yKhk224WjzjbY1kmqMDc9PuSidM8qgSV+9m
	J0Fl5dwl3suduGCzzGyCVGF4zuErAzdO4vkPjg9hm6vsQ9fcymoVe8TrCV4ZGO6fbXJyQu
	4gLMJc6NjWkgKX0vsjbe8b/Rpl8g8ZLgpseKSlcZ973sG1O4Wza1AdMw5aYCyQ==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>,
	=?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] maintenance: use packaged systemd units
Date: Fri, 22 Mar 2024 23:11:07 +0100
Message-ID: <20240322221327.12204-3-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322221327.12204-1-mg@max.gautier.name>
References: <20240322221327.12204-1-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, `git maintenance start`, if it uses the systemd scheduler,
will create systemd user units in $XDG_CONFIG_HOME, and overwrite the
files on each invocation.
Conversely, `git maintenance stop` will remove the unit files.

This is problematic mostly because it steps on user toes (and their
configuration, also). You can't mask the git maintenance systemd units,
because they are in $XDG_CONFIG_HOME and you can only mask "vendor"
units (see man systemctl), you can't override them either.

Additionally, it necessitates creating, modifying and removing files
from builtin/gc.c, which adds code and some avoidable complexity.

Package the systemd user units (timer and service) with git in
$(prefix)/lib/systemd/user (or $XDG_DATA_HOME for $HOME installation),
and remove code for writing and deleting the units from builtin/gc.c.
Determine the correct git path at install time by for the service unit.

Detect systemd timers support (at install time) by relying on systemctl
presence, since we use it as the control interface for the systemd
scheduler.

Signed-off-by: Max Gautier <mg@max.gautier.name>
---

Notes:
    I'm not completely sure if it's ok to do install time templating like
    this, but I couldn't find a similar enough example in the Makefile. Any
    suggestion for a better way ?

 Makefile                                 |   5 +
 builtin/gc.c                             | 117 +----------------------
 config.mak.uname                         |  10 ++
 systemd/user/git-maintenance@.service.in |  17 ++++
 systemd/user/git-maintenance@.timer      |  12 +++
 5 files changed, 49 insertions(+), 112 deletions(-)
 create mode 100644 systemd/user/git-maintenance@.service.in
 create mode 100644 systemd/user/git-maintenance@.timer

diff --git a/Makefile b/Makefile
index 4e255c81f2..4fb015478e 100644
--- a/Makefile
+++ b/Makefile
@@ -3469,6 +3469,11 @@ install: all
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
+ifdef SYSTEMD_USER_UNIT_DIR
+	$(INSTALL) -Dm 644 -t '$(DESTDIR_SQ)$(SYSTEMD_USER_UNIT_DIR)' systemd/user/git-maintenance@.timer
+	sed 's+@BINDIR@+$(bindir_SQ)+' systemd/user/git-maintenance@.service.in | \
+		$(INSTALL) -Dm 644 /dev/stdin '$(DESTDIR_SQ)$(SYSTEMD_USER_UNIT_DIR)/git-maintenance@.service'
+endif
 
 ifdef MSVC
 	# We DO NOT install the individual foo.o.pdb files because they
diff --git a/builtin/gc.c b/builtin/gc.c
index dac59414f0..199c8e6240 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2303,110 +2303,6 @@ static int is_systemd_timer_available(void)
 	return real_is_systemd_timer_available();
 }
 
-static char *xdg_config_home_systemd(const char *filename)
-{
-	return xdg_config_home_for("systemd/user", filename);
-}
-
-static int systemd_timer_delete_unit_templates(void)
-{
-	int ret = 0;
-	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
-	if (unlink(filename) && !is_missing_file_error(errno))
-		ret = error_errno(_("failed to delete '%s'"), filename);
-	FREE_AND_NULL(filename);
-
-	filename = xdg_config_home_systemd("git-maintenance@.service");
-	if (unlink(filename) && !is_missing_file_error(errno))
-		ret = error_errno(_("failed to delete '%s'"), filename);
-
-	free(filename);
-	return ret;
-}
-
-static int systemd_timer_write_unit_templates(const char *exec_path)
-{
-	char *filename;
-	FILE *file;
-	const char *unit;
-
-	filename = xdg_config_home_systemd("git-maintenance@.timer");
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
-	       "[Timer]\n"
-	       "OnCalendar=%i\n"
-	       "Persistent=true\n"
-	       "RandomizedDelaySecond=3540\n"
-	       "FixedRandomDelay=true\n"
-	       "\n"
-	       "[Install]\n"
-	       "WantedBy=timers.target\n";
-	if (fputs(unit, file) == EOF) {
-		error(_("failed to write to '%s'"), filename);
-		fclose(file);
-		goto error;
-	}
-	if (fclose(file) == EOF) {
-		error_errno(_("failed to flush '%s'"), filename);
-		goto error;
-	}
-	free(filename);
-
-	filename = xdg_config_home_systemd("git-maintenance@.service");
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
-	free(filename);
-	return 0;
-
-error:
-	free(filename);
-	systemd_timer_delete_unit_templates();
-	return -1;
-}
-
 static int systemd_timer_enable_unit(int enable,
 				     enum schedule_priority schedule)
 {
@@ -2447,24 +2343,21 @@ static int systemd_timer_enable_unit(int enable,
 	return 0;
 }
 
-static int systemd_timer_delete_units(void)
+static int systemd_timer_disable_units(void)
 {
 	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY) ||
 	       systemd_timer_enable_unit(0, SCHEDULE_DAILY) ||
-	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY) ||
-	       systemd_timer_delete_unit_templates();
+	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY);
 }
 
 static int systemd_timer_setup_units(void)
 {
-	const char *exec_path = git_exec_path();
 
-	int ret = systemd_timer_write_unit_templates(exec_path) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_HOURLY) ||
+	int ret = systemd_timer_enable_unit(1, SCHEDULE_HOURLY) ||
 		  systemd_timer_enable_unit(1, SCHEDULE_DAILY) ||
 		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY);
 	if (ret)
-		systemd_timer_delete_units();
+		systemd_timer_disable_units();
 	return ret;
 }
 
@@ -2473,7 +2366,7 @@ static int systemd_timer_update_schedule(int run_maintenance, int fd UNUSED)
 	if (run_maintenance)
 		return systemd_timer_setup_units();
 	else
-		return systemd_timer_delete_units();
+		return systemd_timer_disable_units();
 }
 
 enum scheduler {
diff --git a/config.mak.uname b/config.mak.uname
index d0dcca2ec5..35ca236874 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -68,6 +68,16 @@ ifeq ($(uname_S),Linux)
 	ifneq ($(findstring .el7.,$(uname_R)),)
 		BASIC_CFLAGS += -std=c99
 	endif
+	ifeq ($(shell command -v systemctl >/dev/null ?&& echo y),y)
+		XDG_DATA_HOME ?= $(HOME)/.local/share
+		# systemd user units of programm installed in the home directory
+		# (meaning prefix == $HOME) shall go in XDG_DATA_HOME
+		# (from man 5 systemd.unit)
+		SYSTEMD_USER_UNIT_DIR = $(strip $(if $(and \
+			$(findstring $(prefix),$(HOME)),\
+			$(findstring $(HOME),$(prefix))),\
+			$(XDG_DATA_HOME),$(prefix)/$(lib)))/systemd/user
+	endif
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/systemd/user/git-maintenance@.service.in b/systemd/user/git-maintenance@.service.in
new file mode 100644
index 0000000000..649ba87e7e
--- /dev/null
+++ b/systemd/user/git-maintenance@.service.in
@@ -0,0 +1,17 @@
+[Unit]
+Description=Optimize Git repositories data
+Documentation=man:git-maintenance(1)
+
+[Service]
+Type=oneshot
+ExecStart=@BINDIR@/git for-each-repo --config=maintenance.repo \
+          maintenance run --schedule=%i
+LockPersonality=yes
+MemoryDenyWriteExecute=yes
+NoNewPrivileges=yes
+RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6 AF_VSOCK
+RestrictNamespaces=yes
+RestrictRealtime=yes
+RestrictSUIDSGID=yes
+SystemCallArchitectures=native
+SystemCallFilter=@system-service
diff --git a/systemd/user/git-maintenance@.timer b/systemd/user/git-maintenance@.timer
new file mode 100644
index 0000000000..2834bac365
--- /dev/null
+++ b/systemd/user/git-maintenance@.timer
@@ -0,0 +1,12 @@
+[Unit]
+Description=Optimize Git repositories data
+Documentation=man:git-maintenance(1)
+
+[Timer]
+OnCalendar=%i
+Persistent=true
+RandomizedDelaySec=3540
+FixedRandomDelay=true
+
+[Install]
+WantedBy=timers.target
-- 
2.44.0

