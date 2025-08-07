Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F191235BEE
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600004; cv=none; b=UrsifOehU4SfgsIVEZ3K4Bv8dPBr2Sgry56kh3HJsXVC/4oOd69XUQ5SHKZaHypsSskeEEGdaJURvk357nXao4Odvi31y3H7pTTB9kNg2eI2rkfRIrsunOCXv4t5Lt8d/36pznwUfac9hZxygOZ91oO3vk7ThkBKTVQl08d2QKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600004; c=relaxed/simple;
	bh=NUbLiYryKxRxzYfQBwncU1D/lWZuHuhoK9uRD3+XAs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V/ZHZSBGNBq7UNSjbbu9PRx4wQbYq0AzcQ6ziFlZMwu7mdTe4N8/4u18B+30cOSybCUgjpB6b1/XfLJGzppO+qgt9qkPHJ6dtAjDK968d+q/zImOmy2lZ6DTKscXn79Neleoj5lMDB6a0G9ex1BJ8OjMTzx/GiA8HLdMHSbwJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Ilcl1LSR; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Ilcl1LSR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754599998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsjQrvUFCFbonCpvoD62vvqfb5soQSK9LPoYNVoYRjE=;
	b=Ilcl1LSRUTKEldz5SXlW90vcCZzOr7CCkJV00ZH3WVIBdj6XMlAE7DZCeVmoC8bdzCXybZ
	vV2HEch5s1Cqpu4WCwGxpw84JI3XZjj8gugy94UurWkOJijKw0W+qaCB/SIcQLbwCQ02RG
	9HPLxBYFoOoUCWcD1Ce7DqBlm210ZJk=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 07 Aug 2025 22:52:57 +0200
Subject: [PATCH v2 2/3] within_depth: fix return for empty path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-toon-max-depth-v2-2-50b7e5c81665@iotcl.com>
References: <20250807-toon-max-depth-v2-0-50b7e5c81665@iotcl.com>
In-Reply-To: <20250807-toon-max-depth-v2-0-50b7e5c81665@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Justin Tobler <jltobler@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The within_depth() function is used to check whether pathspecs limited
by a max-depth parameter are acceptable. It takes a path to check, a
maximum depth, and a "base" depth. It counts the components in the
path (by counting slashes), adds them to the base, and compares them to
the maximum.

However, if the base does not have any slashes at all, we always return
`true`. If the base depth is 0, then this is correct; no matter what the
maximum is, we are always within it. However, if the base depth is
greater than 0, then we might return an erroneous result.

This ends up not causing any user-visible bugs in the current code. The
call sites in dir.c always pass a base depth of 0, so are unaffected.
But tree_entry_interesting() uses this function differently: it will
pass the prefix of the current entry, along with a `1` if the entry is a
directory, in essence checking whether items inside the entry would be
of interest. It turns out not to make a difference in behavior, but the
reasoning is complex.

Given a tree like:

  file
  a/file
  a/b/file

walking the tree and calling tree_entry_interesting() will yield the
following results:

  (with max_depth=0):
      file: yes
         a: yes
    a/file: no
       a/b: no

  (with max_depth=1):
      file: yes
         a: yes
    a/file: yes
       a/b: no

So we have inconsistent behavior in considering directories interesting.
If they are at the edge of our depth but at the root, we will recurse
into them, but then find all of their entries uninteresting (e.g., in
the first case, we will look at "a" but find "a/*" uninteresting). But
if they are at the edge of our depth and not at the root, then we will
not recurse (in the second example, we do not even bother entering
"a/b").

This turns out not to matter because the only caller which uses
max-depth pathspecs is cmd_grep(), which only cares about blob entries.
From its perspective, it is exactly the same to not recurse into a
subtree, or to recurse and find that it contains no matching entries.
Not recursing is merely an optimization.

It is debatable whether tree_entry_interesting() should consider such an
entry interesting. The only caller does not care if it sees the tree
itself, and can benefit from the optimization. But if we add a
"max-depth" limiter to regular diffs, then a diff with
DIFF_OPT_TREE_IN_RECURSIVE would probably want to show the tree itself,
but not what it contains.

This patch just fixes within_depth(), which means we consider such
entries uninteresting (and makes the current caller happy). If we want
to change that in the future, then this fix is still the correct first
step, as the current behavior is simply inconsistent.

