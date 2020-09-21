Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B80AC4346E
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 19:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE59020757
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 19:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgIUT0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:26:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:35766 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgIUT0c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 15:26:32 -0400
Received: (qmail 9136 invoked by uid 109); 21 Sep 2020 19:26:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Sep 2020 19:26:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23856 invoked by uid 111); 21 Sep 2020 19:26:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Sep 2020 15:26:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Sep 2020 15:26:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca
Subject: Re: [PATCH v2] diff: Fix modified lines stats with --stat and
 --numstat
Message-ID: <20200921192630.GA2399334@coredump.intra.peff.net>
References: <20200918113256.8699-2-tguyot@gmail.com>
 <20200920130945.26399-1-tguyot@gmail.com>
 <20200920153915.GB2726066@nand.local>
 <xmqqlfh4gt5z.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfh4gt5z.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 20, 2020 at 12:11:20PM -0700, Junio C Hamano wrote:

> > After reading your explanation in [1], this version makes more sense to
> > me.
> 
> These oid fields are prepared by calling diff_fill_oid_info(), and
> even for paths that are dirty (hence no "free" oid available from
> index or tree entry), an appropriate oid is computed.

This is the part that confused me earlier. I expected these "stdin"
entries, just like other some other entries (e.g., stat dirty ones for
diff-files, or anything for "diff --no-index") to have bogus oids.

But that diff_fill_oid_info() is what actually computes the sha1 from
scratch for them. I get why that is needed for generating a git diff, as
we have an "index from...to" line there that we'd want to fill.

For diffstat, though, it seems like a waste of time; we don't care what
the object hash is. I.e., if we were to do this:

diff --git a/diff.c b/diff.c
index 16eeaf6645..1934af29a5 100644
--- a/diff.c
+++ b/diff.c
@@ -4564,9 +4564,6 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
-	diff_fill_oid_info(p->one, o->repo->index);
-	diff_fill_oid_info(p->two, o->repo->index);
-
 	builtin_diffstat(name, other, p->one, p->two,
 			 diffstat, o, p);
 }

then everything seems to work fine _except_ a "git diff --stat
--no-index", exactly because it hits this "same_contents" check we've
been discussing. And once that is fixed properly (to handle any case
where we have no oid, not just when the stdin flag is set), then perhaps
it is worth doing.

Or perhaps not. Even if we have to memcmp sometimes in
builtin_diffstat(), it would be faster than computing the individual
hashes. But it may not be measurably so, and it would be no difference
for the common case of filespecs for which we do know the oid for free.
I also suspect we'd need to be a little smarter about combined formats
(e.g., "--stat --patch" might as well compute the oid as early as
possible, since we'll need it eventually for the patch; but we'd hit the
call in builtin_diffstat() before the one in run_diff()).

> But there are paths for which oid cannot be computed without
> destroying their contents.  Such paths are marked by the function
> with null_oid.

I'm not clear how computing the oid destroys the contents. We have them
in an in-memory buffer at this point, don't we? So we _could_ generate
an oid even for stdin, like this:

diff --git a/cache.h b/cache.h
index 55d7f61087..1ace143eac 100644
--- a/cache.h
+++ b/cache.h
@@ -858,6 +858,7 @@ int ie_modified(struct index_state *, const struct cache_entry *, struct stat *,
 #define HASH_RENORMALIZE  4
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
+int index_mem(struct index_state *istate, struct object_id *oid, void *buf, size_t size, enum object_type type, const char *path, unsigned flags);
 
 /*
  * Record to sd the data from st that we use to check whether a file
diff --git a/diff.c b/diff.c
index 16eeaf6645..181b632114 100644
--- a/diff.c
+++ b/diff.c
@@ -4463,7 +4463,10 @@ static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *is
 		if (!one->oid_valid) {
 			struct stat st;
 			if (one->is_stdin) {
-				oidclr(&one->oid);
+				if (index_mem(istate, &one->oid,
+					      one->data, one->size,
+					      OBJ_BLOB, one->path, 0))
+					die("cannot hash diff file from stdin");
 				return;
 			}
 			if (lstat(one->path, &st) < 0)
diff --git a/sha1-file.c b/sha1-file.c
index 770501d6d1..c7d017b3e0 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2046,10 +2046,10 @@ static void check_tag(const void *buf, size_t size)
 		die(_("corrupt tag"));
 }
 
-static int index_mem(struct index_state *istate,
-		     struct object_id *oid, void *buf, size_t size,
-		     enum object_type type,
-		     const char *path, unsigned flags)
+int index_mem(struct index_state *istate,
+	      struct object_id *oid, void *buf, size_t size,
+	      enum object_type type,
+	      const char *path, unsigned flags)
 {
 	int ret, re_allocated = 0;
 	int write_object = flags & HASH_WRITE_OBJECT;

which is basically your "best fix" from below. It fixes the bug here,
and it gives you a non-null index line. I'd consider coupling it with
calling fill_oid less often, though (something like range-diff computes
a bunch of fake-stdin diffs, and doesn't need to waste time computing
the oids at all).

> Summarizing the above, I think the second best fix is this (which
> means that the posted patch is the third best):
> 
> 	/*
> 	 * diff_fill_oid_info() marked one/two->oid with null_oid
> 	 * for a path whose oid is not available.  Disable early
> 	 * return optimization for them.
> 	 */
> 	if (oideq(&one->oid, &null_oid) || oideq(&two->oid, &null_oid))
> 		same_contents = 0; /* could be different */
> 	else if (oideq(&one->oid, &two->oid))
> 		same_contents = 1; /* definitely the same */
> 	else
> 		same_contents = 0; /* definitely different */

This is the direction I was getting at in my earlier emails, except that
I imagined that first conditional could be checking:

  if (!one->oid_valid || !two->oid_valid)

but I was surprised to see that diff_fill_oid_info() does not set
oid_valid. Is that a bug?

I also imagined that we'd have to determine right then whether the
contents are actually different or not with a memcmp(), to avoid
emitting a "0 changes" line, but we do handle that case within the
"!same_contents" conditional. See the comment starting with "Omit
diffstats..." added recently by 1cf3d5db9b (diff: teach --stat to ignore
uninteresting modifications, 2020-08-20).

-Peff
