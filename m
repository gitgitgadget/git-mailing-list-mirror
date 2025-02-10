Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69525A4D5
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 02:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.199.136.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739153523; cv=none; b=O7Uxn5r7D7qyAbtbOMlHDHi3WO/Z4dLj7APXZEcIgBcJJAI2WcyC1Z9E+15zL59oQW9e/Rp2b46ymCOsHhTZXdtRunBO3HATg02fRqWNFgvpognS/npDG7MwPbwo8DStsW8n2cnRjT54BFPs+A02MV+VpAjyDIizyQ0eO7Ilf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739153523; c=relaxed/simple;
	bh=hwem6d/GNlCV7VPZEpsiZdPg407MF3yQTRpGPIpFbSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XryWen112dp86PIbaV3Puh+Js4utP5X39uBiHaaY0rYK6NAmeZ5IbA9a8CCzsjAcMV+17Ye9rbJdbgWEGCPl2FEvEmMsllz0AqPcNcwEnQo8qqwzeKx95MKcnX6/116qoyLyrbsR2Om73juyAqO18BZZn6sEIdw4aVv/fgysUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; spf=pass smtp.mailfrom=envs.net; arc=none smtp.client-ip=5.199.136.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id D844C38A3ED4;
	Mon, 10 Feb 2025 02:11:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FVNTnLkoQ-iW; Mon, 10 Feb 2025 02:11:47 +0000 (UTC)
Received: from xtexx.eu.org (unknown [120.230.227.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Mon, 10 Feb 2025 02:11:47 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Bingwu Zhang <xtex@aosc.io>,
	apenwarr@gmail.com
Subject: [PATCH] contrib/subtree: verify HEAD is valid before adding a subtree
Date: Mon, 10 Feb 2025 10:11:26 +0800
Message-ID: <20250210021128.31083-2-xtex@envs.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; i=xtex@aosc.io; h=from:subject; bh=zS2GL+08mZGijujVIxoowkGtNpvpWEYJ9Ym64zrIgsc=; b=owGbwMvMwCW2U4Ij7wZL9ETG02pJDOkrEwIcWk/lrPz38o8dk3vmZ3OrzoW39101niC7m+PpP 7EGodgfHaUsDGJcDLJiiixFhg3erDrp/KLLymVh5rAygQxh4OIUgIm87GZkOOomUVaygodn54k+ 05hdimGeCavz1G3FxdkVVJ+uNp8dwfC/dLNI/ak4q8zD6az3GOMeKrz8G37SaPrXd0xxO2Z0HlV gAgA=
X-Developer-Key: i=xtex@aosc.io; a=openpgp; fpr=7231804B052C670F15A6771DB918086ED8045B91
Content-Transfer-Encoding: 8bit

From: Bingwu Zhang <xtex@aosc.io>

After initializing a new repository or switching to a orphan branch,
HEAD is a symbolic reference to refs/heads/xxx while the pointed branch
head does not exist until a initial commit.

"git subtree add" will try to ensure that working tree and index are
clean, but as HEAD is invalid, diff-index always fails:
  fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'
  fatal: working tree has modifications.  Cannot add.
It says "working tree has modifications" but it is not the case.

Add a check using "git show-ref --verify" to ensure that HEAD is a valid
reference and give a clearer error message.

Signed-off-by: Bingwu Zhang <xtex@aosc.io>
---
 contrib/subtree/git-subtree.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 15ae86db1b27..41eb816e454a 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -770,6 +770,11 @@ copy_or_skip () {
 # Usage: ensure_clean
 ensure_clean () {
 	assert test $# = 0
+	# verify HEAD, or else "git diff-index HEAD" will fail
+	if ! git show-ref --verify --quiet HEAD 2>&1
+	then
+		die "fatal: HEAD is not a valid reference.   Subtree cannot be committed as the first commit of a branch."
+	fi
 	if ! git diff-index HEAD --exit-code --quiet 2>&1
 	then
 		die "fatal: working tree has modifications.  Cannot add."

base-commit: f93ff170b93a1782659637824b25923245ac9dd1
-- 
2.48.1

