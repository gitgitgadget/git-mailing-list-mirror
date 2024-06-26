Received: from zulu.geekplace.eu (zulu.geekplace.eu [5.45.100.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F010A11
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.45.100.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405254; cv=none; b=u616v1T5ioXX5ztLH9p/Omh/dmpjCozuV+WnvP3q0vFtGGrWTZvpKH7HWG+YfJnIsXf10y+N8FXKlBqeT/TJgOgW7+6oKF/4IQWemX+S59agTn7xrZTJEZ3IJTDq73bdrrbNAhxSee3prmO2+Q0bFlU15xNkZrM+S0JUpzBrd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405254; c=relaxed/simple;
	bh=UuhpkL5fcKoEypuznLqjj6atrFvuRJvn2X8KFIlxAl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CChykFX6GQsKnpiDC4a5d1mC6d6+Ndpj39LdLrEhB8jbyqFHeABipuNj8sML+nOmSkaT+LLiFrMCqPc65uzrkyk6+9bDIVJbwaltAbTApRdzxDk+Ha0IqXiVRAQ0miX4kbbiaRd0sUagpTKnFZJaDizZx8UCwshM4VHqyf8aNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu; spf=pass smtp.mailfrom=geekplace.eu; arc=none smtp.client-ip=5.45.100.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geekplace.eu
Received: from neo-pc.sch (unknown [IPv6:2001:4091:a242:8321:34fb:50ff:feac:591b])
	by zulu.geekplace.eu (Postfix) with ESMTPA id 6CB0D4A02F2;
	Wed, 26 Jun 2024 14:34:03 +0200 (CEST)
From: Florian Schmaus <flo@geekplace.eu>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment variable
Date: Wed, 26 Jun 2024 14:33:58 +0200
Message-ID: <20240626123358.420292-2-flo@geekplace.eu>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240626123358.420292-1-flo@geekplace.eu>
References: <20240626123358.420292-1-flo@geekplace.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes more flexibility to disable/ignore the ownership check, besides
the safe.directory configuration option, is required.

For example, git-daemon running as nobody user, which typically has no
home directory. Therefore, we can not add the path to a user-global
configuration and adding the path to the system-wide configuration could
have negative security implications.

Therefore, make the check configurable via an environment variable.

If the environment variable GIT_IGNORE_INSECURE_OWNER is set to true,
then ignore potentially insecure ownership of git-related path
components.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 setup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/setup.c b/setup.c
index 3afa6fb09b28..da3f504fb536 100644
--- a/setup.c
+++ b/setup.c
@@ -1278,6 +1278,14 @@ static int ensure_valid_ownership(const char *gitfile,
 	 */
 	git_protected_config(safe_directory_cb, &data);
 
+	if (data.is_safe)
+		return data.is_safe;
+
+	if (git_env_bool("GIT_IGNORE_INSECURE_OWNER", 0)) {
+		warning("ignoring dubious ownership in repository at '%s' (GIT_IGNORE_INSECURE_OWNER set)", data.path);
+		return 1;
+	}
+
 	return data.is_safe;
 }
 
-- 
2.44.2

