Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C433130E2B
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103632; cv=none; b=G6qmiF5XugrqEbRJhiGc+WoP/VONIacPfmevyeSlL/7a9jCYjYn3CIPhBHPxyCi+uV4vn7YXhI5gKhATl5dXb/H9cTeFsdIxjpM0r2b18vV1eRtLHRG03M5kpQv4Gak2gJ8Fkng4kt5FmNJMfiTdqHULk6UBCONFgsXNwCjIt+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103632; c=relaxed/simple;
	bh=+fMvVC9LDxd0RH+Hb18Lbr41brOssrLMLZ/bOQSJ3UE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqUv8zjGDL4Lc8yjAt+xQBCotuaxVg1buT7qSGDRszm7NbBGOzZ1SZVCYhCLDwFYH8OiHwZmUMGcu8Ww6oNKwrL63oPBfGrV6D9p3nQGEjOooyTRwg20EGD8/xwIGdl38LzfEqndh3pzQZYast/e/H2ORqFY9t6RVBDnhcWqYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rb1k3-0000000079F-3jyK
	for git@vger.kernel.org;
	Fri, 16 Feb 2024 18:11:16 +0100
Received: from [10.20.10.230] (port=45956 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rb1k2-00ARme-2T;
	Fri, 16 Feb 2024 18:11:14 +0100
Received: by drbeat.li (Postfix, from userid 1000)
	id 7A320180192; Fri, 16 Feb 2024 18:11:14 +0100 (CET)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Beat Bolli <dev+git@drbeat.li>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] completion: use awk for filtering the config entries
Date: Fri, 16 Feb 2024 18:10:46 +0100
Message-ID: <20240216171046.927552-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.42.0.583.ga47b40fd90
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Commits 1e0ee4087e (completion: add and use
__git_compute_first_level_config_vars_for_section, 2024-02-10) and
6e32f718ff (completion: add and use
__git_compute_second_level_config_vars_for_section, 2024-02-10)
introduced new helpers for config completion.

Both helpers use a pipeline of grep and awk to filter the list of config
entries. awk is perfectly capable of filtering, so let's eliminate the
grep process and move the filtering into the awk script.

The "-E" grep option (extended syntax) was not necessary, as $section is
a single word.

While at it, wrap the over-long lines to make them more readable.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---

Junio, this goes on top of 'pb/complete-config' which is on next
currently.

 contrib/completion/git-completion.bash | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 444b3efa63..fcf1afd75d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2673,7 +2673,8 @@ __git_compute_first_level_config_vars_for_section ()
 	__git_compute_config_vars
 	local this_section="__git_first_level_config_vars_for_section_${section}"
 	test -n "${!this_section}" ||
-	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
+	printf -v "__git_first_level_config_vars_for_section_${section}" %s \
+		"$(echo "$__git_config_vars" | awk -F. "/^${section}\.[a-z]/ { print \$2 }")"
 }
 
 __git_compute_second_level_config_vars_for_section ()
@@ -2682,7 +2683,8 @@ __git_compute_second_level_config_vars_for_section ()
 	__git_compute_config_vars_all
 	local this_section="__git_second_level_config_vars_for_section_${section}"
 	test -n "${!this_section}" ||
-	printf -v "__git_second_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars_all" | grep -E "^${section}\.<" | awk -F. '{print $3}')"
+	printf -v "__git_second_level_config_vars_for_section_${section}" %s \
+		"$(echo "$__git_config_vars_all" | awk -F. "/^${section}\.</ { print \$3 }")"
 }
 
 __git_config_sections=
-- 
2.42.0.583.ga47b40fd90

