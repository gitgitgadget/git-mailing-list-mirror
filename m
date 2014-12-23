From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 4/4] upload-pack: use --objects-edge-aggressive for shallow fetches
Date: Tue, 23 Dec 2014 12:01:22 +0000
Message-ID: <1419336082-283091-5-git-send-email-sandals@crustytoothpaste.net>
References: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 13:01:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3O9p-0002sg-D7
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 13:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055AbaLWMBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 07:01:40 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55909 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756026AbaLWMBd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2014 07:01:33 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1EB9228094;
	Tue, 23 Dec 2014 12:01:31 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261726>

When fetching into a shallow repository, we want to aggressively mark
edges as uninteresting, since this decreases the pack size.  However,
is_shallow_repository() returns false on the server side, since the
server is not shallow.

As the server, we get an indication of whether the client is shallow
based on stdin; however, by the time we get to parsing stdin, we already
will have called setup_revisions and won't be able to change our
decision anymore.  Teach pack-objects a --shallow option to indicate
that the remote side is shallow and use it in upload-pack.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-pack-objects.txt | 7 ++++++-
 builtin/pack-objects.c             | 5 ++++-
 upload-pack.c                      | 4 +++-
 3 files changed, 13 insertions(+), 3 deletions(-)

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
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f3ba861..6bfbd3d 100644
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
@@ -2711,7 +2714,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	argv_array_push(&rp, "pack-objects");
 	if (thin) {
 		use_internal_rev_list = 1;
-		argv_array_push(&rp, is_repository_shallow()
+		argv_array_push(&rp, is_repository_shallow() || shallow
 				? "--objects-edge-aggressive"
 				: "--objects-edge");
 	} else
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
