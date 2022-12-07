Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E833C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 07:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiLGHHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 02:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLGHHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 02:07:22 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9AD4B9BC
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 23:07:21 -0800 (PST)
Received: (qmail 18115 invoked by uid 109); 7 Dec 2022 07:07:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Dec 2022 07:07:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31152 invoked by uid 111); 7 Dec 2022 07:07:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Dec 2022 02:07:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Dec 2022 02:07:20 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2 2/3] object-file: emit corruption errors when detected
Message-ID: <Y5A7qOaxyWxHJiex@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670373420.git.jonathantanmy@google.com>
 <9ddfff3585c293c9801570e395b514505796a43f.1670373420.git.jonathantanmy@google.com>
 <221207.86359rc03e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221207.86359rc03e.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 05:05:47AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Isn't the below squashed in better? I.e. just always pass the "path",
> but maybe pass a "fd=0", in which case the function might need to
> git_open() it.
> 
> Then have map_loose_object() and loose_object_info() call
> open_loose_object(), and pass in the "path" and "fd".

I like this direction, though I'd give a few small suggestions. One is
to make it unconditional to pass in a valid "fd". These kind of magic
sentinel values sometimes lead to confusion or bugs, and it's easy
enough for the caller to use git_open() itself.

In fact, in the one caller who cares, it lets us produce a nicer
error message:

diff --git a/object-file.c b/object-file.c
index 24793e1b47..7c2a85132b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1219,9 +1219,6 @@ static void *map_loose_object_1(struct repository *r, const char *const path,
 {
 	void *map;
 
-	if (!fd)
-		fd = git_open(path);
-
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
@@ -2790,13 +2787,18 @@ int read_loose_object(const char *path,
 		      struct object_info *oi)
 {
 	int ret = -1;
+	int fd;
 	void *map = NULL;
 	unsigned long mapsize;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	unsigned long *size = oi->sizep;
 
-	map = map_loose_object_1(the_repository, path, 0, &mapsize);
+	fd = git_open(path);
+	if (fd < 0)
+		error_errno(_("unable to open %s"), path);
+
+	map = map_loose_object_1(the_repository, path, fd, &mapsize);
 	if (!map) {
 		error_errno(_("unable to mmap %s"), path);
 		goto out;

> +static void *map_loose_object_1(struct repository *r, const char *const path,
> +				int fd, unsigned long *size)
>  {
>  	void *map;
> -	int fd;
>  
> -	if (path)
> +	if (!fd)
>  		fd = git_open(path);
> -	else
> -		fd = open_loose_object(r, oid, &path);
> -	if (mapped_path)
> -		*mapped_path = xstrdup(path);

The other weird thing here is ownership of "fd". Now some callers pass
it in, but map_loose_object_1() always closes it. I think that's OK
(since we want it closed even on success), but definitely surprising
enough that we'd want to document that in a comment.

> @@ -1251,7 +1245,10 @@ void *map_loose_object(struct repository *r,
>  		       const struct object_id *oid,
>  		       unsigned long *size)
>  {
> -	return map_loose_object_1(r, NULL, oid, size, NULL);
> +	const char *path;
> +	int fd = open_loose_object(r, oid, &path);
> +
> +	return map_loose_object_1(r, path,fd, size);
>  }

It's also kind of weird that map_loose_object_1() is a noop on a
negative descriptor. That technically makes this correct, but I think it
would be much less surprising to always take a valid descriptor, and
this code should do:

  if (fd)
	return -1;
  return map_loose_object_1(r, path, fd, size);

If we are going to make map_loose_object_1() less confusing (and I think
that is worth doing), let's go all the way.

-Peff
