Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C5E1F858
	for <e@80x24.org>; Fri, 29 Jul 2016 04:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbcG2EGw (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 00:06:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:50796 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750752AbcG2EGv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 00:06:51 -0400
Received: (qmail 24073 invoked by uid 102); 29 Jul 2016 04:06:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:06:52 -0400
Received: (qmail 31331 invoked by uid 107); 29 Jul 2016 04:07:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:07:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 00:06:48 -0400
Date:	Fri, 29 Jul 2016 00:06:48 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/7] sha1_file: drop free_pack_by_name
Message-ID: <20160729040647.GB22408@sigill.intra.peff.net>
References: <20160729040422.GA19678@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160729040422.GA19678@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The point of this function is to drop an entry from the
"packed_git" cache that points to a file we might be
overwriting, because our contents may not be the same (and
hence the only caller was pack-objects as it moved a
temporary packfile into place).

In older versions of git, this could happen because the
names of packfiles were derived from the set of objects they
contained, not the actual bits on disk. But since 1190a1a
(pack-objects: name pack files after trailer hash,
2013-12-05), the name reflects the actual bits on disk, and
any two packfiles with the same name can be used
interchangeably.

Dropping this function not only saves a few lines of code,
it makes the lifetime of "struct packed_git" much easier to
reason about: namely, we now do not ever free these structs.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h      |  1 -
 pack-write.c |  1 -
 sha1_file.c  | 30 ------------------------------
 3 files changed, 32 deletions(-)

diff --git a/cache.h b/cache.h
index 3855ddf..57ef726 100644
--- a/cache.h
+++ b/cache.h
@@ -1416,7 +1416,6 @@ extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t
 extern void close_pack_windows(struct packed_git *);
 extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
-extern void free_pack_by_name(const char *);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
diff --git a/pack-write.c b/pack-write.c
index 33293ce..ea0b788 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -354,7 +354,6 @@ void finish_tmp_packfile(struct strbuf *name_buffer,
 		die_errno("unable to make temporary index file readable");
 
 	strbuf_addf(name_buffer, "%s.pack", sha1_to_hex(sha1));
-	free_pack_by_name(name_buffer->buf);
 
 	if (rename(pack_tmp_name, name_buffer->buf))
 		die_errno("unable to rename temporary pack file");
diff --git a/sha1_file.c b/sha1_file.c
index d5e1121..e045d2f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -891,36 +891,6 @@ void close_pack_index(struct packed_git *p)
 	}
 }
 
-/*
- * This is used by git-repack in case a newly created pack happens to
- * contain the same set of objects as an existing one.  In that case
- * the resulting file might be different even if its name would be the
- * same.  It is best to close any reference to the old pack before it is
- * replaced on disk.  Of course no index pointers or windows for given pack
- * must subsist at this point.  If ever objects from this pack are requested
- * again, the new version of the pack will be reinitialized through
- * reprepare_packed_git().
- */
-void free_pack_by_name(const char *pack_name)
-{
-	struct packed_git *p, **pp = &packed_git;
-
-	while (*pp) {
-		p = *pp;
-		if (strcmp(pack_name, p->pack_name) == 0) {
-			clear_delta_base_cache();
-			close_pack(p);
-			free(p->bad_object_sha1);
-			*pp = p->next;
-			if (last_found_pack == p)
-				last_found_pack = NULL;
-			free(p);
-			return;
-		}
-		pp = &p->next;
-	}
-}
-
 static unsigned int get_max_fd_limit(void)
 {
 #ifdef RLIMIT_NOFILE
-- 
2.9.2.607.g98dce7b

