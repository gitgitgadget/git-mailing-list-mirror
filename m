Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382222B5B8
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720626; cv=none; b=OjvZOJXcsQyih3o5eHb3GmzfDFT9Bv64pWVQXVgxOD8xPf22MdzislCU6BujHoki6cIS5qRbtXWjBsgkr21kDbTo1PO5uAlRPH8lfw3Tb/jhrHh88QxZs/6419CbwbG60ZWwYZ8e+mR6Ab3gJdvSla7301zJxdar+mvzPE59d6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720626; c=relaxed/simple;
	bh=g/2+r3bbncJGKOFiKtw7DorsJdO54rspYHdw9OpOy1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wtxg16bwG22ILfOb88ILPzMhhGYYVMj/TghKtdycxTZMQ4vBht70OvB2Lfs1DOTaYEALV3tUDJy/1+7dgU+mKZVv/h3NBxEIJDUCG8ZtWo9CNQ7ecizxWjmpMBV1KMPOXd9jIgk7O/Y0To/H0JpExBulrJAauWZvZ08gqlmrGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Af+4/Goa; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Af+4/Goa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750720625; x=1782256625;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=g/2+r3bbncJGKOFiKtw7DorsJdO54rspYHdw9OpOy1Q=;
  b=Af+4/GoaUbaFZksNQBreVxqMqUGdl/s6G+PS9M8l0GorwXczj5MIquJ9
   DJdFuEr1Eeze5yWRpjWscv1/d0bpl624GfB6uejORth8jn6wm6JCLal6J
   YyY2Y6ck/p3oVPvsUSoQCpxT7B1s0yn0FPA3PXHbx4TwQVcLJHszjDvOb
   pOv4H6g2a+eSp+INtT3t2wT0uv2JYwjSK2zzSbjddZQ88rbZayq5FFgNm
   pYDgMbmClvMPrW46Lz3B8WZwLYjXmpBYf8yum7sO12h8UtL3rN8erLGcD
   cq4DjRN9gwji2efzt6JzK3xLLT7MX3dMjC8GmjhILoEWPRCDsGX0X8E19
   A==;
X-CSE-ConnectionGUID: mmRtKNg5S/69h9QRL5hNIg==
X-CSE-MsgGUID: iv/EiWJ+TY65Pj9lr6icrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53084558"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="53084558"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:42 -0700
X-CSE-ConnectionGUID: hWqmXs59TDacri0oU2ezhw==
X-CSE-MsgGUID: b0qdE1WoQVuoMQd8c2z7QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="151888465"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:16:41 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Jun 2025 16:11:30 -0700
Subject: [PATCH v4 2/7] remote: fix tear down of struct remote
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-jk-submodule-helper-use-url-v4-2-133ef3d89569@gmail.com>
References: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
In-Reply-To: <20250623-jk-submodule-helper-use-url-v4-0-133ef3d89569@gmail.com>
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Lidong Yan <yldhome2d2@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>
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
index ee95126f3f20080a932b82314e8017e277569cc1..194bb447784ac1f71fb85a9fed3312e7458a9d5d 100644
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

