Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B151A5BA4
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141193; cv=none; b=PFsjMzcbzEksLsRAnWP+lCqgHnvIfgIP/UcPgfju30lu5VsD+KbhvcdGYbjdROBgOsI9H14N1AZHm1ibpJJpVlsyw+1nh25Bt02B0KrkOFBmGS7mBuksakOAt2+mWzF4fdkGLmtreig2lfLS+S1hpxiZqI2TtT/+kC1xykVk6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141193; c=relaxed/simple;
	bh=Y3IFRFyfAK9GWjac9+XHmwkWGn2EgLExyLBM0eqqyjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r9x6HsaT7mKeCr3NESD2pXE9wh6XS0NSD9qoxnngiuS6O3jbWJwVpNCfrvt7ABSgnNmTWBGqXUhwj4i1QPcX2BUmSggxhM16mNMD7PW5Hv4/fYJX2VyYBiipjd5k5cACqW36WpmfCyXwyTu4n1QNfTuIwBJPS2zjZ338HTZKQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adGk3LmT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adGk3LmT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753141191; x=1784677191;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Y3IFRFyfAK9GWjac9+XHmwkWGn2EgLExyLBM0eqqyjg=;
  b=adGk3LmTCkAsP7V2lujGgRlZJGtRYmgQ7w/t2LBmAl3LELshiT6Vpv7C
   RQNhSEdNJ4sOI+uNRWvzmsVwtGMFe9hJQklFbfV8Bv6B/K6LOzJDeCfRR
   nTWdohjJSuNDvaF3ZjsWfeqHwn/6Y38GjCVg4L4feI4NKMimZxsq7bPZj
   Gd80vinDWdGoPl+RjdwmTOS/9U482nEhVwrL5JOyooqmnV0ucj+9KRyXA
   lDCL2pCqOsAuiy7Cdra8gOgkuOniQYBY7eCxOzT/8ORwyBulvgXeoPj5k
   NBNck0jTPdU1Xk0KTA7Hj1Fj4TZtd3WoJceRrveDkVtZf4id5T4PBLP27
   g==;
X-CSE-ConnectionGUID: cyEB0SYPTgGh6TYKCUIEpQ==
X-CSE-MsgGUID: LKaZvhzLSMyuu8hCasOAmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="80818568"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="80818568"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:39:50 -0700
X-CSE-ConnectionGUID: EDnN+b8QS/KynFS+k3EOYg==
X-CSE-MsgGUID: 4+xIT6p+R2+BQnYjtHbzEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="182689936"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:39:51 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 21 Jul 2025 16:39:37 -0700
Subject: [PATCH v3] reflog: close leak of reflog expire entry
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com>
X-B4-Tracking: v=1; b=H4sIALnPfmgC/5XNyw6CMBCF4VchXTuGFsrFle9hXNQyhZFLSWsaD
 OHdLazcsvwnk++szKMj9OyWrMxhIE92ipFdEqY7NbUI1MRmIhUyLdMa3j0YWmBA1YNDM9gWcJn
 JIWg7GWqh5EKrotFFJRWLzBy/aDkmHs/YHfmPdd9jMfD9egIPHDhkeSPzgmtTGXlvR0XDVduR7
 XgQZ0ERQVMrU2f5CyvN/8Ft23428xj8IQEAAA==
X-Change-ID: 20250709-jk-fix-leak-reflog-expire-config-712ca6dc685a
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Jacob Keller <jacob.keller@gmail.com>
X-Mailer: b4 0.15-dev-d4ca8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4185;
 i=jacob.keller@gmail.com; h=from:subject:message-id;
 bh=0eTDxe0Jry8ImMePeuYqbfpDtTRj/eorb8/7PP4Wa+Q=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoy688eWx25en8pypvbOhK6HvreehiQapC+ym3CywbTlu
 LRnq/63jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACaip8Dwv2Zvq4lem8fpRbFq
 1445Zvz8tW2eV9YmtzsPrreWTWiXusbw3ynkJVfFoRcKvFbaulIqz5tnvXVV37T9bcRMm72Hf1e
 yMAIA
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
cmd_reflog_expire() and reflog_expire_condition().

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Changes in v3:
- Remove the incorrect call in reflog_expiry_cleanup()
- Add a call in reflog_expire_condition()
- Link to v2: https://lore.kernel.org/r/20250709-jk-fix-leak-reflog-expire-config-v2-1-f9af934be8c1@gmail.com

Changes in v2:
- Actually fix the leak properly. (Thanks Jeff for catching my brain fart!)
- Link to v1: https://lore.kernel.org/r/20250709-jk-fix-leak-reflog-expire-config-v1-1-34d5461cf8f5@gmail.com
---
 reflog.h         |  2 ++
 builtin/gc.c     |  1 +
 builtin/reflog.c |  3 +++
 reflog.c         | 14 ++++++++++++++
 4 files changed, 20 insertions(+)

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
diff --git a/builtin/gc.c b/builtin/gc.c
index 845876ff0286..37f543736599 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -346,6 +346,7 @@ static int reflog_expire_condition(struct gc_config *cfg UNUSED)
 				 count_reflog_entries, &data);
 
 	reflog_expiry_cleanup(&data.policy);
+	reflog_clear_expire_config(&data.policy);
 	return data.count >= data.limit;
 }
 
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
index 15d81ebea978..e2a2f3ad3e30 100644
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

---
base-commit: a30f80fde927d70950b3b4d1820813480968fb0d
change-id: 20250709-jk-fix-leak-reflog-expire-config-712ca6dc685a

Best regards,
--  
Jacob Keller <jacob.keller@gmail.com>

