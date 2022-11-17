Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF65C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 18:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbiKQSrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiKQSro (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 13:47:44 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ADB8756B
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 10:47:43 -0800 (PST)
Received: (qmail 26069 invoked by uid 109); 17 Nov 2022 18:47:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Nov 2022 18:47:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14661 invoked by uid 111); 17 Nov 2022 18:47:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Nov 2022 13:47:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Nov 2022 13:47:41 -0500
From:   Jeff King <peff@peff.net>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] object-file: use real paths when adding alternates
Message-ID: <Y3aBzbzub7flQyca@coredump.intra.peff.net>
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 05:31:13PM +0000, Glen Choo via GitGitGadget wrote:

> When adding an alternate ODB, we check if the alternate has the same
> path as the object dir, and if so, we do nothing. However, that
> comparison does not resolve symlinks. This makes it possible to add the
> object dir as an alternate, which may result in bad behavior. For
> example, it can trick "git repack -a -l -d" (possibly run by "git gc")
> into thinking that all packs come from an alternate and delete all
> objects.

I think we do attempt to normalize the names. In link_alt_odb_entries(),
we call strbuf_normalize_path() on the base object directory, and then
in link_alt_odb_entry(), we similarly normalize the proposed odb names.
And then we drop duplicates (either of other alternates, or of the main
object directory).

So it seems like the problem is that "normalize" is not enough here,
because it only normalizes the text. We need to be using
strbuf_realpath() which will actually evaluate symbolic links.

> diff --git a/object-file.c b/object-file.c
> index 957790098fa..f901dd272d1 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -455,14 +455,16 @@ static int alt_odb_usable(struct raw_object_store *o,
>  			  struct strbuf *path,
>  			  const char *normalized_objdir, khiter_t *pos)
>  {
> +	int ret = 0;
>  	int r;
> +	struct strbuf real_path = STRBUF_INIT;
>  
>  	/* Detect cases where alternate disappeared */
>  	if (!is_directory(path->buf)) {
>  		error(_("object directory %s does not exist; "
>  			"check .git/objects/info/alternates"),
>  		      path->buf);
> -		return 0;
> +		goto cleanup;
>  	}

This goto seems unnecessary; we know we haven't touched real_path yet,
so there is nothing to clean. But...

> @@ -478,11 +480,16 @@ static int alt_odb_usable(struct raw_object_store *o,
>  		assert(r == 1); /* never used */
>  		kh_value(o->odb_by_path, p) = o->odb;
>  	}
> -	if (fspatheq(path->buf, normalized_objdir))
> -		return 0;
> +
> +	strbuf_realpath(&real_path, path->buf, 1);
> +	if (fspatheq(real_path.buf, normalized_objdir))
> +		goto cleanup;
>  	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
>  	/* r: 0 = exists, 1 = never used, 2 = deleted */
> -	return r == 0 ? 0 : 1;
> +	ret = r == 0 ? 0 : 1;
> + cleanup:
> +	strbuf_release(&real_path);
> +	return ret;
>  }

This seems like the wrong place to be doing realpath. We've already
normalized earlier in link_alt_odb_entry(). Why not use realpath there?

It does mean we'd end up with the realpath in the object_directory
struct, but I don't see that as a bad thing (in fact, it may be slightly
faster if it saves the kernel crossing a symlink boundary).

I do suspect it would change the error message for missing intermediate
directories (since realpath would complain, before we even hit the "does
this even exist"), but it's an error in both cases. Which brings up
another point here: I think right now we treat those errors as warnings,
and cnotinue on without the alternate available (because we ignore the
result of link_alt_odb_entry). But with your patch, a failure in this
realpath would cause us to die immediately.

> @@ -596,7 +603,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
>  		return;
>  	}
>  
> -	strbuf_add_absolute_path(&objdirbuf, r->objects->odb->path);
> +	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
>  	if (strbuf_normalize_path(&objdirbuf) < 0)
>  		die(_("unable to normalize object directory: %s"),
>  		    objdirbuf.buf);

Similarly here, I think we'd want to _replace_ the normalize with a
realpath. There's no point in doing both. It's OK to die in this one
because we assume the object directory can be normalized/realpath'd.

So I'd have expected the code portion of your patch to be more like:

diff --git a/object-file.c b/object-file.c
index 957790098f..c6a195c6dd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -508,6 +508,7 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 {
 	struct object_directory *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
 
 	if (!is_absolute_path(entry->buf) && relative_base) {
@@ -516,12 +517,18 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	}
 	strbuf_addbuf(&pathbuf, entry);
 
-	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
-		error(_("unable to normalize alternate object path: %s"),
-		      pathbuf.buf);
-		strbuf_release(&pathbuf);
-		return -1;
+	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
+		if (relative_base) {
+			error(_("unable to normalize alternate object path: %s"),
+			      pathbuf.buf);
+			strbuf_release(&pathbuf);
+			return -1;
+		}
+		/* allow broken paths from env per 37a95862c625 */
+		strbuf_addstr(&tmp, pathbuf.buf);
 	}
+	strbuf_swap(&pathbuf, &tmp);
+	strbuf_release(&tmp);
 
 	/*
 	 * The trailing slash after the directory name is given by
@@ -596,10 +603,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, r->objects->odb->path);
-	if (strbuf_normalize_path(&objdirbuf) < 0)
-		die(_("unable to normalize object directory: %s"),
-		    objdirbuf.buf);
+	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
 
 	while (*alt) {
 		alt = parse_alt_odb_entry(alt, sep, &entry);

The "tmp" swapping in link_alt_odb_entry is kind of unfortunate. It
would be nice if there were an in-place version of strbuf_realpath, even
if it was using two buffers under the hood (which is how the normalize
code does it). And then the patch really would be s/normalize/realpath/,
which is easier to understand.

Possibly this should also be using the "forgiving" version. We
eventually error out on missing entries later on, so it's not a big deal
to error here. But it would let us keep the error message the same. I
don't know that it matters much in practice.

-Peff
