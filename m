From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 3/3] pack-objects: use --objects-edge-aggressive for shallow repos
Date: Wed, 24 Dec 2014 23:05:40 +0000
Message-ID: <1419462340-769147-4-git-send-email-sandals@crustytoothpaste.net>
References: <1419462340-769147-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 25 00:06:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3v0Z-0006Er-6P
	for gcvg-git-2@plane.gmane.org; Thu, 25 Dec 2014 00:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbaLXXGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 18:06:04 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55958 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751568AbaLXXGC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Dec 2014 18:06:02 -0500
Received: from vauxhall.hsd1.tx.comcast.net. (unknown [98.201.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 24D1528093;
	Wed, 24 Dec 2014 23:05:55 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1419462340-769147-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261814>

When fetching into or pushing from a shallow repository, we want to
aggressively mark edges as uninteresting, since this decreases the pack
size.  However, aggressively marking edges can negatively affect
performance on large non-shallow repositories with lots of refs.

Teach pack-objects a --shallow option to indicate that we're pushing
from or fetching into a shallow repository.  Use
--objects-edge-aggressive only for shallow repositories and otherwise
use --objects-edge, which performs better in the general case.  Update
the callers to pass the --shallow option when they are dealing with a
shallow repository.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-pack-objects.txt | 7 ++++++-
 Documentation/rev-list-options.txt | 3 ++-
 builtin/pack-objects.c             | 7 ++++++-
 send-pack.c                        | 3 +++
 upload-pack.c                      | 4 +++-
 5 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d2d8f47..c2f76fb 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
 	[--revs [--unpacked | --all]] [--stdout | base-name]
-	[--keep-true-parents] < object-list
+	[--shallow] [--keep-true-parents] < object-list
 
 
 DESCRIPTION
@@ -190,6 +190,11 @@ required objects and is thus unusable by Git without making it
 self-contained. Use `git index-pack --fix-thin`
 (see linkgit:git-index-pack[1]) to restore the self-contained property.
 
+--shallow::
+	Optimize a pack that will be provided to a client with a shallow
+	repository.  This option, combined with \--thin, can result in a
+	smaller pack at the cost of speed.
+
 --delta-base-offset::
 	A packed archive can express the base object of a delta as
 	either a 20-byte object name or as an offset in the
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 8cb6f92..2984f40 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -659,7 +659,8 @@ These options are mostly targeted for packing of Git repositories.
 
 --objects-edge-aggressive::
 	Similar to `--objects-edge`, but it tries harder to find excluded
-	commits at the cost of increased time.
+	commits at the cost of increased time.  This is used instead of
+	`--objects-edge` to build ``thin'' packs for shallow repositories.
 
 --unpacked::
 	Only useful with `--objects`; print the object IDs that are not
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f93a17c..d816587 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2613,6 +2613,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
 	int thin = 0;
+	int shallow = 0;
 	int all_progress_implied = 0;
 	struct argv_array rp = ARGV_ARRAY_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
@@ -2677,6 +2678,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
 		OPT_BOOL(0, "thin", &thin,
 			 N_("create thin packs")),
+		OPT_BOOL(0, "shallow", &shallow,
+			 N_("create packs suitable for shallow fetches")),
 		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep,
 			 N_("ignore packs that have companion .keep file")),
 		OPT_INTEGER(0, "compression", &pack_compression_level,
@@ -2711,7 +2714,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
-		argv_array_push(&rp, "--objects-edge-aggressive");
+		argv_array_push(&rp, shallow
+				? "--objects-edge-aggressive"
+				: "--objects-edge");
 	} else
 		argv_array_push(&rp, "--objects");
 
diff --git a/send-pack.c b/send-pack.c
index 949cb61..25947d7 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -47,6 +47,7 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 		NULL,
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po = CHILD_PROCESS_INIT;
 	int i;
@@ -60,6 +61,8 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 		argv[i++] = "-q";
 	if (args->progress)
 		argv[i++] = "--progress";
+	if (is_repository_shallow())
+		argv[i++] = "--shallow";
 	po.argv = argv;
 	po.in = -1;
 	po.out = args->stateless_rpc ? -1 : fd;
diff --git a/upload-pack.c b/upload-pack.c
index ac9ac15..b531a32 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -86,7 +86,7 @@ static void create_pack_file(void)
 		"corruption on the remote side.";
 	int buffered = -1;
 	ssize_t sz;
-	const char *argv[12];
+	const char *argv[13];
 	int i, arg = 0;
 	FILE *pipe_fd;
 
@@ -100,6 +100,8 @@ static void create_pack_file(void)
 		argv[arg++] = "--thin";
 
 	argv[arg++] = "--stdout";
+	if (shallow_nr)
+		argv[arg++] = "--shallow";
 	if (!no_progress)
 		argv[arg++] = "--progress";
 	if (use_ofs_delta)
-- 
2.2.1.209.g41e5f3a
