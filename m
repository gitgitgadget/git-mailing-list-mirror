Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82E1BE852
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046398; cv=none; b=ubHWPfigAWK1Y8ZJFDLzjAI2PMtKuHPmeaVOnhL2ZSbmDBa2KgAJNZLiKongyXPwwMVugw/jmU6v0we2u+tqpO9oO3mTrSgqgKlAJigwDIYzKvKlJnMf5CuHkpGymutczHjt1U1pArKiWquy8oTNk6/PWx8CgzJsxgGp4KkGnKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046398; c=relaxed/simple;
	bh=983aj0m9Nd1cMEI8yG3tAFsNx/OO1ec9KQUeOaqTv1k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E9+h0AhtIEdSU/xJz26zYMBk7O8UZrPMND3iUbNquwjTUo6AOTmvTSQH/8fbBwccTqRZ7fHCD+fFowlBveDf/583s428I8LG1uYUSdRvv1lwMxYkOTXQmD4IFr0xgfnPmHXWAfL+jCWCnJ39155qKZrOj6K92oyO7kv8QHAr7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h2zzJp5R; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h2zzJp5R"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A0771316AA;
	Fri, 30 Aug 2024 15:33:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	83aj0m9Nd1cMEI8yG3tAFsNx/OO1ec9KQUeOaqTv1k=; b=h2zzJp5RZLJhwCsEI
	XFyTPZaAb97I0i0xUWPfJ2+Yxt/t5J9PzG4P01BKMxSDK9aV6F0ow7KoQNUnixOv
	wF9nhFb/z6iwB9II5YX9QoM72QRX9XMAlxxatpMCaMAuWg+cFMF196rl0A64Vm/Z
	TAGIHmhrMj0KqH2cHoJuev1JnY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 996A3316A9;
	Fri, 30 Aug 2024 15:33:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F795316A8;
	Fri, 30 Aug 2024 15:33:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] refs/files-backend: work around -Wunused-parameter
Date: Fri, 30 Aug 2024 12:33:13 -0700
Message-ID: <xmqqjzfxrekm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B38046CC-6706-11EF-92A5-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

This is needed to build things with -Werror=unused-parameter on a
platform without symbolic link support.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1cff65f6ae..4c5573b19c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1946,10 +1946,13 @@ static int commit_ref_update(struct files_ref_store *refs,
 	return 0;
 }
 
+#ifdef NO_SYMLINK_HEAD
+#define create_ref_symlink(a, b) (-1)
+#else
 static int create_ref_symlink(struct ref_lock *lock, const char *target)
 {
 	int ret = -1;
-#ifndef NO_SYMLINK_HEAD
+
 	char *ref_path = get_locked_file_path(&lock->lk);
 	unlink(ref_path);
 	ret = symlink(target, ref_path);
@@ -1957,9 +1960,9 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
 
 	if (ret)
 		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
-#endif
 	return ret;
 }
+#endif
 
 static int create_symref_lock(struct ref_lock *lock, const char *target,
 			      struct strbuf *err)
-- 
2.46.0-592-gd813a5bb5c

