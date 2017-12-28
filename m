Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B86B51F404
	for <e@80x24.org>; Thu, 28 Dec 2017 09:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbdL1JhA (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 04:37:00 -0500
Received: from huc12-ckmail02.hiroshima-u.ac.jp ([133.41.12.55]:56026 "HELO
        huc12-ckmail02.hiroshima-u.ac.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751442AbdL1Jg6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Dec 2017 04:36:58 -0500
X-Greylist: delayed 1858 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2017 04:36:48 EST
Received: from huc12-ckmail02.hiroshima-u.ac.jp (localhost [127.0.0.1])
        by dummy.hiroshima-u.ac.jp (Postfix) with ESMTP id B4055A8B62A;
        Thu, 28 Dec 2017 18:05:48 +0900 (JST)
Received: from huc12-smtp02.hiroshima-u.ac.jp (huc12-smtp02.hiroshima-u.ac.jp [133.41.12.53])
        by huc12-ckmail02.hiroshima-u.ac.jp (Postfix) with ESMTP id A93194E39;
        Thu, 28 Dec 2017 18:05:48 +0900 (JST)
Received: from localhost.localdomain (flavor1.ipc.hiroshima-u.ac.jp [133.41.117.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by huc12-smtp02.hiroshima-u.ac.jp (Postfix) with ESMTPSA id A5319D317A;
        Thu, 28 Dec 2017 18:05:48 +0900 (JST)
From:   suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
To:     git@vger.kernel.org
Cc:     suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
Subject: [PATCH] git-archive: accepts --owner --group aslike GNU tar.
Date:   Thu, 28 Dec 2017 18:05:27 +0900
Message-Id: <20171228090527.25056-1-mpsuzuki@hiroshima-u.ac.jp>
X-Mailer: git-send-email 2.15.1.501.g29533fb16
X-TM-AS-MML: disable
X-TM-AS-Product-Ver: IMSS-7.1.0.1808-8.1.0.1062-23558.003
X-TM-AS-Result: No--13.305-10.0-31-10
X-imss-scan-details: No--13.305-10.0-31-10
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-MatchedRID: mJt40tgS0QBITndh1lLRAdTXZe7/fokgcx5k3wffojP9Ez/5IpHqp2wq
        STpOVkRPMEUFB3L4QxUroSXEo28yS4Z2q4ASQIldRlqShqb35p4mdFfLQflbre9Jtzyqge7R+Vi
        hXqn9xLGamE2YeLQqiMcIK6S4JS2iakeT4pIvkQ1SGsgQwHevX73gm8md8WsedpzrD6s6VCiOnr
        itHUsGhHZWeyxNH9jKiBG7WL/69SqLAgDrDJFDvGMGiV639iF0Ct4iaV1DkEMLigFCwAAoVq6O1
        xWv/DI8bBgMLgONATUqTmX/lEbtGpShxRaS8Dn1jtK7dC6UBnn1Mhmn7sQBMLlmMfLNiukan1iz
        PVW7z4EdxbzhTwelwDXlui1+0TfQEuficaCabpdIcJTn2HkqseiY+s2L3xQE/rvU1dGgVf7yjSl
        ymkf4R8Gc2UXB/wr1hbIOTDeUqBuR9GF2J2xqMxRFJJyf5BJeMM4ioayl4t2g5oovEWFmKY6HM5
        rqDwqtlZatA0BS5F3zNVxW8PiYAFl1yfWb0Q+GRCQ9jrtZuPt+sjWzXRy/6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current tar output by git-archive has always root:root.
To generate tar output with non-root owner/group,
the options like GNU tar are added.

* archive.h: add members 'uid', 'gid', 'uname', 'gname'
  to struct archiver_args.

* archive.c: add functions to reflect the operands of
  '--owner' and '--group' to archiver_args.

* archive-tar.c: copy 'uid', 'gid', 'uname', 'gname'
  from archiver_args to the entry headers in tar archive.

* t/parse-tar-file.py: a script to dump uid, gid, uname,
  gname fields from a tar archive.

* t/t5005-archive-uid-gid.sh: a test script comparing
  uid, gid, uname, gname between the options and
  generated tar file.
---
 archive-tar.c              |  8 +++---
 archive.c                  | 66 ++++++++++++++++++++++++++++++++++++++++++
 archive.h                  |  4 +++
 t/parse-tar-file.py        | 56 ++++++++++++++++++++++++++++++++++++
 t/t5005-archive-uid-gid.sh | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 201 insertions(+), 4 deletions(-)
 create mode 100755 t/parse-tar-file.py
 create mode 100755 t/t5005-archive-uid-gid.sh

diff --git a/archive-tar.c b/archive-tar.c
index c6ed96ee7..8546a6229 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -204,10 +204,10 @@ static void prepare_header(struct archiver_args *args,
 	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode) ? size : 0);
 	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long) args->time);
 
-	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
-	xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
-	strlcpy(header->uname, "root", sizeof(header->uname));
-	strlcpy(header->gname, "root", sizeof(header->gname));
+	xsnprintf(header->uid, sizeof(header->uid), "%07o", args->uid);
+	xsnprintf(header->gid, sizeof(header->gid), "%07o", args->gid);
+	strlcpy(header->uname, args->uname ? args->uname : "root", sizeof(header->uname));
+	strlcpy(header->gname, args->gname ? args->gname : "root", sizeof(header->gname));
 	xsnprintf(header->devmajor, sizeof(header->devmajor), "%07o", 0);
 	xsnprintf(header->devminor, sizeof(header->devminor), "%07o", 0);
 
diff --git a/archive.c b/archive.c
index 0b7b62af0..db69041f1 100644
--- a/archive.c
+++ b/archive.c
@@ -8,6 +8,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "dir.h"
+#include "git-compat-util.h"
 
 static char const * const archive_usage[] = {
 	N_("git archive [<options>] <tree-ish> [<path>...]"),
@@ -417,6 +418,57 @@ static void parse_treeish_arg(const char **argv,
 	{ OPTION_SET_INT, (s), NULL, (v), NULL, "", \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p) }
 
+static void set_args_uname_uid(struct archiver_args *args,
+		const char* tar_owner, int set_gid_too)
+{
+	if (!args || !tar_owner)
+		return;
+
+	const char* col_pos = strchr(tar_owner, ':');
+	struct passwd* pw = NULL;
+
+	if (col_pos) {
+		args->uname = xstrndup(tar_owner, col_pos - tar_owner);
+		args->uid = atoi(col_pos + 1);
+		return;
+	}
+
+	args->uname = xstrndup(tar_owner, strlen(tar_owner));
+	pw = getpwnam(tar_owner);
+	if (!pw)
+		return;
+
+	args->uid = pw->pw_uid;
+	if (set_gid_too)
+		args->gid = pw->pw_gid;
+
+	return;
+}
+
+static void set_args_gname_gid(struct archiver_args *args,
+		const char* tar_group)
+{
+	if (!args || !tar_group)
+		return;
+
+	const char* col_pos = strchr(tar_group, ':');
+	struct group* gr = NULL;
+
+	if (col_pos) {
+		args->gname = xstrndup(tar_group, col_pos - tar_group);
+		args->gid = atoi(col_pos + 1);
+		return;
+	}
+
+	args->gname = xstrndup(tar_group, strlen(tar_group));
+	gr = getgrnam(tar_group);
+	if (!gr)
+		return;
+
+	args->gid = gr->gr_gid;
+	return;
+}
+
 static int parse_archive_args(int argc, const char **argv,
 		const struct archiver **ar, struct archiver_args *args,
 		const char *name_hint, int is_remote)
@@ -431,6 +483,8 @@ static int parse_archive_args(int argc, const char **argv,
 	int i;
 	int list = 0;
 	int worktree_attributes = 0;
+	char *tar_owner = NULL;
+	char *tar_group = NULL;
 	struct option opts[] = {
 		OPT_GROUP(""),
 		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
@@ -459,6 +513,8 @@ static int parse_archive_args(int argc, const char **argv,
 			N_("retrieve the archive from remote repository <repo>")),
 		OPT_STRING(0, "exec", &exec, N_("command"),
 			N_("path to the remote git-upload-archive command")),
+		OPT_STRING(0, "owner", &tar_owner, N_("owner"), N_("<name[:uid]> in tar")),
+		OPT_STRING(0, "group", &tar_group, N_("group"), N_("<name[:gid]> in tar")),
 		OPT_END()
 	};
 
@@ -507,6 +563,16 @@ static int parse_archive_args(int argc, const char **argv,
 	args->baselen = strlen(base);
 	args->worktree_attributes = worktree_attributes;
 
+	args->uname = NULL;
+	args->gname = NULL;
+	args->uid = 0;
+	args->gid = 0;
+	set_args_uname_uid(args,
+		tar_owner,
+		1 /* init args->gid by pw, if resolved */);
+	set_args_gname_gid(args,
+		tar_group);
+
 	return argc;
 }
 
diff --git a/archive.h b/archive.h
index 62d1d82c1..fad4a5d3e 100644
--- a/archive.h
+++ b/archive.h
@@ -15,6 +15,10 @@ struct archiver_args {
 	unsigned int worktree_attributes : 1;
 	unsigned int convert : 1;
 	int compression_level;
+	int uid;
+	int gid;
+	const char *uname;
+	const char *gname;
 };
 
 #define ARCHIVER_WANT_COMPRESSION_LEVELS 1
diff --git a/t/parse-tar-file.py b/t/parse-tar-file.py
new file mode 100755
index 000000000..c240a8676
--- /dev/null
+++ b/t/parse-tar-file.py
@@ -0,0 +1,56 @@
+#!/usr/bin/env python
+
+import sys
+import getopt
+import tarfile
+
+optlist, args = getopt.getopt( sys.argv[1:], "", [
+				"print=", "show=",
+				"uniq",
+				"fail-if-multi",
+		] )
+
+infos_to_print = []
+uniq = False
+fail_if_multi = False
+
+for opt in optlist:
+  if opt[0] == "--print":
+    infos_to_print.append(opt[1])
+  elif opt[0] == "--show":
+    infos_to_print.append(opt[1])
+  elif opt[0] == "--uniq":
+    uniq = True
+  elif opt[0] == "--fail-if-multi":
+    uniq = True
+    fail_if_multi = True
+
+if len(infos_to_print) == 0:
+  infos_to_print = ["uid", "gid", "uname", "gname", "name"]
+
+tar = tarfile.open( args[0] )
+out_lines = []
+for tarinfo in tar:
+  infos = []
+  for info_tag in infos_to_print:
+    if info_tag == "uid":
+      infos.append( str(tarinfo.uid) )
+    elif info_tag == "gid":
+      infos.append( str(tarinfo.gid) )
+    elif info_tag == "uname" or info_tag == "owner":
+      infos.append( tarinfo.uname )
+    elif info_tag == "gname" or info_tag == "group":
+      infos.append( tarinfo.gname )
+    elif info_tag == "name" or info_tag == "pathname":
+      infos.append( tarinfo.name )
+  out_lines.append( "\t".join(infos) )
+tar.close()
+
+if uniq:
+  out_lines = list(set(out_lines))
+  if fail_if_multi and (len(out_lines) > 1):
+    sys.stderr.write("*** not unique value, " + str(len(out_lines)) + " values found\n")
+    sys.exit(len(out_lines))
+
+for line in out_lines:
+  print line
diff --git a/t/t5005-archive-uid-gid.sh b/t/t5005-archive-uid-gid.sh
new file mode 100755
index 000000000..2b2a694d8
--- /dev/null
+++ b/t/t5005-archive-uid-gid.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+
+test_description='test --owner --group options for git-archive'
+. ./test-lib.sh
+
+check_uid_gid_uname_gname_in_tar() {
+	# $1 tar pathname
+	# $2 uid (digit in string)
+	# $3 gid (digit in string)
+	# $4 uname (string)
+	# $5 gname (string)
+	uid=`./parse-tar-file.py --print=uid --fail-if-multi $1`
+	if test $? != 0 -o x"${uid}" != "x"$2
+	then
+	  echo "(some) uid differs from the specified value"
+	  return $?
+        fi
+
+	gid=`./parse-tar-file.py --print=gid --fail-if-multi $1`
+	if test $? != 0 -o x"${gid}" != "x"$3
+	then
+	  echo "(some) gid differs from the specified value"
+	  return $?
+	  exit $?
+        fi
+
+	uname=`./parse-tar-file.py --print=uname --fail-if-multi $1`
+	if test $? != 0 -o x"${uname}" != "x"$4
+	then
+	  echo "(some) uname differs from the specified value"
+	  return $?
+        fi
+
+	gname=`./parse-tar-file.py --print=gname --fail-if-multi $1`
+	if test $? != 0 -o x"${gname}" != "x"$5
+	then
+	  echo "(some) gname differs from the specified value"
+	  return $?
+        fi
+
+	return 0
+}
+
+git init . 1>/dev/null 2>/dev/null
+touch uid-gid-test.001
+mkdir uid-gid-test.002
+mkdir uid-gid-test.002/uid-gid-test.003
+git add uid-gid-test.001
+git add uid-gid-test.002
+git add uid-gid-test.002/uid-gid-test.003
+git commit -m "uid-gid-test" 2>/dev/null 1>/dev/null
+
+test_expect_success 'test a case with explicitly specified name/id, owner=nobody:1234 group=nogroup:5678' '
+	git archive --format=tar --owner nobody:1234 --group nogroup:5678 HEAD > uid-gid-test1.tar &&
+	check_uid_gid_uname_gname_in_tar uid-gid-test1.tar 1234 5678 nobody nogroup &&
+	test_result=$? &&
+	return ${test_result}
+'
+
+test_expect_success 'test a case with only name is specified, owner=(current my name) group=(current my group)' '
+	my_uid=`id -u` &&
+	my_gid=`id -g` &&
+	my_uname=`id -u -n` &&
+	my_gname=`id -g -n` &&
+	git archive --format=tar --owner ${my_uname} --group ${my_gname} HEAD > uid-gid-test2.tar &&
+	check_uid_gid_uname_gname_in_tar uid-gid-test2.tar ${my_uid} ${my_gid} ${my_uname} ${my_gname} &&
+	test_result=$? &&
+	return ${test_result}
+'
+
+test_done
-- 
2.11.0


