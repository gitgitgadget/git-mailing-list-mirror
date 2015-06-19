From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 3/3] Add filter-objects command
Date: Fri, 19 Jun 2015 10:10:59 +0100
Message-ID: <1434705059-2793-4-git-send-email-charles@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
To: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 11:37:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5sjn-0004pX-K6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 11:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbbFSJhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 05:37:23 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:51078 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbFSJhU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 05:37:20 -0400
X-Greylist: delayed 1563 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2015 05:37:20 EDT
Received: from hashpling.plus.com ([212.159.69.125]:41965)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z5sKQ-0006de-Nv; Fri, 19 Jun 2015 10:11:14 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
In-Reply-To: <1434705059-2793-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272116>

From: Charles Bailey <cbailey32@bloomberg.net>

filter-objects is a command to scan all objects in the object database
for the repository and print the ids of those which match the given
criteria.

The current supported criteria are object type and the minimum size of
the object.

The guiding use case is to scan repositories quickly for large objects
which may cause performance issues for users. The list of objects can
then be used to guide some future remediating action.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
 Documentation/git-filter-objects.txt | 38 +++++++++++++++++++
 Makefile                             |  1 +
 builtin.h                            |  1 +
 builtin/filter-objects.c             | 73 ++++++++++++++++++++++++++++++++++++
 git.c                                |  1 +
 t/t8100-filter-objects.sh            | 67 +++++++++++++++++++++++++++++++++
 6 files changed, 181 insertions(+)
 create mode 100644 Documentation/git-filter-objects.txt
 create mode 100644 builtin/filter-objects.c
 create mode 100755 t/t8100-filter-objects.sh

diff --git a/Documentation/git-filter-objects.txt b/Documentation/git-filter-objects.txt
new file mode 100644
index 0000000..c10ca01
--- /dev/null
+++ b/Documentation/git-filter-objects.txt
@@ -0,0 +1,38 @@
+git-filter-objects(1)
+=====================
+
+NAME
+----
+git-filter-objects - Scan through all objects in the repository and print those
+matching a given filter
+
+
+SYNOPSIS
+--------
+[verse]
+'git filter-objects' [-t <type> | --type=<type>] [--min-size=<size>]
+	[-v|--verbose]
+
+DESCRIPTION
+-----------
+Scans all objects in a repository - including any unreachable objects - and
+print out the ids of all matching objects.  If `--verbose` is specified then
+the object type and size is printed out as well as its id.
+
+OPTIONS
+-------
+-t::
+--type::
+	Only list objects whose type matches <type>.
+
+--min-size::
+	Only list objects whose size exceeds <size> bytes.
+
+-v::
+--verbose::
+	Output in the followin format instead of just printing object ids:
+	<sha1> SP <type> SP <size>
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 149f1c7..a7c017f 100644
--- a/Makefile
+++ b/Makefile
@@ -842,6 +842,7 @@ BUILTIN_OBJS += builtin/diff.o
 BUILTIN_OBJS += builtin/fast-export.o
 BUILTIN_OBJS += builtin/fetch-pack.o
 BUILTIN_OBJS += builtin/fetch.o
+BUILTIN_OBJS += builtin/filter-objects.o
 BUILTIN_OBJS += builtin/fmt-merge-msg.o
 BUILTIN_OBJS += builtin/for-each-ref.o
 BUILTIN_OBJS += builtin/fsck.o
