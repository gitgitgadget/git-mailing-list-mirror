Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE971E515
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772899; cv=none; b=hB8G+Glu3Jl/2EmOpEfdfg9FAHNoLXORgTibCJq/kpYrXIGZ45DDEWe8l7V5S7o6HnKwSrKw6UxSqDWlwO71PzMSdOwkj5gdhcyNN65cHEWzgA3RJKAMtgHwgi+3+FXJ7iT3FNjKe6VsKrKr8MzwwGBX93np5hSlEaH5y4aiFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772899; c=relaxed/simple;
	bh=mjFCK7zjqcMCQRoSz0CHhUdP2+D7HJ+WMGt9dQIOj5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkgECA3WhnfnPtGuw1sSRJ+7Dao0h4OOZIivLVGJbsLVhYaPvn/lMz5Hq7hqx5+KhCqIvgHWeDKEGi0hm4OuCCB8gcvOcM7bItUO73JAeaHnFFQuIH3gv9zJ3TVurfGqYmRtD//rbz3kaajdLhix0/ZVtRVpF6HHNVtcsyv44nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=snPUl1Wu; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="snPUl1Wu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cSIt3MlXa9vN3RYgnr6WtD14J3bEFqfZmyroDS5bYBg=;
  b=snPUl1WuOxM7HuW7Q2rcHJZDLTqXCEp2YqtQGEdloqiuW2twRba/lmIt
   xr6Avxkzk/zFTEaoYO4ozlJ8/m4IWvTbDVF9WlCwT966dJ57FEEKeoArQ
   ilxHVMS213RjHIF6d0Zvwtd3oZJFWrPkffO/ALaWx4lasoNzhQtQhbLjU
   Y=;
X-CSE-ConnectionGUID: ukkF80AjQta+Kj5n8lbhWg==
X-CSE-MsgGUID: ocKpvbpKSkOoUmIBY9qzhA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=gabriel.scherer@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.18,261,1751234400"; 
   d="scan'208";a="238904510"
Received: from 88-126-14-38.subs.proxad.net (HELO localhost) ([88.126.14.38])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 16:13:43 +0200
From: Gabriel Scherer <gabriel.scherer@inria.fr>
To: git@vger.kernel.org
Cc: Gabriel Scherer <gabriel.scherer@inria.fr>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/3] rebase: hint when failing on branch used by another worktree
Date: Sat, 13 Sep 2025 16:13:20 +0200
Message-ID: <20250913141327.2775228-4-gabriel.scherer@inria.fr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Gabriel.Scherer" <gabriel.scherer@inria.fr>

Signed-off-by: Gabriel Scherer <gabriel.scherer@inria.fr>
---
 builtin/rebase.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7a57ebd852..05c86117fc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -9,6 +9,7 @@
 
 #include "builtin.h"
 
+#include "advice.h"
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
@@ -1687,8 +1688,15 @@ int cmd_rebase(int argc,
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/heads/%s", branch_name);
 		if (!refs_read_ref(get_main_ref_store(the_repository), buf.buf, &branch_oid)) {
-			if (!options.ignore_other_worktrees)
-				die_if_checked_out(buf.buf, 1);
+			if (!options.ignore_other_worktrees) {
+				int code = die_message_if_checked_out(buf.buf, 1);
+				if (code) {
+					advise_if_enabled(
+						ADVICE_BRANCH_USED_IN_OTHER_WORKTREE,
+						_("Use --ignore-other-worktrees to proceed anyway."));
+					exit(code);
+				}
+			}
 			options.head_name = xstrdup(buf.buf);
 			options.orig_head =
 				lookup_commit_object(the_repository,
-- 
2.51.0

