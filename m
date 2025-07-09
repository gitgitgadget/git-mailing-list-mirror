Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145358633F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752104523; cv=none; b=pBDGGjmwHAc6PAQMXKdXP6WjuXjU173nghpM/gLZhqtrFP/w4QRUSEj/1ReFFqMD/CdefEWEkEXNGn2E6o67tni6ZWp+m4BnsRTu9Fh822trFIBAcmjpVo+BSrAOTB/u5OLRuvxD3ysWV16GRlr9Ewar5Z4uknsCeUrKDDE1H04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752104523; c=relaxed/simple;
	bh=6tLFDD31eQLBuYVRVUq3VrdKPq0j2DWWjFqHmn3ih6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FI2dwlzUpfcIlImAIh71rpRgjT4Ves8ESqxUEPJ/46HYWVfs+lVij77Oy4twujVWS9B+tv7W7Tq/vNTJrE5TAYqv5GGvfyqcp/cXudvfiqUl4/eCs4lQMPeC252IXkRmNbW/ImXlGA1b3YJfnPmDHqI2XydmeiQnj8VmHj8EWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4UHJDqs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4UHJDqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752104522; x=1783640522;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=6tLFDD31eQLBuYVRVUq3VrdKPq0j2DWWjFqHmn3ih6k=;
  b=D4UHJDqsh+i5Z+adazQnJwAxOcJ7vbWN4JAVnyUTJfu1YRj2Qq7898Xx
   qP3DUsy7DkpZX4PDYzXHc9LgTShFOpseDyet3TV9aSbk1G9+byjttI6o6
   lTZcS8LCp7jr6eCr/Bcbi3bMhE0Yy7vvcyaDIJdao7wqunfZVwCs6L9Hh
   Ka9Hoh7P01XfgzuHLX2ZCRGVBPvg1NuD/7wjAYqMZw8insVlOjlY7K8zk
   D19TcZNTl55W5BwpIQflaCsUH2qZt/IVXY3KSf3wDhNCAhJWJTLrsFC4t
   BLw2r1vmRZRNVUHwxVd3VYnYGclOnzPtGT0mUy+zrwG9cY7FGDrquIBdW
   A==;
X-CSE-ConnectionGUID: PPHPIhpdRjaIMI/CR13tfw==
X-CSE-MsgGUID: PisNKzUjRHuoCc2Com3LzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="58182384"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="58182384"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 16:42:01 -0700
X-CSE-ConnectionGUID: LouwFZu5REW0Q53P8zZ1cg==
X-CSE-MsgGUID: SVedL1QJTL2xOMARPa948Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="160186948"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 16:42:01 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 09 Jul 2025 16:41:17 -0700
Subject: [PATCH v2] reflog: close leak of reflog expire entry
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-jk-fix-leak-reflog-expire-config-v2-1-f9af934be8c1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB3+bmgC/5WNTQ6CMBBGr0Jm7RhaKSAr72FYNGVaRn5KWkMwh
 LtbuYHL9+XLeztECkwRmmyHQCtH9nMCecnA9Hp2hNwlBplLlVf5HV8DWt5wJD1gIDt6h7QtHAi
 Nny07rIQ0uuxMWSsNSbOkF29n4tkm7jm+fficxVX81j/kq0CBt6JTRSmMra16uEnzeDV+gvY4j
 i/Jgwhy0AAAAA==
X-Change-ID: 20250709-jk-fix-leak-reflog-expire-config-712ca6dc685a
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Jacob Keller <jacob.keller@gmail.com>
X-Mailer: b4 0.15-dev-d4ca8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3860;
 i=jacob.keller@gmail.com; h=from:subject:message-id;
 bh=l+BRe94q8RRzLvaC6tTOjO3EvQJIu3Mn2cVMNSlOso0=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoy8f85lC7+my61/w9YlvfDhiQldd4z/qgmXfUxotm6e2
 2ZnmFzWUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwESupDH8d/kbFN0Rwnaiy8Tm
 33uJvmkP1OQ3tX3f8+5r0dEgJ4VMS0aGryIByyKy1pqvivjqu0PF68x7a17p5RWHpY7dqvn6o7q
 HBQA=
X-Developer-Key: i=jacob.keller@gmail.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jacob Keller <jacob.keller@gmail.com>

find_cfg_ent() allocates a struct reflog_expire_entry_option via
FLEX_ALLOC_MEM and inserts it into a linked list in the
reflog_expire_options structure. The entries in this list are never
freed, resulting in a leak in cmd_reflog_expire and the gc reflog expire
maintenance task:

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

Close this leak by adding a reflog_clear_expire_config() function which
iterates the linked list and frees its elements. Call it upon exit of
cmd_reflog_expire() and in reflog_expiry_cleanup().

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Changes in v2:
- Actually fix the leak properly. (Thanks Jeff for catching my brain fart!)
- Link to v1: https://lore.kernel.org/r/20250709-jk-fix-leak-reflog-expire-config-v1-1-34d5461cf8f5@gmail.com
---
 reflog.h         |  2 ++
 builtin/reflog.c |  3 +++
 reflog.c         | 15 +++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/reflog.h b/reflog.h
index 63bb56280f4e..74b3f3c4f0ac 100644
--- a/reflog.h
+++ b/reflog.h
@@ -34,6 +34,8 @@ struct reflog_expire_options {
 int reflog_expire_config(const char *var, const char *value,
 			 const struct config_context *ctx, void *cb);
 
+void reflog_clear_expire_config(struct reflog_expire_options *opts);
+
 /*
  * Adapt the options so that they apply to the given refname. This applies any
  * per-reference reflog expiry configuration that may exist to the options.
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3acaf3e32c27..d4da41aaea73 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -283,6 +283,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 					     &cb);
 		free(ref);
 	}
+
+	reflog_clear_expire_config(&opts);
+
 	return status;
 }
 
diff --git a/reflog.c b/reflog.c
index 15d81ebea978..3ce1780924dd 100644
--- a/reflog.c
+++ b/reflog.c
@@ -81,6 +81,20 @@ int reflog_expire_config(const char *var, const char *value,
 	return 0;
 }
 
+void reflog_clear_expire_config(struct reflog_expire_options *opts)
+{
+	struct reflog_expire_entry_option *ent = opts->entries, *tmp;
+
+	while (ent) {
+		tmp = ent;
+		ent = ent->next;
+		free(tmp);
+	}
+
+	opts->entries = NULL;
+	opts->entries_tail = NULL;
+}
+
 void reflog_expire_options_set_refname(struct reflog_expire_options *cb,
 				       const char *ref)
 {
@@ -490,6 +504,7 @@ void reflog_expiry_cleanup(void *cb_data)
 	for (elem = cb->mark_list; elem; elem = elem->next)
 		clear_commit_marks(elem->item, REACHABLE);
 	free_commit_list(cb->mark_list);
+	reflog_clear_expire_config(&cb->opts);
 }
 
 int count_reflog_ent(struct object_id *ooid UNUSED,

---
base-commit: a30f80fde927d70950b3b4d1820813480968fb0d
change-id: 20250709-jk-fix-leak-reflog-expire-config-712ca6dc685a

Best regards,
--  
Jacob Keller <jacob.keller@gmail.com>

