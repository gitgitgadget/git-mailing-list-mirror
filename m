Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F481207
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145644; cv=none; b=FRQClsfT3KZ8rMiI1nsmeZhUZDv0Mnutx5FJGUr4dohOAnlbrKfqJIos5NTbsJ4MfKa/MjGgg0YKrHJCp2WAfh88DAn9fcL/wvoZWjCMI4djq7MY7c9s+sX3VGI6Kr6vNQufrrmmDN5srAmKtft3SWt+E3yLq2n73EfHrCYUvJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145644; c=relaxed/simple;
	bh=GPddT3vuYv8b96rYYXfMppXzyC8w0K5sxVMWjjcT5IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUfUzEUqYXs2DKcdMq/NPl9WDRiH05PkkNekHTfzGWvwyZ//UB/hIzZTgoppKzsqDjTz7ASFVbNmoZE1XLwMrFFtkeEASMroqp28kJc2Np2J/E5avT7H5YEEkrMVrYFWXhUzpGkqnntg9zWquo+QaahBbRghVqKAP7M2R7XzA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=lxmQxCQO; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="lxmQxCQO"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 75A3C6037A;
	Fri, 22 Mar 2024 23:13:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711145634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JvtaAHuIsinpNSxPVRMAdnASiq8hhGWGMnbjt/Z9j4=;
	b=lxmQxCQO2OgJgRu+uqxNII50lbCMOLTIvxE2spibxtK7NZfI2rz+HDALioaPqfSxbB1WWs
	QsSYs/F4YYCjYJ5YLhnUXlLc4z6SadTMN56CHXcI3B5janEuqYZH7sovaR3cGJwbpxAT5P
	euTSxEZcOMQREfJFYHnNqR8/MZkQCx8owFD1gHfAAG9MTBEkwFBkrie5SDlA5PUZvKAKEV
	ESK45VRDELVglqytT3AkR9pSeZ3U8h7QLG72vrd7LA6P26ipehQRcOqODU9yMN21oKyVxT
	ki0jh5QrB/K23Ggtn2US49bX2RlQw3TWcZksQ8MTmvwu7nFAWQ2PEHgnisFAxg==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>,
	=?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
Date: Fri, 22 Mar 2024 23:11:09 +0100
Message-ID: <20240322221327.12204-5-mg@max.gautier.name>
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

Before commit 976640edbb (maintenance: use packaged systemd units,
2024-03-21), we we're putting systemd unit files in $XDG_CONFIG_HOME ;
these could mask those we are now distributing as part of git.

Remove all the systemd units possibly created by previous version of
git when running `git maintenance start/stop`.
Avoid overwriting units we didn't write, by comparing the first line
with the start of the comment we added to our unit files previously.

Signed-off-by: Max Gautier <mg@max.gautier.name>
---

Notes:
    How should I refer to a commit which is part of the same patch series ?
    The commit id will change so the message won't be correct anymore, right
    ?

 builtin/gc.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index aaee91451a..99b158e481 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2329,8 +2329,50 @@ static int systemd_set_units_state(int enable)
 	return 0;
 }
 
+/*
+ * TODO: in the future (~2026 ?) remove this cleanup code
+ */
+static void systemd_delete_user_unit(char const *unit)
+{
+	char const	file_start_stale[] =	"# This file was created and is"
+						" maintained by Git.";
+	char		file_start_user[sizeof(file_start_stale)] = {'\0'};
+
+	char *filename = xdg_config_home_for("systemd/user", unit);
+	int handle = open(filename, O_RDONLY);
+
+	/*
+	 * Check this is actually our file and we're not removing a legitimate
+	 * user override.
+	 */
+	if (handle == -1 && !is_missing_file_error(errno))
+		warning(_("failed to delete '%s'"), filename);
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
+
+	free(filename);
+}
+
 static int systemd_timer_update_schedule(int run_maintenance, int fd UNUSED)
 {
+	/*
+	 * A previous version of Git wrote the units in the user configuration
+	 * directory. Clean these up, if they exist.
+	 * TODO: in the future (~2026 ?) remove this cleanup code
+	 */
+	systemd_delete_user_unit("git-maintenance@hourly.timer");
+	systemd_delete_user_unit("git-maintenance@daily.timer");
+	systemd_delete_user_unit("git-maintenance@weekly.timer");
+	systemd_delete_user_unit("git-maintenance@.timer");
+	systemd_delete_user_unit("git-maintenance@.service");
 	return systemd_set_units_state(run_maintenance);
 }
 
-- 
2.44.0

