From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/10] Add memory pool library
Date: Mon, 9 Aug 2010 17:11:11 -0500
Message-ID: <20100809221111.GD4203@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 00:13:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiaaj-0004yg-2o
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 00:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757147Ab0HIWMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 18:12:50 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59092 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757115Ab0HIWMt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 18:12:49 -0400
Received: by qwh6 with SMTP id 6so7668119qwh.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 15:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=guD9A50Vgle/Ans/m4YzLnn8LpjX2w0HLwltTEWyceY=;
        b=x1l7dzs3KLiDNg/dOuSINUAYZBSZOr1v10z76Nm8a1u9kAPBpQ6dZdyxK2ORvK/eBs
         u9vIkHggDmAS1lnFZS8kWOnbcoJnZHko7q5TMy+O5x8H2qj0KBv8tRoZg8Z3P2qQePxe
         Xk/D6DOw8i6bO3hkL6oNnMC5Vi4efGoZmRj1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q/yllUAro2GhXSelFzOdEe8M/HHw6AYN65e70QVGPZ8CB7luVNbocSQtteTxsK2770
         gLo9v2WU++oemnTz71q7IU6qz9/k46W//4KOC4PPa1ia0RIkNQ2VjG4ydIfXWM5f/34h
         Iz90OuRbgpgHJ9alweJl/C5Y6AXE0MywA+t1g=
Received: by 10.220.168.10 with SMTP id s10mr10001139vcy.50.1281391968583;
        Mon, 09 Aug 2010 15:12:48 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id m31sm1142333vcf.13.2010.08.09.15.12.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 15:12:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809215719.GA4203@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153035>

From: David Barr <david.barr@cordelta.com>

Add a memory pool library implemented using C macros. The
obj_pool_gen() macro creates a type-specific memory pool.

The memory pool library is distinguished from the existing specialized
allocators in alloc.c by using a contiguous block for all allocations.
This means that on one hand, long-lived pointers have to be written as
offsets, since the base address changes as the pool grows, but on the
other hand, the entire pool can be easily written to the file system.
This could allow the memory pool to persist between runs of an
application.

For the svn importer, such a facility is useful because each svn
revision can copy trees and files from any previous revision.  The
relevant information for all revisions has to persist somehow to
support incremental runs.

[rr: minor cleanups]
[jn: added tests; removed file system backing for now]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
The only change from last round is the notes at the end of the commit
message.  Hopefully David is less likely to be blamed for bugs I
introduced this way. :)

 .gitignore         |    1 +
 Makefile           |    4 +-
 t/t0080-vcs-svn.sh |   79 +++++++++++++++++++++++++++++++++++
 test-obj-pool.c    |  116 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/obj_pool.h |   61 +++++++++++++++++++++++++++
 5 files changed, 260 insertions(+), 1 deletions(-)
 create mode 100755 t/t0080-vcs-svn.sh
 create mode 100644 test-obj-pool.c
 create mode 100644 vcs-svn/obj_pool.h

diff --git a/.gitignore b/.gitignore
index 14e2b6b..1e64a6a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -167,6 +167,7 @@
 /test-genrandom
 /test-index-version
 /test-match-trees
+/test-obj-pool
 /test-parse-options
 /test-path-utils
 /test-run-command
diff --git a/Makefile b/Makefile
index 71cca35..eb471e7 100644
--- a/Makefile
+++ b/Makefile
@@ -409,6 +409,7 @@ TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-match-trees
+TEST_PROGRAMS_NEED_X += test-obj-pool
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-run-command
@@ -1863,7 +1864,8 @@ xdiff-interface.o $(XDIFF_OBJS): \
 	xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
 	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
