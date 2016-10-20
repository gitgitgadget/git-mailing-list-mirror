Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38CB920986
	for <e@80x24.org>; Thu, 20 Oct 2016 06:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbcJTGTX (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 02:19:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:59860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752475AbcJTGTW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 02:19:22 -0400
Received: (qmail 18610 invoked by uid 109); 20 Oct 2016 06:19:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 06:19:22 +0000
Received: (qmail 21037 invoked by uid 111); 20 Oct 2016 06:19:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 02:19:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 02:19:19 -0400
Date:   Thu, 20 Oct 2016 02:19:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/7] find_unique_abbrev: use 4-buffer ring
Message-ID: <20161020061919.qu443ud7lbkopvth@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some code paths want to format multiple abbreviated sha1s in
the same output line. Because we use a single static buffer
for our return value, they have to either break their output
into several calls or allocate their own arrays and use
find_unique_abbrev_r().

Intead, let's mimic sha1_to_hex() and use a ring of several
buffers, so that the return value stays valid through
multiple calls. This shortens some of the callers, and makes
it harder to for them to make a silly mistake.

Signed-off-by: Jeff King <peff@peff.net>
---
It feels a little funny in these callers to be moving from a reentrant
function to one that relies on a static buffer. But I feel like the
result is more obvious and less error-prone, and the "ring of buffers"
concept has proven useful and safe in sha1_to_hex().

My ulterior motive is that while refactoring one of the later patches, I
just assumed that we did have a ring of buffers, and introduced a subtle
bug.

 builtin/merge.c        | 11 +++++------
 builtin/receive-pack.c | 16 ++++++----------
 cache.h                |  4 ++--
 sha1_name.c            |  4 +++-
 4 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a8b57c7..b65eeaa 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1374,12 +1374,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		struct commit *commit;
 
 		if (verbosity >= 0) {
-			char from[GIT_SHA1_HEXSZ + 1], to[GIT_SHA1_HEXSZ + 1];
-			find_unique_abbrev_r(from, head_commit->object.oid.hash,
-					      DEFAULT_ABBREV);
-			find_unique_abbrev_r(to, remoteheads->item->object.oid.hash,
-					      DEFAULT_ABBREV);
-			printf(_("Updating %s..%s\n"), from, to);
+			printf(_("Updating %s..%s\n"),
+			       find_unique_abbrev(head_commit->object.oid.hash,
+						  DEFAULT_ABBREV),
+			       find_unique_abbrev(remoteheads->item->object.oid.hash,
+						  DEFAULT_ABBREV));
 		}
 		strbuf_addstr(&msg, "Fast-forward");
 		if (have_message)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 04ed38e..680759d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1163,10 +1163,6 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	struct string_list_item *item;
 	struct command *dst_cmd;
 	unsigned char sha1[GIT_SHA1_RAWSZ];
-	char cmd_oldh[GIT_SHA1_HEXSZ + 1],
-	     cmd_newh[GIT_SHA1_HEXSZ + 1],
-	     dst_oldh[GIT_SHA1_HEXSZ + 1],
-	     dst_newh[GIT_SHA1_HEXSZ + 1];
 	int flag;
 
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
@@ -1197,14 +1193,14 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 
 	dst_cmd->skip_update = 1;
 
-	find_unique_abbrev_r(cmd_oldh, cmd->old_sha1, DEFAULT_ABBREV);
-	find_unique_abbrev_r(cmd_newh, cmd->new_sha1, DEFAULT_ABBREV);
-	find_unique_abbrev_r(dst_oldh, dst_cmd->old_sha1, DEFAULT_ABBREV);
-	find_unique_abbrev_r(dst_newh, dst_cmd->new_sha1, DEFAULT_ABBREV);
 	rp_error("refusing inconsistent update between symref '%s' (%s..%s) and"
 		 " its target '%s' (%s..%s)",
-		 cmd->ref_name, cmd_oldh, cmd_newh,
-		 dst_cmd->ref_name, dst_oldh, dst_newh);
+		 cmd->ref_name,
+		 find_unique_abbrev(cmd->old_sha1, DEFAULT_ABBREV),
+		 find_unique_abbrev(cmd->new_sha1, DEFAULT_ABBREV),
+		 dst_cmd->ref_name,
+		 find_unique_abbrev(dst_cmd->old_sha1, DEFAULT_ABBREV),
+		 find_unique_abbrev(dst_cmd->new_sha1, DEFAULT_ABBREV));
 
 	cmd->error_string = dst_cmd->error_string =
 		"inconsistent aliased update";
diff --git a/cache.h b/cache.h
index 05ecb88..6e06311 100644
--- a/cache.h
+++ b/cache.h
@@ -901,8 +901,8 @@ extern char *sha1_pack_index_name(const unsigned char *sha1);
  * The result will be at least `len` characters long, and will be NUL
  * terminated.
  *
- * The non-`_r` version returns a static buffer which will be overwritten by
- * subsequent calls.
+ * The non-`_r` version returns a static buffer which remains valid until 4
+ * more calls to find_unique_abbrev are made.
  *
  * The `_r` variant writes to a buffer supplied by the caller, which must be at
  * least `GIT_SHA1_HEXSZ + 1` bytes. The return value is the number of bytes
diff --git a/sha1_name.c b/sha1_name.c
index 4092836..36ce9b9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -472,7 +472,9 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 
 const char *find_unique_abbrev(const unsigned char *sha1, int len)
 {
-	static char hex[GIT_SHA1_HEXSZ + 1];
+	static int bufno;
+	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
+	char *hex = hexbuffer[3 & ++bufno];
 	find_unique_abbrev_r(hex, sha1, len);
 	return hex;
 }
-- 
2.10.1.619.g16351a7

