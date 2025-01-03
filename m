Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FF1B6CF5
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735934386; cv=none; b=O1COqzpy7oRj+59LMQVhPJXn2u1t6a4za10zVxwpofN5kcAKTVIK0Tq+B/c3MuBljvrxtYTHCeyz6MNVv2QxHFseBStiaZ9NmCKLj1gKSZfiuZxC+kflxoictkQ4LfLCjf3peZx80gMjIagzVjE4Q6bC9eRS10P1VrsZj1ng290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735934386; c=relaxed/simple;
	bh=+8+vkYgSICPUyDhj+DTgPWzv5Bq2Cyuwip7q3nLdC4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvOe6AxreetWbYQfnQdZJPvSPk53pZBEwCXoOEHT828qe0LZ6/7LCoa74+RbjvndLgOlU8HAaqvK8WWz10+88DuCIsVdf+tAeMX0L/9xulCdQnDe/o/c9TXcy3XMIJ6wzoLtjjSAOnmZAkYEf5/9kUUFj5Dcl1xVMcn2uK5oEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MDe5/A/W; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MDe5/A/W"
Received: (qmail 18808 invoked by uid 109); 3 Jan 2025 19:59:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+8+vkYgSICPUyDhj+DTgPWzv5Bq2Cyuwip7q3nLdC4s=; b=MDe5/A/W32hRuOAboUN2H+/6XnmwFFM+7twJ0/YzxrT4IaKdtusSdIgO6PrVWj+Nhfda93Ehj7deuqVPMMbweO+rHHZAUHSQZGtyo70B3CKELKz4oAQZZU+XLilS0YO0kFURQEeTgTzN2N/UtTw1kxj2yci3QsEK/5LGucsRw30+LL6q7W19USueTQUjEqCIqT+LXw2iR9L24jzPVfp+8OrTExLRn8Nat/9E8C7imJieneOHMw37D2dI5pgDAMupXg1UC6PdIJ7VIpx2SPFZsIpGwfh+1M1i6kK6T/d05JWYVp+zmO7FmArCi1leBElX+zPJT1TCobyEBwjqADjgxg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jan 2025 19:59:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4604 invoked by uid 111); 3 Jan 2025 19:59:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 14:59:43 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 14:59:42 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] object-file: retry linking file into place when
 occluding file vanishes
Message-ID: <20250103195942.GA3212696@coredump.intra.peff.net>
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
 <20250103-b4-pks-object-file-racy-collision-check-v1-2-6ef9e2da1f87@pks.im>
 <20250103194058.GE3208749@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103194058.GE3208749@coredump.intra.peff.net>

On Fri, Jan 03, 2025 at 02:40:58PM -0500, Jeff King wrote:

> I suspect there's a way to write this as a loop that would be more
> structured, but it would be a bigger refactor. Bonus points if it also
> get rid of the try_rename goto, too. ;)
> 
> I'm OK punting on that, though.

For fun, here's a version without any goto's in it, that should behave
the same. But it would be very easy to miss a case. So I don't know if
it is worth the regression risk, and I don't blame you if you delete
this message without looking carefully. ;)

Diff is kind of hard to read, so you may want to apply (on top of your
patches) and just look at the post-image.

diff --git a/object-file.c b/object-file.c
index 88432cc9c0..923d75a889 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2037,58 +2037,66 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 int finalize_object_file_flags(const char *tmpfile, const char *filename,
 			       enum finalize_object_file_flags flags)
 {
-	int ret;
+	int tries = 5;
 
-retry:
-	ret = 0;
+	while (tries-- > 0) {
+		int ret = 0;
+		if (object_creation_mode != OBJECT_CREATION_USES_RENAMES) {
+			if (!link(tmpfile, filename)) {
+				unlink_or_warn(tmpfile);
+				break;
+			}
+			ret = errno;
+		}
 
-	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
-		goto try_rename;
-	else if (link(tmpfile, filename))
-		ret = errno;
-	else
-		unlink_or_warn(tmpfile);
+		/*
+		 * Coda hack - coda doesn't like cross-directory links,
+		 * so we fall back to a rename, which will mean that it
+		 * won't be able to check collisions, but that's not a
+		 * big deal.
+		 *
+		 * The same holds for FAT formatted media.
+		 *
+		 * When this succeeds, we just return.  We have nothing
+		 * left to unlink.
+		 */
+		if (!ret || ret == EEXIST) {
+			struct stat st;
 
-	/*
-	 * Coda hack - coda doesn't like cross-directory links,
-	 * so we fall back to a rename, which will mean that it
-	 * won't be able to check collisions, but that's not a
-	 * big deal.
-	 *
-	 * The same holds for FAT formatted media.
-	 *
-	 * When this succeeds, we just return.  We have nothing
-	 * left to unlink.
-	 */
-	if (ret && ret != EEXIST) {
-		struct stat st;
+			if (!stat(filename, &st))
+				ret = EEXIST;
+			else if (!rename(tmpfile, filename))
+				break;
+			else
+				ret = errno;
+		}
 
-	try_rename:
-		if (!stat(filename, &st))
-			ret = EEXIST;
-		else if (!rename(tmpfile, filename))
-			goto out;
-		else
-			ret = errno;
-	}
-	if (ret) {
+		/* Do not retry most filesystem errors */
 		if (ret != EEXIST) {
 			int saved_errno = errno;
 			unlink_or_warn(tmpfile);
 			errno = saved_errno;
 			return error_errno(_("unable to write file %s"), filename);
 		}
-		if (!(flags & FOF_SKIP_COLLISION_CHECK)) {
-			ret = check_collision(tmpfile, filename);
-			if (ret == CHECK_COLLISION_DEST_VANISHED)
-				goto retry;
-			else if (ret)
-				return -1;
+
+		ret = (flags & FOF_SKIP_COLLISION_CHECK) ? 0 :
+			check_collision(tmpfile, filename);
+
+		if (!ret) {
+			/* Same contents (or we are allowed to assume such). */
+			unlink_or_warn(tmpfile);
+			break;
 		}
-		unlink_or_warn(tmpfile);
+
+		if (ret != CHECK_COLLISION_DEST_VANISHED)
+			return -1; /* check_collision() already complained */
+
+		/* loop again to retry vanished destination */
 	}
 
-out:
+	if (tries < 0)
+		return error(_("unable to write repeatedly vanishing file %s"), filename);
+
 	if (adjust_shared_perm(filename))
 		return error(_("unable to set permission to '%s'"), filename);
 	return 0;

-Peff