diff --git a/builtin.h b/builtin.h
index b87df70..5a15693 100644
--- a/builtin.h
+++ b/builtin.h
@@ -62,6 +62,7 @@ extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_fast_export(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
+extern int cmd_filter_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 extern int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
diff --git a/builtin/filter-objects.c b/builtin/filter-objects.c
new file mode 100644
index 0000000..c40d621
--- /dev/null
+++ b/builtin/filter-objects.c
@@ -0,0 +1,73 @@
+#include "cache.h"
+#include "builtin.h"
+#include "revision.h"
+#include "parse-options.h"
+
+#include <stdio.h>
+
+static int req_type;
+static unsigned long min_size;
+static int verbose;
+
+static int check_object(const unsigned char *sha1)
+{
+	unsigned long size;
+	int type = sha1_object_info(sha1, &size);
+
+	if (type < 0)
+		return -1;
+
+	if (size >= min_size && (!req_type || type == req_type)) {
+		if (verbose)
+			printf("%s %s %lu\n", sha1_to_hex(sha1), typename(type), size);
+		else
+			printf("%s\n", sha1_to_hex(sha1));
+	}
+
+	return 0;
+}
+
+static int check_loose_object(const unsigned char *sha1,
+			      const char *path,
+			      void *data)
+{
+	return check_object(sha1);
+}
+
+static int check_packed_object(const unsigned char *sha1,
+			       struct packed_git *pack,
+			       uint32_t pos,
+			       void *data)
+{
+	return check_object(sha1);
+}
+
+static char *opt_type;
+static struct option builtin_filter_objects_options[] = {
+	OPT_ULONG(0, "min-size", &min_size, "minimum size of object to show"),
+	OPT_STRING('t', "type", &opt_type, NULL, "type of objects to show"),
+	OPT__VERBOSE(&verbose, "show object type and size"),
+	OPT_END()
+};
+
+int cmd_filter_objects(int argc, const char **argv, const char *prefix)
+{
+	struct packed_git *p;
+
+	argc = parse_options(argc, argv, prefix, builtin_filter_objects_options,
+			     NULL, 0);
+
+	if (opt_type)
+		req_type = type_from_string(opt_type);
+
+	for_each_loose_object(check_loose_object, NULL, 0);
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		open_pack_index(p);
+	}
+
+	for_each_packed_object(check_packed_object, NULL, 0);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 44374b1..4c87afd 100644
--- a/git.c
+++ b/git.c
@@ -403,6 +403,7 @@ static struct cmd_struct commands[] = {
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
+	{ "filter-objects", cmd_filter_objects, RUN_SETUP },
 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
diff --git a/t/t8100-filter-objects.sh b/t/t8100-filter-objects.sh
new file mode 100755
index 0000000..4b0137b
--- /dev/null
+++ b/t/t8100-filter-objects.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description='git filter-objects'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello, world >file &&
+	git add file &&
+	git commit -m "initial"
+'
+
+test_expect_success 'filter by type' '
+	git rev-parse HEAD >expected &&
+	git filter-objects -t commit >result &&
+	test_cmp expected result &&
+	git rev-parse HEAD:file >expected &&
+	git filter-objects -t blob >result &&
+	test_cmp expected result &&
+	git rev-parse HEAD^{tree} >expected &&
+	git filter-objects -t tree >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'filter by type after pack' '
+	git repack -Ad &&
+	git rev-parse HEAD >expected &&
+	git filter-objects -t commit >result &&
+	test_cmp expected result &&
+	git rev-parse HEAD:file >expected &&
+	git filter-objects -t blob >result &&
+	test_cmp expected result &&
+	git rev-parse HEAD^{tree} >expected &&
+	git filter-objects -t tree >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'verbose output' '
+	echo $(git rev-parse HEAD) commit $(git cat-file -s HEAD) >expected &&
+	git filter-objects -v -t commit >result &&
+	test_cmp expected result &&
+	echo $(git rev-parse HEAD:file) blob $(git cat-file -s HEAD:file) >expected &&
+	git filter-objects -v -t blob >result &&
+	test_cmp expected result &&
+	echo $(git rev-parse HEAD^{tree}) tree $(git cat-file -s HEAD^{tree}) >expected &&
+	git filter-objects -v -t tree >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'filter on size' '
+	git commit -F - --allow-empty <<-\EOF &&
+		This is a reasonably long commit message
+
+		It is designed to make sure that we create an object
+		that is substantially larger than all the others.
+
+		Our test file blob is a few bytes, our tree is similarly
+		small and our first commit is not too big.
+
+		This message alone is about 300 characters and a sample
+		commit from it has been measured at 562 bytes.
+	EOF
+	git rev-parse HEAD >expected &&
+	git filter-objects --min-size=500 >result &&
+	test_cmp expected result
+'
+
+test_done
-- 
2.4.0.53.g8440f74
