Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0284C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 02:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLICAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 21:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLICAG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 21:00:06 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF523151
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 18:00:06 -0800 (PST)
Received: (qmail 30953 invoked by uid 109); 9 Dec 2022 02:00:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Dec 2022 02:00:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19438 invoked by uid 111); 9 Dec 2022 02:00:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Dec 2022 21:00:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Dec 2022 21:00:05 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 2/4] object-file: refactor map_loose_object_1()
Message-ID: <Y5KWpXwxdRI4QPNl@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670532905.git.jonathantanmy@google.com>
 <7419e4ac7053ab2d89a4cdc4612e5baeca48ce9f.1670532905.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7419e4ac7053ab2d89a4cdc4612e5baeca48ce9f.1670532905.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2022 at 12:57:06PM -0800, Jonathan Tan wrote:

> This function can do 3 things:
>  1. Gets an fd given a path
>  2. Simultaneously gets a path and fd given an OID
>  3. Memory maps an fd
> 
> Split this function up. Only one caller needs 1, so inline that. As for
> 2, a future patch will also need this functionality and, in addition,
> the calculated path, so extract this into a separate function with an
> out parameter for the path.

This is moving in a good direction. I like the name "map_fd" for the
helper. Being able to give it a useful name like that is a good clue
that it is doing a more focused and understandable job than the generic
map_loose_object_1(). :)

In fact...

> +static void *map_loose_object_1(struct repository *r,
> +				const struct object_id *oid,
> +				unsigned long *size,
> +				const char **path)
> +{
> +	const char *p;
> +	int fd = open_loose_object(r, oid, &p);
> +
> +	if (fd < 0)
> +		return NULL;
> +	if (path)
> +		*path = p;
> +	return map_fd(fd, p, size);
> +}
> +
>  void *map_loose_object(struct repository *r,
>  		       const struct object_id *oid,
>  		       unsigned long *size)
>  {
> -	return map_loose_object_1(r, NULL, oid, size);
> +	return map_loose_object_1(r, oid, size, NULL);
>  }

If you take my suggestion on patch 3, then the only other caller of
map_loose_object_1() goes away, and we can fold it all into one
reasonably-named function:

diff --git a/object-file.c b/object-file.c
index d99d05839f..429e3a746d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1233,28 +1233,18 @@ static void *map_fd(int fd, const char *path, unsigned long *size)
 	return map;
 }
 
-static void *map_loose_object_1(struct repository *r,
-				const struct object_id *oid,
-				unsigned long *size,
-				const char **path)
+void *map_loose_object(struct repository *r,
+		       const struct object_id *oid,
+		       unsigned long *size)
 {
 	const char *p;
 	int fd = open_loose_object(r, oid, &p);
 
 	if (fd < 0)
 		return NULL;
-	if (path)
-		*path = p;
 	return map_fd(fd, p, size);
 }
 
-void *map_loose_object(struct repository *r,
-		       const struct object_id *oid,
-		       unsigned long *size)
-{
-	return map_loose_object_1(r, oid, size, NULL);
-}
-
 enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 						    unsigned char *map,
 						    unsigned long mapsize,

-Peff
