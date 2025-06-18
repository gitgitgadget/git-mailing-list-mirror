Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6827F4D4
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750288116; cv=none; b=njvHKwYedKAcihDTEeQTblaiRtE+PHJLZU1t0jzrwxYi/BNw0kodL5xzZMGQ9PmAGQrNoYeKYsI6uFW7mYBiJRHavxcnx3cvvR1AkZKjoKLN7caagRGSqErJ0xApu7o0/gCV/06CaG3n7E/FvTb+Pewm+sGuhZPA7SN7r3kDrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750288116; c=relaxed/simple;
	bh=LYeNkCx7fb/fINeUOPhuAr/uBnEnxnZ+WYxtRDU/VX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4yf4yn+JH7ybLyQZVbrxKSLn/W013nDAOqEgZpzxdoviRGx9/4spz9HAOIm9geCd8fjdMzjWdhACqX3lWbCTw2NsrCFWLnbPNb4a4KiczImqg9O+TwiVk+ZQzdaATeSdMKO5NwORSV6pEdJWCKfUkll8tfk4BBiX9Y1jzEev1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wvj2cY5U; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wvj2cY5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750288114; x=1781824114;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LYeNkCx7fb/fINeUOPhuAr/uBnEnxnZ+WYxtRDU/VX8=;
  b=Wvj2cY5Usil3CIjvzfSsNzOPvErfGBqWNvYcTUfbZTyMV38lx+OmaqJV
   XSvJ+xbvn56G60Fs5mjuCbaUXvAggG8ZGIOWaGr8Xp/M4xhNR7kltZP/r
   mT2gYijTxYk9HJZcpeSDwDOtEQulr21uCtE3+z48SLY/HOKgB2gEakEgP
   GN8DNkcMYxFB3RmMlxAC5LCCeQEMurUsgyErm2c4OSKx1M5/k3kTteZ0C
   9Ky4+tlrDmZoC9ZvHZvYS99geaSriJHyR/YDLXRMzkq96AX21Cb5zugA0
   8zNkeofbFsrXvLAfaGAitTb7FVHFRBkGXnTpkLhc0wZBsFarljT4cexyN
   g==;
X-CSE-ConnectionGUID: +LMGy8a6QxqtEqXuC6cOkg==
X-CSE-MsgGUID: RVzjllqdQ3u8NSirHmFojA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="69966808"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="69966808"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:31 -0700
X-CSE-ConnectionGUID: NLbMY5UPQ7yD9u3qG2hS9g==
X-CSE-MsgGUID: Gp7mqdotRUafgI4q40k3pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="156048562"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 16:08:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Jun 2025 16:08:16 -0700
Subject: [PATCH v3 2/7] remote: fix tear down of struct remote
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-jk-submodule-helper-use-url-v3-2-7c60f2679271@gmail.com>
References: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
In-Reply-To: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

From: Jacob Keller <jacob.keller@gmail.com>

The remote_clear() function failed to free the remote->push and
remote->fetch refspec fields.

This should be caught by the leak sanitizer. However, for callers which
use ``the_repository``, the values never go out of scope and the
sanitizer doesn't complain.

A future change is going to add a caller of read_config() for a
submodule repository structure, which would result in the leak sanitizer
complaining.

Fix remote_clear(), updating it to properly call refspec_clear() for
both the push and fetch members.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 remote.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/remote.c b/remote.c
index dff76e4626cc4eea54a28a63acc43aea2115cf56..e6f0721060a1ad6b119e5e45545c8c6ca94658af 100644
--- a/remote.c
+++ b/remote.c
@@ -165,6 +165,9 @@ static void remote_clear(struct remote *remote)
 	strvec_clear(&remote->url);
 	strvec_clear(&remote->pushurl);
 
+	refspec_clear(&remote->push);
+	refspec_clear(&remote->fetch);
+
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
 	FREE_AND_NULL(remote->http_proxy);

-- 
2.48.1.397.gec9d649cc640

