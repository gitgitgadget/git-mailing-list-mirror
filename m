Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A8019F421
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672971; cv=none; b=ndVC+CTAeF4MQAkluicEROIojqsaF7zzCxkOkhUq2F5jGs2K9a/zfyi2f9ORalZuzrcIQRcawedhzz9OdLDvy8pw+hORkIc65BxZi9Amk9CYOoQ+PPTqcwUE5VCraHYYLC/5CZM9NdoL26175ZlUk11zScD5ZRb/o2dNJsV+aGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672971; c=relaxed/simple;
	bh=e0+9ul2jmzOG0JLELZsQgwvEmbN8DFlZAgQzDyBPM6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLaxTuWCkIQC/tEiRjpG7mx5ALXbOSC9dBhJSRs4Pv5kCIFoTZ3HTm/DwSXtJlo8mY9y5Q/eK4oH7B4eL+DX3+djVA5cSmcdZbRgtWJMs/qJvgKY4YlY3flgjgn5hsQ49CCbkcSfbbKt1sOXlAkNCOTj0hTN1lsHK3KKshp6YeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oFij2Kc1; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oFij2Kc1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752672965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YZcfrVvK3D0LQeXlumoyEP0yOJ+bTsL5rkTvPtUn1Q=;
	b=oFij2Kc1h7xvPwHrG33Akf5D6UJEfNQNA1TKC9IlVnJhrCdhEF8vEl1Jxuvq+ldcO95ItZ
	zTPFygyFmKEYP5J9taa9DKYkOdDsXk/W1DHParVOFZXl8EOrYIAr3KfYFKVMO2zk/Xff8j
	wuYQIsDCqjVdqoKlTYnDFsfqTAmiSas=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 5/6] last-modified: support --extended format
Date: Wed, 16 Jul 2025 15:35:17 +0200
Message-ID: <20250716133518.1788126-5-toon@iotcl.com>
In-Reply-To: <20250716133206.1787549-1-toon@iotcl.com>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On many forges when they display a tree view, they show which commit
last modified each entry of the tree. The command git-last-modified(1)
was introduced to feed the data for this view. But it only returned the
commit OID and the path.

Add option --extended to git-last-modified(1). In combination with the
path and the commit OID, it shows the raw commit data which can be used
directly to feed the tree view on a forge.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-last-modified.adoc | 46 ++++++++++++++++++++++++++++
 builtin/last-modified.c              | 46 +++++++++++++++++++++++-----
 t/t8020-last-modified.sh             | 22 +++++++++++++
 3 files changed, 107 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index 89138ebeb7..af028c7b74 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -27,6 +27,14 @@ OPTIONS
 -t::
 	Show tree entry itself as well as subtrees.  Implies `-r`.

+-z::
+
+	Instead of separating output entries with newlines, use a NUL byte to
+	delimit them. See 'OUTPUT' for more details.
+
+--extended::
+	Show output in extended format. See 'OUTPUT' below.
+
 <revision-range>::
 	Only traverse commits in the specified revision range. When no
 	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
@@ -39,6 +47,44 @@ OPTIONS
 	Without an optional path parameter, all files and subdirectories
 	in path traversal the are included in the output.

+OUTPUT
+------
+
+The default format prints for each path:
+
+	<oid> TAB <path> LF
+
+When the commit is at boundary, it's prefixed with a caret `^`.
+
+Or when option `-z` is given:
+
+	<oid> TAB <path> NUL
+
+When `--extended` is provided, the output will be in the format:
+
+	path SP <path> LF
+	commit SP <oid> LF
+	tree SP <tree> LF
+	parent SP <parent> LF
+	author SP <author> LF
+	    <message>
+
+Each line of the commit message is indented with four spaces.
+
+Unless together with `--extended` option `-z` is given, then the output is:
+
+	path SP <path> NUL
+	commit SP <oid> LF
+	tree SP <tree> LF
+	parent SP <parent> LF
+	author SP <author> LF
+	<message>
+
+In this situation the commit message is not indented.
+
+A path containing SP or special characters is enclosed in double-quotes in the C
+style as needed, unless option `-z` is provided.
+
 SEE ALSO
 --------
 linkgit:git-blame[1],
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 466df04fba..71c66e8782 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -12,6 +12,7 @@
 #include "object-name.h"
 #include "object.h"
 #include "parse-options.h"
