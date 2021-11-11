Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D9CC433FE
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE218610C8
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 15:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhKKPU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 10:20:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:57482 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhKKPU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 10:20:56 -0500
Received: (qmail 612 invoked by uid 109); 11 Nov 2021 15:18:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Nov 2021 15:18:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30457 invoked by uid 111); 11 Nov 2021 15:18:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Nov 2021 10:18:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Nov 2021 10:18:05 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] object-file: fix SEGV on free() regression in
 v2.34.0-rc2
Message-ID: <YY00LfI8vHKMaxAs@coredump.intra.peff.net>
References: <20211111030532.75910-1-hanxin.hx@alibaba-inc.com>
 <cover-0.2-00000000000-20211111T051800Z-avarab@gmail.com>
 <patch-1.2-811242178e4-20211111T051800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.2-811242178e4-20211111T051800Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 11, 2021 at 06:18:55AM +0100, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/object-file.c b/object-file.c
> index 02b79702748..ac476653a06 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2528,6 +2528,8 @@ int read_loose_object(const char *path,
>  	char hdr[MAX_HEADER_LEN];
>  	unsigned long *size = oi->sizep;
>  
> +	*contents = NULL;
> +
>  	map = map_loose_object_1(the_repository, path, NULL, &mapsize);
>  	if (!map) {
>  		error_errno(_("unable to mmap %s"), path);

OK, I agree this fixes the segfault, and is the minimal fix.

I do find the fact that fsck_loose() looks at "contents" after
read_loose_object() returns an error to be a bit questionable. It's a
recipe for confusion about what has happened, and who is supposed to
free what.  Your v2 addresses the leak, but by just shifting more burden
to the caller. There's only one caller, so it's not too bad, but for a
public function, read_loose_object() has a lot of sharp edges.

Plus I think it fails to work as intended for streaming blobs (we do not
fill in "contents" at all in that case, so we can never say "hash-path
mismatch").

I understand you're trying to catch the case of "we actually opened the
file and computed the sha1 of its contents" from cases where we didn't
get that far. But since you initialize real_oid, it seems like it would
be better to see if anything was written to that.

I.e., something like:

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d87c28a1cc..8f156ed9cd 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -617,18 +617,20 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	oi.typep = &type;
 
 	if (read_loose_object(path, oid, &real_oid, &contents, &oi) < 0) {
-		if (contents && !oideq(&real_oid, oid))
+		if (!is_null_oid(&real_oid) && !oideq(&real_oid, oid))
 			err = error(_("%s: hash-path mismatch, found at: %s"),
 				    oid_to_hex(&real_oid), path);
 		else
 			err = error(_("%s: object corrupt or missing: %s"),
 				    oid_to_hex(oid), path);
+		errors_found |= ERROR_OBJECT;
+		return 0; /* keep checking other objects */
 	}
-	if (type != OBJ_NONE && type < 0)
+	if (type != OBJ_NONE && type < 0) {
 		err = error(_("%s: object is of unknown type '%s': %s"),
 			    oid_to_hex(&real_oid), cb_data->obj_type.buf,
 			    path);
-	if (err < 0) {
+		free(contents);
 		errors_found |= ERROR_OBJECT;
 		return 0; /* keep checking other objects */
 	}

(the "err" variable is now superfluous, but I left it in to keep the
diff smaller). And then it would be safe to just set "contents" in
read_loose_object() when we need it:

diff --git a/object-file.c b/object-file.c
index ac476653a0..5e8ff94fd4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2528,8 +2528,6 @@ int read_loose_object(const char *path,
 	char hdr[MAX_HEADER_LEN];
 	unsigned long *size = oi->sizep;
 
-	*contents = NULL;
-
 	map = map_loose_object_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno(_("unable to mmap %s"), path);
@@ -2549,6 +2547,7 @@ int read_loose_object(const char *path,
 	}
 
 	if (*oi->typep == OBJ_BLOB && *size > big_file_threshold) {
+		*contents = NULL;
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
 			goto out;
 	} else {

That doesn't fix the hash-path mismatch problem for streaming, but it
sets us up to do so, if check_stream_oid() returned the real_oid it
computed.

All of this is much too large for an -rc fix, so we should take your
patch as-is. These are just thoughts I had while trying to figure out
if there were other problems caused by that same commit.

-Peff
