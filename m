Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B42360
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721003748; cv=none; b=H2zRm1zYaCCv+ZBVrEdmFYCEgb1jtBpdYyAsvd81XbuJ3HNKlnH5ydGfikiVJ9gy7LzU/m0S60mwWF8V2ND/YxMzs/hggTIYepGfb6Vp9KzjK4vdUawFj9/wP9VmFBdLsU15NiMSjYKCUpDL9IsEQ0YXxtFqMuxpeHykUARXzVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721003748; c=relaxed/simple;
	bh=78C0BLyFrigKYnHJcc6TtTsjlkmLDcEhL0fk29JbaTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfdqUqQKQ6BX4HFdLS2WfsdD7EevOOMpoLTMws8AF3CKcpp4dDaxN2RwwuMOG8OkB1oQHXrYkhn6f2Tib41T+iDt7fzsHuhQWHX5T6aFPHsydndra0vI3jkzJ7Abh4JoVarW9RtMyKzxasnSYOajF7nDkwcFy2OlyXBy4eKW3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=xDY1IFxm; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="xDY1IFxm"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B54F1F5B1;
	Mon, 15 Jul 2024 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721003720;
	bh=78C0BLyFrigKYnHJcc6TtTsjlkmLDcEhL0fk29JbaTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xDY1IFxmyqyS7lDQboeyAefNBG4JClpy5i71Jyt44cQdUTLhpqlbMAU3+1Jonv1OR
	 2/57JIIMy8MyEUojDm5+0DaUBzYDU2fTmAEOfa7DdXRPpU02hrMdAa5tYMiFpQxW6u
	 TKS/biay4WrCQ0xgg/ez/c3ScNkD0MCzfhcrD0cY=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v1 03/10] packfile: fix off-by-one in content_limit comparison
Date: Mon, 15 Jul 2024 00:35:12 +0000
Message-ID: <20240715003519.2671385-4-e@80x24.org>
In-Reply-To: <20240715003519.2671385-1-e@80x24.org>
References: <20240715003519.2671385-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

object-file.c::loose_object_info() accepts objects matching
content_limit exactly, so it follows packfile handling allows
slurping objects which match loose object handling and slurp
objects with size matching the content_limit exactly.

Signed-off-by: Eric Wong <e@80x24.org>
---
 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 54b9d46928..371da96cdb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1558,7 +1558,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		}
 
 		if (oi->contentp) {
-			if (oi->sizep && *oi->sizep < oi->content_limit) {
+			if (oi->sizep && *oi->sizep <= oi->content_limit) {
 				*oi->contentp = cache_or_unpack_entry(r, p, obj_offset,
 								      oi->sizep, &type);
 				if (!*oi->contentp)
