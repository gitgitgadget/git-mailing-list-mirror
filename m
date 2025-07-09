Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87FE218ADD
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097797; cv=none; b=tcBeBn+XdEd+A2U35faAhRSOytj9WuaVd6SH8IeosrGWzqwb9tAlRurik5WPnf9WF/8MT3T9LcfeEJeeQrTNHVprip9vnqAtWKkX/al6yIdEbNilzWQHFvWy15v0Wg5FbP6cax6LM66QMRfEeEH5WXGzGyqYYI9IT2rGW0f94jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097797; c=relaxed/simple;
	bh=WSoIMPwDAlv9PhJN+C5Gn6wIAe80tjEHy/8I593XyDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mBaexmwh+qE+XYBrbpLwP4j9xRyf3qWwjrW/nr11R4DvgTfisBg+BjGrgObvHDw1sBu0vVvIqyEGaeUwEyUXq+r0S8JjicwD7kPpItoStoro9AxNK8Rv6TShkYP7tbUgIGOx809MgAfHSC5CIQKDUxKQmJCsKtNW0n5RLuJ7pa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frS87eu4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frS87eu4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752097796; x=1783633796;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=WSoIMPwDAlv9PhJN+C5Gn6wIAe80tjEHy/8I593XyDg=;
  b=frS87eu4HQAEsky6l9245m2H/BfeRZKUSbDy864aYwfjQB5cXSkscJ2G
   PkdKXb4pN1ScdbUik/lENqK1c7dNhtCjbrvm/k3YTT21wTlCDuFiYqdom
   E6EdJNWZgWorsNm6oUPvCAkuJQKmccw0JkcWab0EnH7SYprRa9GNw+s01
   knarVZv+80t88ILHTwmJw+WUbEf5jTJYwTSSWqJk+G7J/CZ/KoXCv/Ck2
   mbZLMWs7Ubq0h69TwJM8Mfw8VS1YLKJZ+nFqzyCkP+cZd8lq0V6F0vXpb
   0Q7CKTXx0izdylYQQNZtHaf6rQ7NhLdlItB9QcVmDcVyUhDY1oljGrjVp
   w==;
X-CSE-ConnectionGUID: BdkIZiAPREmYEAEj5kKNUg==
X-CSE-MsgGUID: 9iVAD4LtSaaE8UWfwzzfCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="65068673"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="65068673"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 14:49:55 -0700
X-CSE-ConnectionGUID: Zv4HzeAeRj++u6Dc/fM5PA==
X-CSE-MsgGUID: p+alHSOUSMaUAo8o+rfvZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="155531086"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 14:49:55 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 09 Jul 2025 14:49:14 -0700
Subject: [PATCH] reflog: close leak of reflog expire entry
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-jk-fix-leak-reflog-expire-config-v1-1-34d5461cf8f5@gmail.com>
X-B4-Tracking: v=1; b=H4sIANrjbmgC/x2NQQqAIBAAvxJ7bsGEtPpKdBBbbSs0FEKI/p50H
 BhmHsiUmDJMzQOJbs4cQ4WubcBuJnhCXiuDFLIXWoy4H+i44EnmwETujB6pXJwIbQyOPepOWqN
 Wq4beQM1c1eLyL+blfT9un9IzcgAAAA==
X-Change-ID: 20250709-jk-fix-leak-reflog-expire-config-712ca6dc685a
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Jacob Keller <jacob.keller@gmail.com>
X-Mailer: b4 0.15-dev-2503c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995;
 i=jacob.keller@gmail.com; h=from:subject:message-id;
 bh=9qoHWgA9HaP2e9U5YZ1FMsh/n/7I0dITK0myWGueQKM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoy8x9+Onr2/OKrmYVLA5E/vY+8ueX8nzDj0T5Znm/bjB
 7s0Ps9d1lHKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBERLcwMmydXeY2sVV8yuSa
 OZ/P1ppOKs7+zt74Nsk9p1mgXDWTo4uR4cauZ4buji8b0hZ6dQcv+nv+bL1x2b6wWT0hzPdE/x2
 P4gUA
X-Developer-Key: i=jacob.keller@gmail.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jacob Keller <jacob.keller@gmail.com>

find_cfg_ent() allocates a struct reflog_expire_entry_option via
FLEX_ALLOC_MEM and returns its pointer to reflog_expire_config(). The
function exits without freeing the memory:

Direct leak of 39 byte(s) in 1 object(s) allocated from:
    #0 0x7ff975ee6883 in calloc (/lib64/libasan.so.8+0xe6883)
    #1 0x0000010edada in xcalloc ../wrapper.c:154
    #2 0x000000df0898 in find_cfg_ent ../reflog.c:28
    #3 0x000000df0898 in reflog_expire_config ../reflog.c:70
    #4 0x00000095c451 in configset_iter ../config.c:2116
    #5 0x0000006d29e7 in git_config ../config.h:724
    #6 0x0000006d29e7 in cmd_reflog_expire ../builtin/reflog.c:205
    #7 0x0000006d504c in cmd_reflog ../builtin/reflog.c:419
    #8 0x0000007e4054 in run_builtin ../git.c:480
    #9 0x0000007e4054 in handle_builtin ../git.c:746
    #10 0x0000007e8a35 in run_argv ../git.c:813
    #11 0x0000007e8a35 in cmd_main ../git.c:953
    #12 0x000000441e8f in main ../common-main.c:9
    #13 0x7ff9754115f4 in __libc_start_call_main (/lib64/libc.so.6+0x35f4)
    #14 0x7ff9754116a7 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x36a7)
    #15 0x000000444184 in _start (/home/jekeller/libexec/git-core/git+0x444184)

Close this leak by freeing the entry pointer on exit of the
reflog_expire_config() function. This frees both the entry structure and
its embedded pattern array thanks to the use of FLEX_ALLOC_MEM.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 reflog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/reflog.c b/reflog.c
index 15d81ebea978..43647eaf89eb 100644
--- a/reflog.c
+++ b/reflog.c
@@ -78,6 +78,9 @@ int reflog_expire_config(const char *var, const char *value,
 		ent->expire_unreachable = expire;
 		break;
 	}
+
+	free(ent);
+
 	return 0;
 }
 

---
base-commit: a30f80fde927d70950b3b4d1820813480968fb0d
change-id: 20250709-jk-fix-leak-reflog-expire-config-712ca6dc685a

Best regards,
--  
Jacob Keller <jacob.keller@gmail.com>

