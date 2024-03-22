Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774BC80C03
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145645; cv=none; b=O6oivLpEjxI+zjN9qT762aOYlmtp/wYr2flHBrFcZEOpZM9HjO5kYUYYZY0BWAANmOEhsB31MhJ7b7Na85gOkg1DVsjvVIvlZgmp+BIyPJQja7TBctXKxvq4T4SHArhcC8N4LhAf/S7qr2Ztnc70SbQ1Wke4vh15UXuq9GgNyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145645; c=relaxed/simple;
	bh=mUP/g8fzBtTUk2XWm2E3wzy38DpT3pDvY8yNAtZiclA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkt2u9CokAGax/rRkVSyF0w3B2cal6RiaNHuUAMsnOk0mYU9N9N760ZbEEQRViOMoLHXc+/qx8D/g8cEwszTRunjRt6JddlIkBnbbxwa2WAnW2Ouy1ZtlfJuZ9v6VOov0VnQXp0bmtLrjHrb+QppNatmi90fRnbWPO3LtfTCZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=Qb9wdEDJ; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="Qb9wdEDJ"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 1F6E560379;
	Fri, 22 Mar 2024 23:13:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711145634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPiJPiGolYaJh6ma4zzZgwHwJBI2dPrwAFYxApcigjg=;
	b=Qb9wdEDJX8ltLDhWeDQZd1W8GfF5YPNaZnem3NRovrt5C9rAWSKRhmONOqRLULdi0GjIdF
	4sBMGmwRvjULUqBeMjIwVt40RrQv9PtLwJkcGEW2whzLeG+pJs/91B/xYsnIS4tNTDLGGM
	ZlCP8pE7MxuKrugegLjVQmndxvnkxCJSXjJxy/YcEWcOwlOTNIyOvZcXNxFhzECihv81mz
	9LvhiDlgP8tJFp5QrBSX0+DW0qeklIkM6XkaCp8UytFpEf4QF94HhtisPVC4sweKT7m1oi
	f3DMgH2puPtLruhIO7dDfOD5qnCcO5BgZWjz3uufghr6DfzO6cBJx2uALGi2hQ==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>,
	=?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 3/6] maintenance: simplify systemctl calls
Date: Fri, 22 Mar 2024 23:11:08 +0100
Message-ID: <20240322221327.12204-4-mg@max.gautier.name>
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

The systemctl invocation to enable or disable the git maintenance timers
is needlessly complicated:
- systemctl does not mind at all enabling already enabled units, nor
  disabling already disabled units.
- it can act on several units at once instead of only one.

Use only one systemctl invocation per `git maintenance start/stop`.
Transparently pass its status and output.
Add the --force option to override conflicting symlinks to previous
instances of our units files which lived in $XDG_CONFIG_HOME.

Signed-off-by: Max Gautier <mg@max.gautier.name>
---
 builtin/gc.c | 63 ++++++++++++----------------------------------------
 1 file changed, 14 insertions(+), 49 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 199c8e6240..aaee91451a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2303,70 +2303,35 @@ static int is_systemd_timer_available(void)
 	return real_is_systemd_timer_available();
 }
 
-static int systemd_timer_enable_unit(int enable,
-				     enum schedule_priority schedule)
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
 
 	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&child.args, cmd);
-	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
-		     "--now", NULL);
-	strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
+
+	strvec_pushl(&child.args, "--user", "--force", "--now",
+			enable ? "enable" : "disable",
+			"git-maintenance@hourly.timer",
+			"git-maintenance@daily.timer",
+			"git-maintenance@weekly.timer", NULL);
+	/*
+	 * --force override existing conflicting symlinks
+	 * We need it because the units have changed location (~/.config ->
+	 * /usr/lib)
+	 */
 
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
 
-static int systemd_timer_disable_units(void)
-{
-	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY) ||
-	       systemd_timer_enable_unit(0, SCHEDULE_DAILY) ||
-	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY);
-}
-
-static int systemd_timer_setup_units(void)
-{
-
-	int ret = systemd_timer_enable_unit(1, SCHEDULE_HOURLY) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_DAILY) ||
-		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY);
-	if (ret)
-		systemd_timer_disable_units();
-	return ret;
-}
-
 static int systemd_timer_update_schedule(int run_maintenance, int fd UNUSED)
 {
-	if (run_maintenance)
-		return systemd_timer_setup_units();
-	else
-		return systemd_timer_disable_units();
+	return systemd_set_units_state(run_maintenance);
 }
 
 enum scheduler {
-- 
2.44.0

