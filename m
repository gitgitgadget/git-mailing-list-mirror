Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108471E5B72
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501927; cv=none; b=hMp1FFeQo9HDI9tDV7zDxKW12POZzMTjVMJ4IhwmsCsk04oTqeTQzL7RBaKW4jHwMRJY8U52CqG/yzVo3W36u2HcP8dXVLuTcVu0a5jDgqIb9mYAVeOMMajbZFMlfNIhi56xlpYoCy47DQ66e9ZBT4jC5OVfB4lH6ogSYY9Zwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501927; c=relaxed/simple;
	bh=aX7XsovBkHlFYsqbkil3RnZNhIh5tAaYtllba2twuL8=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=loWNiyUn7g+jED4SrndUBI8faz5nod6OBPpKjUr4XA3pvlQZ3gKVwdnMXrVG1C54W1I0rxXwRkf6uCQY5Lth6jEfltAh2txVruPlfCqtW7MUQLzkPrtaomKc2f9o0qsBOzeq1SWUXnBMFvimJcjDyAs4WfpcuxUT83yoTgM8GEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4bxyFR4mJ5zRpKw;
	Wed,  6 Aug 2025 19:38:35 +0200 (CEST)
Message-ID: <37f6e34c-91aa-4e55-88e1-019d2e042df3@kdbg.org>
Date: Wed, 6 Aug 2025 19:38:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] rebase -i: permit 'drop' of a merge commit
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

4c063c82e9 (rebase -i: improve error message when picking merge,
2024-05-30) added advice texts for cases when a merge commit is
passed as argument of sequencer command that cannot operate with
a merge commit. However, it forgot about the 'drop' command, so
that in this case the BUG() in the default branch is reached.

Handle 'drop' like 'merge', i.e., permit it without a message.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 sequencer.c                   | 1 +
 t/t3404-rebase-interactive.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index aaf2e4df64..9ae40a91b2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2720,8 +2720,9 @@ static int check_merge_commit_insn(enum todo_command command)
 	case TODO_SQUASH:
 		return error(_("cannot squash merge commit into another commit"));
 
 	case TODO_MERGE:
+	case TODO_DROP:
 		return 0;
 
 	default:
 		BUG("unexpected todo_command");
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 6bac217ed3..34d6ad0770 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -2262,8 +2262,9 @@ rebase_setup_and_clean () {
 	reword $oid
 	edit $oid
 	fixup $oid
 	squash $oid
+	drop $oid # acceptable, no advice
 	EOF
 	(
 		set_replace_editor todo &&
 		test_must_fail git rebase -i HEAD 2>actual
-- 
2.50.1.837.g8c5950ae16

