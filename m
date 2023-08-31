Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFFAC83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbjHaGUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjHaGUF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:20:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B96FC2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:20:02 -0700 (PDT)
Received: (qmail 21152 invoked by uid 109); 31 Aug 2023 06:20:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 06:20:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3001 invoked by uid 111); 31 Aug 2023 06:20:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 02:20:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 02:20:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/10] fsck: detect very large tree pathnames
Message-ID: <20230831062001.GD3185325@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831061735.GA2702156@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In general, Git tries not to arbitrarily limit what it will store, and
there are currently no limits at all on the size of the path we find in
a tree. In theory you could have one that is gigabytes long.

But in practice this freedom is not really helping anybody, and is
potentially harmful:

  1. Most operating systems have much lower limits for the size of a
     single pathname component (e.g., on Linux you'll generally get
     ENAMETOOLONG for anything over 255 bytes). And while you _can_ use
     Git in a way that never touches the filesystem (manipulating the
     index and trees directly), it's still probably not a good idea to
     have gigantic tree names. Many operations load and traverse them,
     so any clever Git-as-a-database scheme is likely to perform poorly
     in that case.

  2. We still have a lot of code which assumes strings are reasonably
     sized, and I won't be at all surprised if you can trigger some
     interesting integer overflows with gigantic pathnames. Stopping
     malicious trees from entering the repository provides an extra line
     of defense, protecting downstream code.

This patch implements an fsck check so that such trees can be rejected
by transfer.fsckObjects. I've picked a reasonably high maximum depth
here (4096) that hopefully should not bother anybody in practice. I've
also made it configurable, as an escape hatch.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/fsck-msgids.txt |  7 +++++++
 fsck.c                        | 24 +++++++++++++++++++++++-
 fsck.h                        |  1 +
 t/t1450-fsck.sh               | 10 ++++++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 12eae8a222..09b0aecbf8 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -103,6 +103,13 @@
 `hasDotgit`::
 	(WARN) A tree contains an entry named `.git`.
 
+`largePathname`::
+	(WARN) A tree contains an entry with a very long path name. If
+	the value of `fsck.largePathname` contains a colon, that value
+	is used as the maximum allowable length (e.g., "warn:10" would
+	complain about any path component of 11 or more bytes). The
+	default value is 4096.
+
 `mailmapSymlink`::
 	(INFO) `.mailmap` is a symlink.
 
diff --git a/fsck.c b/fsck.c
index 2b1e348005..6a0bbc5087 100644
--- a/fsck.c
+++ b/fsck.c
@@ -24,6 +24,8 @@
 #include "credential.h"
 #include "help.h"
 
+static ssize_t max_tree_entry_len = 4096;
+
 #define STR(x) #x
 #define MSG_ID(id, msg_type) { STR(id), NULL, NULL, FSCK_##msg_type },
 static struct {
@@ -154,15 +156,29 @@ void fsck_set_msg_type(struct fsck_options *options,
 		       const char *msg_id_str, const char *msg_type_str)
 {
 	int msg_id = parse_msg_id(msg_id_str);
-	enum fsck_msg_type msg_type = parse_msg_type(msg_type_str);
+	char *to_free = NULL;
+	enum fsck_msg_type msg_type;
 
 	if (msg_id < 0)
 		die("Unhandled message id: %s", msg_id_str);
 
+	if (msg_id == FSCK_MSG_LARGE_PATHNAME) {
+		const char *colon = strchr(msg_type_str, ':');
+		if (colon) {
+			msg_type_str = to_free =
+				xmemdupz(msg_type_str, colon - msg_type_str);
+			colon++;
+			if (!git_parse_ssize_t(colon, &max_tree_entry_len))
+				die("unable to parse max tree entry len: %s", colon);
+		}
+	}
+	msg_type = parse_msg_type(msg_type_str);
+
 	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
 		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
 
 	fsck_set_msg_type_from_ids(options, msg_id, msg_type);
+	free(to_free);
 }
 
 void fsck_set_msg_types(struct fsck_options *options, const char *values)
@@ -578,6 +594,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 	int has_bad_modes = 0;
 	int has_dup_entries = 0;
 	int not_properly_sorted = 0;
+	int has_large_name = 0;
 	struct tree_desc desc;
 	unsigned o_mode;
 	const char *o_name;
@@ -607,6 +624,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 		has_dotdot |= !strcmp(name, "..");
 		has_dotgit |= is_hfs_dotgit(name) || is_ntfs_dotgit(name);
 		has_zero_pad |= *(char *)desc.buffer == '0';
+		has_large_name |= tree_entry_len(&desc.entry) > max_tree_entry_len;
 
 		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
 			if (!S_ISLNK(mode))
@@ -749,6 +767,10 @@ static int fsck_tree(const struct object_id *tree_oid,
 		retval += report(options, tree_oid, OBJ_TREE,
 				 FSCK_MSG_TREE_NOT_SORTED,
 				 "not properly sorted");
+	if (has_large_name)
+		retval += report(options, tree_oid, OBJ_TREE,
+				 FSCK_MSG_LARGE_PATHNAME,
+				 "contains excessively large pathname");
 	return retval;
 }
 
diff --git a/fsck.h b/fsck.h
index 6359ba359b..e3adf9d911 100644
--- a/fsck.h
+++ b/fsck.h
@@ -73,6 +73,7 @@ enum fsck_msg_type {
 	FUNC(NULL_SHA1, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
+	FUNC(LARGE_PATHNAME, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(BAD_FILEMODE, INFO) \
 	FUNC(GITMODULES_PARSE, INFO) \
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5805d47eb9..10a539158c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -589,6 +589,16 @@ test_expect_success 'fsck notices submodule entry pointing to null sha1' '
 	)
 '
 
+test_expect_success 'fsck notices excessively large tree entry name' '
+	git init large-name &&
+	(
+		cd large-name &&
+		test_commit a-long-name &&
+		git -c fsck.largePathname=warn:10 fsck 2>out &&
+		grep "warning.*large pathname" out
+	)
+'
+
 while read name path pretty; do
 	while read mode type; do
 		: ${pretty:=$path}
-- 
2.42.0.561.gaa987ecc69

