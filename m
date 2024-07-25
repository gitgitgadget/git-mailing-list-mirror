Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB41448FD
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 23:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949165; cv=none; b=pK7zp4dMlk3o/04jqInp/Kf0qqzYA7z629hNmzmlLl8rP1Uux+OgWgWB6DeiJ97vjAugVUV2isLtyb79OFntMQE/bJXmABgI8ivMVA39tMQDGDGiGc215OD6DV5fkdPBiQIL5A16tGEu7bDaCiBIlJuty5fAF52jLo6FDy3WMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949165; c=relaxed/simple;
	bh=PF96KFtZBt5ruDa+vUVLxbWFHf3Zn5RyVMvenjmKDoo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kYVORqKrpPVARai4HAoJ8KOXn3Yi9ueSITdIUa06vaBSBiFzE6X/U5Yyxpc6SDv0YvQVffidPlL7bFptz27sCeM0q4OmH4Q+sV61DR1svE7ebfgjYhqcCQANREFrY8xB0Q5uyC3wvJlSzhcAk/t577Bt4fWlViu+PUTas80XgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DiMls90c; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DiMls90c"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EB092882F;
	Thu, 25 Jul 2024 19:12:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=P
	F96KFtZBt5ruDa+vUVLxbWFHf3Zn5RyVMvenjmKDoo=; b=DiMls90cLi2WRrAar
	9xqgsh0XQQnrR7kdyPgJOP/JIj8rEIG3KXqzMWvd4Ia1gmYppKPnFj2u2feqibLk
	cJyjA3Emh3liv+4pfyGuVOw007amrHf0wlsjp2hqimZUO9VFfbkZMcdvGCyVunps
	S+gI4QhjIAJ4RfQTgPiEFLTBB8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 462672882E;
	Thu, 25 Jul 2024 19:12:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF0D42882D;
	Thu, 25 Jul 2024 19:12:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] mailmap: plug memory leak in read_mailmap_blob()
Date: Thu, 25 Jul 2024 16:12:41 -0700
Message-ID: <xmqqcyn112xi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 652AA892-4ADB-11EF-825C-34EEED2EC81B-77302942!pb-smtp1.pobox.com

When a named object to read mailmap from is not a blob, the code
correctly errors out, but it forgot to free the object data before
doing so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailmap.c          | 4 +++-
 t/t4203-mailmap.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index 2d0212f444..2acf97f307 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -201,8 +201,10 @@ static int read_mailmap_blob(struct string_list *map, const char *name)
 	buf = repo_read_object_file(the_repository, &oid, &type, &size);
 	if (!buf)
 		return error("unable to read mailmap object at %s", name);
-	if (type != OBJ_BLOB)
+	if (type != OBJ_BLOB) {
+		free(buf);
 		return error("mailmap is not a blob: %s", name);
+	}
 
 	read_mailmap_string(map, buf);
 
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 8a88dd7900..79e5f42760 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -5,6 +5,7 @@ test_description='.mailmap configurations'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commits and contacts file' '
-- 
2.46.0-rc2-67-g99767055c1

