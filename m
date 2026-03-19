Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2BA40756D
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959930; cv=none; b=CCp0CQq0umg7BOWV0pV0y8hEZfVv1FT7IHKDxBRLF62qzC+UYfNLHW4g8lkfG5q7jl9NgQE29/3MLF7dHG74h3CSlnm9fZL/x3Lluq+AL0sSsC3s6NSsGjJQHhw1STJlTzr47B0ZwOBHJiGyGyVk9yS3ZMX3sQ9BQ2qPcCkMteY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959930; c=relaxed/simple;
	bh=TmNhCMYwRhbrvn+j6FFmfoiZi9M0z1i3Kq7p2jEDaXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbWM4q2WbSNY9FoFqqMbrJNAs5DKAnVthnp7F4CVwA/sTiy7HPNNw/l4d4KM2MmNg97r4Ns/UaM+oF9jEewJIYkIFTycUfQMjFQ8ar1tcWKJo03jNdU3OO627RNUvhVAn9mfwESIy/WfHGlUs3STzlHwHkCntqETtuN24euRnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=g8rxUk/E; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="g8rxUk/E"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773959920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JywgW+Bpg1U98MnA0QdtCAk6qQQ73Jm97agrnPkzDZM=;
	b=g8rxUk/EQIQWV/5NMeurssMeyS8PBsX1B9p8zVadAwEd7XXoIG+fOtNecsqNoylhUOWJRv
	1+pMOwUN5QZ78Xtheb0MrawrkNhCkGg+/cPEzmU/YpiSv613q0DwbWSVn17KXWUBQe5KuP
	MNyEc6MmgJ7aLy+jWpWWAXg0XjP+0L8LqF8b81Y4lDAZUo0aCeEGGqLD1GuIaYo5K/OWzj
	JXlB6b5VplF8We6dGbX3G3yZr1SUwE/i72qQ9Yg9ll4pdi8OcxMSDUj8+2HBrPSAn0JeTm
	HHwSGjHQm73k9NgCHC4xp80WwrnUEc4mtKwcbXAyQuwkRN5D51lX7p++H7R2PQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 5/8] format.commitListFormat: strip meaning from empty
Date: Thu, 19 Mar 2026 23:38:15 +0100
Message-ID: <3cb0a0a088f3ca7d4a1d8f97e428cb94b0901968.1773959395.git.mroik@delayed.space>
In-Reply-To: <cover.1773959395.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space> <cover.1773959395.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

The configuration variable format.commitListFormat allows for an empty
value. This is unusual and can create issues when interacting with this
configuration variable through the cli interface.

Strip meaning to format.commitListFormat with an empty value.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c           | 11 +----------
 t/t4014-format-patch.sh | 11 -----------
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a7f129d583..47126f9064 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1055,17 +1055,8 @@ static int git_format_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "format.commitlistformat")) {
-		struct strbuf tmp = STRBUF_INIT;
-		strbuf_init(&tmp, 0);
-		if (value)
-			strbuf_addstr(&tmp, value);
-		else
-			strbuf_addstr(&tmp, "log:[%(count)/%(total)] %s");
-
 		FREE_AND_NULL(cfg->fmt_cover_letter_commit_list);
-		git_config_string(&cfg->fmt_cover_letter_commit_list, var, tmp.buf);
-		strbuf_release(&tmp);
-		return 0;
+		return git_config_string(&cfg->fmt_cover_letter_commit_list, var, value);
 	}
 	if (!strcmp(var, "format.outputdirectory")) {
 		FREE_AND_NULL(cfg->config_output_directory);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index d2a775f78d..ca37f40a6a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -451,17 +451,6 @@ test_expect_success 'cover letter config with count and author' '
 	test_line_count = 2 result
 '
 
-test_expect_success 'cover letter config commitlistformat set but no format' '
-	test_when_finished "rm -rf patches result" &&
-	test_when_finished "git config unset format.coverletter" &&
-	test_when_finished "git config unset format.commitlistformat" &&
-	git config set format.coverletter true &&
-	printf "\tcommitlistformat" >> .git/config &&
-	git format-patch -o patches HEAD~2 &&
-	grep -E "^[[[:digit:]]+/[[:digit:]]+] .*" patches/0000-cover-letter.patch >result &&
-	test_line_count = 2 result
-'
-
 test_expect_success 'cover letter config commitlistformat set to shortlog' '
 	test_when_finished "rm -rf patches result" &&
 	test_when_finished "git config unset format.coverletter" &&
-- 
2.53.0.1018.g2bb0e51243

