Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C461F1F855
	for <e@80x24.org>; Wed, 27 Jul 2016 22:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162817AbcG0WEq (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 18:04:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:50168 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1162257AbcG0WEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 18:04:41 -0400
Received: (qmail 10945 invoked by uid 102); 27 Jul 2016 22:04:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 18:04:41 -0400
Received: (qmail 21366 invoked by uid 107); 27 Jul 2016 22:05:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 18:05:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 18:04:38 -0400
Date:	Wed, 27 Jul 2016 18:04:38 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] pack-objects: break out of want_object loop early
Message-ID: <20160727220437.GA2792@sigill.intra.peff.net>
References: <20160725185010.GA12974@sigill.intra.peff.net>
 <xmqqeg6h5w60.fsf@gitster.mtv.corp.google.com>
 <20160725214113.GA13589@sigill.intra.peff.net>
 <xmqqbn1l4c87.fsf@gitster.mtv.corp.google.com>
 <20160725221411.GA14131@sigill.intra.peff.net>
 <xmqqshuwyw14.fsf@gitster.mtv.corp.google.com>
 <20160726204851.GA22353@sigill.intra.peff.net>
 <xmqqr3agxep7.fsf@gitster.mtv.corp.google.com>
 <20160727211338.GA20608@sigill.intra.peff.net>
 <CAPc5daWjNBazzVrH3jdgur2wC19upjM9A_pWp-u=tPUM_qaK0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daWjNBazzVrH3jdgur2wC19upjM9A_pWp-u=tPUM_qaK0Q@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 02:28:32PM -0700, Junio C Hamano wrote:

> On Wed, Jul 27, 2016 at 2:13 PM, Jeff King <peff@peff.net> wrote:
> > ... But two is that I've
> > wondered if we can do even better with a most-recently-used cache
> > instead of the last_pack_found hack. So I'm trying to implement and
> > measure that (both for this loop, and to see if it does better in
> > find_pack_entry).
> 
> It is always delightful to hear a well constructed description of a
> thought process. Thanks.
> 
> One thing that made me wonder was what would happen to the
> last_found that is static to has_sha1_pack_kept_or_nonlocal()
> funciton, when we invalidate the packed_git list, but within the
> context of pack-objects it is not likely?

I wondered that, too, and that's part of what I'm working on. :)

We leave the old packed_git structs in place when we re-read the pack
directory. That works because either we have them already opened (so
even though they're gone, we can still access them, and that's why we
_must_ keep the structs in place), or we will call is_pack_valid() and
notice that it went away (and quietly skip to checking the next pack).

There is one place where we do free the packed_git, but I actually think
we can stop doing so. Here's what I'm planning as part of my series:


-- >8 --
Subject: [PATCH] sha1_file: drop free_pack_by_name

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
I won't be surprised if this fixes some obscure bug, because there may
be parts of the code that store a pointer to our packed_git that could
be invalidated (I'm certain the bitmap code does). But perhaps it
doesn't matter because it's rare for this function to trigger at all.

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

