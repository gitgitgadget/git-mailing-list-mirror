Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0930B500
	for <git@vger.kernel.org>; Wed, 31 Dec 2025 03:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767153025; cv=none; b=aqxgRRa0L9EGPuFNnil75kolv8A9sfEfPH3rPussmNVVJGBQujK+uB56yUtX5H/aIYCep4bXZW9Srp5RcE10B2PkEkEhcRvJwVVGExMH0ub2YEP4gOU8zws5OrljaWe5hnDf37P4R3WZQci1ex/Y6MdslmhvEPUuCYF1FCzmym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767153025; c=relaxed/simple;
	bh=Nv+NPFlnODNYRWTFjQLP8fGUIxe365qnn06dPD3WP8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LplqHDAU75UUdDrEghTSOoxOdEYHy97lUgFpQayWFrT1tHyZst5IrRBXBWF0ycJ8J+hAbzOqp+8PQlgnqwReQH3jxrA32TjQfPoBy0AZR5+9CwTauWJ2TWWoUn4YZ4lI036Hb2Vo5lNiiUpFpo/3Z7UItUQ/GZl3K2VcIKM+eao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=HQZp0KHj; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="HQZp0KHj"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D12F114C2D6;
	Wed, 31 Dec 2025 04:42:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1767152547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RTkcFOyzggKZQaVbDQaURf2z0eM7RxhOD6hm1GQUW9k=;
	b=HQZp0KHj6sqDAZnoYVffSpPOU6w2wA2xPg9JfJrwUWRSw3hS/hcw50CoYNHq9Jw2csixar
	fuyMNw8w2THTjJhkCZv4ShRDinFJ8vbzvT9NTBrFio7/qTaf23tIvn/SXLVXwEln7SAkCl
	drY+DxZGc6hAu5yscxBFshK80YzPxOEbpC7o8shyWASBYrS7ZjhVusnFMMsqoOE+smwIw+
	tGhJPAxrxM86NCt4JZ5ykb2xgfb0x5KnskL4o8QKNwoxOdnz4WqofKC/srPyT9UOhwXbuG
	8AW+F2176eAZoxhLsdJYiGy1nhR2S2hlpPUcR9kqzdL2o4onwXimxQ8XDiWgoQ==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id bbce8503;
	Wed, 31 Dec 2025 03:42:24 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Julien Moutinho <julm@sourcephile.fr>
Subject: [RFC PATCH] builtin/format-patch: print a warning for skipped merge commits?
Date: Wed, 31 Dec 2025 12:42:17 +0900
Message-ID: <20251231034217.2498648-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git format-patch historically silently ignores merge commits, because
a merge commit simply cannot be fully described by a simple patch.

This can be surprising for users, especially when coupled with newer
merge-heavy workflows such as encouraged by jj: trying to generate a
patch from a jj commit that was a git merge with "content" will not
generate anything, without any message.

This RFC patch illustrates how we could easily print a warning, but
perhaps the warning would only make sense if no other commit has been
formatted?
I don't think it hurts all that much to print all the time but I can see
it being annoying in some use-cases, so it'd likely deserve a config
knob if we inconditionally print that...
Also perhaps pretty-printing the merge commit a bit better like printing
the subject...

Please let me know what you think would make sense here and I'll send a
more proper patch (tests..)
Thanks!

Reported-by: Julien Moutinho <julm@sourcephile.fr>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 builtin/log.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index d4cf9c59c81a..b21274461cd3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2044,7 +2044,6 @@ int cmd_format_patch(int argc,
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
 	rev.diff = 1;
-	rev.max_parents = 1;
 	rev.diffopt.flags.recursive = 1;
 	rev.diffopt.no_free = 1;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
@@ -2274,6 +2273,11 @@ int cmd_format_patch(int argc,
 		die(_("revision walk setup failed"));
 	rev.boundary = 1;
 	while ((commit = get_revision(&rev)) != NULL) {
+		if (commit->parents->next) {
+			warning(_("skipped merge commit %s"),
+				oid_to_hex(&commit->object.oid));
+			continue;
+		}
 		if (commit->object.flags & BOUNDARY) {
 			boundary_count++;
 			origin = (boundary_count == 1) ? commit : NULL;
-- 
2.52.0