-$(VCSSVN_OBJS):
+$(VCSSVN_OBJS): \
+	vcs-svn/obj_pool.h
 endif
 
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS = \
diff --git a/t/t0080-vcs-svn.sh b/t/t0080-vcs-svn.sh
new file mode 100755
index 0000000..3f29496
--- /dev/null
+++ b/t/t0080-vcs-svn.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+test_description='check infrastructure for svn importer'
+
+. ./test-lib.sh
+uint32_max=4294967295
+
+test_expect_success 'obj pool: store data' '
+	cat <<-\EOF >expected &&
+	0
+	1
+	EOF
+
+	test-obj-pool <<-\EOF >actual &&
+	alloc one 16
+	set one 13
+	test one 13
+	reset one
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'obj pool: NULL is offset ~0' '
+	echo "$uint32_max" >expected &&
+	echo null one | test-obj-pool >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'obj pool: out-of-bounds access' '
+	cat <<-EOF >expected &&
+	0
+	0
+	$uint32_max
+	$uint32_max
+	16
+	20
+	$uint32_max
+	EOF
+
+	test-obj-pool <<-\EOF >actual &&
+	alloc one 16
+	alloc two 16
+	offset one 20
+	offset two 20
+	alloc one 5
+	offset one 20
+	free one 1
+	offset one 20
+	reset one
+	reset two
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'obj pool: high-water mark' '
+	cat <<-\EOF >expected &&
+	0
+	0
+	10
+	20
+	20
+	20
+	EOF
+
+	test-obj-pool <<-\EOF >actual &&
+	alloc one 10
+	committed one
+	alloc one 10
+	commit one
+	committed one
+	alloc one 10
+	free one 20
+	committed one
+	reset one
+	EOF
+	test_cmp expected actual
+'
+
+test_done
diff --git a/test-obj-pool.c b/test-obj-pool.c
new file mode 100644
index 0000000..5018863
--- /dev/null
+++ b/test-obj-pool.c
@@ -0,0 +1,116 @@
+/*
+ * test-obj-pool.c: code to exercise the svn importer's object pool
+ */
+
+#include "cache.h"
+#include "vcs-svn/obj_pool.h"
+
+enum pool { POOL_ONE, POOL_TWO };
+obj_pool_gen(one, int, 1)
+obj_pool_gen(two, int, 4096)
+
+static uint32_t strtouint32(const char *s)
+{
+	char *end;
+	uintmax_t n = strtoumax(s, &end, 10);
+	if (*s == '\0' || (*end != '\n' && *end != '\0'))
+		die("invalid offset: %s", s);
+	return (uint32_t) n;
+}
+
+static void handle_command(const char *command, enum pool pool, const char *arg)
+{
+	switch (*command) {
+	case 'a':
+		if (!prefixcmp(command, "alloc ")) {
+			uint32_t n = strtouint32(arg);
+			printf("%"PRIu32"\n",
+				pool == POOL_ONE ?
+				one_alloc(n) : two_alloc(n));
+			return;
+		}
+	case 'c':
+		if (!prefixcmp(command, "commit ")) {
+			pool == POOL_ONE ? one_commit() : two_commit();
+			return;
+		}
+		if (!prefixcmp(command, "committed ")) {
+			printf("%"PRIu32"\n",
+				pool == POOL_ONE ?
+				one_pool.committed : two_pool.committed);
+			return;
+		}
+	case 'f':
+		if (!prefixcmp(command, "free ")) {
+			uint32_t n = strtouint32(arg);
+			pool == POOL_ONE ? one_free(n) : two_free(n);
+			return;
+		}
+	case 'n':
+		if (!prefixcmp(command, "null ")) {
+			printf("%"PRIu32"\n",
+				pool == POOL_ONE ?
+				one_offset(NULL) : two_offset(NULL));
+			return;
+		}
+	case 'o':
+		if (!prefixcmp(command, "offset ")) {
+			uint32_t n = strtouint32(arg);
+			printf("%"PRIu32"\n",
+				pool == POOL_ONE ?
+				one_offset(one_pointer(n)) :
+				two_offset(two_pointer(n)));
+			return;
+		}
+	case 'r':
+		if (!prefixcmp(command, "reset ")) {
+			pool == POOL_ONE ? one_reset() : two_reset();
+			return;
+		}
+	case 's':
+		if (!prefixcmp(command, "set ")) {
+			uint32_t n = strtouint32(arg);
+			if (pool == POOL_ONE)
+				*one_pointer(n) = 1;
+			else
+				*two_pointer(n) = 1;
+			return;
+		}
+	case 't':
+		if (!prefixcmp(command, "test ")) {
+			uint32_t n = strtouint32(arg);
+			printf("%d\n", pool == POOL_ONE ?
+				*one_pointer(n) : *two_pointer(n));
+			return;
+		}
+	default:
+		die("unrecognized command: %s", command);
+	}
+}
+
+static void handle_line(const char *line)
+{
+	const char *arg = strchr(line, ' ');
+	enum pool pool;
+
+	if (arg && !prefixcmp(arg + 1, "one"))
+		pool = POOL_ONE;
+	else if (arg && !prefixcmp(arg + 1, "two"))
+		pool = POOL_TWO;
+	else
+		die("no pool specified: %s", line);
+
+	handle_command(line, pool, arg + strlen("one "));
+}
+
+int main(int argc, char *argv[])
+{
+	struct strbuf sb = STRBUF_INIT;
+	if (argc != 1)
+		usage("test-obj-str < script");
+
+	while (strbuf_getline(&sb, stdin, '\n') != EOF)
+		handle_line(sb.buf);
+	strbuf_release(&sb);
+	return 0;
+}
diff --git a/vcs-svn/obj_pool.h b/vcs-svn/obj_pool.h
new file mode 100644
index 0000000..deb6eb8
--- /dev/null
+++ b/vcs-svn/obj_pool.h
@@ -0,0 +1,61 @@
+/*
+ * Licensed under a two-clause BSD-style license.
+ * See LICENSE for details.
+ */
+
+#ifndef OBJ_POOL_H_
+#define OBJ_POOL_H_
+
+#include "git-compat-util.h"
+
+#define MAYBE_UNUSED __attribute__((__unused__))
+
+#define obj_pool_gen(pre, obj_t, initial_capacity) \
+static struct { \
+	uint32_t committed; \
+	uint32_t size; \
+	uint32_t capacity; \
+	obj_t *base; \
+} pre##_pool = {0, 0, 0, NULL}; \
+static MAYBE_UNUSED uint32_t pre##_alloc(uint32_t count) \
+{ \
+	uint32_t offset; \
+	if (pre##_pool.size + count > pre##_pool.capacity) { \
+		while (pre##_pool.size + count > pre##_pool.capacity) \
+			if (pre##_pool.capacity) \
+				pre##_pool.capacity *= 2; \
+			else \
+				pre##_pool.capacity = initial_capacity; \
+		pre##_pool.base = realloc(pre##_pool.base, \
+					pre##_pool.capacity * sizeof(obj_t)); \
+	} \
+	offset = pre##_pool.size; \
+	pre##_pool.size += count; \
+	return offset; \
+} \
+static MAYBE_UNUSED void pre##_free(uint32_t count) \
+{ \
+	pre##_pool.size -= count; \
+} \
+static MAYBE_UNUSED uint32_t pre##_offset(obj_t *obj) \
+{ \
+	return obj == NULL ? ~0 : obj - pre##_pool.base; \
+} \
+static MAYBE_UNUSED obj_t *pre##_pointer(uint32_t offset) \
+{ \
+	return offset >= pre##_pool.size ? NULL : &pre##_pool.base[offset]; \
+} \
+static MAYBE_UNUSED void pre##_commit(void) \
+{ \
+	pre##_pool.committed = pre##_pool.size; \
+} \
+static MAYBE_UNUSED void pre##_reset(void) \
+{ \
+	free(pre##_pool.base); \
+	pre##_pool.base = NULL; \
+	pre##_pool.size = 0; \
+	pre##_pool.capacity = 0; \
+	pre##_pool.committed = 0; \
+}
+
+#endif
-- 
1.7.2.1.544.ga752d.dirty
