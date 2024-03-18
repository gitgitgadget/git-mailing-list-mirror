Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E62854BEF
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781422; cv=none; b=iFStG/CBpaXr1KnffX3g3dTe9U2u/yDPGvTm1Jyi886O58uQ6d3y7fTn9OuIofWdHm3VXBpGFOB+JgIR0gM96W71GrvYOpJA2YWrsxqQcNiOh+NH98qwM/+zOmIuyM/HWmD8nhDuDmZmQRHLFKZwDlMVywBjZh2C7Fl88sXXd3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781422; c=relaxed/simple;
	bh=6/zVtv66V3j437HgBq7a9Lt5mKObb3o67gOKzcYGR5k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PsKQW19TVxGfezVUnsqkX8/nPwSJYqzKiGQ5HhCAHiyR5ZJetMj8v1IQblNrmlyW1KIUHxkv2t2RYeAiAlhQ/mCJ6OB8jHoRarPeu/VzCkaDIIcphprU8k6V+668RPRLM3E0wE/ovDAB0Y8Wrsa4+iRv5E9RnIm9x0C8YJJ/DUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Sr/bb/kz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Sr/bb/kz"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710781411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1clfhW8X25prny2BqppR/1LKCJ/ynoPHWdnYUhXx00=;
	b=Sr/bb/kzADHZqlcndPHbOx06K7+lQMY9rXrZ4VKspwg0Bghqqj9Tme5uiNBsprw/UmlyJF
	GSVFtyKixg1KTJBkdqjVEweaLHnEmsMoVMZd5JA8eDO0Fzu5eHIuu+kBPTqtTNuE0Hfun+
	Pz+9GRA1CQOQzm97nGej+pj/vxpDaN6wmUsL9/0CVyebSEtDE9QkcJd2J1mGcOLfKKUPLf
	0IS1oLJloZ/S5vuZ2H+Wi4pOH5SoTuLEye4WKok/n2KD0h3WoFxgapP7NOMOXj60eEG+R5
	RdYNCRFcO1q+Fz0ioU+J7kvjzEcprdvscn6WsS2rgNnLsmrD/DRrdUiGibNg0w==
To: git@vger.kernel.org
Subject: [PATCH 4/5] grep: introduce new config option to include untracked files
Date: Mon, 18 Mar 2024 18:03:24 +0100
Message-Id: <9f70eeb4f04a874a2036e1d8c61f3b7ec130663a.1710781235.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710781235.git.dsimic@manjaro.org>
References: <cover.1710781235.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add new configuration option grep.includeUntracked that enables --untracked
option by default.  This pretty much follows the logic established by the
already existing configuration option grep.fallbackToNoIndex, while also
respecting the dependencies of the --untracked option.

Also add a few automated tests to the t7810, to cover the new configuration
option by replicating the already existing tests for --untracked.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 builtin/grep.c  | 3 +++
 t/t7810-grep.sh | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index af89c8b5cb19..71d94126fb6e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1041,6 +1041,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		the_repository->settings.command_requires_full_index = 0;
 	}
 
+	if (use_index && !cached)
+		git_config_get_bool("grep.includeuntracked", &untracked);
+
 	if (use_index && !startup_info->have_repository) {
 		int fallback = 0;
 		git_config_get_bool("grep.fallbacktonoindex", &fallback);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 875dcfd98f3a..de93936d585f 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1298,20 +1298,29 @@ test_expect_success 'inside git repository but with --no-index' '
 		git grep --untracked o >../actual.unignored &&
 		test_cmp ../expect.unignored ../actual.unignored &&
 
+		git -c grep.includeUntracked=true grep o >../actual.unignored &&
+		test_cmp ../expect.unignored ../actual.unignored &&
+
 		git grep --no-index o >../actual.full &&
 		test_cmp ../expect.full ../actual.full &&
 
+		git -c grep.includeUntracked=true grep --no-index o >../actual.full &&
+		test_cmp ../expect.full ../actual.full &&
+
 		git grep --no-index --exclude-standard o >../actual.unignored &&
 		test_cmp ../expect.unignored ../actual.unignored &&
 
 		cd sub &&
 		test_must_fail git grep o >../../actual.sub &&
 		test_must_be_empty ../../actual.sub &&
 
 		git grep --no-index o >../../actual.sub &&
 		test_cmp ../../expect.sub ../../actual.sub &&
 
 		git grep --untracked o >../../actual.sub &&
+		test_cmp ../../expect.sub ../../actual.sub &&
+
+		git -c grep.includeUntracked=true grep o >../../actual.sub &&
 		test_cmp ../../expect.sub ../../actual.sub
 	)
 '
