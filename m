From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/20] t7063: tests for untracked cache
Date: Wed,  7 May 2014 21:52:00 +0700
Message-ID: <1399474320-6840-21-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:53:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3EL-0006ZM-Ex
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932891AbaEGOxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:53:52 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:39004 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932881AbaEGOxv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:53:51 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so1298226pab.1
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pxe3515wNA87cRPORjWqHk8h1f/P3JQYB+MfGVx0lvM=;
        b=Ejr/O6j2QdW+Mt81iIMQbHj8nX0v2CdZ8BjTfHYGBmqLh0nNo2RKMu4ZmhFesJkd30
         nia+/16wkbDkN7zr5vrSQof2ErbnHbPYN0TxNzc4gGDANLBdeP5kKZ9kvZb20wdext6D
         BBzhTiFNG2mxUVzS4XY8TrBHbKvyQ83YNEFiPtHnRO1YKOhNYRCa4uXNYR365jbETX3E
         wkEVHCXq4RZrIN/3KWcSh9cWVMfCt4umKvVy2cqv8xBOb7DJDdWLxcstZXEMOsErCnLf
         s88QoAWDQLBS3upVSgDWIhc693OZGvVwPHdkq2mCMqDz3XlxcevTZJ26+0pJCio7Pfuu
         eAdQ==
X-Received: by 10.66.254.3 with SMTP id ae3mr19883472pad.49.1399474430905;
        Wed, 07 May 2014 07:53:50 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id iq10sm3669759pbc.14.2014.05.07.07.53.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:53:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:53:50 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248326>

---
 .gitignore                                 |   1 +
 Makefile                                   |   1 +
 t/t7063-status-untracked-cache.sh (new +x) | 352 +++++++++++++++++++++++++++++
 test-dump-untracked-cache.c (new)          |  61 +++++
 4 files changed, 415 insertions(+)
 create mode 100755 t/t7063-status-untracked-cache.sh
 create mode 100644 test-dump-untracked-cache.c

diff --git a/.gitignore b/.gitignore
index dc600f9..7f3bfdb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -180,6 +180,7 @@
 /test-date
 /test-delta
 /test-dump-cache-tree
+/test-dump-untracked-cache
 /test-scrap-cache-tree
 /test-genrandom
 /test-hashmap