+#include "pretty.h"
 #include "quote.h"
 #include "repository.h"
 #include "revision.h"
@@ -39,6 +40,7 @@ struct last_modified {
 	struct hashmap paths;
 	struct rev_info rev;
 	int recursive, tree_in_recursive;
+	int extended;
 };

 static void last_modified_release(struct last_modified *lm)
@@ -244,14 +246,42 @@ static void show_entry(const char *path, const struct commit *commit, void *d)
 {
 	struct last_modified *lm = d;

-	if (commit->object.flags & BOUNDARY)
-		putchar('^');
-	printf("%s\t", oid_to_hex(&commit->object.oid));
+	if (lm->extended) {
+		struct strbuf buf = STRBUF_INIT;
+		struct pretty_print_context pp = { 0 };

-	if (lm->rev.diffopt.line_termination)
-		write_name_quoted(path, stdout, '\n');
-	else
-		printf("%s%c", path, '\0');
+		pp.abbrev = lm->rev.abbrev;
+		pp.date_mode = lm->rev.date_mode;
+		pp.date_mode_explicit = lm->rev.date_mode_explicit;
+		pp.fmt = CMIT_FMT_RAW;
+		pp.color = lm->rev.diffopt.use_color;
+		pp.rev = &lm->rev;
+		pp.no_indent = !lm->rev.diffopt.line_termination;
+
+		pretty_print_commit(&pp, commit, &buf);
+
+		printf("path ");
+		if (lm->rev.diffopt.line_termination)
+			write_name_quoted(path, stdout, '\n');
+		else
+			printf("%s%c", path, '\0');
+
+		printf("commit %s%s\n",
+		       (commit->object.flags & BOUNDARY) ? "^" : "",
+		       oid_to_hex(&commit->object.oid));
+		printf("%s%c", buf.buf, lm->rev.diffopt.line_termination);
+
+		strbuf_release(&buf);
+	} else {
+		printf("%s%s\t",
+		       (commit->object.flags & BOUNDARY) ? "^" : "",
+		       oid_to_hex(&commit->object.oid));
+
+		if (lm->rev.diffopt.line_termination)
+			write_name_quoted(path, stdout, '\n');
+		else
+			printf("%s%c", path, '\0');
+	}

 	fflush(stdout);
 }
@@ -306,6 +336,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 			 N_("recurse into subtrees")),
 		OPT_BOOL('t', "tree-in-recursive", &lm.tree_in_recursive,
 			 N_("recurse into subtrees and include the tree entries too")),
+		OPT_BOOL(0, "extended", &lm.extended,
+			 N_("extended format will include the commit message in the output")),
 		OPT_END()
 	};

diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 05c113a1f8..008ea708ab 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -48,6 +48,28 @@ test_expect_success 'last-modified non-recursive' '
 	EOF
 '

+test_expect_success 'last-modified extended output' '
+	check_last_modified --extended <<-\EOF
+	path a
+	commit 3
+	tree e9a947598482012e54c9c5d3635d5b526b43a6a4
+	parent 2
+	author A U Thor <author@example.com> 1112912113 -0700
+	committer C O Mitter <committer@example.com> 1112912113 -0700
+
+	    3
+
+	path file
+	commit 1
+	tree f27c6ae26adb8396d3861976ba268f87ad8afa0b
+	author A U Thor <author@example.com> 1112911993 -0700
+	committer C O Mitter <committer@example.com> 1112911993 -0700
+
+	    1
+
+	EOF
+'
+
 test_expect_success 'last-modified recursive' '
 	check_last_modified -r <<-\EOF
 	3 a/b/file
--
2.50.1.327.g047016eb4a
