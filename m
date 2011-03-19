From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 8/9] vcs-svn: drop obj_pool.h
Date: Sat, 19 Mar 2011 18:03:50 +1100
Message-ID: <1300518231-20008-9-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qLF-0004uk-4v
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab1CSHMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:12:33 -0400
Received: from [119.15.97.146] ([119.15.97.146]:60191 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753503Ab1CSHMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:12:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id D70A9C040;
	Sat, 19 Mar 2011 18:00:39 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7effVa+hBVk3; Sat, 19 Mar 2011 18:00:33 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id B9F1FC053;
	Sat, 19 Mar 2011 18:00:28 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169390>

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 .gitignore         |    1 -
 Makefile           |    2 -
 t/t0080-vcs-svn.sh |   79 -----------------------------------
 test-obj-pool.c    |  116 ----------------------------------------------------
 vcs-svn/obj_pool.h |   61 ---------------------------
 5 files changed, 0 insertions(+), 259 deletions(-)
 delete mode 100755 t/t0080-vcs-svn.sh
 delete mode 100644 test-obj-pool.c
 delete mode 100644 vcs-svn/obj_pool.h

diff --git a/.gitignore b/.gitignore
index aa94ff1..789f922 100644
--- a/.gitignore
+++ b/.gitignore
@@ -171,7 +171,6 @@
 /test-line-buffer
 /test-match-trees
 /test-mktemp
-/test-obj-pool
 /test-parse-options
 /test-path-utils
 /test-run-command
diff --git a/Makefile b/Makefile
index 2d56ab9..6165609 100644
--- a/Makefile
+++ b/Makefile
@@ -424,7 +424,6 @@ TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
-TEST_PROGRAMS_NEED_X += test-obj-pool
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-run-command
@@ -1962,7 +1961,6 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(VCSSVN_OBJS) $(VCSSVN_TEST_OBJS): $(LIB_H) \
-	vcs-svn/obj_pool.h \
 	vcs-svn/line_buffer.h vcs-svn/repo_tree.h vcs-svn/fast_export.h \
 	vcs-svn/svndump.h
 
diff --git a/t/t0080-vcs-svn.sh b/t/t0080-vcs-svn.sh
deleted file mode 100755
index 3f29496..0000000
--- a/t/t0080-vcs-svn.sh
+++ /dev/null
@@ -1,79 +0,0 @@
-#!/bin/sh
-
-test_description='check infrastructure for svn importer'
-
-. ./test-lib.sh
-uint32_max=4294967295
-
-test_expect_success 'obj pool: store data' '
-	cat <<-\EOF >expected &&
-	0
-	1
-	EOF
-
-	test-obj-pool <<-\EOF >actual &&
-	alloc one 16
-	set one 13
-	test one 13
-	reset one
-	EOF
-	test_cmp expected actual
-'
-
-test_expect_success 'obj pool: NULL is offset ~0' '
-	echo "$uint32_max" >expected &&
-	echo null one | test-obj-pool >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success 'obj pool: out-of-bounds access' '
-	cat <<-EOF >expected &&
-	0
-	0
-	$uint32_max
-	$uint32_max
-	16
-	20
-	$uint32_max
-	EOF
-
-	test-obj-pool <<-\EOF >actual &&
-	alloc one 16
-	alloc two 16
-	offset one 20
-	offset two 20
-	alloc one 5
-	offset one 20
-	free one 1
-	offset one 20
-	reset one
-	reset two
-	EOF
-	test_cmp expected actual
-'
-
-test_expect_success 'obj pool: high-water mark' '
-	cat <<-\EOF >expected &&
-	0
-	0
-	10
-	20
-	20
-	20
-	EOF
-
-	test-obj-pool <<-\EOF >actual &&
-	alloc one 10
-	committed one
-	alloc one 10
-	commit one
-	committed one
-	alloc one 10
-	free one 20
-	committed one
-	reset one
-	EOF
-	test_cmp expected actual
-'
-
-test_done
diff --git a/test-obj-pool.c b/test-obj-pool.c
deleted file mode 100644
index 5018863..0000000
--- a/test-obj-pool.c
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- * test-obj-pool.c: code to exercise the svn importer's object pool
- */
-
-#include "cache.h"
-#include "vcs-svn/obj_pool.h"
-
-enum pool { POOL_ONE, POOL_TWO };
-obj_pool_gen(one, int, 1)
-obj_pool_gen(two, int, 4096)
-
-static uint32_t strtouint32(const char *s)
-{
-	char *end;
-	uintmax_t n = strtoumax(s, &end, 10);
-	if (*s == '\0' || (*end != '\n' && *end != '\0'))
-		die("invalid offset: %s", s);
-	return (uint32_t) n;
-}
-
-static void handle_command(const char *command, enum pool pool, const char *arg)
-{
-	switch (*command) {
-	case 'a':
-		if (!prefixcmp(command, "alloc ")) {
-			uint32_t n = strtouint32(arg);
-			printf("%"PRIu32"\n",
-				pool == POOL_ONE ?
-				one_alloc(n) : two_alloc(n));
-			return;
-		}
-	case 'c':
-		if (!prefixcmp(command, "commit ")) {
-			pool == POOL_ONE ? one_commit() : two_commit();
-			return;
-		}
-		if (!prefixcmp(command, "committed ")) {
-			printf("%"PRIu32"\n",
-				pool == POOL_ONE ?
-				one_pool.committed : two_pool.committed);
-			return;
-		}
-	case 'f':
-		if (!prefixcmp(command, "free ")) {
-			uint32_t n = strtouint32(arg);
-			pool == POOL_ONE ? one_free(n) : two_free(n);
-			return;
-		}
-	case 'n':
-		if (!prefixcmp(command, "null ")) {
-			printf("%"PRIu32"\n",
-				pool == POOL_ONE ?
-				one_offset(NULL) : two_offset(NULL));
-			return;
-		}
-	case 'o':
-		if (!prefixcmp(command, "offset ")) {
-			uint32_t n = strtouint32(arg);
-			printf("%"PRIu32"\n",
-				pool == POOL_ONE ?
-				one_offset(one_pointer(n)) :
-				two_offset(two_pointer(n)));
-			return;
-		}
-	case 'r':
-		if (!prefixcmp(command, "reset ")) {
-			pool == POOL_ONE ? one_reset() : two_reset();
-			return;
-		}
-	case 's':
-		if (!prefixcmp(command, "set ")) {
-			uint32_t n = strtouint32(arg);
-			if (pool == POOL_ONE)
-				*one_pointer(n) = 1;
-			else
-				*two_pointer(n) = 1;
-			return;
-		}
-	case 't':
-		if (!prefixcmp(command, "test ")) {
-			uint32_t n = strtouint32(arg);
-			printf("%d\n", pool == POOL_ONE ?
-				*one_pointer(n) : *two_pointer(n));
-			return;
-		}
-	default:
-		die("unrecognized command: %s", command);
-	}
-}
-
-static void handle_line(const char *line)
-{
-	const char *arg = strchr(line, ' ');
-	enum pool pool;
-
-	if (arg && !prefixcmp(arg + 1, "one"))
-		pool = POOL_ONE;
-	else if (arg && !prefixcmp(arg + 1, "two"))
-		pool = POOL_TWO;
-	else
-		die("no pool specified: %s", line);
-
-	handle_command(line, pool, arg + strlen("one "));
-}
-
-int main(int argc, char *argv[])
-{
-	struct strbuf sb = STRBUF_INIT;
-	if (argc != 1)
-		usage("test-obj-str < script");
-
-	while (strbuf_getline(&sb, stdin, '\n') != EOF)
-		handle_line(sb.buf);
-	strbuf_release(&sb);
-	return 0;
-}
diff --git a/vcs-svn/obj_pool.h b/vcs-svn/obj_pool.h
deleted file mode 100644
index deb6eb8..0000000
--- a/vcs-svn/obj_pool.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * Licensed under a two-clause BSD-style license.
- * See LICENSE for details.
- */
-
-#ifndef OBJ_POOL_H_
-#define OBJ_POOL_H_
-
-#include "git-compat-util.h"
-
-#define MAYBE_UNUSED __attribute__((__unused__))
-
-#define obj_pool_gen(pre, obj_t, initial_capacity) \
-static struct { \
-	uint32_t committed; \
-	uint32_t size; \
-	uint32_t capacity; \
-	obj_t *base; \
-} pre##_pool = {0, 0, 0, NULL}; \
-static MAYBE_UNUSED uint32_t pre##_alloc(uint32_t count) \
-{ \
-	uint32_t offset; \
-	if (pre##_pool.size + count > pre##_pool.capacity) { \
-		while (pre##_pool.size + count > pre##_pool.capacity) \
-			if (pre##_pool.capacity) \
-				pre##_pool.capacity *= 2; \
-			else \
-				pre##_pool.capacity = initial_capacity; \
-		pre##_pool.base = realloc(pre##_pool.base, \
-					pre##_pool.capacity * sizeof(obj_t)); \
-	} \
-	offset = pre##_pool.size; \
-	pre##_pool.size += count; \
-	return offset; \
-} \
-static MAYBE_UNUSED void pre##_free(uint32_t count) \
-{ \
-	pre##_pool.size -= count; \
-} \
-static MAYBE_UNUSED uint32_t pre##_offset(obj_t *obj) \
-{ \
-	return obj == NULL ? ~0 : obj - pre##_pool.base; \
-} \
-static MAYBE_UNUSED obj_t *pre##_pointer(uint32_t offset) \
-{ \
-	return offset >= pre##_pool.size ? NULL : &pre##_pool.base[offset]; \
-} \
-static MAYBE_UNUSED void pre##_commit(void) \
-{ \
-	pre##_pool.committed = pre##_pool.size; \
-} \
-static MAYBE_UNUSED void pre##_reset(void) \
-{ \
-	free(pre##_pool.base); \
-	pre##_pool.base = NULL; \
-	pre##_pool.size = 0; \
-	pre##_pool.capacity = 0; \
-	pre##_pool.committed = 0; \
-}
-
-#endif
-- 
1.7.3.2.846.gf4b062