diff --git a/Makefile b/Makefile
index a53f3a8..d8a0482 100644
--- a/Makefile
+++ b/Makefile
@@ -553,6 +553,7 @@ TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
+TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
new file mode 100755
index 0000000..bb5124b
--- /dev/null
+++ b/t/t7063-status-untracked-cache.sh
@@ -0,0 +1,352 @@
+#!/bin/sh
+
+test_description='test untracked cache'
+
+. ./test-lib.sh
+
+avoid_racy() {
+	sleep 1
+}
+
+git update-index --untracked-cache
+# It's fine if git update-index returns an error code other than one,
+# it'll be caught in the first test.
+if test $? -eq 1; then
+	skip_all='This system does not support untracked cache'
+	test_done
+fi
+
+test_expect_success 'setup' '
+	git init worktree &&
+	cd worktree &&
+	mkdir done dtwo dthree &&
+	touch one two three done/one dtwo/two dthree/three &&
+	git add one two done/one &&
+	: >.git/info/exclude &&
+	git update-index --untracked-cache
+'
+
+test_expect_success 'untracked cache is empty' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 0000000000000000000000000000000000000000
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+EOF
+	test_cmp ../expect ../actual
+'
+
+cat >../status.expect <<EOF &&
+A  done/one
+A  one
+A  two
+?? dthree/
+?? dtwo/
+?? three
+EOF
+
+cat >../dump.expect <<EOF &&
+info/exclude e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ 0000000000000000000000000000000000000000 recurse valid
+dthree/
+dtwo/
+three
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+three
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+two
+EOF
+
+test_expect_success 'status first time (empty cache)' '
+	: >../trace &&
+	GIT_TRACE_UNTRACKED="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 3
+gitignore invalidation: 1
+directory invalidation: 0
+opendir: 4
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'untracked cache after first status' '
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../dump.expect ../actual
+'
+
+test_expect_success 'status second time (fully populated cache)' '
+	avoid_racy &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 0
+opendir: 0
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'untracked cache after second status' '
+	test-dump-untracked-cache >../actual &&
+	test_cmp ../dump.expect ../actual
+'
+
+test_expect_success 'modify in root directory, one dir invalidation' '
+	avoid_racy &&
+	: >four &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	cat >../status.expect <<EOF &&
+A  done/one
+A  one
+A  two
+?? dthree/
+?? dtwo/
+?? four
+?? three
+EOF
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 1
+opendir: 1
+EOF
+	test_cmp ../trace.expect ../trace
+
+'
+
+test_expect_success 'verify untracked cache dump' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ 0000000000000000000000000000000000000000 recurse valid
+dthree/
+dtwo/
+four
+three
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+three
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'new .gitignore invalidates recursively' '
+	avoid_racy &&
+	echo four >.gitignore &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	cat >../status.expect <<EOF &&
+A  done/one
+A  one
+A  two
+?? .gitignore
+?? dthree/
+?? dtwo/
+?? three
+EOF
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 1
+directory invalidation: 1
+opendir: 4
+EOF
+	test_cmp ../trace.expect ../trace
+
+'
+
+test_expect_success 'verify untracked cache dump' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dthree/
+dtwo/
+three
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+three
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'new info/exclude invalidates everything' '
+	avoid_racy &&
+	echo three >>.git/info/exclude &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	cat >../status.expect <<EOF &&
+A  done/one
+A  one
+A  two
+?? .gitignore
+?? dtwo/
+EOF
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 1
+directory invalidation: 0
+opendir: 4
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'verify untracked cache dump' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dtwo/
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'move two from tracked to untracked' '
+	git rm --cached two &&
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'status after the move' '
+	: >../trace &&
+	GIT_TRACE_UNTRACKED="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	cat >../status.expect <<EOF &&
+A  done/one
+A  one
+?? .gitignore
+?? dtwo/
+?? two
+EOF
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 0
+opendir: 1
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'verify untracked cache dump' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dtwo/
+two
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'move two from untracked to tracked' '
+	git add two &&
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'status after the move' '
+	: >../trace &&
+	GIT_TRACE_UNTRACKED="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../actual &&
+	cat >../status.expect <<EOF &&
+A  done/one
+A  one
+A  two
+?? .gitignore
+?? dtwo/
+EOF
+	test_cmp ../status.expect ../actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 0
+opendir: 1
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'verify untracked cache dump' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dtwo/
+/done/ 0000000000000000000000000000000000000000 recurse valid
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_done
diff --git a/test-dump-untracked-cache.c b/test-dump-untracked-cache.c
new file mode 100644
index 0000000..c55db09
--- /dev/null
+++ b/test-dump-untracked-cache.c
@@ -0,0 +1,61 @@
+#include "cache.h"
+#include "dir.h"
+
+static int compare_untracked(const void *a_, const void *b_)
+{
+	const char *const *a = a_;
+	const char *const *b = b_;
+	return strcmp(*a, *b);
+}
+
+static int compare_dir(const void *a_, const void *b_)
+{
+	const struct untracked_cache_dir *const *a = a_;
+	const struct untracked_cache_dir *const *b = b_;
+	return strcmp((*a)->name, (*b)->name);
+}
+
+static void dump(struct untracked_cache_dir *ucd, struct strbuf *base)
+{
+	int i, len;
+	qsort(ucd->untracked, ucd->untracked_nr, sizeof(*ucd->untracked),
+	      compare_untracked);
+	qsort(ucd->dirs, ucd->dirs_nr, sizeof(*ucd->dirs),
+	      compare_dir);
+	len = base->len;
+	strbuf_addf(base, "%s/", ucd->name);
+	printf("%s %s", base->buf,
+	       sha1_to_hex(ucd->exclude_sha1));
+	if (ucd->recurse)
+		fputs(" recurse", stdout);
+	if (ucd->check_only)
+		fputs(" check_only", stdout);
+	if (ucd->valid)
+		fputs(" valid", stdout);
+	printf("\n");
+	for (i = 0; i < ucd->untracked_nr; i++)
+		printf("%s\n", ucd->untracked[i]);
+	for (i = 0; i < ucd->dirs_nr; i++)
+		dump(ucd->dirs[i], base);
+	strbuf_setlen(base, len);
+}
+
+int main(int ac, char **av)
+{
+	struct untracked_cache *uc;
+	struct strbuf base = STRBUF_INIT;
+	if (read_cache() < 0)
+		die("unable to read index file");
+	uc = the_index.untracked;
+	if (!uc) {
+		printf("no untracked cache\n");
+		return 0;
+	}
+	printf("info/exclude %s\n", sha1_to_hex(uc->info_exclude_sha1));
+	printf("core.excludesfile %s\n", sha1_to_hex(uc->excludes_file_sha1));
+	printf("exclude_per_dir %s\n", uc->exclude_per_dir);
+	printf("flags %08x\n", uc->dir_flags);
+	if (uc->root)
+		dump(uc->root, &base);
+	return 0;
+}
-- 
1.9.1.346.ga2b5940