This has the effect the function tree_entry_interesting() now behaves
like following on the first example:

  (with max_depth=0):
      file: yes
         a: no
    a/file: no
       a/b: no

Meaning we won't step in "a/" no more to realize all "a/*" entries are
uninterested, but we stop at the tree entry itself.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Makefile             |  1 +
 dir.c                |  2 +-
 t/meson.build        |  1 +
 t/unit-tests/u-dir.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e11340c1ae..8d403301d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1354,6 +1354,7 @@ THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
 CLAR_TEST_SUITES += u-ctype
+CLAR_TEST_SUITES += u-dir
 CLAR_TEST_SUITES += u-example-decorate
 CLAR_TEST_SUITES += u-hash
 CLAR_TEST_SUITES += u-hashmap
diff --git a/dir.c b/dir.c
index dfb4d40103..71108ac79b 100644
--- a/dir.c
+++ b/dir.c
@@ -277,7 +277,7 @@ int within_depth(const char *name, int namelen,
 		if (depth > max_depth)
 			return 0;
 	}
-	return 1;
+	return depth <= max_depth;
 }
 
 /*
diff --git a/t/meson.build b/t/meson.build
index bbeba1a8d5..03245e2160 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1,5 +1,6 @@
 clar_test_suites = [
   'unit-tests/u-ctype.c',
+  'unit-tests/u-dir.c',
   'unit-tests/u-example-decorate.c',
   'unit-tests/u-hash.c',
   'unit-tests/u-hashmap.c',
diff --git a/t/unit-tests/u-dir.c b/t/unit-tests/u-dir.c
new file mode 100644
index 0000000000..2d0adaa39e
--- /dev/null
+++ b/t/unit-tests/u-dir.c
@@ -0,0 +1,47 @@
+#include "unit-test.h"
+#include "dir.h"
+
+#define TEST_WITHIN_DEPTH(path, depth, max_depth, expect) do { \
+		int actual = within_depth(path, strlen(path), \
+					  depth, max_depth); \
+		if (actual != expect) \
+			cl_failf("path '%s' with depth '%d' and max-depth '%d': expected %d, got %d", \
+				 path, depth, max_depth, expect, actual); \
+	} while (0)
+
+void test_dir__within_depth(void)
+{
+	/* depth = 0; max_depth = 0 */
+	TEST_WITHIN_DEPTH("",         0, 0, 1);
+	TEST_WITHIN_DEPTH("file",     0, 0, 1);
+	TEST_WITHIN_DEPTH("a",        0, 0, 1);
+	TEST_WITHIN_DEPTH("a/file",   0, 0, 0);
+	TEST_WITHIN_DEPTH("a/b",      0, 0, 0);
+	TEST_WITHIN_DEPTH("a/b/file", 0, 0, 0);
+
+	/* depth = 0; max_depth = 1 */
+	TEST_WITHIN_DEPTH("",         0, 1, 1);
+	TEST_WITHIN_DEPTH("file",     0, 1, 1);
+	TEST_WITHIN_DEPTH("a",        0, 1, 1);
+	TEST_WITHIN_DEPTH("a/file",   0, 1, 1);
+	TEST_WITHIN_DEPTH("a/b",      0, 1, 1);
+	TEST_WITHIN_DEPTH("a/b/file", 0, 1, 0);
+
+	/* depth = 1; max_depth = 1 */
+	TEST_WITHIN_DEPTH("",         1, 1, 1);
+	TEST_WITHIN_DEPTH("file",     1, 1, 1);
+	TEST_WITHIN_DEPTH("a",        1, 1, 1);
+	TEST_WITHIN_DEPTH("a/file",   1, 1, 0);
+	TEST_WITHIN_DEPTH("a/b",      1, 1, 0);
+	TEST_WITHIN_DEPTH("a/b/file", 1, 1, 0);
+
+	/* depth = 1; max_depth = 0 */
+	TEST_WITHIN_DEPTH("",         1, 0, 0);
+	TEST_WITHIN_DEPTH("file",     1, 0, 0);
+	TEST_WITHIN_DEPTH("a",        1, 0, 0);
+	TEST_WITHIN_DEPTH("a/file",   1, 0, 0);
+	TEST_WITHIN_DEPTH("a/b",      1, 0, 0);
+	TEST_WITHIN_DEPTH("a/b/file", 1, 0, 0);
+
+
+}

-- 
2.50.1.327.g047016eb4a

