Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93145289809
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226595; cv=none; b=a8iwLrmmyehAV03rUzptN6KuQA7MP1k6cODkwcWkKvHMdOR6y/UFYSfGqLA3sKbxOsTiuNldMa9XY4Nid7uk/JFHmByYakiwkNhw0+SJ0jbYvQ5qRH7o8PAfsj0mVeej2BGbJlr+uaGF+b2wWFYHrtOSL8WDmhit3O/0IWVVvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226595; c=relaxed/simple;
	bh=uIAbaVxTBXKZzFVDw79ChdJhAfC9yyhXAdH1101d8LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g3qHg7V4JERIukdAtwFI/CwjBBLgsn9sbSLt2G8R4Gd8wvOdAtjbL2h1AsKh0pV6xVxPNbqo1bcKa5uweo3b3g3RO89jNwl8UnwICIwlWJTr+e0F88Ugoajgad+ZAf2oenj28//URI5SusJ5G5pXr2JMpmqCkpEwpY3bFimjvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUxYbF3/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUxYbF3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753226593; x=1784762593;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=uIAbaVxTBXKZzFVDw79ChdJhAfC9yyhXAdH1101d8LY=;
  b=TUxYbF3/lSseQY8rJsN6QJmg8ARbysgt/37I8eH9cp1IP1Fhe6Z7EvNI
   bxLau6nU0QwpoIZry59nPpkEHo78GP4rjzHhmM+7ygiFLnMTbzHmEm2oX
   3rY/PZUtCcrDVnJuI9AvEURqovG0xLyx8N9s8tls3GF2+Vg2noZ3rravQ
   gyhwW3y/GSPCgCyg7wKfNBX4Yjm5KIr0uLTtowwG6pQB+/VARIfthNV6v
   dRNTwGJU75eLF6PKA+NELEQlbm1AbWK9xr1q+b83XqA9mAY+rN3lFtpAY
   hxCsOFRYY6PtjJG99tLXOITGUKoMqN6+ieF8SAuEyY+Rh4qVRPFhb2nEt
   w==;
X-CSE-ConnectionGUID: Ilpf1QztQ0WjGrQl9+36xg==
X-CSE-MsgGUID: cnn3zotcQ0GroqaoAUrtkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55344113"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="55344113"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:23:12 -0700
X-CSE-ConnectionGUID: L/NEPow3QVy3lsEUzADboA==
X-CSE-MsgGUID: o/3tdctmTMegmQYBTjpOlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="160010534"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:23:11 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Jul 2025 16:18:26 -0700
Subject: [PATCH v4] reflog: close leak of reflog expire entry
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-jk-fix-leak-reflog-expire-config-v4-1-b65a83551020@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEIcgGgC/5XNQQ6CMBCF4auYrh3TlhaLK+9hXJQyxVGkphiCI
 dzdwoq4kuU/mXxvZB1Gwo6ddiOL2FNHoU2h9jvmbratEahKzSSXmh95AfcHeBqgQfuAiL4JNeD
 woojgQuuphqOQzuaVy422LDGv9EXDMnG5pr5R9w7xsyz2Yr5uwHsBAjJVaZUL543X5/ppqTm48
 GQz3sutoEygL6wvMlWiceIXzFagFH+AWQKdMqbk2uRo+BqcpukLvJAeUHIBAAA=
X-Change-ID: 20250709-jk-fix-leak-reflog-expire-config-712ca6dc685a
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15-dev-d4ca8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5964;
 i=jacob.keller@gmail.com; h=from:subject:message-id;
 bh=eIekEcHZGyPmaacWf12VynmYLrQqBdZQTVRYxSKKFcc=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowG2Wj5u+cXr59w51W+5NZ894k3dTd2dah/VPqUVqz/h
 TtAftnNjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACbCp8LwV/RD5XWO/Zb5k3h0
 oiUL9X7Fy+fdOx4Q8PL09YTPLAs6Ohn+pzefT1u2qTT8RkY5y3eteKmEj5qKmmb/vd1UMg+vjpj
 DDAA=
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

Add a basic test which covers this leak. While at it, cover the
functionality from commit commit 3cb22b8efe (Per-ref reflog expiry
configuration, 2008-06-15). We've had this support for years, but lacked
any tests.

Co-developed-by: Jeff King <peff@peff.net>
Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Changes in v4:
- Pass correct struct in reflog_expire_condition
- Add a unit test (thanks Jeff!)
- Link to v3: https://lore.kernel.org/r/20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com

Changes in v3:
- Remove the incorrect call in reflog_expiry_cleanup()
- Add a call in reflog_expire_condition()
- Link to v2: https://lore.kernel.org/r/20250709-jk-fix-leak-reflog-expire-config-v2-1-f9af934be8c1@gmail.com

Changes in v2:
- Actually fix the leak properly. (Thanks Jeff for catching my brain fart!)
- Link to v1: https://lore.kernel.org/r/20250709-jk-fix-leak-reflog-expire-config-v1-1-34d5461cf8f5@gmail.com
---
 reflog.h          |  2 ++
 builtin/gc.c      |  1 +
 builtin/reflog.c  |  3 +++
 reflog.c          | 14 ++++++++++++++
 t/t1410-reflog.sh | 28 ++++++++++++++++++++++++++++
 5 files changed, 48 insertions(+)

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
index 845876ff0286..459aad0b6d7e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -346,6 +346,7 @@ static int reflog_expire_condition(struct gc_config *cfg UNUSED)
 				 count_reflog_entries, &data);
 
 	reflog_expiry_cleanup(&data.policy);
+	reflog_clear_expire_config(&data.policy.opts);
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
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 42b501f163ff..e30f87a35812 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -673,4 +673,32 @@ test_expect_success 'reflog drop --all with reference' '
 	)
 '
 
+test_expect_success 'expire with pattern config' '
+	# Split refs/heads/ into two roots so we can apply config to each. Make
+	# two branches per root to verify that config is applied correctly
+	# multiple times.
+	git branch root1/branch1 &&
+	git branch root1/branch2 &&
+	git branch root2/branch1 &&
+	git branch root2/branch2 &&
+
+	test_config "gc.reflogexpire" "never" &&
+	test_config "gc.refs/heads/root2/*.reflogExpire" "now" &&
+	git reflog expire \
+		root1/branch1 root1/branch2 \
+		root2/branch1 root2/branch2 &&
+
+	cat >expect <<-\EOF &&
+	root1/branch1@{0}
+	root1/branch2@{0}
+	EOF
+	git log -g --branches="root*" --format=%gD >actual.raw &&
+	# The sole reflog entry of each branch points to the same commit, so
+	# the order in which they are shown is nondeterministic. We just care
+	# about the what was expired (and what was not), so sort to get a known
+	# order.
+	sort <actual.raw >actual.sorted &&
+	test_cmp expect actual.sorted
+'
+
 test_done

---
base-commit: a30f80fde927d70950b3b4d1820813480968fb0d
change-id: 20250709-jk-fix-leak-reflog-expire-config-712ca6dc685a

Best regards,
--  
Jacob Keller <jacob.keller@gmail.com>

