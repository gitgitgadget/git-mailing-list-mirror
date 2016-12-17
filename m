Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80F781FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 04:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbcLQEEb (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 23:04:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:57905 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752223AbcLQEEa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 23:04:30 -0500
Received: (qmail 6372 invoked by uid 109); 17 Dec 2016 04:04:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 17 Dec 2016 04:04:30 +0000
Received: (qmail 16429 invoked by uid 111); 17 Dec 2016 04:05:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 23:05:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2016 23:04:26 -0500
Date:   Fri, 16 Dec 2016 23:04:26 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: don't warn about bitmaps on incremental
 pack
Message-ID: <20161217040426.7qeixbihiou5mbsl@sigill.intra.peff.net>
References: <20161216214906.z53yp2x4n6hdc27m@sigill.intra.peff.net>
 <1481932775-12952-1-git-send-email-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481932775-12952-1-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2016 at 06:59:35PM -0500, David Turner wrote:

> When running git pack-objects --incremental, we do not expect to be
> able to write a bitmap; it is very likely that objects in the new pack
> will have references to objects outside of the pack.  So we don't need
> to warn the user about it.
> [...]
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 0fd52bd..96de213 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1083,7 +1083,8 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset)) {
>  		/* The pack is missing an object, so it will not have closure */
>  		if (write_bitmap_index) {
> -			warning(_(no_closure_warning));
> +			if (!incremental)
> +				warning(_(no_closure_warning));
>  			write_bitmap_index = 0;
>  		}
>  		return 0;

I agree that the user doesn't need to be warned about it when running
"gc --auto", but I wonder if somebody invoking "pack-objects
--incremental --write-bitmap-index" ought to be.

In other words, your patch is detecting at a low level that we've been
given a nonsense combination of options, but should we perhaps stop
passing nonsense in the first place?

Either at the repack level, with something like:

diff --git a/builtin/repack.c b/builtin/repack.c
index 80dd06b4a2..6608a902b1 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -231,8 +231,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_pushf(&cmd.args, "--no-reuse-delta");
 	if (no_reuse_object)
 		argv_array_pushf(&cmd.args, "--no-reuse-object");
-	if (write_bitmaps)
-		argv_array_push(&cmd.args, "--write-bitmap-index");
 
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs);
@@ -256,8 +254,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	} else {
 		argv_array_push(&cmd.args, "--unpacked");
 		argv_array_push(&cmd.args, "--incremental");
+		write_bitmap_index = 0;
 	}
 
+	if (write_bitmaps)
+		argv_array_push(&cmd.args, "--write-bitmap-index");
 	if (local)
 		argv_array_push(&cmd.args,  "--local");
 	if (quiet)

Though that still means we do not warn on:

  git repack --write-bitmap-index

which is nonsense (it is asking for an incremental repack with bitmaps).

So maybe do it at the gc level, like:

diff --git a/builtin/gc.c b/builtin/gc.c
index 069950d0b4..d3c978c765 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -191,6 +191,11 @@ static void add_repack_all_option(void)
 	}
 }
 
+static void add_repack_incremental_option(void)
+{
+	argv_array_push(&repack, "--no-write-bitmap-index");
+}
+
 static int need_to_gc(void)
 {
 	/*
@@ -208,7 +213,9 @@ static int need_to_gc(void)
 	 */
 	if (too_many_packs())
 		add_repack_all_option();
-	else if (!too_many_loose_objects())
+	else if (too_many_loose_objects())
+		add_repack_incremental_option();
+	else
 		return 0;
 
 	if (run_hook_le(NULL, "pre-auto-gc", NULL))

-Peff
